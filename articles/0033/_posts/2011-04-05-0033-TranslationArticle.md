---
layout: post
title: 海外記事翻訳シリーズ 【第 2 回】 Rack 仕様
short_title: 海外記事翻訳シリーズ 【第 2 回】 Rack 仕様
tags: 0033 TranslationArticle
---
{% include base.html %}


* Table of content
{:toc}


翻訳: 桑田誠

〔訳注: 本稿は [http://rack.rubyforge.org/doc/SPEC.html](http://rack.rubyforge.org/doc/SPEC.html) の翻訳です。〕

This specification aims to formalize the Rack protocol. You can (and should) use [Rack::Lint](http://rack.rubyforge.org/doc/Rack/Lint.html) to enforce it. When you develop middleware, be sure to add a Lint before and after to catch all mistakes.

本仕様は、Rack プロトコルを形式的に定義することを目的としている。[Rack::Lint](http://rack.rubyforge.org/doc/Rack/Lint.html) を使うと (ぜひ使うべきだ)、仕様に従うことを強制できる。ミドルウェアを開発するときは、ミスをすべて捕捉するために Lint を前後に付け加えるようにすること。

## Rack applications (Rack アプリケーション)

A Rack application is an Ruby object (not a class) that responds to call. It takes exactly one argument, the environment and returns an Array of exactly three values: The status, the headers, and the body.

Rack アプリケーションは、call() メソッドが呼び出せる Ruby のオブジェクトである (クラスではない)。call() は「環境 (environment)」を表す引数を 1 つだけとり、「ステータス」「ヘッダ」「ボディ」の 3 つを要素とする配列 (Array) を戻り値として返す[^1]。

### The Environment (環境)

The environment must be an instance of Hash that includes CGI-like headers. The application is free to modify the environment. The environment is required to include these variables (adopted from PEP333), except when they'd be empty, but see below.

環境 (environment) は CGI ライクなヘッダを持った Hash のインスタンスオブジェクトである。アプリケーションは好きなように環境を変更してよい。環境は以下のような変数を含む必要がある (これは PEP333[^2] に倣った)。ただし値が空である場合は含まなくてもよい。

 REQUEST_METHOD
: 
:  The HTTP request method, such as "GET" or "POST". This cannot ever be an empty string, and so is always required.
:  「GET」や「POST」のような、HTTP リクエストメソッドを表す。これは決して空文字列であってはならず、省略もできない。

 SCRIPT_NAME
:  The initial portion of the request URL's "path" that corresponds to the application object, so that the application knows its virtual "location". This may be an empty string, if the application corresponds to the "root" of the server. 
:  アプリケーションオブジェクトに対応するリクエスト URL の「パス」における、最初の部分を表す。これによってアプリケーションは自分自身の仮想的な「位置 (location)」を知ることができる。この値は、アプリケーションがサーバの「ルート (root)」に対応する場合は、空の文字列でもよい。

 PATH_INFO
:  The remainder of the request URL's "path", designating the virtual "location" of the request's target within the application. This may be an empty string, if the request URL targets the application root and does not have a trailing slash. This value may be percent-encoded when I originating from a URL. 
:  リクエスト URL の「パス」における、残りの部分を表す。これはつまり、アプリケーション内におけるリクエスト対象の仮想的な「位置 (location)」を意味する。この値は、リクエスト URL がアプリケーションのルートでありかつスラッシュで終わっていない場合は、空の文字列でもよい。またこの値が URL をもとに決定された場合はパーセントエンコーディングされている可能性がある。

 QUERY_STRING
:  The portion of the request URL that follows the ?, if any. May be empty, but is always required! 
:  リクエスト URL において「?」のあとに続く部分 (もしあれば)。空文字列でもよいが、省略はできない！

 SERVER_NAME, SERVER_PORT
:  When combined with SCRIPT_NAME and PATH_INFO, these variables can be used to complete the URL. Note, however, that HTTP_HOST, if present, should be used in preference to SERVER_NAME for reconstructing the request URL. SERVER_NAME and SERVER_PORT can never be empty strings, and so are always required. 
:  SCRIPT_NAME や PATH_INFO と組み合わせることで、これらの変数は完全な URL を構築するのに用いることができる。しかし、もし HTTP_HOST があるなら、リクエスト URL を再構築するときには SERVER_NAME よりそちらを使うべきである。SERVER_NAME と SERVER_PORT は空文字列であってはならない。また省略もできない。

 HTTP_ Variables (HTTP_ 変数)
:  Variables corresponding to the client-supplied HTTP request headers (i.e., variables whose names begin with HTTP_). The presence or absence of these variables should correspond with the presence or absence of the appropriate HTTP header in the request. 
:  これらの変数はクライアントが発した HTTP リクエストヘッダに対応する (つまり名前が「HTTP_」で始まる変数)。これらの変数が設定されるかどうかは、リクエスト中において適切な HTTP ヘッダが存在するかどうかによって決まる。

In addition to this, the Rack environment must include these Rack-specific variables:

これらに加え、Rack の環境は以下のような Rack 特有の変数を含なければならない。

 rack.version
:  The Array [1,1], representing this version of Rack. 
: 「[1, 1]」という配列オブジェクト。Rack のバージョンを表す。

 rack.url_scheme
:  http or https, depending on the request URL. 
:  「http」または「https」。現在のリクエスト URL によって決まる。

 rack.input
:  See below, the input stream. 
:  以下の「入力ストリーム」を参照のこと。

 rack.errors
:  See below, the error stream. 
:  以下の「エラーストリーム」を参照のこと。

 rack.multithread
:  true if the application object may be simultaneously invoked by another thread in the same process, false otherwise. 
:  アプリケーションオブジェクトが、同じプロセスの別スレッドから同時に実行される可能性がある場合は true、それ以外は false。

 rack.multiprocess
:  true if an equivalent application object may be simultaneously invoked by another process, false otherwise.
:  アプリケーションオブジェクトが、他のプロセスから同時に実行される可能性があるなら true、それ以外は false[^3]。

 rack.run_once
:  true if the server expects (but does not guarantee!) that the application will only be invoked this one time during the life of its containing process. Normally, this will only be true for a server based on CGI (or something similar). 
:  サーバがそのプロセスにおいて、アプリケーションを一度しか実行しないと期待される場合 (ただし保証はしないことに注意！) は true。通常は、CGI (あるいはそれに類するもの) として実行される場合にのみ true である。

Additional environment specifications have approved to standardized middleware APIs. None of these are required to be implemented by the server.

これらに加え、以下のような付加的な環境が標準ミドルウェア API において承認されている。サーバはこれらを実装する必要はない。

 rack.session
:  A hash like interface for storing request session data. The store must implement: store(key, value) (aliased as []=); fetch(key, default = nil) (aliased as []); delete(key); clear;
:  リクエストセッションデータを保持するオブジェクト。ハッシュに似たインターフェースを持つ。セッションオブジェクトは以下のメソッドを実装している必要がある: store(key, value) (aliased as []=); fetch(key, default = nil) (aliased as []); delete(key); clear;

 rack.logger
:  A common object interface for logging messages. The object must implement:
:  メッセージのログをとるためのインターフェースを持つ、共通のオブジェクト。オブジェクトは以下を実装している必要がある:

{% highlight text %}
{% raw %}
 info(message, &block)
 debug(message, &block)
 warn(message, &block)
 error(message, &block)
 fatal(message, &block)
{% endraw %}
{% endhighlight %}


The server or the application can store their own data in the environment, too. The keys must contain at least one dot, and should be prefixed uniquely. The prefix rack. is reserved for use with the Rack core distribution and other accepted specifications and must not be used otherwise. The environment must not contain the keys HTTP_CONTENT_TYPE or HTTP_CONTENT_LENGTH (use the versions without HTTP_). The CGI keys (named without a period) must have String values. There are the following restrictions: 

サーバまたはアプリケーションは、独自のデータも環境に追加できる。キーは最低限 1 つのピリオドを含まなければならず、接頭辞は一意に識別されるべきである。接頭辞「rack.」は Rack コアおよび他の受理された仕様のために予約されており、他の目的で使ってはならない。環境は「HTTP_CONTENT_TYPE」または「HTTP_CONTENT_LENGTH」を含んではいけない (かわりに「HTTP_」を取り除いた名前を使う)。CGI キー (ピリオドなしの名前) は文字列の値を持たなければならない。そのほか以下のような制限事項がある:

* rack.version must be an array of Integers.
* rack.url_scheme must either be http or https.
* There must be a valid input stream in rack.input.
* There must be a valid error stream in rack.errors.
* The REQUEST_METHOD must be a valid token.
* The SCRIPT_NAME, if non-empty, must start with /
* The PATH_INFO, if non-empty, must start with /
* The CONTENT_LENGTH, if given, must consist of digits only.
* One of SCRIPT_NAME or PATH_INFO must be set. PATH_INFO should be / if SCRIPT_NAME is empty. SCRIPT_NAME never should be /, but instead be empty.


* rack.version は Integer の配列でなければならない。
* rack.url_schema は「http」または「https」でなければならない。
* rack.input は妥当な入力ストリームでなければならない。
* rack.errors は妥当なストリームでなければならない。
* REQUEST_METHOD は妥当なトークンでなければならない。
* SCRIPT_NAME は、もし空でなければ「/」で始まってなければならない。
* PATH_INFO は、もし空でなければ「/」で始まってなければならない。
* CONTENT_LENGTH は、もし指定されていれば、数字のみで構成されてなければならない。
* SCRIPT_NAME または PATH_INFO の少なくとも一方が設定されてなければならない。SCRIPT_NAME が空の場合、PATH_INFO は「/」でなければならない。SCRIPT_NAME は決して「/」であってはならないが、そのかわりに空であってよい。


#### The Input Stream (入力ストリーム)

The input stream is an IO-like object which contains the raw HTTP POST data. When applicable, its external encoding must be "ASCII-8BIT" and it must be opened in binary mode, for Ruby 1.9 compatibility. The input stream must respond to gets, each, read and rewind. 

入力ストリーム (input stream) は IO に似たオブジェクトであり、HTTP POST の生データを保持している。もし適用可能であれば、その外部エンコーディングは「ASCII-8BIT」でなければならず、バイナリモードでオープンされてないといけない (これは Ruby 1.9 との互換性のためである)。入力ストリームは gets() と each() と read() と rewind() を実装していなければならない。

* gets must be called without arguments and return a string, or nil on EOF.
* read behaves like IO#read. Its signature is read([length, [buffer]]). If given, length must be an non-negative Integer (&gt;= 0) or nil, and buffer must be a String and may not be nil. If length is given and not nil, then this method reads at most length bytes from the input stream. If length is not given or nil, then this method reads all data until EOF. When EOF is reached, this method returns nil if length is given and not nil, or "" if length is not given or is nil. If buffer is given, then the read data will be placed into buffer instead of a newly created String object.
* each must be called without arguments and only yield Strings.
* rewind must be called without arguments. It rewinds the input stream back to the beginning. It must not raise Errno::ESPIPE: that is, it may not be a pipe or a socket. Therefore, handler developers must buffer the input data into some rewindable object if the underlying input stream is not rewindable.
* close must never be called on the input stream.


* gets() は引数なしで呼ばれ、文字列を返す。ただし EOF の場合は nil を返す。
* read() は IO#read() のように振る舞う。シグニチャは read([length, [buffer]]) である。もし length が指定された場合は、正の Integer か 0 か nil でなければならない。もし buffer が指定された場合は String でなければならず、nil であってはならない。もし length に nil 以外の値が指定された場合、read() は入力ストリームから最大 length バイトを読み込む。length が指定されなかった場合または nil の場合は、EOF になるまでのデータをすべて読み込む。EOF に達した場合は、length に nil 以外の値が指定されていれば read() は nilを返し、length が指定されてないか nil であれば read() は「""」(空文字列) を返す。引数に buffer が指定されていれば、新しく文字列オブジェクトが生成されるかわりに、読み込まれたデータが buffer に追加される。
* each() は引数なしで呼び出され、文字列を yield する。
* rewind() は引数なしで呼び出され、入力ストリームを先頭に巻き戻す。またこのとき例外 Errno::ESPIPE を発生してはならない: つまり、入力ストリームはパイプやソケットであってはならない。それゆえ、入力ストリームが巻き戻しできないものであった場合、ハンドラ開発者は入力データを何らかの巻き戻し可能なオブジェクトにバッファリングしなければならない。
* close() は入力ストリームに対して呼び出されることはない。


#### The Error Stream (エラーストリーム)

The error stream must respond to puts, write and flush. 

エラーストリームは puts() と write() と flush() を実装しなければならない。

* puts must be called with a single argument that responds to to_s.
* write must be called with a single argument that is a String.
* flush must be called without arguments and must be called in order to make the error appear for sure.
* close must never be called on the error stream.


* puts() は to_s() を実装している引数 1 つで呼び出される。
* write() は文字列の引数 1 つで呼び出される。
* flush() は引数なしで呼ばれ、エラーが確実に出力されたことを保証するために呼び出される。
* close() はエラーストリームに対して呼び出されることはない。


### The Response (レスポンス)

#### The Status (ステータス)

This is an HTTP status. When parsed as integer (to_i), it must be greater than or equal to 100. 

HTTP ステータスを表す。整数としてパースされた場合 (to_i)、100 以上でなければならない。

#### The Headers (ヘッダ)

The header must respond to each, and yield values of key and value. The header keys must be Strings. The header must not contain a Status key, contain keys with : or newlines in their name, contain keys names that end in - or _, but only contain keys that consist of letters, digits, _ or - and start with a letter. The values of the header must be Strings, consisting of lines (for multiple header values, e.g. multiple Set-Cookie values) seperated by "n". The lines must not contain characters below 037. 

ヘッダは each() を実装し、キーと値の組を yield しなければならない。ヘッダのキーは文字列でなければならない。ヘッダは「Status」キーを含んではならない。また名前に「:」や改行があるキーや、「-」や「_」で終わるようなキーを含んでもいけない。キーは文字[^4]と数字と「_」と「-」のみで構成され、文字で始まらなければならない。ヘッダの値は文字列でなければならない。値は複数行である場合もあり (これは値が複数であるヘッダのため、たとえば Set-Cookie を複数回指定した場合など)、その場合は「\n」で区切られてなければならない。行は 037 より小さい文字[^5]を含んではならない。

#### The Content-Type (Content-Type ヘッダ)

There must be a Content-Type, except when the Status is 1xx, 204 or 304, in which case there must be none given. 

「Content-Type」は、ステータスが「1xx」「204」「304」のときは何も指定されてはならず、それ以外のときは必ず指定されなければならない。

#### The Content-Length (Content-Length ヘッダ)

There must not be a Content-Length header when the Status is 1xx, 204 or 304. 

「Content-Length」ヘッダは、ステータスが「1xx」「204」「304」のときは何も指定されてはならない。

#### The Body (ボディ)

The Body must respond to each and must only yield String values. The Body itself should not be an instance of String, as this will break in Ruby 1.9. If the Body responds to close, it will be called after iteration. If the Body responds to to_path, it must return a String identifying the location of a file whose contents are identical to that produced by calling each; this may be used by the server as an alternative, possibly more efficient way to transport the response. The Body commonly is an Array of Strings, the application instance itself, or a File-like object. 

ボディは each() を実装し、文字列のみを yield しなければならない。ボディ自体は文字列であってはならない (なぜなら Ruby 1.9 では動かないから[^6])。もしボディが close() を実装している場合は、繰り返しのあとで呼び出される。ボディが to_path() を実装している場合は、to_path() はファイルの場所を表す文字列を返さなければならず、そのファイルの内容は each() を呼び出しているときに生成される; この方法は、サーバによってはレスポンスを効率よく転送するための代替手段として使われることがある。ボディは、通常は文字列を要素とした配列か、アプリケーションインスタンスそのものか、ファイルに似たオブジェクトである。

### Thanks (謝辞)

Some parts of this specification are adopted from PEP333: Python Web Server Gateway Interface v1.0 ([www.python.org/dev/peps/pep-0333/](http://www.python.org/dev/peps/pep-0333/)). I'd like to thank everyone involved in that effort. 

本仕様のいくつかの部分は、PEP333: Python Web Server Gateway Interface v1.0[^7] ([www.python.org/dev/peps/pep-0333/](http://www.python.org/dev/peps/pep-0333/)) から取り込まれた。その仕様策定に尽力された方全員に感謝の意を表する。

## 訳者について

桑田誠。
『[新・のび太と鉄人兵団](http://movie.goo.ne.jp/contents/movies/MOVCSTD17913/)』はドラえもん映画として[ひさびさの傑作](http://blog.goo.ne.jp/hballoon/e/819a9fd171a3c4cfb4b35b929ab3368c)。[ネットでの評判も高い](http://coco.to/movie/7990)ので、見てない人はぜひ。

## バックナンバー

{% for post in site.tags.TranslationArticle %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}

----

[^1]: 訳注: call() が引数として受け取る Hash オブジェクトが HTTP リクエストを表し、戻り値である配列が HTTP レスポンスを表す。
[^2]: 訳注: 「PEP333」とは、Rack のもとになった [Python WSGI](http://www.python.org/dev/peps/pep-0333/) の仕様のこと。「PEP」とは「Python Enhancement Proposals」のことで、その中の番号 333 が WSGI である。Rack は WSGI をうまく Ruby 流にアレンジしており、結果として WSGI よりわかりやすくなっている (高階関数を使うかわりに戻り値を配列にするなど)。
[^3]: 訳注: つまりサーバプロセスが複数あれば true になる。通常は true。
[^4]: 訳注: 原文は「letters」だがおそらくアルファベット限定。
[^5]: 訳注: アスキーコードで「037 より小さい文字」は制御文字にあたる。なお 037 も制御文字なので、正確には「アスキーコードで 037 以下の文字」が正しい。
[^6]: 訳注: String#each() は Ruby 1.9 で削除された。
[^7]: 訳注: WSGI (Web Server Gateway Interface) の最新仕様は [WSGI v1.0.1](http://www.python.org/dev/peps/pep-3333/) である。実は Python 3 では WSGI v1.0 がうまく動作しないため、v1.0.1 ではそれへの対応がなされている。なお Python 3 の登場を機に、Rack の仕様を一部取り込んだ [Web3](http://www.python.org/dev/peps/pep-0444/) という仕様が WSGI の後継として提案されたが、より保守的な WSGI v1.0.1 が登場したため、[Python 3.2 ではそちらが採用された](http://docs.python.org/release/3.2/whatsnew/3.2.html#pep-3333-python-web-server-gateway-interface-v1-0-1)。
