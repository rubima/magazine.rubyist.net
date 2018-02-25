---
layout: post
title: 0015-CodeReview-tropy2.rb
short_title: 0015-CodeReview-tropy2.rb
tags: 0015 CodeReview
---
{% include base.html %}


[あなたの Ruby コードを添削します 【第 4 回】 Tropy]({{base}}{% post_url articles/0015/2006-07-13-0015-CodeReview %}) で解説した、添削後のソースコード tropy.rb です。

```ruby
#
# tropy.rb - Tropy in Ruby, Version 2
#
# Copyright (C) 2005,2006 by Hiroshi Yuki.
# http://www.hyuki.com/tropy/
#
# 2006-07-07 modified by Minero Aoki
#
# You can redistribute and/or modify it under the same terms as Ruby.
#

require 'pstore'
require 'cgi'
require 'erb'
require 'nkf'
require 'stringio'

unless Object.method_defined?(:funcall)
  class Object
    alias funcall __send__
  end
end

class CGI
  def get(key)
    a = params()[key]
    a ? a[0] : nil
  end
end

module Tropy

  class Application
    def initialize(db, manager)
      @db = db
      @screenmanager = manager
    end

    def cgi_main
      screen = handle(CGI.new)
      print screen.http_response
    end

    # FIXME: not implemented yet
    #def fcgi_main
    #end

    def handle(req)
      cmd, *args = parse_request(req)
      funcall("handle_#{cmd}", *args)
    rescue => err
      return error_response(err)
    end

    private

    def parse_request(req)
      # For backward compatibility
      req.params.each_key do |k|
        case k
        when /\A(\d{8})\z/  then return "view", $1
        when /\Ae(\d{8})\z/ then return "edit", $1
        when /\Aw(\d{8})\z/ then return "write", $1, req.params['msg'][0]
        when /\Ac\z/        then return "create"
        end
      end
      if req.params.key?('id')
        case req.get('cmd')
        when 'view', nil then return 'view', req.get('id')
        when 'edit'      then return 'edit', req.get('id')
        when 'save'      then return 'save', req.get('id'), req.get('text')
        when 'create'    then return 'create'
        end
      end
      return "drift"
    end

    def error_response(err)
      ErrorScreen.new(err)
    end

    def handle_view(id)
      page = @db[id]
      return handle_create() unless page
      @screenmanager.view_page_screen(id, page)
    end

    def handle_drift
      id, page = *@db.random
      return handle_create() unless id
      @screenmanager.view_page_screen(id, page)
    end

    def handle_create
      id, page = *@db.create
      @screenmanager.edit_page_screen(id, page)
    end

    def handle_edit(id)
      page = @db[id] || Page.empty
      @screenmanager.edit_page_screen(id, page)
    end

    def handle_save(id, src)
      if src.to_s.strip.empty?
        @db.delete id.to_s
        @screenmanager.redirect
      else
        @db[id] = @db.parse_page(src)
        @screenmanager.redirect_page(id)
      end
    end
  end


  class URLMapper
    def initialize(baseurl)
      @url = baseurl
    end

    attr_reader :url

    def drift
      @url
    end

    def view(id)
      "#{@url}?#{id}"
    end

    def edit(id)
      "#{@url}?e#{id}"
    end

    def create
      "#{@url}?c"
    end

    def write(id)
      "#{@url}?w#{id}"
    end
  end


  class ScreenManager
    def initialize(h)
      @urlmapper = URLMapper.new(h[:baseurl])
      @params = Params.new(@urlmapper,
                           TemplateRepository.new(h[:templatedir]),
                           h[:theme])
    end

    def view_page_screen(id, page)
      ViewPageScreen.new(@params, id, page)
    end

    def edit_page_screen(id, page)
      EditPageScreen.new(@params, id, page)
    end

    def redirect_top
      RedirectScreen.new(@params, @urlmapper.url)
    end

    def redirect_page(id)
      RedirectScreen.new(@params, @urlmapper.view(id))
    end

    class Params
      def initialize(umap, tmpl, theme)
        @urlmapper = umap
        @template_repository = tmpl
        @theme = theme
      end

      attr_reader :urlmapper
      attr_reader :template_repository

      def css_url
        "#{@theme}/style.css"
      end
    end
  end

  class TemplateRepository
    def initialize(prefix)
      @prefix = prefix
    end

    def load(id)
      File.read("#{@prefix}/#{id}")
    end
  end

  class Screen
    def http_response
      body = body()
      out = StringIO.new
      out.puts "Content-Type: #{content_type()}"
      out.puts "Content-Length: #{body.length}"
      out.puts
      out.puts body
      out.string
    end

    private

    def escape_html(s)
      CGI.escapeHTML(s)
    end
  end

  class ErrorScreen < Screen
    def initialize(err)
      @error = err
    end

    def content_type
      'text/html'
    end

    def body
      <<-EndHTML
<html>
<head><title>Error</title></head>
<body>
<h1>Error</h1>
<pre>#{escape_html(@error.message)} (#{escape_html(@error.class.name)})
#{@error.backtrace.map {|s| escape_html(s) }.join("\n")}</pre>
</body>
</html>
      EndHTML
    end
  end

  class TemplateScreen < Screen
    def initialize(params)
      @params = params
      @urlmapper = params.urlmapper
      @template_repository = params.template_repository
    end

    private

    def run_template(id)
      erb = ERB.new(@template_repository.load(id))
      erb.filename = id
      erb.result(binding())
    end

    alias h escape_html
  end

  class PageBoundScreen < TemplateScreen
    def initialize(params, id, page)
      super params
      @id = id
      @page = page
    end

    def content_type
      "text/html; charset=#{@page.encoding}"
    end
  end

  class ViewPageScreen < PageBoundScreen
    def editable?
      true
    end

    def body
      run_template('view')
    end
  end

  class EditPageScreen < PageBoundScreen
    def editable?
      false
    end

    def body
      run_template('edit')
    end
  end

  class RedirectScreen < TemplateScreen
    def initialize(params, desturl)
      super params
      @desturl = desturl
    end

    def content_type
      "text/html"
    end

    def body
      run_template('thanks')
    end
  end


  class Database
    def initialize(path, encoding)
      @pstore = PStore.new(path)
      @encoding = encoding
    end

    def parse_page(src)
      Page.parse(to_local(src), @encoding)
    end

    def to_local(str)
      case @encoding
      when 'shift_jis'
        NKF.nkf("-m0 -s", str)
      when 'euc-jp'
        NKF.nkf("-m0 -e", str)
      else
        raise "unsupported encoding: #{@encoding.inspect}"
      end
    end
    private :to_local

    def ids
      @pstore.transaction(true) {|ps| ps.roots }
    end

    def [](id)
      @pstore.transaction(true) {|store|
        store[id]
      }
    end

    def []=(id, page)
      @pstore.transaction {|store|
        store[id.to_s] = page
      }
    end

    def random
      @pstore.transaction(true) {|store|
        ids = store.roots
        id = ids[rand(ids.size)]
        return id, store[id]
      }
    end

    def create
      @pstore.transaction(true) {|store|
        id = sprintf("%08d", rand(10 ** 8))
        if store.root?(id)
          return id, store[id]
        else
          return id, Page.empty
        end
      }
    end

    def delete(id)
      @pstore.delete(id)
    end
  end

  class Page
    def Page.parse(src, encoding = nil)
      title, *body = src.to_a
      new(title.strip, body.join(''), encoding)
    end

    def Page.empty
      new("New Page", "")
    end

    def initialize(title, body, encoding = nil)
      @title = title
      @body = body
      @encoding = encoding
    end

    attr_reader :title
    attr_reader :body
    attr_reader :encoding

    def source
      "#{@title}\n#{@body}"
    end

    def body_html
      body = CGI.escapeHTML(@body).gsub(/\n/, "<br>")
      "<p>#{body}</p>"
    end
  end

end

```


