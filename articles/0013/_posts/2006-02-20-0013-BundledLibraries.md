---
layout: post
title: 標準添付ライブラリ紹介 【第 7 回】 net/http
short_title: 標準添付ライブラリ紹介 【第 7 回】 net/http
tags: 0013 BundledLibraries
---
{% include base.html %}


書いた人：cuzic

## はじめに

Ruby には便利な標準添付ライブラリがたくさんありますが、なかなか知られていないのが現状です。
そこで、この連載では Ruby の標準添付ライブラリを紹介していきます。

今回は、ネットワークに分類されているライブラリから HTTP を簡単に扱える
net/http を紹介します。

### net/http で実現できること

あなたもロボット型の検索エンジンは使ったことがありますよね。
[Google](http://google.co.jp/) が代表的です。

Google は巡回ロボット (スパイダー・クローラー) と呼ばれるプログラムを
大量に Web を巡回させ、サーバに蓄積・検索を行うサービスを行っています。

Google では、ブラウザからではなく、プログラムによって、自動的に Web ページを
取得し、それを加工しているわけです。

検索エンジン以外にも Web ページを自動的に取得・加工するサービスには
興味深いものは数多くあります。
[Google News](http://news.google.co.jp/) では、自動的に収集された
最新のニュースを見出し付で確認することが可能です。

これらは、かなり大々的なサービスの例ですが、
これほど大規模でなくても、自分が日ごろしているような作業を自動化させれば、
それだけでとても毎日楽に効率的になるはずです。

たとえば、日々お仕事をしていく上でも最近では Web ページ上でフォームに
値を入力することで、業務を行うというようなケースが増えています。
Web ページ上でフォームに値を連続して入力するような場合では、
テキストボックスごとに、Excel シートからのコピーアンドペーストを
実施する必要があったりして、その作業を続けていると疲れてしまいます。

このような Web ページを操作する業務は、ブラウザが元々やっている処理を
Ruby で代替することによって大幅に省力化できます。

### HTTP について

おそらくこの記事を読んでいる人はすでに知っているでしょうが、
HTTP (Hypertext Transfer Protocol)[^1]
というプロトコルに従って Web サーバと通信することで Web ページを取得します。

そして、Ruby にはこの HTTP を自分で扱うためのライブラリがあり、とても
機能が充実しています。
今回のこの記事ではその HTTP を扱うライブラリについてこれから一緒に学んで
いきます。

## open-uri について

いきなり、タイトルとは違うライブラリについて紹介してしまいまして恐縮ですが、
Ruby にはとても簡潔で使いやすい HTTP にアクセスできるライブラリとして
open-uri があります。

コマンドラインから次のコマンドを実行すればその威力が分かるでしょう。

{% highlight text %}
{% raw %}
ruby -ropen-uri -e 'open("http://www.ruby-lang.org/ja/").read.display'
{% endraw %}
{% endhighlight %}


(注：環境によっては、nkf 等でフィルタしないと日本語が化けます。)

open-uri を使うことで、普通のファイルを開くときと
全く同じように、Web ページを取得できます。
つまり、open-uri を使うことで open メソッドの引数に URI 文字列を指定する
ことで IO オブジェクトが返るようになります。
つまり、ファイルのパスを書く代わりに URI 文字列を書けばよいということです。

上記のコマンドではその後、IO#read メソッドによって、そのページをすべて取得し、
Object#display メソッドによって表示を行っています。

Object#display は $stdout.print obj と同じ処理を行うメソッドです。
文字列の出力を行うとき、ブロック付メソッド呼び出しと混在させられるので便利です。
print と select や map でのブロック呼び出しを混在させるときは表示前に一時変数に
退避させる必要がありますが、Object#display メソッドを使えばその手間が省けるので
私はよく利用します。

## net/http

１ページを取得する場合だけであれば、open-uri はとても分かりやすく便利なのですが、
同一のサーバに対して、繰り返しアクセスするような場合にはあまり効率の良い
方法とはいえません。

そのような場合は、net/http を使う方法が良いでしょう。
net/http は HTTP をとても簡単に扱うことができるライブラリです。

### URI について復習

net/http について説明する前に説明が不要かも知れませんが、
念のため簡単に URI について復習しておきましょう。
[http://www.ruby-lang.org/ja/](http://www.ruby-lang.org/ja/) という URI があったとき、これは次の構成要素
に分けることができます。

1. http : データの転送方式を示す部分
1. www.ruby-lang.org : Web サーバの名前
1. 80 : サーバのポート番号 (HTTP の場合、省略されていると 80 になります)
1. /ja/ : 取得したい Web ページのパス


Web サーバの名前、ポート番号、Web ページのパスを使って、
サーバが持つエンティティ (実体、コンテンツ) を取得することになります。

また、この記事のアドレス
[http://jp.rubyist.net/magazine/?0013-BundledLibraries](http://jp.rubyist.net/magazine/?0013-BundledLibraries) の場合は、

1. http : データの転送方式を示す部分 (scheme)
1. jp.rubyist.net : Web サーバの名前 (server)
1. 80 : サーバのポート番号 (HTTP の場合、省略されていると 80 になります) (port)
1. /magazine/ : 取得したい Web ページのパス (path)
1. 0013-BundledLibraries : サーバーに送る文字列 (query)


このように、Web サーバの名前、ポート番号、Web ページのパス等を使って、
サーバが持つエンティティ (実体、コンテンツ) を取得することになります。

### Web サーバからドキュメントを得る

先ほど open-uri で書いたのと同じ処理を行うスクリプトを net/http を使って書き直して
みましょう。
なお、net/http にはバージョン 1.1 とバージョン 1.2 があるのですが、
現在は 1.2 が推奨されています。
今回紹介するのも、このバージョン 1.2 についてです。

これは、リファレンスマニュアルに記載の例を焼きなおしただけですが、
net/http での GET リクエストの例は次のようになります。

[get.rb]({{base}}{{site.baseurl}}/images/0013-BundledLibraries/get.rb)

```ruby
require 'net/http'

Net::HTTP.version_1_2

Net::HTTP.start('www.ruby-lang.org', 80) {|http|
  response = http.get('/ja/')
  puts response.body
}


```

Net::HTTP#start メソッドは、HTTP セッションを開始するメソッドです。
start メソッドは、先ほど説明しました Web サーバの名前とポート番号を
引数としてとります。

Net::HTTP#start メソッドは、IO#open メソッドと同じようにブロック付で
呼び出すことによって、ブロックの間だけセッションを接続し、
ブロック終了とともに自動的にセッションを閉じます。
IO#open をブロック付で呼び出すのが良い作法とされているのと同じように、
何か理由がない限り Net::HTTP#start メソッドはブロック付で呼び出
したほうがいいです。
Ruby が代わりにセッションの終了をやってくれます。

{% highlight text %}
{% raw %}
 response = http.get('/ja/')
{% endraw %}
{% endhighlight %}


Net::HTTP#get メソッドは、Web サーバの path にあるエンティティ (実体) を
取得します。この例では、'/ja/' です。

Net::HTTP のバージョン 1.2 では、Net::HTTP#get メソッドは
HTTPResponse を返します。

{% highlight text %}
{% raw %}
 puts response.body
{% endraw %}
{% endhighlight %}


HTTPResponse#body によって、エンティティのボディを取得できます。

### HTTP について復習

さて、この記事を読んでいる人は HTTP を使った通信について
知っている人が多いと思いますが、あまり詳しくない人もいる
かも知れません。
知らない人はここで一緒に、HTTP について簡単に学んで
いきましょう。

一般的には次の流れで HTTP クライアントはサーバから、Web ページを
取得します。

1. サーバの名前から名前解決して、IP アドレスを得る
1. IP アドレスと指定されたポート番号でサーバに接続
1. 取得したい Web ページをサーバにリクエストする。
1. クライアントからのリクエストに対してサーバがレスポンスを返す。


本当はもう少し複雑なのですが、この程度はまず知っておきましょう。

そして、クライアントがサーバにリクエストするときは、パスの他に
リクエストヘッダというものを付加できます。
同様にサーバがクライアントにレスポンスを返すときもヘッダが
付加されて返ってきます。

リクエストヘッダについては、もしもあなたがこの記事を読んで
巡回ロボットを作りたいのであれば、ある程度知っておいた方が
いいでしょう。
この記事の範囲を超えるので、詳しい解説はしませんが、
User-Agent, If-Modified-Since については設定した方が
望ましいと思います。

### POST メソッドの発行

リクエストの主な種類として、GET と POST があります。
これは、CGI を作成した経験がある方はご存知でしょう。
get.rb では GET リクエストを利用した例について解説しました。

この節では、POST メソッドについて解説します。

net/http を利用すると POST リクエストは、とても簡単に行えます。
次のようになります。

[hatena_search.rb]({{base}}{{site.baseurl}}/images/0013-BundledLibraries/hatena_search.rb)

```ruby
require 'net/http'

Net::HTTP.version_1_2

Net::HTTP.start('search.hatena.ne.jp', 80) {|http|
  response = http.post('/questsearch',"word=ruby")
  puts response.body
}


```

この例では「はてな」のサービスの 1 つである「はてな質問」の
検索を行います。

POST リクエストの場合は、Net::HTTP#post の第二引数に
送信する文字列を指定します。

ちょっとしたテクニックですが、 QUERY_STRING (サーバに送信する文字列)
が長くなる場合に、筆者は

{% highlight text %}
{% raw %}
require 'uri'
query_hash = {"word" => "ruby", "日本語" => "オブジェクト指向スクリプト言語Ruby"}
query_string = query_hash.map{|key,value|
 "#{URI.encode(key)}=#{URI.encode(value)}"
end.join("&")
{% endraw %}
{% endhighlight %}


というようなイディオムをよく使います。
要素数が増えたときに整理して記述できる点で優れています。
なお、URI.encode は、文字列を URI エンコードするメソッドです。

### Basic 認証

ある種のページでは、Basic 認証が必要になります。
これから、Basic 認証の行い方について学んでいきましょう。

次の例では、[http://www.notwork.org/~gotoken/uu200410/](http://www.notwork.org/~gotoken/uu200410/) にある
Basic 認証が必要な [http://www.notwork.org/~gotoken/uu200410/basic/](http://www.notwork.org/~gotoken/uu200410/basic/)
のページにログインします。

[basic_auth.rb]({{base}}{{site.baseurl}}/images/0013-BundledLibraries/basic_auth.rb)

```ruby
require 'net/http'

Net::HTTP.version_1_2

req = Net::HTTP::Get.new("/~gotoken/uu200410/basic/")
req.basic_auth "basic","basic"
Net::HTTP.start('www.notwork.org', 80) {|http|
  response = http.request(req)
  puts response.body
}

```

Net::HTTP::Get クラスを利用することで、Basic 認証を行えます。

Basic 認証を行う場合は、Net::HTTPRequest を生成することで
明示的に HTTP リクエストを構築します。

{% highlight text %}
{% raw %}
req = Net::HTTP::Get.new("/~gotoken/uu200410/basic/")
req.basic_auth "basic","basic"
{% endraw %}
{% endhighlight %}


のように、Net::HTTPRequest そのものは抽象クラスで、Net::HTTP.GET は
Net::HTTPRequest のサブクラスになります。
そして、リクエストするパス名を引数に与えることで、Net::HTTPRequest の
インスタンスを生成できます。
Net::HTTPRequest のサブクラスを生成し、Net::HTTRequest#basic_auth 
メソッドを呼ぶことで、Basic 認証を行うリクエストを構築できます。

そして実際にサーバにリクエストするときに

{% highlight text %}
{% raw %}
 response = http.request(req)
{% endraw %}
{% endhighlight %}


というように、先ほど構築した Net::HTTPRequest を引数に渡して、
Net::HTTP#request メソッドを呼ぶと、Basic 認証でサーバに要求した
エンティティ (実体) を取得できます。

なお、リクエスト時に If-Modified-Since などの追加ヘッダーを送信
したいときも、この Net::HTTPRequest を利用します。
詳しくは、[Ruby リファレンスマニュアル - Net::HTTPRequest](http://www.ruby-lang.org/ja/man/?cmd=view;name=Net%3A%3AHTTPRequest) を参照してください。

### プロキシ経由のアクセス

net/http でのプロキシ経由のアクセスの実装は、筆者はとても興味深く
感じました。
ここでは、RDoc に掲載されているスクリプトを少し改変したスクリプトを
例にして、プロキシ経由のアクセスの仕方について学んでいきましょう。

{% highlight text %}
{% raw %}
require 'net/http'

proxy_host = 'your.proxy.host'
proxy_port = 8080
proxy_user = "username"
proxy_pass = "password"
Net::HTTP.Proxy(proxy_host, proxy_port,
                proxy_user, proxy_pass).start('www.example.com') {|http|
#  your.proxy.addr:8080 に対して指定されたユーザ名とパスワードで接続します。
#  そして、your.proxy.addr:8080 を経由して、www.example.com に接続します。
        :
}
{% endraw %}
{% endhighlight %}


プロキシ経由のアクセスは単に行うだけであれば上記のようにして行えます。
Net::HTTP.Proxy メソッドは、Net::HTTP を継承したクラスを作成して、作成した
クラスを返します。
Ruby は非常に柔軟な言語であるため、メソッド中に動的にクラスを作成して、
そのクラスを返すということが可能です。
Net::HTTP.Proxy の返り値を Net::HTTP の代わりに利用することで、
指定されたプロキシを常に経由して HTTP サーバに接続できます。

また、Net::HTTP.Proxy メソッドは、第一引数が nil のときは、
Net::HTTP クラス自身を返します。
この性質を利用すればプロキシが必要なときと必要でないの両方を
コーディングをする場合でも、より分岐とコードの重複の少ない
スマートなコードを書くことができるでしょう。

### リダイレクト

Ruby リファレンスマニュアルには、リダイレクトに対応した fetch の例が
あります。
このスクリプトを元にリダイレクトについて学んでいきましょう。

{% highlight text %}
{% raw %}
require 'uri'
require 'net/http'
Net::HTTP.version_1_2    # おまじない

def fetch( uri_str, limit = 10 )
  # 適切な例外クラスに変えるべき
  raise ArgumentError, 'http redirect too deep' if limit == 0

  response = Net::HTTP.get_response(URI.parse(uri_str))
  case response
  when Net::HTTPSuccess     then response
  when Net::HTTPRedirection then fetch(response['Location'], limit - 1)
  else
    response.error!
  end
end

print fetch('http://www.ruby-lang.org')
{% endraw %}
{% endhighlight %}


URI ライブラリにある URI.parse メソッドを使うことで、
URI 文字列から URI クラスを継承したサブクラスの
インスタンスを生成できます。

そして、Net::HTTP.get_response メソッドは URI を
引数にとります。

{% highlight text %}
{% raw %}
response = Net::HTTP.get_response(URI.parse(uri_str))
{% endraw %}
{% endhighlight %}


は、次と同じ効果を持ちます。

{% highlight text %}
{% raw %}
response = nil
Net::HTTP.new(uri.host, uri.post).start do |http|
  response = http.get(uri.request_uri)
end
{% endraw %}
{% endhighlight %}


response は、 Net::HTTPResponse クラスのサブクラスの
インスタンスです。
ここで、Net::HTTPResponse は、HTTP レスポンスの階層構造を
直接に反映した継承関係をとっています。
これを RDoc から引用すると次のようになります。

{% highlight text %}
{% raw %}
xxx        HTTPResponse

  1xx        HTTPInformation
    100        HTTPContinue
    101        HTTPSwitchProtocol

  2xx        HTTPSuccess
    200        HTTPOK
    201        HTTPCreated
    202        HTTPAccepted
    203        HTTPNonAuthoritativeInformation
    204        HTTPNoContent
    205        HTTPResetContent
    206        HTTPPartialContent

  3xx        HTTPRedirection
    300        HTTPMultipleChoice
    301        HTTPMovedPermanently
    302        HTTPFound
    303        HTTPSeeOther
    304        HTTPNotModified
    305        HTTPUseProxy
    307        HTTPTemporaryRedirect

  4xx        HTTPClientError
    400        HTTPBadRequest
    401        HTTPUnauthorized
    402        HTTPPaymentRequired
    403        HTTPForbidden
    404        HTTPNotFound
    405        HTTPMethodNotAllowed
    406        HTTPNotAcceptable
    407        HTTPProxyAuthenticationRequired
    408        HTTPRequestTimeOut
    409        HTTPConflict
    410        HTTPGone
    411        HTTPLengthRequired
    412        HTTPPreconditionFailed
    413        HTTPRequestEntityTooLarge
    414        HTTPRequestURITooLong
    415        HTTPUnsupportedMediaType
    416        HTTPRequestedRangeNotSatisfiable
    417        HTTPExpectationFailed

  5xx        HTTPServerError
    500        HTTPInternalServerError
    501        HTTPNotImplemented
    502        HTTPBadGateway
    503        HTTPServiceUnavailable
    504        HTTPGatewayTimeOut
    505        HTTPVersionNotSupported

  xxx        HTTPUnknownResponse
{% endraw %}
{% endhighlight %}


この HTTPResponse のそれぞれについては、HTTP のプロトコルについて
調べて欲しいですが、よく使われるのは次のものでしょう。

* HTTPSuccess
  * HTTPOK
* HTTPRedirection
  * HTTPFound
  * HTTPNotModified
* HTTPClientError
  * HTTPUnauthorized
  * HTTPForbidden
  * HTTPNotFound
  * HTTPRequestTimeOut
* HTTPServerError
  * HTTPInternalServerError


これらについては、普通にブラウザを使っていても表示されますので、
だいたい意味合いは分かるかもしれません。
この節では、このうち HTTPRedirection というリダイレクトと
関連するレスポンスを扱います。

もしもあなたが巡回ロボットを作ろうとしているのでしたら、
HTTPNotModified については知っておきましょう。
If-Modified-Since ヘッダを利用したときに、更新されていない場合に、
返るレスポンスです。
これらを使うことで Web サーバに優しいロボットを作成できます。

HTTP のレスポンスが返ったときは、この HTTPResponse の継承関係を利用して、
分岐を行うことが定石です。

あるオブジェクトがどのクラスに属しているかで分岐するときは、
Ruby に備わっている case-when の構文が便利です。

{% highlight text %}
{% raw %}
case response
when Net::HTTPSuccess     then response
when Net::HTTPRedirection then fetch(response['location'], limit - 1)
else
  response.error!
end
{% endraw %}
{% endhighlight %}


case-when は、when で指定された式それぞれに対して、=== メソッドに
よって、一致判定を行います。多くの場合、=== は、
== と同じように振舞います。しかし、特に左辺がクラスの場合は
右辺がそのクラスのインスタンスであれば true で、
インスタンスでなければ false を返します。
そのため、case-when を利用することで、どのクラスの
インスタンスかで分岐を行えるのです。

ただし === メソッドは、クラスの実装ごとに再定義可能なので注意が必要です。
振る舞いが変なときは利用しているクラスの === メソッドの動作について
調べるようにしましょう。

#### リダイレクトの重箱の隅つつき

話が大きく横道に逸れて、HTTP や Ruby の文法の話になってしまいましたね。
話を戻してリダイレクトの解説をしましょう。

それで、Net::HTTPSuccess の場合は Net::HTTPResponse#body で
取得したいコンテンツを得られますが、リダイレクトの 
HTTP レスポンスの場合は HTTP レスポンスヘッダの Location フィールドの
値で指定されたページへと取得しに行かないと、取得したいコンテンツは
得られません。

そのため、

{% highlight text %}
{% raw %}
fetch(response['Location'], limit - 1)
{% endraw %}
{% endhighlight %}


と、再帰的に fetch メソッドを呼び出して、Location で指定された
URI に対して再度、取得を実行させています。
limit を減らして渡しているのは、無限再帰に陥ることを防ぐための工夫です。

なお、RFC では、「Location フィールドの値は単一の絶対 URL からなる」と
書かれているのですが、実際には、Location フィールドは絶対 URL ではなく、
相対パスであっても大抵の有名 HTTP クライアントは受け入れて、
リダイレクトを行うようです。

「Be conservative in what you do; be liberal in what you accept」
(自分の行いは保守的に、自分が受け取るときは寛大に)[^2] の精神に従って、

{% highlight text %}
{% raw %}
fetch(response['location'], limit - 1)
{% endraw %}
{% endhighlight %}


という部分については、 

{% highlight text %}
{% raw %}
fetch(URI.join(uri_str,response['location']).to_s, limit - 1)
{% endraw %}
{% endhighlight %}


とした方がよいでしょう。
URI.join メソッドを使うことで、絶対 URI 文字列と相対 URI 文字列を
連結して新しい URI を生成できます。
絶対 URI と 絶対 URI の場合は最後の引数の絶対 URI になります。

ただ、ひょっとしたら、このような場合はメソッド引数を URI にする
ようにリファクタリングした方がいいかもしれませんが。

リダイレクトには、HTTP レスポンスによるものだけではなく、
HTML の HEAD 内で行う手法もあります。
HTML ファイルの HEAD 内に

{% highlight text %}
{% raw %}
<META HTTP-EQUIV="Refresh" CONTENT="5; URL=http://www.ruby-lang.org/">
{% endraw %}
{% endhighlight %}


と書くことで、META タグによるリダイレクトができます。

ただ、これも考慮して行う実装については、net/http ではなく
正規表現の適用などの話になるので、ここでは割愛します。

## 終わりに

今回は、net/http について学びました。

今回の内容を利用する上で注意して欲しいことがあります。
本文中でも幾度かふれましたが、あなたがもしもロボットなどの巡回ソフトを
作成しようとしているのであれば、マナーのいいロボットを作りましょう。
If-Modified-Since ヘッダの送信や、今回説明していない内容ですが 
robots.txt や &lt;meta name="robots"...&gt; を尊重することなど、マナーよく
実装してください。
このあたりの作法については、参考文献にあげた Spidering Hacks に詳しく書かれていますので、参考にしてください。

ま、それはそれとして、スパイダリングやスクレイピング
という技術は使いこなせば、自分専用にコンテンツを集約でき、
また手間を軽くし効率化できます。

最近では複数のコンテンツを組み合わせるマッシュアップと
いった手法も流行しています。
そういうときにもこの記事で紹介した技術は活用できるでしょう。

ここで学んだテクニックで友達をアッと驚かせる作品を作って
ください。

## 参考文献

* [Ruby リファレンスマニュアル - net/http](http://www.ruby-lang.org/ja/man/?cmd=view;name=net%2Fhttp)
* [Ruby リファレンスマニュアル - open-uri](http://www.ruby-lang.org/ja/man/?cmd=view;name=open-uri)
* {% isbn('4873111870', 'Spidering Hacks') %}


## 著者について

cuzic は ここ Rubyist Magazine で Win32OLE 活用法を書いていました。
Ruby 関西というコミュニティで、Ruby 勉強会＠関西という活動をやっています。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}

----

[^1]: [Hypertext Transfer Protocol -- HTTP/1.1](http://www.ietf.org/rfc/rfc2616.txt)
[^2]: Robustness Principle
. [RFC 793 - Transmission Control Protocol](http://www.ietf.org/rfc/rfc793.txt) で使われたことで有名
