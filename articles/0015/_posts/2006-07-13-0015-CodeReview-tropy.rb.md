---
layout: post
title: 0015-CodeReview-tropy.rb
short_title: 0015-CodeReview-tropy.rb
created_on: 2006-07-13
tags: 0015 CodeReview
---
{% include base.html %}


[あなたの Ruby コードを添削します 【第 4 回】 Tropy]({{base}}{% post_url articles/0015/2006-07-13-0015-CodeReview %}) で添削した Tropy のソースコード (添削前) です。

```ruby
#
# tropy.rb - Tropy in Ruby, Version 0.2
#
# Copyright (C) 2005,2006 by Hiroshi Yuki.
# http://www.hyuki.com/tropy/
#
# You can redistribute and/or modify it under the same terms as Ruby.
#
require "cgi"
require "nkf"
require "pstore"

CHARSET = "Shift_JIS"
NKF_OPTION = "-m0 -s"

BEGIN { $defout.binmode }

module Tropy

  # idとメッセージ（タイトルと本体）を管理
  class Database < PStore
    INDEX = "index" # id一覧保存用のキー

    def initialize(filename)
      super(filename)
      transaction do
        unless self[INDEX]
          self[INDEX] = []
        end
      end
    end

    def empty?
      transaction(true) do
        self[INDEX].length == 0
      end
    end

    # 存在するidからランダムに一個選択
    def random_id
      transaction(true) do
        size = self[INDEX].length
        self[INDEX][rand(size)]
      end
    end

    # 存在の有無にかかわらずランダムなidを一個生成
    def create_id
      sprintf("%08d", rand(10 ** 8))
    end

    # idを追加
    def add_id(id)
      unless self[INDEX].index(id)
        self[INDEX] << id
      end
    end

    # idを削除
    def delete_id(id)
      index = self[INDEX].index(id)
      if index
        self[INDEX].delete_at(index)
      end
    end

    # idのページにメッセージmを保存
    def set_msg(id, m)
      id = id.to_s
      m = NKF::nkf(NKF_OPTION, m.to_s)
      transaction do
        if m.length > 0
          self[id] = m
          add_id(id)
        else
          self.delete(id)
          delete_id(id)
        end
      end
    end

    # idのページのメッセージ
    def msg(id)
      transaction(true) do
        self[id.to_s].to_s
      end
    end

    # idのページのタイトル（一行目）
    def title(id)
      if msg(id) =~ /^(.*)$/
        $1
      else
        ""
      end
    end

    # idのページの本体（二行目以降）
    def body(id)
      msg(id).sub!(/^.*$/, "")
    end
  end

  class Tropy
    def initialize(cgi, db)
      @db = db
      begin
        cgi.params.each_key do |k|
          if k =~ /^(\d{8})$/
            @id = $1
            do_read
          elsif k =~ /^e(\d{8})$/
            @id = $1
            do_edit
          elsif k =~ /^w(\d{8})$/
            @id = $1
            do_write(cgi.params["msg"])
          elsif k =~ /^c$/
            @id = @db.create_id
            do_create
          end
        end
        unless @id
          if @db.empty?
            @id = @db.create_id
            do_create
          else
            @id = @db.random_id
            do_read
          end
        end
      rescue
        print error
      end
    end

    # 新規ページ作成フォームを表示
    def do_create
      print header("New Page"), editform, footer
    end

    # @idで指定したページを表示
    def do_read
      print header(@db.title(@id), :editable), content, footer
    end

    # @idで指定したページの編集フォームを表示
    def do_edit
      print header(@db.title(@id)), editform, footer
    end

    # @idで指定したページにmsgを書き込む
    def do_write(msg)
      @db.set_msg(@id, msg)
      print "Location: #{ABSOLUTE_URL}?#{@id}\n\n"
    end

    # 編集フォーム
    def editform
      escmsg = CGI.escapeHTML(@db.msg(@id))
      <<-"EOD"
<form action="#{ABSOLUTE_URL}" method="post">
<input type="hidden" name="w#{@id}" value="1">
<textarea cols="#{MAX_COLS}" rows="#{MAX_ROWS}" name="msg">#{escmsg}</textarea><br>
<input type="submit" value="Write">
</form>
      EOD
    end

    # 中身
    def content
      body = CGI.escapeHTML(@db.body(@id))
      body.gsub!(/\n/, "<br />")
      "<p>#{body}</p>"
    end

    # ヘッダ
    def header(title, editable=nil)
      edit = editable == :editable ? %Q(<a href="?e#{@id}">Edit</a>) : ''
      create = %Q(<a href="?c">Create</a>)
      random = %Q(<a href="#{ABSOLUTE_URL}">Random</a>)
      <<-"EOD"
Content-type: text/html; charset=#{CHARSET}

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ja">
<head>
<meta http-equiv="content-type" content="text/html; charset=#{CHARSET}">
<meta http-equiv="content-style-type" content="text/css">
<base href="#{ABSOLUTE_URL}">
<style type="text/css"><!--
body{font-family:Verdana,sans-serif;margin:2% 20% 10% 20%;color:black;background-color:white;}
input{font-family:Verdana,sans-serif;}
#navi{text-align:right;}
p{line-height:150%;}
a{color:gray;background-color:white;text-decoration:none;}
a:hover{text-decoration:underline;color:white;background-color:gray;}
--></style>
<title>#{title} - #{TITLE}</title>
</head>
<body>
<p id="navi">#{edit} #{create} #{random}</p>
<h1>#{title}</h1>
      EOD
    end

    # フッタ
    def footer
      "</div></body></html>"
    end

    # エラー
    def error
      <<-"EOD"
Content-Type: text/html

<html><head><title>Error</title></head><body><h1>Error</h1><pre>
#{$!}
#{$!.class}
#{$@.join("\n")}
</pre>
      EOD
    end
  end
end

```


