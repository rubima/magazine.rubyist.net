---
layout: post
title: 標準添付ライブラリ紹介 【第 2 回】 Logger
short_title: 標準添付ライブラリ紹介 【第 2 回】 Logger
tags: 0008 BundledLibraries
---
{% include base.html %}


* Table of content
{:toc}


書いた人: 西山

## はじめに

### この連載について

Ruby 1.8 になって標準添付ライブラリが増えました。
そんなライブラリをどんどん紹介していこうという連載です。

### 今回の記事について

ログ記録関係のライブラリを紹介します。

紹介するライブラリは

1. ファイルなどにログを記録するための Logger
1. syslog にログを記録するための Syslog


です。

## Logger

### Logger とは？

Logger とは、ファイルなどにログを記録するためのクラスです。

### ログの例

ログの形式は

{% highlight text %}
{% raw %}
 SeverityID, [Date Time mSec #pid] SeverityLabel -- ProgName: message
{% endraw %}
{% endhighlight %}


となっていて、たとえば

{% highlight text %}
{% raw %}
 log.warn("Nothing to do!")
{% endraw %}
{% endhighlight %}


で出力されるログは

{% highlight text %}
{% raw %}
 W, [2005-07-10T20:02:25.402217 #15339]  WARN -- : Nothing to do!
{% endraw %}
{% endhighlight %}


のようになっています。

それぞれの項目の意味は表の通りです。

| SeverityID| SeverityLabel の 1 文字目|
| Date Time mSec| 日時|
| pid| プロセス ID|
| SeverityLabel| ログの重要度|
| ProgName| プログラム名など (省略されていることが多い)|
| message| ログメッセージ自体|


ProgName はあらかじめ

{% highlight text %}
{% raw %}
 logger.progname = "MyApp"
{% endraw %}
{% endhighlight %}


のように設定しておくか、ログを出力するときに指定します。
上の例では ProgName は省略されています。

### ログのレベル (重要度)

アプリケーションが出力するログには重要なものも重要でないものもあります。
ログはその重要度 (severity) によって、五つのレベルにわけて記録します。

その意味は以下の表のようになっています。

| FATAL| (プログラムをクラッシュさせるような) 対処不可能なエラー|
| ERROR| 対処可能なエラー|
| WARN| 警告|
| INFO| 一般的な情報|
| DEBUG| 開発者用の低レベルの情報|


基本的には、ログのレベルの名前を小文字にしたメソッドで、
そのレベルのログが出力されます。

#### 閾値の変更

通常稼働時には DEBUG レベルのログは不要なことが多いでしょう。
そこで、Logger オブジェクトに閾値となるレベルを設定しておけば、
閾値より重要度が低いメッセージは記録せずに捨ててくれます。

{% highlight text %}
{% raw %}
 # 例:
 logger.level = Logger::WARN
 logger.level = Logger::ERROR
{% endraw %}
{% endhighlight %}


### 簡単な例

ライブラリ本体のファイルの logger.rb から例を紹介します。

{% highlight text %}
{% raw %}
 require 'logger'
 log = Logger.new(STDOUT)
 log.level = Logger::WARN

 log.debug("Created logger")
 log.info("Program started")
 log.warn("Nothing to do!")

 begin
   File.each_line(path) do |line|
     unless line =~ /^(\w+) = (.*)$/
       log.error("Line in wrong format: #{line}")
     end
   end
 rescue => err
   log.fatal("Caught exception; exiting")
   log.fatal(err)
 end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 出力例:
 W, [2005-07-18T12:02:31.747391 #9493]  WARN -- : Nothing to do!
 F, [2005-07-18T12:02:31.748051 #9493] FATAL -- : Caught exception; exiting
 F, [2005-07-18T12:02:31.748227 #9493] FATAL -- : undefined local variable or method `path' for main:Object (NameError)
 sample.rb:10
{% endraw %}
{% endhighlight %}


最初にレベルを WARN に設定しているので、
warn と error と fatal だけがログに出力されて、
debug と info のメッセージは出力されずに黙って捨てられます。

### ログの出力先

#### 標準出力などの IO

Logger.new の引数に STDOUT や STDERR のような IO オブジェクトを渡すと、
ログがその IO オブジェクトに出力されます。

{% highlight text %}
{% raw %}
 # 例:
 logger = Logger.new(STDOUT)
 # または
 logger = Logger.new(STDERR)
{% endraw %}
{% endhighlight %}


自分で File.open した File オブジェクトを渡すことも出来ます。
しかし、File オブジェクトを Logger オブジェクトとは別に扱う手間がかかるので、
次のファイル名を渡す方法を使った方が良いでしょう。

#### ファイル

Logger.new の引数にファイル名を渡すとそのファイルに出力されます。

{% highlight text %}
{% raw %}
 # 例:
 logger = Logger.new('foo.log')
{% endraw %}
{% endhighlight %}


ファイル名だけを指定した場合は、そのファイルにどんどん追加されていきます。

##### ログのローテーション

どんどん追加されていくと、ログファイルでディスクが埋まってしまうので、
普通はログファイルのローテーションをします。

ローテーションとは、一定のサイズや期間ごとにファイル名を変更していき、
新しいものから一定のファイル数だけ残して、古いものは消してしまうことです。

logrotate などの別の手段を併用してログのローテーションをするのなら、
ファイル名だけ指定する方法でも良いでしょう。
ただし、Logger は Logger#close でログファイルを閉じることは出来ても、
再度開くことは出来ないので、
Logger 自身にローテーションを任せることをお勧めします。

#### 一定サイズごとにローテーション

Logger でログファイルのローテーションをすることも出来ます。

第 2 引数で Integer を指定すると、
サイズを基準にしたログのローテーションが出来ます。

第 3 引数で指定した一定サイズごとを超えるごとにログをローテーションして、
第 2 引数で指定したファイル数までのログファイルを残します。
サイズを省略すると
1 MiB [^1]
ごとになります。

ただし、一度に (logger.info などの呼び出しで)
出力した内容が分割されることはありません。
つまり、各ファイルの分量が厳密に指定したサイズになるとは限りません。

Logger がログをローテーションする場合、
たとえば Logger.new('foo.log', 7) なら

* foo.log
* foo.log.0
* foo.log.1
* foo.log.2
* foo.log.3
* foo.log.4
* foo.log.5


が残ります。

{% highlight text %}
{% raw %}
 # 例:
 logger = Logger.new('foo.log', 7)
 # または
 logger = Logger.new('foo.log', 7, 10*1024*1024)
{% endraw %}
{% endhighlight %}


#### 一定期間ごとに名前を変更

第 2 引数に 'daily' などの文字列を指定すると、
期間を基準にしてログをローテーションしてくれます。

たとえば、Logger.new('foo.log', 'daily') なら、最新のログは
foo.log に入っていて、最新のログの前日以前のログは

* ...
* foo.log.20050630
* foo.log.20050701
* foo.log.20050702
* foo.log.20050703
* foo.log.20050704
* foo.log.20050705
* ...


のようなファイル名に変更されます。

ログが書き込まれるときに古いログファイルの名前が変更されるので、
ログの書き込みがなければ、昨日以前のログでも foo.log のままになります。

サイズを基準にしたローテーションとは違って、
古いログファイルが自動で消えることはありません。
そのため、ディスクの空き容量に注意する必要があります。

{% highlight text %}
{% raw %}
 # 例:
 logger = Logger.new('foo.log', 'daily')
 # または
 logger = Logger.new('foo.log', 'weekly')
 # または
 logger = Logger.new('foo.log', 'monthly')
{% endraw %}
{% endhighlight %}


念のため補足しておきますが、

* daily は 日ごと
* weekly は週ごと
* monthly は月ごと


です。

### ログへの出力方法

次にアプリケーションからログを出力する方法を示します。
基本的には次のようにログのレベルを小文字にしたメソッドを使うだけです。

{% highlight text %}
{% raw %}
 # 例:
 logger.error "lost connection"
 logger.debug "got new connection"
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 出力例:
 E, [2005-07-18T12:03:21.820442 #9551] ERROR -- : lost connection
 D, [2005-07-18T12:03:21.837889 #9551] DEBUG -- : got new connection
{% endraw %}
{% endhighlight %}


これらのメソッドにはメッセージを指定する方法がいくつかあります。
それをここで紹介します。

#### ブロック

ブロック付きで呼び出すと、ログが記録されるときだけブロックが呼ばれて、
その値がメッセージに使われます。

{% highlight text %}
{% raw %}
 # 例:
 logger.fatal { "Argument 'foo' not given." }
 logger.debug { "ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]" }
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 出力例:
 F, [2005-07-18T12:04:14.123795 #9551] FATAL -- : Argument 'foo' not given.
 D, [2005-07-18T12:04:14.157705 #9551] DEBUG -- : ruby 1.8.2 (2005-04-11) [i386-linux]
{% endraw %}
{% endhighlight %}


#### 文字列

ブロックなしで引数に文字列を指定すると、
文字列がそのままログメッセージに使われます。

{% highlight text %}
{% raw %}
 # 例:
 logger.error("Argument #{@foo} mismatch.")
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 出力例:
 E, [2005-07-18T12:05:41.200541 #9551] ERROR -- : Argument value-of-@foo mismatch.
{% endraw %}
{% endhighlight %}


#### ProgName 指定付き

引数の文字列とブロックの両方を指定すると、文字列が ProgName に使われます。

{% highlight text %}
{% raw %}
 # 例:
 logger.info('initialize') { "Initializing..." }
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 # 出力例:
 I, [2005-07-18T12:05:58.596513 #9551]  INFO -- initialize: Initializing...
{% endraw %}
{% endhighlight %}


#### レベル指定付き

ログのレベルを小文字にしたメソッドの中で呼ばれている add メソッドを
レベル指定付きで直接呼び出すことも出来ます。

普通は add メソッドは使わず、ログのレベルごとのメソッドを使えば良いでしょう。

{% highlight text %}
{% raw %}
 # 例:
 logger.add(Logger::FATAL) { 'Fatal error!' }
{% endraw %}
{% endhighlight %}


#### 例外オブジェクト

ブロック付きの場合もブロックなしで引数に指定する場合も、
文字列の変わりに例外オブジェクトを指定することが出来ます。

{% highlight text %}
{% raw %}
 # 例:
 begin
   raise "some error"
 rescue
   logger.error($!)
 end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 # 出力例:
 E, [2005-07-18T12:06:09.525728 #9551] ERROR -- : some error (RuntimeError)
 sample.rb:4
{% endraw %}
{% endhighlight %}


## Syslog

### Syslogとは？

Syslog モジュールとは、
UNIX のシステムのログ記録用プログラム (syslog)
にメッセージを送るためのモジュールです。

### なぜクラスではなくモジュール？

syslog はプロセスごとに 1 つしか開けないので、
最初は Syslog が Singleton
パターンのクラスになっていました。[^2]
その後の互換性を保った変更で、現在はモジュールになっています。

### facility

syslog には、Logger の レベルと同じような意味の priority (優先度) の他に
facility (ファシリティ) があります。

facility とは、ログの種類を表しているもので、詳細はシステムに依存します。
詳しいことは、それぞれのシステムの syslog の man などを参照してください。

例として、Linux の facility を
[JM の syslog(3)](http://www.linux.or.jp/JM/html/LDP_man-pages/man3/syslog.3.html)
から表の形式にして引用します。

| LOG_AUTH| セキュリティ/認証 メッセージ (非推奨。代わりに LOG_AUTHPRIV を使用すること) |
| LOG_AUTHPRIV| セキュリティ/認証 メッセージ (プライベート) |
| LOG_CRON| クロックデーモン (cron と at) |
| LOG_DAEMON| 特定の facility 値を持たないシステムデーモン |
| LOG_FTP| ftp デーモン |
| LOG_KERN| カーネルメッセージ |
| LOG_LOCAL0 から LOG_LOCAL7| ローカルな使用のためにリザーブされている |
| LOG_LPR| ラインプリンタ・サブシステム |
| LOG_MAIL| メール・サブシステム |
| LOG_NEWS| USENET ニュース・サブシステム |
| LOG_SYSLOG| syslogd によって内部的に発行されるメッセージ |
| LOG_USER (デフォルト)| 一般的なユーザレベルメッセージ |
| LOG_UUCP| UUCPサブシステム|


この中で、
プログラムの目的に適した facility があればそれを使うと良いでしょう。
適した facility がなければ、LOG_LOCAL0 から LOG_LOCAL7 のうち、
他のプログラムが使っていないものを調べて、デフォルトとして使い、
他の facility にも設定可能にしておくと良いと思います。

### 使用例

[ruby-man:Syslog](ruby-man:Syslog) にある例を紹介します。

{% highlight text %}
{% raw %}
 require 'syslog'
 Syslog.open("syslogtest")
 Syslog.log(Syslog::LOG_WARNING, "the sky is falling in %d seconds!", 100)
 Syslog.log(Syslog::LOG_CRIT, "the sky is falling in %d seconds!", 10)
 Syslog.crit("the sky is falling in %d seconds!", 5)
 Syslog.close
{% endraw %}
{% endhighlight %}


Syslog を使うためには、まず一度だけ open する必要があります。

その後は、

* Syslog.log(priority, format, ...)


または

* Syslog.emerg(message, ...)
* Syslog.alert(message, ...)
* Syslog.crit(message, ...)
* Syslog.err(message, ...)
* Syslog.warning(message, ...)
* Syslog.notice(message, ...)
* Syslog.info(message, ...)
* Syslog.debug(message, ...)


などの priority ごとのメソッドでメッセージを送ります。

priority (priority に対応する定数とメソッド) は、
システムによっては定義されていないものもあります。

message とそれに続く引数は、syslog(3) 関数ではなく
Ruby の sprintf メソッドで処理されます。
そのため、syslog(3) 関数とは違って「%m」が使えません。

sprintf で処理されるので、任意の文字列を出力するためには

{% highlight text %}
{% raw %}
 Syslog.debug('%s', str)
{% endraw %}
{% endhighlight %}


のように %s を使う必要があることに注意してください。[^3]

Ruby では、

{% highlight text %}
{% raw %}
 Syslog.debug(str)
{% endraw %}
{% endhighlight %}


としてしまうと、str に %s などが含まれていた場合に

{% highlight text %}
{% raw %}
 ArgumentError: too few arguments
{% endraw %}
{% endhighlight %}


になります。

### openlog の option 引数

openlog(3) 関数の第 2 引数の option を Syslog.open の第 2 引数に指定出来ます。
Syslog::Constants モジュールに定義された定数を「|」(ビット単位の or)
した値を指定します。

オプションもシステム依存のため、詳細はそれぞれのシステムの syslog の man などを参照してください。

{% highlight text %}
{% raw %}
 例:
 Syslog.open('ftpd', Syslog::LOG_PID | Syslog::LOG_NDELAY, Syslog::LOG_FTP)
{% endraw %}
{% endhighlight %}


### mask (ログの優先度マスク)

Syslog は Logger と違い、メッセージを送るかどうかを
priority ごとに設定出来ます。

syslogd などのメッセージを受け取る側でファイルに記録するかどうかなどの
扱いを設定出来るので、mask を使うことはあまりないかもしれません。

Logger のレベルのようにある priority 以上のログのみを送る設定は、
LOG_UPTO の存在するシステムの場合は、

{% highlight text %}
{% raw %}
 Syslog.mask = Syslog.LOG_UPTO(Syslog::LOG_WARNING)
{% endraw %}
{% endhighlight %}


のようにすると良いでしょう。

特定の priority が syslog に送られるかどうかを調べるには

{% highlight text %}
{% raw %}
 Syslog.mask & Syslog.LOG_MASK(Syslog::LOG_WARNING) != 0
 Syslog.mask & Syslog.LOG_MASK(Syslog::LOG_INFO) != 0
{% endraw %}
{% endhighlight %}


のようにすると良いでしょう。

## 標準添付以外のライブラリ

### Log4r

Log4r は高機能なログ記録用ライブラリです。
Logger では機能不足と思ったときに使うと良いと思います。

### win32-eventlog

Win32 では [Ruby Library Report 【第 4 回】 Win32Utils]({% post_url articles/0005/2005-02-15-0005-RLR %}) で、その他のライブラリとして名前が出ていた
win32-eventlog を使って、eventlog の読み書きが出来るようです。

## 終わりに

今回は Logger を中心に紹介しました。
一般的なログを記録する用途には、Logger のローテーションを機能を使えば充分だと思います。
用途や環境に応じて syslog や win32-eventlog を使ったり、
プログラムのユーザが XML や YAML でログの設定を自由に出来るようにしたい時は
Log4r を使ったりすると良いのではないかと思います。

## 参考サイト

* [Logger の rdoc](http://www.ruby-doc.org/stdlib/libdoc/logger/rdoc/index.html) (英語)
* [ruby-man:Logger](ruby-man:Logger)
* [ruby-man:Syslog](ruby-man:Syslog)
* [ruby-man:Syslog::Constants](ruby-man:Syslog::Constants)
* [ruby-man:sprintfフォーマット](ruby-man:sprintfフォーマット)
* [http://www.linux.or.jp/JM/html/LDP_man-pages/man3/syslog.3.html](http://www.linux.or.jp/JM/html/LDP_man-pages/man3/syslog.3.html)
* [http://www.linux.or.jp/JM/html/LDP_man-pages/man3/setlogmask.3.html](http://www.linux.or.jp/JM/html/LDP_man-pages/man3/setlogmask.3.html)
* [Log4r](http://log4r.sourceforge.net/) (英語)
* [RAA:log4r](http://raa.ruby-lang.org/project/log4r)
* [RAA:win32-eventlog](http://raa.ruby-lang.org/project/win32-eventlog)


## 著者について

西山和広。前号に続いて、標準添付ライブラリ紹介を書きました。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}

----

[^1]: MiB については http://www.linux.or.jp/JM/html/LDP_man-pages/man7/units.7.html を参照
[^2]: [[ruby-ext:1996]]
[^3]: C 言語で
syslog("%s", str) とせずに syslog(str) としてしまうと format string
bug というセキュリティホールの原因となるバグになります。
