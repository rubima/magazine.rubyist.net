---
layout: post
title: Fluentd v11 の噂
short_title: Fluentd v11 の噂
tags: 0044 FluentdV11NewFeatures
---


書いた人: sonots ([@sonots](https://twitter.com/sonots))

## はじめに

皆さんは Fluentd をご存知でしょうか？ 「[Fluentd](http://fluentd.org/)」は[トレジャーデータ](http://www.treasure-data.com)のメンバおよびコミュニティメンバーにより開発が進められている Ruby 実装のオープンソースログ収集ツールです。

クラウド化が進むことでますますシステムが大規模・複雑化している近年、大量・多様に出力されるログを効率良く管理し、活用できるツールとして注目され、実際に[多くの会社](http://docs.fluentd.org/articles/users)によって利用されています。[^1]

今回私は、そのメジャーバージョンアップとなる Fluentd v11 にまつわる噂を記事にしたいと思います。噂、としているのは v11 はまだ開発途中であり、これらの仕様はまだ確定したものではなく、今後変更もあり得るためです。

Fluentd v11 は今までの Fluentd v10 と内部実装が全く異なり、フルスクラッチで再実装されています。
それに伴い多くの仕様変更、機能追加がされていますのでご紹介していきます。

## v11 の仕様変更・新機能

### 起動時に bundle install する機能の追加

v11 の fluentd コマンドには -g GEMFILE および -G GEM_INSTALL_PATH オプションが追加されました。
このオプションを利用することにより、指定した Gemfile に対して起動時に bundle install を実行し、依存 plugin をインストールさせることができるようになります。

{% highlight text %}
{% raw %}
 $ bin/fluentd -h
 Usage: fluentd [options]
     -s, --setup [DIR]                                          install sample configuration file to the directory (defalut: /etc/fluentd.conf)
     -c, --config PATH                                          config file path (default: /etc/fluentd.conf)
     -p, --plugin DIR                                              add plugin directory
     -I PATH                                                              add library path
     -r NAME                                                            load library
     -g, --gemfile GEMFILE                                Gemfile path
     -G, --gem-path GEM_INSTALL_PATH  Gemfile install path
            --use-shared-gems                               Enable gems not installed into gem-path
     -d, --daemon PIDFILE                                  daemonize fluent process
            --user USER                                              change user of worker processes
            --group GROUP                                        change group of worker processes
     -o, --log PATH                                                 log file path
     -v, --verbose                                                   increase verbose level (-v: debug, -vv: trace)
     -q, --quiet                                                        decrease verbose level (-q: warn, -qq: error)
     -D, --parameter KEY=VALUE                  other parameters
            --version                                                    Show version
{% endraw %}
{% endhighlight %}


試しに次の Gemfile を作成してみましょう。

{% highlight text %}
{% raw %}
 # MyGemfile
 source 'https://rubygems.org'

 gem 'fluentd', path: '.'
 gem 'fluentd-plugin-grep', git: 'https://github.com/sonots/fluent-plugin-grep', branch: 'v11'
{% endraw %}
{% endhighlight %}


config ファイルも必須なので、適当に次のファイルをデフォルトパスである /etc/fluentd.conf に用意しておくことにします。

{% highlight text %}
{% raw %}
 # /etc/fluentd.conf
 <source>
   type forward
   port 20000
 </source>
{% endraw %}
{% endhighlight %}


以下のように -g オプションで Gemfile を指定して fluentd を起動すると、gem のインストールが始まり、fluentd が起動されます。

{% highlight text %}
{% raw %}
 $ bin/fluentd -g MyGemfile
 Resolving dependencies...
 Using cool.io (1.2.0)
 Using http_parser.rb (0.5.3)
 Using msgpack (0.5.5)
 Using sigdump (0.2.2)
 Using serverengine (1.5.3)
 Using yajl-ruby (1.1.0)
 Using fluentd (0.11.0) from source at .
 Installing fluentd-plugin-grep (0.0.4) from https://github.com/sonots/fluent-plugin-grep (at v11)
 Using bundler (1.3.5)
{% endraw %}
{% endhighlight %}


拙作の [fluentd-plugin-grep](https://github.com/sonots/fluent-plugin-grep) が追加インストールされました。

Gemfile で gem のバージョンを指定すればバージョンコントロールが可能です。実は fluentd のバージョンを指定して、fluentd をすげ替えることもできるので、興味深いかと思います。

尚、bundle exec bin/fluend のように bundler を使って fluentd を起動した場合は、-g オプションで指定した Gemfile は読み込まれない仕様ですのでご注意ください。

### マルチプロセスで起動する worker ディレクティブの追加

Fluentd v11 は Fluentd v10 までと内部実装が全く異なり、[serverengine](https://github.com/frsyuki/serverengine) と呼ばれる unicorn のように prefork モデルでマルチプロセスサーバを実装するためのフレームワークをベースに作成されています。

これにより、今までは CPU リソースを有効に活用するためには、コア数分の Fluentd プロセスを supervisord や daemontools を利用するなどしてユーザが独自に管理する必要があったのですが、Fluentd 単体で複数プロセスを管理することができるようになりました。

※ 尚、serverengine の作者は fluentd のコアデベロッパーである古橋さんであり、おそらく Fluentd v11 で利用するために実装したものと思われます。

Fluentd を複数プロセスで起動するには worker ディレクティブを使用します。

{% highlight text %}
{% raw %}
  # /etc/fluentd.conf
  <worker>
    <source>
      type forward
      port 20000
    </source>
    <match **>
      type stdout
    </match>
  </worker>
  
  <worker>
    <source>
      type forward
      port 20001
    </source>
    <match **>
      type stdout
    </match>
  </worker>
  
  <worker>
    <source>
      type forward
      port 20002
    </source>
    <match **>
      type stdout
    </match>
  </worker>
{% endraw %}
{% endhighlight %}


では、fluentd を起動して、ps コマンドでプロセス数を見てみましょう。

{% highlight text %}
{% raw %}
 $ bin/fluentd -c /etc/fluentd.conf
 $ ps -ef | grep fluentd
 1106      7352 25586  0 09:45 pts/0    00:00:00 ruby bin/fluentd -c /etc/fluentd.conf
 1106      7407   7352  0 09:45 pts/0    00:00:00 fluentd:worker 0
 1106      7409   7352  0 09:45 pts/0    00:00:00 fluentd:worker 1
 1106      7421   7352  0 09:45 pts/0    00:00:00 fluentd:worker 2
{% endraw %}
{% endhighlight %}


fluentd:worker プロセスが３つ立ち上がっていることがわかりますね。

尚、Fluentd v11 では、設定ファイルに worker ディレクティブの記載がない場合は、v10 compatible configuration file モードで設定ファイルが読み込まれます。

worker ディレクティブのない次のような設定ファイルを指定すると、次のような warning メッセージがログに出力されるのですぐわかりますね。

{% highlight text %}
{% raw %}
 $ bin/fluentd -c /etc/fluentd.conf
 2013-09-06 16:15:30 +0900 [warn]: fluentd/server.rb:143:read_config: Using backward compatible configuration file. Please replace it with following content to not show this message again:
 <worker>
   <source>
     type "forward"
     port "20000"
   </source>
 </worker>
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 # /etc/fluentd.conf
 <source>
   type forward
   port 20000
 </source>
{% endraw %}
{% endhighlight %}


### 内部ルーティングラベルの導入

Fluentd v11 では内部ルーティングラベルが導入されました。

今までは、ログを加工するようなフィルタリングプラグインに処理を渡す場合には、add_tag_prefix といった設定オプションを用いてタグを変更していました。
つまり、入力時にログファイルの種別を区別するために付けたタグが、フィルタリングプラグインを介すにつれて、
ルーティング用のタグが付加されていき、ごちゃごちゃになってしまっていました。

内部ルーティングラベルが導入されたことにより、
入力時のタグをそのまま出力プラグインに引き渡し保存することができるようになります。
これで出力プラグインの remove_tag_prefix オプションとはおさらばですね。

内部ルーティングラベルを指定するために、設定ファイルの文法に label ディレクティブが新しく導入されています。
また、label を付与してルーティングされるための redirect プラグインが fluentd 本体で用意されています。

設定ファイルは例えば次のようになります。

{% highlight text %}
{% raw %}
 # /etc/fluentd.conf
 <worker>
   <source>
     forward
     port 20000
   </source>

   <match **>
     type redirect
     label test # ラベル test を付ける。タグはそのまま
   </match>

   <label test> # ラベル test の付いたメッセージにマッチする
     <match **>
       type stdout
     </match>
   </label>
 </worker>
{% endraw %}
{% endhighlight %}


### 設定ファイルが DSL で書けるように

設定ファイルを DSL で書く記法が追加されました。例として次のような設定ファイルを DSL に変更してみます。

{% highlight text %}
{% raw %}
 # /etc/fluentd.conf
 <worker>
   <source>
     type "tail"
     path "/var/log/syslog"
     pos_file "/tmp/_var_log_syslog.pos"
     format "/^(?<message>.*)$/"
     tag "raw.syslog"
   </source>
   <match raw.syslog>
     type "stdout"
   </match>
 </worker>

 <worker>
   <match **>
     type stdout
   </match>
 </worker>
{% endraw %}
{% endhighlight %}


拡張子を .rb に変更して次のように書きます。&lt;hoge&gt;&lt;/hoge&gt; のようなディレクティブが hoge {} のように変わっただけで、
他はほとんどそのままです。簡単に移行できそうですね。

{% highlight text %}
{% raw %}
 # fluentd.rb
 worker {
   source {
     type :tail
     path "/var/log/syslog"
     pos_file "/tmp/_var_log_syslog.pos"
     format "/^(?<message>.*)$/"
     tag "raw.syslog"
   }
   match('raw.syslog') {
     type :stdout
   }
 }

 worker {
   match('raw.**') {
     type :stdout
   }
 }
{% endraw %}
{% endhighlight %}


ruby の DSL になりましたので、設定ファイル中で ruby コードを書く事ができるようになります。
例えば以下のように書けば、in_forward の設定をコピー＆ペーストせずに worker プロセスを複数で起動させることができます。

{% highlight text %}
{% raw %}
 # fluentd.rb
 ("20000".."20011").each do |port|
   worker {
     source {
       type :forward
       port port
     }
     match('**') {
       type :stdout
     }
   }
 end
{% endraw %}
{% endhighlight %}


実は、Fluentd v0.10.38 にも experimental な実装として、v11 の DSL 記法がバックポートされています！
Fluentd v10 には worker ディレクティブがありませんので、以下のように書きます。是非、試してみてください。

{% highlight text %}
{% raw %}
 # fluentd.rb
 ("20000".."20011").each do |port|
   source {
     type :forward
     port port
   }
   match('**') {
     type :stdout
   }
 end
{% endraw %}
{% endhighlight %}


### 設定ファイルで配列、ハッシュを指定できる

Fluentd プラグインの設定パラメータに、配列およびハッシュを指定できるようになります。

今まで利用可能だった以下のパラメータの型に加え、

* string
* integer
* float
* size
* bool
* time


次の型が追加されます。

* any
* hash


any は数値、文字列など型を限定することなくパラメータを指定できる型です。

プラグインでこれらの型を受け取るパラメータを用意するには、次のようなコードを書きます。

{% highlight text %}
{% raw %}
 config_param :try_any, :any, :default => ['foo','bar']
 config_param :try_hash, :hash, :default => {'foo' => 'bar'}
{% endraw %}
{% endhighlight %}


すると、設定ファイルで次のように配列およびハッシュを指定できます。

{% highlight text %}
{% raw %}
 try_any  [a,b]
 try_hash {a:b}
{% endraw %}
{% endhighlight %}


今までは、パラメータで配列を受け取りたい場合は、プラグイン内部で文字列を split(",") して配列に変換するなどの必要があったのですが、any および hash の導入により、これらのコードが不要になるので、プラグイン制作者にとって嬉しい機能です。

### 設定ファイルでプレースホルダーを使える

Fluentd v11 の設定ファイルの記法として ${} 記法が追加されます。これにより、設定ファイル中に ruby コードを書けるようになります。

例えば ${Float::NAN} とか ${1+1} のような任意の ruby コードを書けます。${ENV['XXXX']} のように環境変数を呼び出すこともできますね。

{% highlight text %}
{% raw %}
 # /etc/fluentd.conf
 <worker>
   <source>
     type foobar
     size ${10*1024*1024}
     port ${ENV['PORT']}
   </source>
 </worker>
{% endraw %}
{% endhighlight %}


尚、ruby のコードは Object.new のコンテキストで実行されます。

### TCPソケットを閉じない graceful restart

TCP ソケットを閉じない graceful restart ができるようになります。

serverengine では以下の Signal を受け取ることができ、Fluentd v11 でも同様に USR1 シグナルで graceful restart させることができます。

serverengine のシグナル一覧：

* TERM: graceful shutdown
* QUIT: immediate shutdown (available only when worker_type is "process")
* USR1: graceful restart
* HUP: immediate restart (available only when worker_type is "process")
* USR2: reload config file and reopen log file
* INT: detach process for live restarting (available only when supervisor and enable_detach parameters are true. otherwise graceful shutdown)
* CONT: dump stacktrace and memory information to /tmp/sigdump-.log file


試しに fluentd に USR1 シグナルを送るには以下のようにします。

{% highlight text %}
{% raw %}
 $ bin/fluentd -d /tmp/fluentd.pid
 $ kill -USR1 $(cat /tmp/fluentd.pid)
{% endraw %}
{% endhighlight %}


### プラグインの名前空間が Fluent::Plugin から Fluentd::Plugin に変更

プラグイン制作者向けの話となります。

Fluentd v11 用のプラグインは Fluentd v10 用のプラグインと互換性がありません。そこで、プラグインの名前空間が Fluent::Plugin から Fluentd::Plugin に変更となりました。合わせて gem の名称も fluent-plugin-xxx から fluentd-plugin-xxx に変更となりますので、対応が必要です。

[Fluentdプラグインのv10→v11移植ガイド](https://gist.github.com/frsyuki/6191818) がありますので、そちらを参考して、v11 移行を実施してください。

### Filter プラグインの新設

[fluent-plugin-grep](https://github.com/sonots/fluent-plugin-grep) や [fluent-plugin-datacounter](https://github.com/tagomoris/fluent-plugin-datacounter) のようなメッセージを受け取って次のプラグインにフィルタリングするようなプラグインの仕組みとして filter プラグインという枠組みができました。

今までは output プラグインとして実装していましたが、output プラグインはデータベースや他のアプリケーションにデータを出力するもの、filter プラグインはフィルタリング処理をするもの、として役割が明確化されました。

設定ファイルの記述方法も変わっています。v10 までは match ディレクティブを使用していましたが、v11 からは filter プラグイン専用の filter ディレクティブが用意されました。match ディレクティブは output プラグイン用のディレクティブとなります。

{% highlight text %}
{% raw %}
 <filter **>
   type retag
   tag error
 </filter>
{% endraw %}
{% endhighlight %}


プラグイン制作者向けの話となりますが、フィルター系のプラグインを v11 に移行するには、[Fluentdプラグインのv10→v11移植ガイド (filterぷらぎん編)](https://gist.github.com/sonots/6199142) を参考にしてください。

### Windows への対応

Fluentd v11 では Windows に初めから対応する予定です。Windows 対応にあたってネックとなっていた [coolio](https://github.com/tarcieri/cool.io) のコミット権を得て、Windows 対応を進めているとの噂。また、JRuby など他の処理系のことも考え、v10 とは違いライブラリへの依存度を減らすような設計にしているとのこと。

### おまけ: format none の導入

Fluentd v10 の最新ブランチに format `none` が導入されました！今まで Fluentd では、ログをパースすることなく送信したい場合でも、

{% highlight text %}
{% raw %}
 <source>
   type tail
   format /^(?<message>.*)$/
   ....
 </source>
{% endraw %}
{% endhighlight %}


のように正規表現を記述する必要がありました。正規表現でのパースはそれだけでも充分大きなオーバーヘッドとなりえます。

そこで、上記の設定と同等な効用を持ちつつも、正規表現でのパースを必要としない format `none` が [pull request #182](https://github.com/fluent/fluentd/pull/182) によって実装されました。

{% highlight text %}
{% raw %}
 <source>
   type tail
   format none
   ....
 </source>
{% endraw %}
{% endhighlight %}


v0.10.39 および v11 以降で使用できるようになるでしょう。

## おわりに

Fluentd v11 の新機能について解説しました。マルチプロセスや DSL など夢が広がる機能がたくさんあったのではないでしょうか？
Fluentd v11 はまだ開発途中であり、仕様も fix されたものではありませんが( 2013 年 9 月 30 日現在)、近々リリース予定とのことで、前もって新機能を知っておけるとうれしいかと思い、僭越ながらご紹介させて頂きました。

この記事がお役に立てれば幸いです。

## 謝辞

本文書は Fluentd コミッターである [frsyuki](https://github.com/frsyuki) 氏、[repeatedly](https://github.com/repeatedly) 氏、[tagomoris](https://github.com/tagomoris) 氏 (順不同) にレビューして頂きました。ありがとうございました。

## 著者について

瀬尾 直利 ([@sonots](https://twitter.com/sonots))

株式会社ディー・エヌ・エー所属。インフラアプリケーションエンジニア。Ruby で Fluentd クラスタ管理ツール [Haikanko](https://github.com/sonots/haikanko) やグラフツール [Yohoushi](http://yohoushi.github.io/yohoushi/jp/) などの開発をしている。このたび Fluentd コミッターの一員となりました。

----

[^1]: 任天堂でも利用されているとか。 http://www.nintendo.co.jp/3ds/interview/streetpass_relay/vol1/index4.html
