---
layout: post
title: 標準添付ライブラリ紹介 【第 4 回】 1.8.3 更新情報
short_title: 標準添付ライブラリ紹介 【第 4 回】 1.8.3 更新情報
tags: 0010 BundledLibraries
---
{% include base.html %}


* Table of content
{:toc}


書いた人: 西山

## はじめに

今回は 1.8.3 がリリースされたと言うこともあり、1.8.2 から 1.8.3 で添付ライブラリがどのように変わったのかを簡単に紹介していきたいと思います。
詳細については [ruby-man:ruby 1.8.3 feature](ruby-man:ruby 1.8.3 feature) や ChangeLog などを参照してください。

## 非推奨（deprecated）になったライブラリ

非推奨という警告がでるようになったライブラリです。

cgi-lib
:  代わりに cgi を使ってください。

getopts,parsearg
:  代わりに optparse を使ってください。

importenv
:  グローバル変数は推奨されないので、代わりのライブラリはありません。

date/format
:  %1,%2,%3 が deprecated になりました。

## 添付されているバージョンが上がったもの または それに相当するもの

drb, rinda
:  変更点は [http://www2a.biglobe.ne.jp/~seki/ruby/drb_changelog_18.html](http://www2a.biglobe.ne.jp/~seki/ruby/drb_changelog_18.html) を参照してください。

erb
: h、html_escape、u、url_encode が module_function になり、include や extend しなくても ERB::Util.h(str) などで呼び出せるようになりました。

irb
:  0.9 から 0.9.5 になりました。

fileutils
:  いくつかのメソッドが追加されたり、機能追加されたりしています。詳細は [ruby-man:fileutils.rb](ruby-man:fileutils.rb) をご覧ください。

logger
:  formatter が追加されました。ファイルをシフトするときのレースコンディションが修正されました。

open-uri
:  https サポートが追加されました。

rdoc
:  いろいろな修正などがありました。詳細は ChangeLog を参照してください。

rexml
:  REXML::Version が 3.1.2.1 から 3.1.3 になりました。

resolv
:  バグ修正、SRV レコード対応、いくつかのメソッド追加がありました。

rss
:  RSS::VERSION が 0.1.2 から 0.1.5 になりました。

soap,wsdl,xsd
:  soap4r-1.5.3 から soap4r-1.5.5 になりました。変更点は [http://dev.ctor.org/soap4r/wiki/Changes-154](http://dev.ctor.org/soap4r/wiki/Changes-154) と [http://dev.ctor.org/soap4r/wiki/Changes-155](http://dev.ctor.org/soap4r/wiki/Changes-155) を参照してください。

net/http, net/https
:  WebDAV のメソッドをサポートするようになりました。

webrick
:  いくつかのメソッド追加やバグ修正などがありました。

xmlrpc
:  Content-Type に charset=utf-8 がつくようになりました（詳細は[標準添付ライブラリ紹介 【第 1 回】 XMLRPC4R]({% post_url articles/0007/2005-06-19-0007-BundledLibraries %})参照）。FaultException が Exception を直接継承するのではなく StandardError を継承するようになりました。XMLRPC::Server が GServer ではなく WEBrick を使うようになりました。その他いくつかの修正がありました。

yaml,syck
:  YAML::VERSION が 0.45 から 0.60 になりました。詳細は YAML 入門の連載などをご覧ください。

nkf
:  NKF::VERSION が "2.0.4 (2004-12-01)" から "2.0.5 (2005-04-10)" になりました。

openssl
:  新しいクラスやメソッドが追加されるなどのいろいろな変更がありました。

readline
:  libeditに対応しました。

socket
:  AIX 対応などの変更がありました。

stringio
:  StringIO#string が nil にならないようになりました。その他いくつかの修正がありました。

tcltklib, tk
:  いろいろな機能追加や修正などがありました。詳細は ChangeLog を参照してください。

WIN32OLE
:  WIN32OLE::VERSION が 0.5.9 から 0.6.5 になりました。

## 些細な変更があったもの

cgi
:  CGI::Cookie の実装に変更がありました。

date
:  例外のメッセージの変更などがありました。

debug
:  バグ修正がありました（[ruby-core:05419](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/05419)）。

delegate
:  Delegator オブジェクトが生成された後に定義されたメソッドに関しても、適切に委譲するようになりました。

ftools
:  バグ修正などがありました。

ipaddr
:  バグ修正がありました。

mathn
:  バグ修正がありました（[ruby-core:05806](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/05806)）。

mkmf
:  バグ修正などがありました。

monitor
:  1.9 での変更にあわせた実装変更のみがありました。

open3
:  Open3::popen3 実行後の $?.exitstatus が 0 になるように修正されました。

optparse
:  OptionParser#default_argv が追加されました。

ostruct
:  inspect が再帰対応しました。to_s が inspect への alias に変更されました。

pathname
:  unlink の実装変更がありました。

ping
:  StandardError も rescue するようになりました（[ruby-dev:26677](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/26677)）。

pp
:  主にコメント追加がありました。

profiler
:  バグ修正がありました（[ruby-dev:26118](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/26118)）。

set
:  warning 減少、コメント追加、テスト追加がありました。

tempfile
:  typo 修正がありました（Tempfile#unlink の Errno::EACCESS -&gt; Errno::EACCES）。

time
:  バグ修正や機能追加などがありました。

un
:  getopts の代わりに optparse を使うようになりました。

net/imap
:  certs の扱いが修正されました。

net/pop, net/smtp
:  net/protocol の修正にあわせた変更がありました。

net/telnet
:  sysread の代わりに readpartial を使うようになりました。

test/unit
:  Test::Unit::AutoRunner.run の実装変更、collect_file の実装変更がありました。

uri
: 「:pass」のように user 部分が空文字列の userinfo 対応（[ruby-dev:25667](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/25667)）、コメントの追加や修正がありました。

Win32API
:  バグ修正がありました（[ruby-core:5143](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/5143)）。

bigdecimal
:  バグ修正などがありました。

curses
:  メソッドの追加やバグ修正などがありました。

dbm
:  DBM#closed?、GDBM#closed?、SDBM#closed? が追加されました。

digest
:  OpenSSL-0.9.8 でコンパイルエラーになるのが修正されました。

dl
:  DragonFlyBSD 対応やバグ修正などがありました。

etc
:  グループパスワードがない環境でのバグ修正などがありました。

iconv
:  バグ修正などがありました。

io/wait
:  Win32 環境対応などがありました。

pty
:  例外のメッセージ変更などがありました。

strscan
:  例外のメッセージ変更やコメントの追加や修正がありました。

zlib
:  バグ修正などがありました。

## 挙動に変化のない変更だけだったもの

singleton
:  コメント追加がありました。

thread
:  コメントの追加や修正がありました。

timeout
:  コメント追加がありました。

cgi/session
:  コメント追加がありました。

## 著者について

西山和広。
[Ruby hotlinks 五月雨版](http://www.rubyist.net/~kazu/samidare/)
や
[Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)
のメンテナをやっています。
[Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)
はいつでも[執筆者募集中](ruby-man:執筆者募集)です。
何かあれば、マニュアル執筆編集に関する議論をするためのメーリングリスト rubyist@freeml.com（[参加方法](http://www.freeml.com/ctrl/html/MLInfoForm/rubyist)）へどうぞ。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}

----


