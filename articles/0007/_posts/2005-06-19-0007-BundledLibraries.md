---
layout: post
title: 標準添付ライブラリ紹介 【第 1 回】 XMLRPC4R
short_title: 標準添付ライブラリ紹介 【第 1 回】 XMLRPC4R
tags: 0007 BundledLibraries
---
{% include base.html %}


* Table of content
{:toc}


書いた人: 西山

## はじめに

### この連載について

Ruby 1.8 になって標準添付ライブラリ[^1]が増えました。
そんなライブラリをどんどん紹介していこうという連載です。

### 今回の記事について

今回は XMLRPC4R を中心にリモートのメソッドを呼び出すためのライブラリを簡単に紹介します。

## XMLRPC4R

### XML-RPCとは?

XML-RPC とは、HTTP の POST メソッド経由で XML をやりとりして
リモートホストのプロシージャを呼び出す仕組みです。
ここで言う「プロシージャ」とは、Ruby のメソッドと
ほぼ同じ意味にとっていただいて構いません。

サーバ側は普通の Web サーバを使いますが、
クライアント側は Web ブラウザではなく、
専用のクライアントを使うことが多いようです。

有名なところでは、Blogger API のように Blog のサーバと専用クライアントの
間のやりとりに使われています。

### クライアント

まずはクライアント側のプログラム、つまり RPC を発行する側について説明します。

#### クライアントの例

ruby のアーカイブの中にある lib/xmlrpc/README.txt
から例を紹介します。
ほぼそのまま引用しましたが、XMLRPC::Client の
インスタンスを server という変数に入れるのは紛らわしいので、
変数名を client に変更しました。

以下のコードを見てください。このコードでは XML-RPC
を使ってリモートプロシージャを呼び出しています。

{% highlight text %}
{% raw %}
 require 'xmlrpc/client'
 require 'pp'

 client = XMLRPC::Client.new2("http://xmlrpc-c.sourceforge.net/api/sample.php")
 result = client.call("sample.sumAndDifference", 5, 3)
 pp result #=> {"difference"=>2, "sum"=>8}
{% endraw %}
{% endhighlight %}


まず本体 1 行目の XMLRPC::Client.new2 からです。
この例では、XMLRPC::Client.new ではなく XMLRPC::Client.new2
を使って XMLRPC::Client のオブジェクトを生成しています。
この二つのメソッド違いは引き数の使い方です。
new は細かく引き数がわかれていますが、new2 は URI を直接指定できるため、
簡単に使いたい時は new2 を使い、細かい指定が必要な場合は new を使うと
良いでしょう。
この new2 の引き数の URI は「エンドポイント」と呼ばれることもあります。

次に、XMLRPC::Client#call で「sample.sumAndDifference」という
プロシージャを 5 と 3 を引き数として呼び出しています。

このようにクライアントは非常に簡単に作ることができます。

### サーバ

今度はサーバ側のプログラム、つまり RPC リクエストを受け取って、実際に処理する側について説明します。
すでに説明したように XML-RPC のサーバには HTTP サーバを使いますから、
HTTP サーバとの組み合わせ方によっていくつかの種類があります。

#### サーバの種類

XML-RPC のサーバのクラスとして、以下の 4 種類があります。

CGIServer
:  CGIで使うサーバ

ModRubyServer
:  mod_rubyで使うサーバ

Server
:  スタンドアロンで動くサーバ

WEBrickServlet
:  WEBrick の servlet として使うサーバ

どれも XMLRPC::BasicServer を継承していて、XML-RPC のサーバとしての
機能は BasicServer に実装されています。

#### サーバの例

この記事では、単独で実行できる XMLRPC::Server を使って説明します。
下記は、xmlrpc/server.rb のコメントに書かれている例です。

{% highlight text %}
{% raw %}
   require "xmlrpc/server"

   s = XMLRPC::Server.new(8080)

   s.add_handler("michael.add") do |a,b|
     a + b
   end

   s.add_handler("michael.div") do |a,b|
     if b == 0
       raise XMLRPC::FaultException.new(1, "division by zero")
     else
       a / b
     end
   end

   s.set_default_handler do |name, *args|
     raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
                                      " or wrong number of parameters!")
   end

   s.serve
{% endraw %}
{% endhighlight %}


まず、8080 番ポートで待ち受けるサーバを生成します。
そして add_handler で「michael.add」と「michael.div」という
ハンドラを追加します。
さらに set_default_handler で対応するハンドラが見つからなかった
時に呼ばれるハンドラを設定します。[^2]

最後に serve でサーバを実行します。

サーバを停止したい時は SIGHUP (HUP シグナル) をプログラムに送ると終了します。

#### XMLRPC::Server に接続するクライアントの例

XMLRPC::Server はパス部分を無視するので、ホスト名とポート番号さえ
あっていれば繋がるはずです。

{% highlight text %}
{% raw %}
 require 'xmlrpc/client'
 client = XMLRPC::Client.new2("http://localhost:8080/")
 p client.call("michael.add", 5, 3) #=> 8
 p client.call("michael.div", 5, 3) #=> 1
{% endraw %}
{% endhighlight %}


### XML-RPC の fault の処理

ここまでの例では簡略化のため、エラー処理については省略していました。
ここでは、fault の処理について説明します。
fault とは、XML-RPC の処理でのエラーのことです。
XML-RPC より下の層 (HTTP や TCP など) でのエラーについては、
他のエラーになります。

#### XMLRPC::Client#call でのエラー処理

接続先は、サーバの例で紹介したサーバを想定しています。

{% highlight text %}
{% raw %}
 require 'xmlrpc/client'
 client = XMLRPC::Client.new2("http://localhost:8080/")
 begin
   client.call("michael.add", 5)
 rescue XMLRPC::FaultException => e
   p e.faultCode #=> -99
   p e.faultString #=> "Method michael.add missing or wrong number of parameters!"
 end
{% endraw %}
{% endhighlight %}


call でわざと引き数の個数を間違えているので、
XMLRPC::FaultException という例外が発生しています。

fault に faultCode と faultString があるということは XML-RPC の仕様で
決まっていますが、内容については XML-RPC では決められていないので、

Blogger API などの個別の API の仕様を確認する必要があります。

#### XMLRPC::Client#call2 を使う

XMLRPC::Client の call2 メソッドを使う方法もあります。
call2 は呼び出し結果を 2 要素の配列で返します。
その中身は XML-RPC が成功か失敗かによって、

| 成功| [true, レスポンス]|
| 失敗| [false, XMLRPC::FaultExceptionオブジェクト]|


が入っています。

{% highlight text %}
{% raw %}
 require 'xmlrpc/client'
 client = XMLRPC::Client.new2("http://localhost:8080/")

 ok, result = client.call2("michael.add", 5, 3)
 if ok
   p result #=> 8
 else
   puts "Error: #{result.faultCode}: #{result.faultString}"
 end

 ok, result = client.call2("michael.add", 5)
 if ok
   p result
 else
   puts "Error: #{result.faultCode}: #{result.faultString}"
   #=> Error: -99: Method michael.add missing or wrong number of parameters!
 end
{% endraw %}
{% endhighlight %}


### XMLRPC::Client::Proxy を使う

call や call2 ではプロシージャ名を Ruby の文字列で指定する必要がありました。
しかし XMLRPC::Client::Proxy オブジェクトを使うと、
プロシージャ呼び出しを通常のメソッド呼び出しのように書くことができます。

{% highlight text %}
{% raw %}
 require 'xmlrpc/client'
 client = XMLRPC::Client.new2("http://localhost:8080/")
 michael = client.proxy("michael")
 p michael.add(5, 3) #=> 8
 p michael.div(5, 3) #=> 1
{% endraw %}
{% endhighlight %}


XMLRPC::Client#proxy を使うと、XMLRPC::Client::Proxy オブジェクトを作成できます。
この Proxy オブジェクトに対してメソッドを呼び出すと prefix (ここでは "michael") と呼び出されたメソッド名を "." で繋げた
XML-RPC プロシージャ呼び出しに変換されます。

call に対応する call2 があるように、proxy に対応する proxy2 があります。

{% highlight text %}
{% raw %}
 require 'xmlrpc/client'
 client = XMLRPC::Client.new2("http://localhost:8080/")
 michael = client.proxy2("michael")
 p michael.add(5, 3) #=> [true, 8]
 p michael.div(5, 3) #=> [true, 1]
{% endraw %}
{% endhighlight %}


#### プロシージャの名前の付け方

XML-RPC の仕様で決められているわけではないのですが、
このような呼び出しが出来るように、XML-RPC を使った API では、
「API名.メソッド名」という名前を付けることが多いようです。

このような名前の付け方は、クライアント側では Proxy オブジェクトを使って「API名」の部分を省略できるなどの利点があります。

### セキュリティに関する注意

さきほどは add_handler を常にブロック付きで使っていましたが、
add_handler の第 2 引数にオブジェクトを渡すと、そのオブジェクトのメソッドがまとめて公開されます。
次の例を見てください。

{% highlight text %}
{% raw %}
 class MyHandler
  def sumAndDifference(a, b)
     { "sum" => a + b, "difference" => a - b }
   end
 end

 s.add_handler("sample", MyHandler.new) # 注意: セキュリティホールあり!
{% endraw %}
{% endhighlight %}


このようなコードを書くと、MyHandler オブジェクトのメソッドがすべてまとめて公開されます。

問題は「すべて」という点です。この「すべて」にはスーパークラスのメソッドも含まれています。つまり Object#__send__ も公開されてしまいます。
__send__ を経由すると private メソッドも呼び出せるため、
system や exec や exit などの危険なメソッドも呼べてしまうのです。

主な対策は 3 通り考えられます。

1 つ目は、add_handler を常にブロック付きの形式で使うことです。

2 つ目は XMLRPC.iPIMethods を使って

{% highlight text %}
{% raw %}
 # 注意: バージョンによってはこの方法でも危険!
 s.add_handler(XMLRPC::iPIMethods("sample"), MyHandler.new)
{% endraw %}
{% endhighlight %}


とすることです。こうすると、MyHandler クラスで定義されている
public なインスタンスメソッドのみが公開されるようになるはずなのですが、
現在の Ruby に標準添付されている XMLRPC4R では
[Module#public_instance_methods](http://www.ruby-lang.org/ja/man/?cmd=view;name=Module#public_instance_methods)
の引数のデフォルトの変更の影響により、スーパークラスのメソッドも公開されてしまい、対策にならないようです。

3 つ目は以下のように XMLRPC.interface を使って定義する方法です。

{% highlight text %}
{% raw %}
 require "xmlrpc/server"

 class Num
   INTERFACE = XMLRPC::interface("num") {
     meth 'int add(int, int)', 'Add two numbers', 'add'
     meth 'int div(int, int)', 'Divide two numbers'
   }

   def add(a, b) a + b end
   def div(a, b) a / b end
 end


 s = XMLRPC::CGIServer.new
 s.add_handler(Num::INTERFACE, Num.new)
 s.serve
{% endraw %}
{% endhighlight %}


### XML-RPC で使える値の型

XML-RPC では実装がし易いものを目指しているため、基本的な型しか使えません。
Ruby のクラスと XML-RPC での対応は表の通りです。

| XML での要素名| 引き数のクラス| 返り値のクラス|
| &lt;i4&gt;または&lt;int&gt;| 符号付き32ビット整数の範囲内のInteger| Integer|
| &lt;boolean&gt;| true または false| true または false|
| &lt;string&gt;| String, Symbol| String|
| &lt;double&gt;| Float| Float|
| &lt;dateTime.iso8601&gt;| Date, Time, XMLRPC::DateTime| XMLRPC::DateTime|
| &lt;base64&gt;| XMLRPC::Base64| String|
| &lt;array&gt;| Array| Array|
| &lt;struct&gt;| Struct, Hash| Hash|
| &lt;fault&gt;|  - | XMLRPC::FaultException|


&lt;dateTime.iso8601&gt; はタイムゾーンを含んでいないため、タイムゾーンの情報は失なわれてしまうことに注意してください。タイムゾーンによってずれが発生すると困る場合は、サーバとクライアントの間であらかじめどのタイムゾーンを使うのか別途定めておく必要があります。

&lt;struct&gt; のキー部分には文字列しか使えません。

&lt;array&gt; と &lt;struct&gt; の値部分は入れ子に出来ます。

&lt;string&gt; には現在の Ruby に標準添付されている XMLRPC4R では厳密には US-ASCII しか使えません。
理由は、RFC3023 (XML Media Types)で text/xml は XML 宣言の encoding は無視して、charset を使うようになっていて、charset パラメータがない時は、us-ascii として扱うことになっているからです。
XMLRPC::Client では XMLRPC::Client#http_header_extra= (additionalHeaders) で charset 付きの Content-Type を設定すれば US-ASCII 以外も使えるようになります。
サーバとクライアントの両方が RFC3023 を無視してしまう実装になっている場合は US-ASCII 以外も使えてしまう可能性があります。

### Blogger API クライアントの例

XML-RPC についての基本的な説明が終わったところで、
XMLRPC4R を使って Blogger API を利用する実際のスクリプトを載せておきます。
このスクリプトでは、利用可能なメソッド一覧を取得しています。

[cocolog-mt_supportedMethods.rb]({{base}}{{site.baseurl}}/images/0007-BundledLibraries/cocolog-mt_supportedMethods.rb)
![cocolog-mt_supportedMethods.rb]({{base}}{{site.baseurl}}/images/0007-BundledLibraries/cocolog-mt_supportedMethods.rb)

この例では server_uri として、筆者が利用しているプロバイダの
[@nifty の ココログ](http://www.cocolog-nifty.com/)
の
[XML-RPC エンドポイント](http://help.cocolog-nifty.com/help/2004/03/q_xmlrpc.html)
を指定していますが、他の Blog サービスでも同じことが出来ると思います。

HTTP のプロキシの対応についてはここまででは説明していませんが、
XMLRPC::Client.new の引数に指定すると使うことが出来ます。

実際のメソッド呼び出しは引数なしで一番簡単な mt.supportedMethods を呼び出しています。
その結果コメントの中に書いたような文字列の配列が返ってきます。
今回はエラーが返ってくる可能性は低いですが、エラーの時の
XMLRPC::FaultException の処理も例として書いています。

この例を発展させていけば、オリジナルの Blog クライアントも作れるのではないかと思います。

### メソッド一覧の取得用メソッド

ここでは、Blog 用の XML-RPC でサポートされている可能性が高い「mt.supportedMethods」でメソッド一覧を取得しています。
最近の XML-RPC サーバでは「system.listMethods」でメソッド一覧が
取得できるかもしれません。

### メソッドの情報取得用メソッド

サーバの API の情報を調べるために、以下の 3 種類のメソッドが提案されています。

* array system.listMethods ()
* string system.methodHelp (string methodName)
* array system.methodSignature (string methodName)


「system.methodHelp」と「system.methodSignature」がサポートされていれば、
メソッド名の文字列を引き数として呼び出すと、メソッドに関する情報が取得できます。

XMLRPC4R のサーバでは、

{% highlight text %}
{% raw %}
 s.add_introspection
{% endraw %}
{% endhighlight %}


で system.listMethods と system.methodHelp と
system.methodSignature のハンドラが追加されます。

system.methodHelp と system.methodSignature で有用な情報を返すには
以下のように add_handler で signature や help を指定する必要があります。

{% highlight text %}
{% raw %}
 s.add_handler("michael.add", %w(int int int), "add arguments") do |a,b|
   a + b
 end
{% endraw %}
{% endhighlight %}


### 複数メソッドの同時呼び出し

XML-RPC には、一つの HTTP リクエストで複数のプロシージャを処理する system.multicall という仕組みが提案されています。
これを使うにはサーバとクライアントの両方で対応が必要です。

XMLRPC4R のサーバでは、

{% highlight text %}
{% raw %}
 s.add_multicall
{% endraw %}
{% endhighlight %}


で system.multicall のハンドラが追加されます。

一方クライアント側では、次のように XMLRPC::Client#multicall を使って呼び出します。

{% highlight text %}
{% raw %}
 s.multicall(
   ['michael.add', 3, 4],
   ['michael.sub', 4, 5]
 )
 # => [7, -1]
{% endraw %}
{% endhighlight %}


## その他のリモートメソッド呼び出し

Ruby には XMLRPC4R 以外にもリモートメソッド呼び出しに使えるライブラリがいくつか添付されています。drb と SOAP4R です。
この記事の最後にこの 2 つのライブラリを紹介しておきます。

### drb

drb は ruby 専用のリモートメソッド呼び出しライブラリです。
XMLRPC4R や SOAP4R などとは違って ruby プロセス同士でしか通信出来ませんが、
ruby で出来ることならほとんどなんでも出来ます。

元々 druby プロトコルを使ってリモートメソッド呼び出しを実現する実装のひとつの名前でしたが、他の実装が存在しないため druby と言っても同じ物を指します。

druby はデータをやりとりするときに Marshal を使っているため、サーバとクライアントの両方がほぼ同じバージョンの ruby を使っている必要があります。

詳しい使い方などは既にいろいろなドキュメントが存在するので、
[dRuby](http://www.druby.org/ilikeruby/druby.html) などを参照してください。

### SOAP4R

SOAP とは XML ベースのプロトコルで、HTTP 限定で データも特定のものしか扱えない XML-RPC とは違って汎用的なものになっています。

有名なところでは、Google Web API や Amazon Web サービスなどが SOAP で利用できます。

ここでは
[Google Web API](http://www.google.com/apis/)
を利用する例を紹介します。
~/.google_key にはあらかじめ Google Web APIs のライセンスキーを取得して、
その内容を書いたファイルを用意しておきます。

{% highlight text %}
{% raw %}
 require 'soap/wsdlDriver'

 google_key = File.read(File.expand_path('~/.google_key')).chomp
 google_wsdl = 'http://api.google.com/GoogleSearch.wsdl'
 google = SOAP::WSDLDriverFactory.new(google_wsdl).create_driver
 result =
   google.doGoogleSearch(google_key,
                         'ruby', 0, 1,
                         false, "", false,
                         'lang_ja', 'utf-8', 'utf-8')
 result.resultElements.each do |e|
   puts e['URL'] #=> http://www.ruby-lang.org/ja/
 end
{% endraw %}
{% endhighlight %}


google_wsdl には HTTP プロトコルの URL を指定していますが、
[file://...](file://...) でローカルファイルを指定することもできます。
doGoogleSearch の引数について、詳しいことは Google Web API のドキュメントを参照してください。ここでは ruby というキーワードで 1 番目だけを検索しています。
最後の URL 表示部分は、以前は e.URL でも良かったのですが、SOAP4R 1.5.3 から 1.5.4 での仕様変更で e.uRL になってしまったため、どちらのバージョンでも使える e['URL'] という書き方を使っています。

SOAP4R の具体的な使用例としては ruby のソースアーカイブに同梱されているテストスクリプトが参考になります。
アーカイブの test/soap 以下を探してください。

## 終わりに

XMLRPC4R 以外のライブラリについては本当に簡単に紹介するだけになってしまいましたが、この記事を参考にしてネットワーク越しのプログラムを楽しんで頂ければ幸いです。

## 参考サイト

* [Rubyリファレンスマニュアル - XMLRPC](http://www.ruby-lang.org/ja/man/?cmd=view;name=XMLRPC)
* [xmlrpc4r - XML-RPC for Ruby](http://www.fantasy-coders.de/ruby/xmlrpc4r/) (英語)
* [JF の XML-RPC HOWTO](http://www.linux.or.jp/JF/JFdocs/XML-RPC-HOWTO/index.html)
* [XML-RPC Home Page](http://www.xmlrpc.com/) (英語)
* [XML-RPC for C and C++: Overview](http://xmlrpc-c.sourceforge.net/) (英語)
* [RFC: system.multicall](http://www.xmlrpc.com/discuss/msgReader$1208) (英語)
* [dRuby](http://www.druby.org/ilikeruby/druby.html)
* [soap4r - Trac](http://dev.ctor.org/soap4r) (英語)


## 著者について

西山和広。
[Ruby hotlinks 五月雨版](http://www.rubyist.net/~kazu/samidare/)
や
[Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)
のメンテナをやっています。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}

----

[^1]: 標準ライブラリではないそうです
[^2]: 例として定義されているだけで、set_default_handler は定義しなくても構いません。
