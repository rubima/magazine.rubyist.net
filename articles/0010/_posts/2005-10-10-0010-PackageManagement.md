---
layout: post
title: シリーズ パッケージマネジメント 【第 2 回】 RubyGems (2)
short_title: シリーズ パッケージマネジメント 【第 2 回】 RubyGems (2)
tags: 0010 PackageManagement
---
{% include base.html %}


## はじめに

RubyGems の主要開発者 Chad Fowler 氏に再び寄稿してもらいました。今回は、過去・現在・未来の現在編です。簡単ですが、パッケージの管理・作成・配布を一通り網羅しています。是非お試し下さい。

## The Past, Present, and Future of RubyGems (2)

著者：Chad Fowler、訳・編：babie、すぎむし

原文（英文）：（公開され次第反映します）

### RubyGems の現在

かなり物議を醸したが（とりわけそのディレクトリ構造で）[RubyGems](http://docs.rubygems.org) は、ここ 1 年半でかなりポピュラーになってきた
（[Rails](http://www.rubyonrails.com) 人気に大いにあやかって。RubyGems は Rails の第一のインストール手段となったため）。RubyGems 単体でダウンロード数が 10 万に届こうとしてるのに加えて、
人気の [One-Click Ruby Installer](http://rubyinstaller.rubyforge.org/wiki/wiki.pl) に同梱されている分が、世界中の数万のデスクトップパソコンに及ぶ。
[RubyForge](http://www.rubyforge.org) に設置されているメインの gem サーバーでは
およそ通算 90 万の gem パッケージがダウンロードされ、
今現在も 1 日に 5000 程度ダウンロードされている。
これを書いている時点で、インストール用のメイン gem リポジトリで 360 以上のアプリケーションやライブラリが登録されている。

RubyGems は Ruby パッケージの管理においてデファクトスタンダードとなった。
その一番の理由は、検索・インストール・アンインストールする方法が簡単だったからだ。

### ソフトウェアのインストール

例：

{% highlight text %}
{% raw %}
 $ gem search --remote finger

 *** REMOTE GEMS ***

 fingerserver (0.4.0)
   Exposes hash-style objects via the finger protocol.
{% endraw %}
{% endhighlight %}


ふーむ、面白そうだ。インストールしてみよう。

{% highlight text %}
{% raw %}
 $ sudo gem install fingerserver
 Attempting local installation of 'fingerserver'
 Local gem file not found: fingerserver*.gem
 Attempting remote installation of 'fingerserver'
 Successfully installed fingerserver-0.4.0
{% endraw %}
{% endhighlight %}


RDoc をサッと見てから、

{% highlight text %}
{% raw %}
 $ sudo ruby -rubygems -e "require 'fingerserver'; FingerServer.new('chad' => 'A Rubyist')" &
 [1] 12909
 $ finger chad@localhost
 [localhost]
 Trying ::1...
 chad: A Rubyist
{% endraw %}
{% endhighlight %}


オレってばスゲー！
finger サーバが 1 行で書けた！

アプリケーションのインストールはどうするかって？
既に gem パッケージで [Rake](http://rake.rubyforge.org) を入れてある。今のバージョンを調べてみよう。

{% highlight text %}
{% raw %}
 $ rake --version
 rake, version 0.5.3
{% endraw %}
{% endhighlight %}


もっと新しいバージョンがあるかな？

{% highlight text %}
{% raw %}
 $ gem search -r rake

 *** REMOTE GEMS ***
 Updating Gem source index for: http://gems.rubyforge.org

 rake (0.5.4, 0.5.3, 0.5.0, 0.4.15, 0.4.14, 0.4.13, 0.4.12, 0.4.11,
 0.4.10, 0.4.9, 0.4.8, 0.4.7, 0.4.6, 0.4.4, 0.4.3, 0.4.2, 0.4.0, 0.3.2)
   Ruby based make-like utility.
{% endraw %}
{% endhighlight %}


よし、バージョン 0.5.4 がある。アップグレードするぞ。

{% highlight text %}
{% raw %}
 $ sudo gem update rake
 Upgrading installed gems...
 Attempting remote upgrade of rake
 Attempting remote installation of 'rake'
 Successfully installed rake-0.5.4
 Installing RDoc documentation for rake-0.5.4...
 Gems: [rake] updated
{% endraw %}
{% endhighlight %}


おしまい。

{% highlight text %}
{% raw %}
 $ rake --version
 rake, version 0.5.4
{% endraw %}
{% endhighlight %}


仮に 0.5.3 と 0.5.4 で Rake の振る舞いが変わって、自分のビルド用スクリプトが古いバージョンじゃないと動かないことがわかったとしよう。
まだ _uninstall_ コマンドを使ってバージョン 0.5.3 を削除していないのだから、古いバージョンが使えるはず、だよね？

{% highlight text %}
{% raw %}
 $ gem list rake

 *** LOCAL GEMS ***

 rake (0.5.4, 0.5.3)
     Ruby based make-like utility.
{% endraw %}
{% endhighlight %}


古いバージョンで動かすにはこうする：

{% highlight text %}
{% raw %}
 $ rake _0.5.3_ --version
 rake, version 0.5.3
{% endraw %}
{% endhighlight %}


そのうち、同じ gem のバージョン違いでいっぱいになってしまうかもしれない。

{% highlight text %}
{% raw %}
 $ gem list rails

 *** LOCAL GEMS ***

 rails (0.13.1, 0.13.0, 0.12.1)
     Web-application framework with template engine, control-flow layer,
     and ORM.
{% endraw %}
{% endhighlight %}


最新バージョン以外の全てを削除し、一掃することができる：

{% highlight text %}
{% raw %}
 $ gem cleanup rails
 Cleaning up installed gems...
 Attempting uninstall on rails-0.12.1
 Attempting to uninstall gem 'rails'
 Successfully uninstalled rails version 0.12.1
 Attempting uninstall on rails-0.13.0
 Attempting to uninstall gem 'rails'
 Successfully uninstalled rails version 0.13.0
 Clean Up Complete
 $ gem list rails

 *** LOCAL GEMS ***

 rails (0.13.1)
     Web-application framework with template engine, control-flow layer,
     and ORM.
{% endraw %}
{% endhighlight %}


今のコマンドの最後の引数を取ってしまえば、RubyGems は現在インストールされている全ての gem パッケージをキレイにできる。

当然、ある gem が完全に使い道がなくなれば、完全に削除することもできる。

{% highlight text %}
{% raw %}
 $ gem list ook

 *** LOCAL GEMS ***

 Ook (1.0.2)
     A Ruby interpreter for the Ook!
     (www.dangermouse.net/esoteric/ook.html) and BrainF*ck
     (www.catseye.mb.ca/esoteric/bf/index.html) programming languages.
 $ gem uninstall ook
 Attempting to uninstall gem 'ook'
 Successfully uninstalled Ook version 1.0.2
 $ gem list ook

 *** LOCAL GEMS ***
{% endraw %}
{% endhighlight %}


おしまい。

### 自前の gem の作り方

自前の gem をこしらえるのは簡単だ。
まず、どうしたいか（tar ボールと zip ファイルのどちらでリリースするかといったこと）をお膳立てする。
良い例を思いついた:

{% highlight text %}
{% raw %}
 - some_cool_lib
   - lib
     - cool.rb
   - test
     - cool_tc.rb
   - README
   - ChangeLog
{% endraw %}
{% endhighlight %}


このライブラリは単純でファイル数も多いといえないが、gem がどう動くのか・どんなものかを伝えるのには充分だろう。
こいつらを gem にするには gem スペックを作成すればよい。
この場合、some_cool_lib.gemspec というような名前でファイルを作り、中身はこういう風に書く：

{% highlight text %}
{% raw %}
 Gem::Specification.new do |spec|
   spec.name = "some_cool_lib"
   spec.version = "0.0.1"
   spec.summary = "土曜の午後に書いたステキな小さいライブラリ"
   spec.author = "Chad Fowler"
   spec.email = "chad+spam@chadfowler.com"
   spec.homepage = "http://www.chadfowler.com"
   spec.autorequire = "cool"
   spec.files = Dir.glob("{test,lib}/**/*") << "README" << "ChangeLog"
   spec.test_files = ["test/cool_tc.rb"]
   spec.has_rdoc = true
   spec.rdoc_options << "--main" << "README"
   spec.extra_rdoc_files = ["README"]
 end
{% endraw %}
{% endhighlight %}


gemspec を作ったなら、こんな簡単なコマンドで gem を作ることができる：

{% highlight text %}
{% raw %}
 $ gem build some_cool_lib.gemspec
 Attempting to build gem spec 'some_cool_lib.gemspec'
   Successfully built RubyGem
   Name: some_cool_lib
   Version: 0.0.1
   File: some_cool_lib-0.0.1.gem
{% endraw %}
{% endhighlight %}


バラバラに[^1] gem スペックファイルを保守するよりも、[Rake を使って gem パッケージを作る](http://rake.rubyforge.org/classes/Rake/GemPackageTask.html)方が良い。
Rake は RubyGems をビルドとリリース工程に途切れなく取り込む。

gem スペックファイルを用いても、Rake を用いても、これで配布できる gem をつくることができた。
じゃ、インストールしてみよう。

{% highlight text %}
{% raw %}
 $ gem install some_cool_lib-0.0.1.gem --test
 Attempting local installation of 'some_cool_lib-0.0.1.gem'
 Successfully installed some_cool_lib, version 0.0.1
 Installing RDoc documentation for some_cool_lib-0.0.1...
 ERROR:  1 tests, 1 assertions, 1 failures, 0 errors
 ...keep Gem? [Yn]  n
 Successfully uninstalled some_cool_lib version 0.0.1
{% endraw %}
{% endhighlight %}


ぎゃっ！
インストール時に "--test" 引数を指定したので、gem に失敗するテストがあるのがわかった！
コードを修正して gem をリビルドすれば、インストールはうまくいく。

{% highlight text %}
{% raw %}
 $ gem install some_cool_lib-0.0.1.gem --test
 Attempting local installation of 'some_cool_lib-0.0.1.gem'
 Successfully installed some_cool_lib, version 0.0.1
 Installing RDoc documentation for some_cool_lib-0.0.1...
{% endraw %}
{% endhighlight %}


最後の行は RubyGems が RDoc ドキュメントを生成したことを示している。
どうやって見つけるのかって？
それはファイルシステムの_どっか_に隠れている。
UNIXユーザー向けには、こういう_難しい_やり方がある：

{% highlight text %}
{% raw %}
 $ ls `gem env gemdir`/doc/some_cool_lib-0.0.1/rdoc
 classes                 fr_class_index.html     index.html
 created.rid             fr_file_index.html      rdoc-style.css
 files                   fr_method_index.html
{% endraw %}
{% endhighlight %}


けど、RubyGems を使えばもうすこし簡単：

{% highlight text %}
{% raw %}
 $ gem_server
 [2005-08-28 10:37:24] INFO  WEBrick 1.3.1
 [2005-08-28 10:37:24] INFO  ruby 1.8.2 (2004-12-25) [powerpc-darwin8.0]
 [2005-08-28 10:37:24] INFO  WEBrick::HTTPServer#start: pid=698 port=8808
{% endraw %}
{% endhighlight %}

![gem_server_screenshot.jpg]({{base}}{{site.baseurl}}/images/0010-PackageManagement/gem_server_screenshot.jpg)

gem_server の話はもうちょっと後でしよう。

Gem スペックでは他にもメタデータを保持できる。
完全なリファレンスは、RubyGems ドキュメントサイトの [Gemspec Reference](http://docs.rubygems.org/read/chapter/20#page85) を見てくれ。

### gem の配布

さあ、君も今日から自前 gem 作者。そうなったらシェアしたいね。

世界中でシェアする一番楽チンな方法は [RubyForge](http://www.rubyforge.org) にホスティングさせてもらえば良い。
RubyForge にアップロードすれば、自動的にセントラル gem リポジトリに追加され "gem install" コマンドでアクセスできるようになる。

そのほかに、自分で gem をホストする方法もある。
簡単な方法は、RubyGems に同梱されている "gem_server" を使うことだ。
これまで見てきたようにドキュメントを提供できるだけじゃなく、gem だって提供できちゃう。
自分達が今までインストールしたどの gem も単に "gem_server" コマンドを呼び出して提供されている。
それらにアクセスするには：

{% highlight text %}
{% raw %}
 $ gem install some_cool_lib --source http://myhost.com:8808
 Attempting local installation of 'some_cool_lib'
 Successfully installed some_cool_lib, version 0.0.1
 Installing RDoc documentation for some_cool_lib-0.0.1...
{% endraw %}
{% endhighlight %}


ひょっとすると、[Rails](http://download.rubyonrails.com) プロジェクトのように、中央 RubyGems リポジトリでない別のどこかでソフトウェアのベータ版を提供したいかもしれない。
そんでもって、恒久的な本拠地をを構え、webrick のインスタンスを個別にに走らせる代わりに既にある自前のウェブサーバを使いたいかもしれない。
問題ない。

{% highlight text %}
{% raw %}
 $ ssh chad@mywebserver.com
 password:
 mywebserver$ cd /web/server/document/root
 mywebserver$ mkdir gemserver
 mywebserver$ cd gemserver
 mywebserver$ mkdir gems
 mywebserver$ scp chad@myotherhost.com:/home/chad/some_cool_lib-0.0.1.gem gems/
 chad@myotherhost.com's password:
 some_cool_lib-0.0.1.gem                              100%   11KB  11.0KB/s   00:00
{% endraw %}
{% endhighlight %}


全て準備できた。お預けだった gem server の話に戻ろう。

{% highlight text %}
{% raw %}
 $ generate_yaml_index.rb
 $ ls
 gems  yaml  yaml.Z
{% endraw %}
{% endhighlight %}


これだけ！　
これでインターネットに繋がっているコンピューターならどこからでもインストールできる：

{% highlight text %}
{% raw %}
 $ gem install some_cool_lib --source http://mywebserver.com/gemserver
 Attempting remote installation of 'some_cool_lib'
 Updating Gem source index for: http://mywebserver.com/gemserver
 Successfully installed some_cool_lib-0.0.1
 Installing RDoc documentation for some_cool_lib-0.0.1...
{% endraw %}
{% endhighlight %}


### 何が起こってる？

今回はハイレベルな RubyGems の使い方を覚えた。
包括的なドキュメントは
[Programming Ruby (the Pickaxe)](http://pragmaticprogrammer.com/titles/ruby/index.html)
と
[RubyGems ドキュメントサイト](http://docs.rubygems.org)で見つけることができる（どっちも英語です。ごめん！）。
もちろん、一番良い学び方は_たくさんの_[フリーな gem](http://gems.rubyforge.org/gems/?M=D) をいくつか見ることだ。
もし、RubyGems のことで質問や問題（もしくはパッチ！）があるなら、[RubyGems メーリングリスト](http://rubyforge.org/pipermail/rubygems-developers/)に投稿してくれ。

次回は、バージョン 1.0 に向けた計画を含む RubyGems の行く先を取り上げようと思う。
Ruby 本体に取り込んでもらえる可能性とか、外部ツールのサポートとかをね。

## 著者について

Chad Fowler はある巨大な多国籍企業のソフトウェア開発者 兼 マネージャーです。
最近はインドに住んで働いており、オフショア・ソフトウェア開発センターを設置し率いています。
また、Ruby Central の共同設立者でもあります。
Ruby Central は非営利企業で、 
毎年行われる インターナショナル Ruby カンファレンス を主催し、Ruby コミュニティを支援しています。

## おわりに

今回はだいぶ実践的な内容だったと思います。細かいところまで言及していませんでしたが、導入には丁度良いのではないでしょうか？

次回の掲載時期等はまだ決まっておりません。楽しみにしてる方がいれば気長にお待ちください。

## シリーズ パッケージマネジメント 連載一覧

{% for post in site.tags.PackageManagement %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}

----

[^1]: gem だけでなく tar.gz や zip のファイルを作りたい時は別に用意する必要がある
