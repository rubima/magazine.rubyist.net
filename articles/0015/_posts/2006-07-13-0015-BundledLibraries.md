---
layout: post
title: 標準添付ライブラリ紹介 【第 8 回】 uri, pathname
short_title: 標準添付ライブラリ紹介 【第 8 回】 uri, pathname
tags: 0015 BundledLibraries
---
{% include base.html %}


書いた人：西山

## はじめに

Ruby には便利な標準添付ライブラリがたくさんありますが、なかなか知られていないのが現状です。そこで、この連載では Ruby の標準添付ライブラリを紹介していきます。

今回は、リソースの場所を扱うライブラリ uri と pathname を紹介します。

## uri ライブラリ

uri は URI を扱うライブラリです。
ruby 1.8.4 では、ftp, http, https, ldap, mailto に対応しています。

### URI について

URI (Uniform Resource Identifiers; RFC 3986) とは、
世界中のリソースを一意に表現するためのもので、
URL (Uniform Resource Locators; RFC 1738) 以外に
URN (Uniform Resource Names; RFC 2141) も含んだ呼び方です
(参考:[http://www.alib.jp/html/uri.html](http://www.alib.jp/html/uri.html))。
さらに URI を多言語に対応させた IRI (Internationalized Resource Identifier; RFC 3987) というものもあります。

URN は、「urn:ietf:rfc:2141」のように「urn:」で始まる URI です。
URN や IRI は今回は扱いませんが、そういうものがあるということを知っておくと役に立つことがあるかもしれません。

### 基本的な使い方

URI.parse を使うと、URI を表す文字列から URI オブジェクトを生成できます。

{% highlight text %}
{% raw %}
require 'uri'
uri = URI.parse('http://jp.rubyist.net/magazine/?0015-BundledLibraries#l5')
p uri.class
p [uri.scheme, uri.host, uri.port, uri.path, uri.query, uri.fragment]

uri = URI.parse('ftp://ftp.ruby-lang.org/pub/ruby/ruby-1.8.4.tar.gz')
p uri.class
p [uri.scheme, uri.host, uri.port, uri.path]

uri = URI.parse('mailto:foo@example.com?body=test&cc=bar@example.org')
p uri.class
p [uri.scheme, uri.to, uri.headers]

uri = URI.parse('file:/usr/bin/ruby')
p uri.class
p [uri.scheme, uri.path]
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
URI::HTTP
["http", "jp.rubyist.net", 80, "/magazine/", "0015-BundledLibraries", "l5"]
URI::FTP
["ftp", "ftp.ruby-lang.org", 21, "/pub/ruby/ruby-1.8.4.tar.gz"]
URI::MailTo
["mailto", "foo@example.com", [["body", "test"], ["cc", "bar@example.org"]]]
URI::Generic
["file", "/usr/bin/ruby"]
{% endraw %}
{% endhighlight %}


対応している scheme の場合はそれぞれのクラスのオブジェクトが生成されています。
file scheme には対応していないので、URI::Generic クラスのオブジェクトになっています。

そして、それぞれの構成要素が host や path などのメソッドで取り出せるようになっています。

HTTP の場合の URI の構成要素は、

* uri.scheme: "http"
* uri.host: "jp.rubyist.net"
* uri.port: 80 (省略されていたので HTTP のデフォルトポート番号)
* uri.path: "/magazine/"
* uri.query: "0015-BundledLibraries"
* uri.fragment: "l5"


になります。

#### URI()

ruby 1.8.2 以降では、URI.parse() の代わりに URI() も使えます。
この URI は URI クラスとは直接の関係はなく、URI という名前の関数的メソッドです。

{% highlight text %}
{% raw %}
require 'uri'
uri = URI('http://jp.rubyist.net/magazine/?0015-BundledLibraries#l5')
p uri.class
p [uri.scheme, uri.host, uri.port, uri.path, uri.query, uri.fragment]
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
URI::HTTP
["http", "jp.rubyist.net", 80, "/magazine/", "0015-BundledLibraries", "l5"]
{% endraw %}
{% endhighlight %}


### net/http と組み合わせる

[前回]({% post_url articles/0013/2006-02-20-0013-BundledLibraries %}) の net/http を使って書かれていた get.rb のうち、
URI を構成要素に分割する部分を uri ライブラリを使って書くと次のようになります。

{% highlight text %}
{% raw %}
require 'net/http'
require 'uri'
uri = URI.parse('http://www.ruby-lang.org/ja/')
Net::HTTP.version_1_2
Net::HTTP.start(uri.host, uri.port) do |http|
  response = http.get(uri.request_uri)
  puts response.body
end
{% endraw %}
{% endhighlight %}


request_uri は query があれば path + '?' + query と同じで、
この例では query がないため path でも同じ結果になります。
http.get の引数として、一般的には request_uri を使っておけば良いと思います。

### open-uri と組み合わせる

open-uri と組み合わせると URI オブジェクトを open したり
URI オブジェクトから直接 read したり出来るようになります。

open したファイルや
直接 read して返される文字列は OpenURI::Meta が extend されていて、
メタ情報が取り出せるようになっています。

{% highlight text %}
{% raw %}
require 'open-uri'
uri = URI.parse('http://www.ruby-lang.org/en/')
uri.open do |f|
  f.each_line {|line| p line}
  p f.base_uri
  p f.charset
  p f.content_encoding
  p f.last_modified
end
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n"
"<html lang=\"en-US\">\n"
(途中省略)
"</html>\n"
#<URI::HTTP:0x20129736 URL:http://www.ruby-lang.org/en/>
"iso-8859-1"
[]
Tue Jun 27 23:47:31 JST 2006
{% endraw %}
{% endhighlight %}


通常のファイルと同じように each_line で内容を取り出したり、OpenURI::Meta のメソッドでメタ情報が取り出せていることがわかります。

以下の read で返される文字列でも同じように、OpenURI::Meta のメソッドでメタ情報が取り出せます。

{% highlight text %}
{% raw %}
require 'open-uri'
str = URI('http://www.ruby-lang.org/').read
puts str
p str.base_uri
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
(途中省略)
</html>
#<URI::HTTP:0x2017e286 URL:http://www.ruby-lang.org/en/>
{% endraw %}
{% endhighlight %}


[http://www.ruby-lang.org/](http://www.ruby-lang.org/) はリダイレクトされるので、文字列はリダイレクト先の内容になっていて、base_uri ではリダイレクト先の URI になっていることがわかります。

### その他のメソッド

その他のメソッドのうちのいくつかを簡単に紹介しておきます。
詳しくは、[ruby-man:URI](ruby-man:URI) を参照してください。

#### URI.join(uri_str, str, ...), URI::Generic#+(rel)

相対パスを扱うときに便利なメソッドです。

{% highlight text %}
{% raw %}
require 'uri'
uri = URI.parse('http://jp.rubyist.net/') + '/magazine/'
p uri
p URI.join('http://jp.rubyist.net/', '/magazine/')
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
#<URI::HTTP:0x2018af1c URL:http://jp.rubyist.net/magazine/>
#<URI::HTTP:0x2018ad64 URL:http://jp.rubyist.net/magazine/>
{% endraw %}
{% endhighlight %}


URI 2 つから相対パスを返す URI::Generic#-(src) や URI::Generic#route_to(dst) もあります。

#### URI.regexp([match_schemes])

URIにマッチする正規表現を返します。

引数なしの URI.regexp で返される正規表現は、一般的すぎてマッチしすぎてしまうことが多いので、scheme を限定して使うことをおすすめします。

{% highlight text %}
{% raw %}
require 'uri'
str = <<EOS
<a href="http://localhost/">localhost</a>
<a href="http://jp.rubyist.net/magazine/">Rubyist Magazine - るびま</a>
<a href="ftp://ftp.ruby-lang.org/pub/ruby/ruby-1.8.4.tar.gz">ruby 1.8.4</a>
:dt:dd
EOS
uri_re = URI.regexp
str.scan(uri_re) do
  p URI.parse($&)
end
puts
uri_re = URI.regexp(['http', 'https', 'ftp'])
str.scan(uri_re) do
  p URI.parse($&)
end
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
#<URI::HTTP:0x2018addc URL:http://localhost/>
#<URI::HTTP:0x2018acba URL:http://jp.rubyist.net/magazine/>
#<URI::FTP:0x2018ab98 URL:ftp://ftp.ruby-lang.org/pub/ruby/ruby-1.8.4.tar.gz>
#<URI::Generic:0x2018aa94 URL:dt:dd>

#<URI::HTTP:0x2018a92c URL:http://localhost/>
#<URI::HTTP:0x2018a80a URL:http://jp.rubyist.net/magazine/>
#<URI::FTP:0x2018a6e8 URL:ftp://ftp.ruby-lang.org/pub/ruby/ruby-1.8.4.tar.gz>
{% endraw %}
{% endhighlight %}


## pathname ライブラリ

pathname は Unix のパス名を扱うライブラリです。

Windows などの DOSISH な環境ではドライブ名やパスの区切り文字などで問題が起きる可能性があることに注意が必要です。
DOSISH については [ruby-man:DOSISH 対応](ruby-man:DOSISH 対応)も参照してください。

### 基本的な使い方

Pathname オブジェクトは Pathname.new(パスを表す文字列) で生成します。
パスが指すファイルに対する操作やパス名自体の文字列操作が出来ます。

#### ファイル関係

Pathname オブジェクトを使って、ファイル関係の操作がいろいろ出来ます。

{% highlight text %}
{% raw %}
require 'pathname'
path = Pathname.new('/usr/bin/ruby')
p path
p path.size
p path.executable?
p path.dirname
p path.basename
p path.split
p path.symlink?
p path.readlink
p path.realpath
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
#<Pathname:/usr/bin/ruby>
3504
true
#<Pathname:/usr/bin>
#<Pathname:ruby>
[#<Pathname:/usr/bin>, #<Pathname:ruby>]
true
#<Pathname:ruby1.8>
#<Pathname:/usr/bin/ruby1.8>
{% endraw %}
{% endhighlight %}


この例以外にも chmod などのファイル関係のメソッドがあります。

#### パス名関係

Pathname#+ や Pathname#parent などでパス名関連の操作が出来ます。

{% highlight text %}
{% raw %}
require 'pathname'
path = Pathname.new('/tmp')
p path
path += 'hoge'
p path
path2 = Pathname.new('foo/../bar')
p path2
path += path2
p path
p path.cleanpath
p path.parent
p path.cleanpath.parent
p path.absolute?
p path2.absolute?
p path.relative_path_from(Pathname.new('/bin'))
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
#<Pathname:/tmp>
#<Pathname:/tmp/hoge>
#<Pathname:foo/../bar>
#<Pathname:/tmp/hoge/foo/../bar>
#<Pathname:/tmp/hoge/bar>
#<Pathname:/tmp/hoge/foo/..>
#<Pathname:/tmp/hoge>
true
false
#<Pathname:../tmp/hoge/bar>
{% endraw %}
{% endhighlight %}


Pathname#cleanpath で「..」や「.」を減らしたパスを返したり、Pathname#parent で親ディレクトリを返したり、Pathname#relative_path_from で相対パスを返したり出来ます。

#### ディレクトリ関係

ディレクトリを作成する Pathname#mkdir や途中のディレクトリも含めて作成する Pathname#mkpath、
ディレクトリを削除する Pathname#rmdir や中身も含めて削除する Pathname#rmtree、
ディレクトリの中のファイルの Pathname オブジェクトを返す Pathname#children、
Find.find の代わりに使える Pathname#find など、ディレクトリ関連のメソッドもそろっています。

{% highlight text %}
{% raw %}
require 'pathname'
path = Pathname.new('/tmp/hoge')
exit if path.exist?
(path + 'fuga').mkpath
(path + 'foo').open('w'){|f| f.puts 'foo'}
(path + 'bar').open('w'){|f| f.puts 'bar'}
p path.children
path.find do |subpath|
  p subpath
end
path.rmtree
p path.exist?
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
[#<Pathname:/tmp/hoge/bar>, #<Pathname:/tmp/hoge/foo>, #<Pathname:/tmp/hoge/fuga>]
#<Pathname:/tmp/hoge>
#<Pathname:/tmp/hoge/fuga>
#<Pathname:/tmp/hoge/foo>
#<Pathname:/tmp/hoge/bar>
false
{% endraw %}
{% endhighlight %}


### Pathname()

ruby 1.8.5 以降では、URI() のように Pathname.new の代わりに Pathname() も使えます。

{% highlight text %}
{% raw %}
require 'pathname'
path = Pathname('/usr/bin/ruby')
p path
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
#<Pathname:/usr/bin/ruby>
{% endraw %}
{% endhighlight %}


## URI と Pathname の使用例

最後に URI と Pathname を区別せずに扱う例を紹介します。

URI と Pathname の両方に open などの同じ名前のメソッドが存在するので、うまく使うとローカルファイルとリモートのファイルを同じように扱えて便利です。

ここでは、一例として RSS ファイルの情報を表示するものを作ってみました。

{% highlight text %}
{% raw %}
#!/usr/bin/ruby
require 'open-uri'
require 'pathname'
require 'rss/1.0'
a = []
a << URI.parse('http://www.ruby-lang.org/en/index.rdf')
a << Pathname.new('/tmp/index.rdf')
a.each do |x|
  rss = nil
  x.open do |f|
    rss = RSS::Parser.parse(f)
  end
  puts rss.channel.about
  puts rss.channel.description
end
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
http://www.ruby-lang.org/en/index.rdf
Official site of Object Oriented Scripting Language "Ruby"
http://www.ruby-lang.org/en/index.rdf
Official site of Object Oriented Scripting Language "Ruby"
{% endraw %}
{% endhighlight %}


each の中で URI オブジェクトと Pathname オブジェクトが同じように扱えているのがわかると思います。

## 関連リンク

* [ruby-man:URI](ruby-man:URI)
* [ruby-man:open-uri](ruby-man:open-uri)
* [ruby-man:pathname](ruby-man:pathname)


## 著者について

西山和広。
[Ruby hotlinks 五月雨版](http://www.rubyist.net/~kazu/samidare/)
や
[Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)
のメンテナをやっています。
[Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)
はいつでも[執筆者募集中](ruby-man:執筆者募集)です。
何かあれば、マニュアル執筆編集に関する議論をするためのメーリングリスト rubyist@freeml.com ([参加方法](http://www.freeml.com/ctrl/html/MLInfoForm/rubyist)) へどうぞ。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}


