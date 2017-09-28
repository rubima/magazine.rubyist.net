require 'uri'

module HTMLUtils
  ESC = {
    '&' => '&amp;',
    '"' => '&quot;',
    '<' => '&lt;',
    '>' => '&gt;'
  }

  def escape(str)
    table = ESC   # optimize
    str.gsub(/[&"<>]/n) {|s| table[s] }
  end
  
  def urlencode(str)
    str.gsub(/[^\w\.\-]/n) {|ch| sprintf('%%%02X', ch[0]) }
  end
end

class PukiWikiParser
  include HTMLUtils

  def initialize(logger)
    @logger = logger
    @h_start_level = 2
  end

  def to_html(src, page_names, base_uri = '/', suffix= '/')
    @page_names = page_names
    @base_uri = base_uri
    @pagelist_suffix = suffix
    @inline_re = nil   # invalidate cache

    buf = []
    lines = src.rstrip.split(/\r?\n/).map {|line| line.chomp }
    while lines.first
      case lines.first
      when ''
        lines.shift
      when /\A----/
        lines.shift
        buf.push '<hr />'
      when /\A\*/
        buf.push parse_h(lines.shift)
      when /\A\s/
        buf.concat parse_pre(take_block(lines, /\A\s/))
      when /\A>/
        buf.concat parse_quote(take_block(lines, /\A>/))
      when /\A-/
        buf.concat parse_list('ul', take_block(lines, /\A-/))
      when /\A\+/
        buf.concat parse_list('ol', take_block(lines, /\A\+/))
      when /\A:/
        buf.concat parse_dl(take_block(lines, /\A:/))
      else
        buf.push '<p>'
        buf.concat parse_p(take_block(lines, /\A(?![*\s>:\-\+]|----|\z)/))
        buf.push '</p>'
      end
    end
    buf.join("\n")
  end

  private

  def take_block(lines, marker)
    buf = []
    until lines.empty?
      break unless marker =~ lines.first
      buf.push lines.shift.sub(marker, '')
    end
    buf
  end

  def parse_h(line)
    @logger.debug "h: #{line.inspect}"
    level = @h_start_level + (line.slice(/\A\*{1,4}/).length - 1)
    content = line.sub(/\A\*+/, '')
    "<h#{level}>#{parse_inline(content)}</h#{level}>"
  end

  def parse_list(type, lines)
    @logger.debug "#{type}: #{lines.inspect}"
    marker = ((type == 'ul') ? /\A-/ : /\A\+/)
    parse_list0(type, lines, marker)
  end

  def parse_list0(type, lines, marker)
    buf = ["<#{type}>"]
    closeli = nil
    until lines.empty?
      if marker =~ lines.first
        buf.concat parse_list0(type, take_block(lines, marker), marker)
      else
        buf.push closeli if closeli;  closeli = '</li>'
        buf.push "<li>#{parse_inline(lines.shift)}"
      end
    end
    buf.push closeli if closeli;  closeli = '</li>'
    buf.push "</#{type}>"
    buf
  end

  def parse_dl(lines)
    @logger.debug "dl: #{lines.inspect}"
    buf = ["<dl>"]
    lines.each do |line|
      dt, dd = *line.split('|', 2)
      buf.push "<dt>#{parse_inline(dt)}</dt>"
      buf.push "<dd>#{parse_inline(dd)}</dd>" if dd
    end
    buf.push "</dl>"
    buf
  end

  def parse_quote(lines)
    @logger.debug "quote: #{lines.inspect}"
    [ "<blockquote><p>", lines.join("\n"), "</p></blockquote>"]
  end

  def parse_pre(lines)
    @logger.debug "pre: #{lines.inspect}"
    [ "<pre><code>#{lines.map {|line| escape(line) }.join("\n")}",
      '</code></pre>']
  end

  def parse_p(lines)
    lines.map {|line| parse_inline(line) }
  end

  def parse_inline(str)
    @inline_re ||= %r<
        ([&<>"])                             # $1: HTML escape characters
      | \[\[(.+?):\s*(https?://\S+)\s*\]\]   # $2: label, $3: URI
      | (#{autolink_re()})                   # $4: Page name autolink
      | (#{URI.regexp('http')})              # $5...: URI autolink
      >x
    str.gsub(@inline_re) {
      case
      when htmlchar = $1 then escape(htmlchar)
      when bracket  = $2 then a_href($3, bracket, 'outlink')
      when pagename = $4 then a_href(page_uri(pagename), pagename, 'pagelink')
      when uri      = $5 then a_href(uri, uri, 'outlink')
      else
        raise 'must not happen'
      end
    }
  end

  def a_href(uri, label, cssclass)
    %Q[<a class="#{cssclass}" href="#{escape(uri)}">#{escape(label)}</a>]
  end

  def autolink_re
    Regexp.union(* @page_names.reject {|name| name.size <= 3 })
  end

  def page_uri(page_name)
    "#{@base_uri}#{urlencode(page_name)}#{@pagelist_suffix}"
  end
end
