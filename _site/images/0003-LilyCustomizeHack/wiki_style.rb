#
# wiki_style.rb WikiWiki style for lily.
# This module is based on tDiary's WikiWiki style, written by TADA Tadashi.
#
# Copyright (C) 2003, TADA Tadashi <sho@spc.gr.jp>
# Copyright (C) 2004 MATSUNO Tokuhiro <tokuhirom@yahoo.co.jp>
# You can distribute this under GPL.
#

class WikiParser
	class ParserQueue < Array
		def <<( s )
			$stderr.puts s if $DEBUG
			super( s )
		end
	end

	# opt is a Hash.
	#
	#     key  |    value    |      mean       |default 
	# ---------+-------------+-----------------+---------
	# :wikiname|true or false|parse WikiName   | true
	# :url     |true or false|make URL to link | true
	# :plugin  |true or false|parse plugin     | true
	# :absolute|true or false|only absolute URL| false
	#
	def initialize( opt = {} )
		@opt = {    # set default
			:wikiname => true,
			:url => true,
			:plugin => true,
			:absolute => false,
		}
		@opt.update( opt )
	end

	def parse( f )
		@q = ParserQueue::new
		nest = 0
		f.each do |l|
			l.sub!( /[\r\n]+\Z/, '' )
			case l
			when /^$/ # null string
				@q << nil unless @q.last == nil

			when /^----+$/ # horizontal bar
				@q << :RS << :RE

			when /^(!{1,5})\s*(.*)/ # headings
				eval( "@q << :HS#{$1.size}" )
				inline( $2 )
				eval( "@q << :HE#{$1.size}" )

			when /^([\*#]{1,3})\s*(.*)/ # list
				r, depth = $2, $1.size
				style = $1[0] == ?* ? 'U' : 'O'
				nest = 0 unless /^[UO]E$/ =~ @q.last.to_s
				tmp = []
				if nest < depth then
					(nest * 2).times do tmp << @q.pop end
					eval( "@q << :#{style}S << :LS" )
					inline( r )
					eval( "@q << :LE << :#{style}E" )
				elsif nest > depth
					(depth * 2 - 1).times do tmp << @q.pop end
					@q << :LS
					inline( r )
					@q << :LE
				else
					(nest * 2 - 1).times do tmp << @q.pop end
					@q << :LS
					inline( r )
					@q << :LE
				end
				@q << tmp.pop while tmp.size != 0
				nest = depth

			when /^:([^:]+):(.*)/ # definition list
				if @q.last == :DE then
					@q.pop
				else
					@q << :DS
				end
				@q << :DTS
				inline( $1 )
				@q << :DTE << :DDS
				inline( $2 )
				@q << :DDE << :DE

			when /^""$/ # block quote (null line)
				if @q.last == :QE then
					@q.pop
				else
					@q << :QS
				end
				@q << :PS << :PE << :QE

			when /^""\s*(.*)/ # block quote
				if @q.last == :QE then
					@q.pop
					@q.pop
				else
					@q << :QS << :PS
				end
				inline( $1 + "\n" )
				@q << :PE << :QE

			when /^\s(.*)/ # formatted text
				if @q.last == :FE then
					@q.pop
				else
					@q << :FS
				end
				@q << ( $1 + "\n" ) << :FE

			when /^\|\|(.*)/ # table
				if @q.last == :TE then
					@q.pop
					@q << :TRS
				else
					@q << :TS << :TRS
				end
				$1.split( /\|\|/ ).each do |s|
					@q << :TDS
					inline( s )
					@q << :TDE
				end
				@q << :TRE << :TE
			else # paragraph
				if @q.last == :PE then
					@q.pop
				else
					@q << :PS
				end
				inline( l )
				@q << :PE
			end
		end
		@q.compact!
		@q
	end

	private
	def inline( l )
		if @opt[:plugin] then
			r = /(.*?)(\[\[|\]\]|\{\{|\}\}|'''|''|==)/
		else
			r = /(.*?)(\[\[|\]\]|'''|''|==)/
		end
		a = l.scan( r ).flatten
		tail = a.size == 0 ? l : $'
		stat = []
		a.each do |i|
			case i
			when '[['
				@q << :KS
				stat.push :KE
			when ']]'
				@q << stat.pop
			when '{{'
				if @opt[:plugin] then
					@q << :GS
					stat.push :GE
				else
					@q << i
				end
			when '}}'
				if @opt[:plugin] then
					@q << stat.pop
				else
					@q << i
				end
			when "'''"
				if stat.last == :SE then
					@q << stat.pop
				else
					@q << :SS
					stat.push :SE
				end
			when "''"
				if stat.last == :EE then
					@q << stat.pop
				else
					@q << :ES
					stat.push :EE
				end
			when "=="
				if stat.last == :ZE then
					@q << stat.pop
				else
					@q << :ZS
					stat.push :ZE
				end
			else
				if stat.last == :KE or stat.last == :GE then
					@q << i
				else
					url( i ) if i.size > 0
				end
			end
		end
		url( tail ) if tail
	end

	def url( l )
		unless @opt[:url]
			@q << l
			return
		end

		r = %r<(((https?|ftp):[\(\)%#!/0-9a-zA-Z_$@.&+-,'"*=;?:~-]+)|([0-9a-zA-Z_.-]+@[\(\)%!0-9a-zA-Z_$.&+-,'"*-]+\.[\(\)%!0-9a-zA-Z_$.&+-,'"*-]+))>
		a = l.gsub( r ) {
			if $1 == $2 then
				url = $2
				if %r<^(https?|ftp)(://)?$> =~ url then
					url
				elsif %r<^(https?|ftp)://> =~ url
					"[[#{url}]]"
				else
					if @opt[:absolute] then
						url
					else
						"[[#{url.sub( /^(https?|ftp):/, '' )}]]"
					end
				end
			else
				"[[mailto:#$4]]"
			end
		}.scan( /(.*?)(\[\[|\]\])/ ).flatten
		tail = a.size == 0 ? l : $'
		a.each do |i|
			case i
			when '[['
				@q << :XS
			when ']]'
				@q << :XE
			else
				if @q.last == :XS then
					@q << i
				else
					wikiname( i )
				end
			end
		end
		wikiname( tail ) if tail
	end

	def wikiname( l )
		unless @opt[:wikiname]
			@q << l
			return
		end

		l.gsub!( /[A-Z][a-z0-9]+([A-Z][a-z0-9]+)+/, '[[\0]]' )
		a = l.scan( /(.*?)(\[\[|\]\])/ ).flatten
		tail = a.size == 0 ? l : $'
		a.each do |i|
			case i
			when '[['
				@q << :KS
			when ']]'
				@q << :KE
			else
				@q << i
			end
		end
		@q << tail if tail
	end
end

class WikiSection
	attr_reader :subtitle, :author
	attr_reader :categories, :stripped_subtitle
	attr_reader :subtitle_to_html, :stripped_subtitle_to_html, :body_to_html

	def initialize( fragment, author = nil )
		@author = author
		if fragment[0] == ?! then
			@subtitle, @body = fragment.split( /\n/, 2 )
			@subtitle.sub!( /^\!\s*/, '' )
		else
			@subtitle = nil
			@body = fragment.dup
		end
		@body = @body || ''
		@body.sub!( /[\n\r]+\Z/, '' )
		@body << "\n\n"
		@parser = WikiParser::new( :wikiname => false ).parse( to_src )

		@categories = get_categories
		@stripped_subtitle = strip_subtitle

		@subtitle_to_html = @subtitle ? to_html("!#{@subtitle}") : nil
		@stripped_subtitle_to_html = @stripped_subtitle ? to_html("!#{@stripped_subtitle}") : nil
		@body_to_html = to_html(@body)
	end

	def body
		@body.dup
	end

	def to_src
		r = ''
		r << "! #{@subtitle}\n" if @subtitle
		r << @body
	end

	def html4( date, idx, opt )
		r = %Q[<div class="section">\n]
		r << do_html4( @parser, date, idx, opt )
		r << "</div>\n"
	end

	def do_html4( parser, date, idx, opt )
		r = ""
		stat = nil
		subtitle = false
		parser.each do |s|
			stat = s if s.class == Symbol
			case s

			# subtitle heading
			when :HS1
				r << "<h3>"
				if date
					r << "<a "
					if opt['anchor'] then
						r << %Q[name="p#{'%02d' % idx}" ]
					end
					r << %Q[href="#{opt['index']}<%=anchor "#{date.strftime( '%Y%m%d' )}#p#{'%02d' % idx}" %>">#{opt['section_anchor']}</a> ]
				end
				if opt['multi_user'] and @author then
					r << %Q|[#{@author}]|
				end
				subtitle = true
			when :HE1; r << "</h3>\n"

			# other headings
			when :HS2, :HS3, :HS4, :HS5; r << "<h#{s.to_s[2,1].to_i + 2}>"
			when :HE2, :HE3, :HE4, :HE5; r << "</h#{s.to_s[2,1].to_i + 2}>\n"

			# pargraph
			when :PS
				r << '<p>'
				if (!subtitle and date) then
					r << '<a '
					if opt['anchor'] then
						r << %Q[name="p#{'%02d' % idx}" ]
					end
					r << %Q[href="#{opt['index']}<%=anchor "#{date.strftime( '%Y%m%d' )}#p#{'%02d' % idx}" %>">#{opt['section_anchor']}</a>]
				end
			when :PE; r << "</p>\n"

			# horizontal line
			when :RS; r << "<hr>\n"
			when :RE

			# blockquote
			when :QS; r << "<blockquote>\n"
			when :QE; r << "</blockquote>\n"

			# list
			when :US; r << "<ul>\n"
			when :UE; r << "</ul>\n"

			# ordered list
			when :OS; r << "<ol>\n"
			when :OE; r << "</ol>\n"

			# list item
			when :LS; r << "<li>"
			when :LE; r << "</li>\n"

			# definition list
			when :DS; r << "<dl>\n"
			when :DE; r << "</dl>\n"
			when :DTS; r << "<dt>"
			when :DTE; r << "</dt>"
			when :DDS; r << "<dd>"
			when :DDE; r << "</dd>\n"

			# formatted text
			when :FS; r << '<pre>'
			when :FE; r << "</pre>\n"

			# table
			when :TS; r << "<table border=\"1\">\n"
			when :TE; r << "</table>\n"
			when :TRS; r << "<tr>\n"
			when :TRE; r << "</tr>\n"
			when :TDS; r << "<td>"
			when :TDE; r << "</td>"

			# emphasis
			when :ES; r << "<em>"
			when :EE; r << "</em>"

			# strong
			when :SS; r << "<strong>"
			when :SE; r << "</strong>"

			# delete
			when :ZS; r << "<del>"
			when :ZE; r << "</del>"

			# Keyword
			when :KS; r << '<'
			when :KE; r << '>'

			# Plugin
			when :GS; r << '<%='
			when :GE; r << '%>'

			# URL
			when :XS; #r << '<a href="'
			when :XE; #r << '</a>'

			else
				s = CGI::escapeHTML( s ) unless stat == :GS
				case stat
				when :KS
					r << keyword(s)
				when :XS
					case s
					when /^mailto:/
						r << %Q[<a href="#{s}">#{s.sub( /^mailto:/, '' )}</a>]
					when /\.(jpg|jpeg|png|gif)$/
						r << %Q[<img src="#{s}" alt="#{File::basename( s )}">]
					else
						r << %Q[<a href="#{s}">#{s}</a>]
					end
				when :HS1
					r << s.gsub(/\[(.*?)\]/) do
						$1.split(/,/).collect do |c|
							%Q|<%= category_anchor("#{c}") %>|
						end.join
					end
				else
					r << s if s.class == String
				end
			end
		end
		r
	end

	def chtml( date, idx, opt )
		r = ''
		stat = nil
		subtitle = false
		@parser.each do |s|
			stat = s if s.class == Symbol
			case s

			# subtitle heading
			when :HS1
				r << %Q[<H3><A NAME="p#{'%02d' % idx}">*</A> ]
				if opt['multi_user'] and @author then
					r << %Q|[#{@author}]|
				end
				subtitle = true
			when :HE1; r << "</H3>\n"

			# other headings
			when :HS2, :HS3, :HS4, :HS5; r << "<H#{s.to_s[2,1].to_i + 2}>"
			when :HE2, :HE3, :HE4, :HE5; r << "</H#{s.to_s[2,1].to_i + 2}>\n"

			# paragraph
			when :PS
				r << '<P>'
				unless subtitle then
					r << '<A '
					if opt['anchor'] then
						r << %Q[NAME="p#{'%02d' % idx}"]
					end
					r << %Q[>*</A>]
				end
			when :PE; r << "</P>\n"

			# horizontal line
			when :RS; r << "<HR>\n"
			when :RE

			# blockquote
			when :QS; r << "<BLOCKQUOTE>\n"
			when :QE; r << "</BLOCKQUOTE>\n"

			# list
			when :US; r << "<UL>\n"
			when :UE; r << "</UL>\n"

			# ordered list
			when :OS; r << "<OL>\n"
			when :OE; r << "</OL>\n"

			# list item
			when :LS; r << "<LI>"
			when :LE; r << "</LI>\n"

			# definition list
			when :DS; r << "<DL>\n"
			when :DE; r << "</DL>\n"
			when :DTS; r << "<DT>"
			when :DTE; r << "</DT>"
			when :DDS; r << "<DD>"
			when :DDE; r << "</DD>\n"

			# formatted text
			when :FS; r << '<PRE>'
			when :FE; r << "</PRE>\n"

			# table
			when :TS; r << "<TABLE BORDER=\"1\">\n"
			when :TE; r << "</TABLE>\n"
			when :TRS; r << "<TR>\n"
			when :TRE; r << "</TR>\n"
			when :TDS; r << "<TD>"
			when :TDE; r << "</TD>"

			# emphasis
			when :ES; r << "<EM>"
			when :EE; r << "</EM>"

			# strong
			when :SS; r << "<STRONG>"
			when :SE; r << "</STRONG>"

			# delete
			when :ZS; r << "<DEL>"
			when :ZE; r << "</DEL>"

			# Keyword
			when :KS; r << '<'
			when :KE; r << '>'

			# Plugin
			when :GS; r << '<%='
			when :GE; r << '%>'

			# URL
			when :XS; r << '<A HREF="'
			when :XE; r << '</A>'

			else
				s = CGI::escapeHTML( s ) unless stat == :GS
				case stat
				when :KS
					r << keyword(s, true)
				when :XS
					r << s << '">' << s.sub( /^mailto:/, '' )
				else
					r << s if s.class == String
				end
			end
		end
		r
	end

	def to_s
		to_src
	end

private
	def keyword( s, mobile = false )
		r = ''
		if /\|/ =~ s
			k, u = s.split( /\|/, 2 )
			if /^(\d{4}|\d{6}|\d{8})[^\d]*?#?([pct]\d\d)?$/ =~ u then
				r << %Q[%=my '#{$1}#{$2}', '#{k}' %]
			elsif /:/ =~ u
				scheme, path = u.split( /:/, 2 )
				if /\A(?:http|https|ftp|mailto)\z/ =~ scheme
					if mobile
						r << %Q[A HREF="#{u}">#{k}</A]
					else
						r << %Q[a href="#{u}">#{k}</a]
					end
				else
					r << %Q[%=kw '#{u}', '#{k}'%]
				end
			else
				r << %Q[a href="#{u}">#{k}</a]
			end
		else
			r << %Q[%=kw '#{s}' %]
		end
		r
	end

	def to_html(string)
		parser = WikiParser::new( :wikiname => false ).parse( string )
		parser.delete_at(0) if parser[0] == :HS1
		parser.delete_at(-1) if parser[-1] == :HE1
		r = do_html4(parser, nil, nil, {})
		if r == ""
			nil
		else
			r
		end
	end

	def get_categories
		return [] unless @subtitle
		cat = /^(\[([^\[]+?)\])+/.match(@subtitle).to_a[0]
		return [] unless cat
		cat.scan(/\[(.*?)\]/).collect do |c|
			c[0].split(/,/)
		end.flatten
	end

	def strip_subtitle
		return nil unless @subtitle
		@subtitle.sub(/^(\[[^\[]+?\])+\s*/,'')
	end
end

class WikiDiary

	def initialize( date, title, body, modified = Time::now )
		init_diary
		replace( date, title, body )
		@last_modified = modified
	end

	def style
		'Wiki'
	end

	def replace( date, title, body )
		set_date( date )
		set_title( title )
		@sections = []
		append( body )
	end

	def append( body, author = nil )
		section = nil
		body.each do |l|
			case l
			when /^\![^!]/
				@sections << WikiSection::new( section, author ) if section
				section = l
			else
				section = '' unless section
				section << l
			end
		end
		@sections << WikiSection::new( section, author ) if section
		@last_modified = Time::now
		self
	end

	def each_section
		@sections.each do |section|
			yield section
		end
	end

	def to_src
		r = ''
		each_section do |section|
			r << section.to_src
		end
		r
	end

	def to_html( opt, mode = :HTML )
		case mode
		when :CHTML
			to_chtml( opt )
		else
			to_html4( opt )
		end
	end

	def to_html4( opt )
		r = ''
		idx = 1
		each_section do |section|
			r << section.html4( date, idx, opt )
			idx += 1
		end
		r
	end

	def to_chtml( opt )
		r = ''
		idx = 1
		each_section do |section|
			r << section.chtml( date, idx, opt )
			idx += 1
		end
		r
	end

	def to_s
		"date=#{date.strftime('%Y%m%d')}, title=#{title}, body=[#{@sections.join('][')}]"
	end
end

def amazon_image(asin, size)
	sizeinfo = case size
	when "S"
		{:name=>'THUMBZZZ', :width=>40, :height=>60}
	when "M"
		{:name=>'MZZZZZZZ', :width=>93, :height=>140}
	when "L"
		{:name=>'LZZZZZZZ', :width=>317, :height=>475}
	end

	%!<img src="http://images-jp.amazon.com/images/P/#{asin}.#{if asin=~/^4/;"09";else;"01";end}.#{sizeinfo[:name]}.jpg" width="#{sizeinfo[:width]}" height="#{sizeinfo[:height]}">!
end

$amazon_affiliate_id = "tokuhirom-22"
$bk1_id = 'p-tokuhiro79566'
$amazon_token = 'D1V1QYMOC8PJVB'
$amazon_xsl = CGI.escape("http://www13.ocn.ne.jp/~tokuhiro/aws.xsl")

def isbn_heavy(isbn)
  isbn1 = isbn.to_s.gsub(/ISBN/i, "")
  isbn2 = isbn1.gsub(/-/, "")

	s=''
	s << %!<iframe width="640" height="480" frameborder="0" hspace="0" vspace="0" title="price" marginheight="0" marginwidth="0"!
	s << %!src="http://xml-jp.amznxslt.com/onca/xml3?dev-t=#{$amazon_token}&amp;t=#{$amazon_affiliate_id}&amp;f=#{$amazon_xsl}&amp;locale=jp&amp;type=heavy&amp;AsinSearch=#{isbn2}">!
	s << %!<a href="$amazon_link">!
	s << %!<img src="http://images-jp.amazon.com/images/P/#{isbn2}.MZZZZZZZ.jpg">!
	s << %!</a>!
	s << %![<a href="$amazon_link">amazon</a>]!
	s << %!</iframe>!
	s << "[ <a href='http://breeder.bk1.jp/rd/#{isbn1}/#{$bk1_affiliate_id}/noentry'> bk1 </a> ]"
end

def isbn(isbn, bookname = "", size="S")
  isbn1 = isbn.to_s.gsub(/ISBN/i, "")
  isbn2 = isbn1.gsub(/-/, "")

  if bookname == ""
    buf = ""
  else
    buf = "#{bookname.escapeHTML}"
  end

  amazon_link = "http://www.amazon.co.jp/exec/obidos/ASIN/#{isbn2}/#{$amazon_affiliate_id}/ref=nosim/"

  s  = ""
  s << %!<a href="#{amazon_link}">#{amazon_image(isbn2, size)}</a>!
  s << "["
  s << %!<a href="#{amazon_link}">amazon</a> / !
  s << %!<a href="http://www.bk1.co.jp/cgi-bin/srch/srch_result_book.cgi?idx=3&amp;isbn=#{isbn1}&amp;aid=#{$bk1_affiliate_id}">bk1</a>!
  s << "]"
  s << buf
end

def wiki_style_filter
  if @fext == 'wiki'
	text = WikiSection.new(@body).html4(nil, nil, {})
	
	text.gsub!(/isbn_heavy:([0-9xX]{9,12})/) do |x|
		isbn_heavy($1)
	end
	
	text.gsub!(/isbn:([0-9xX]{9,12})/) do |x|
		isbn($1)
	end
	
	@body = text
  end
end
