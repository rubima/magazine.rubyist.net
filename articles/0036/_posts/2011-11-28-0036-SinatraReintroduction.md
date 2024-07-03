---
layout: post
title: Sinatra 再入門、 Padrino / Rack / その先の何か
short_title: Sinatra 再入門、 Padrino / Rack / その先の何か
created_on: 2011-11-28
tags: 0036 SinatraReintroduction
---
{% include base.html %}


* Table of content
{:toc}


書いた人 : 近藤うちお ([@udzura](http://twitter.com/udzura))

## はじめに

この記事では、軽量ウェブアプリケーション DSL である [Sinatra](http://www.sinatrarb.com/)、Sinatra を拡張したフルスタックウェブ開発スイートである [Padrino](http://jp.padrinorb.com/)、そして Rails 登場以降の Ruby でのウェブ開発についての著者の持論、などを語って行きます。チュートリアル的な内容は今回は少ないですので、今回の話で興味をお持ちになったら、[Sinatra Book](http://sinatra-book.gittr.com/)、[Blog Tutorial - Padrino web framework](http://jp.padrinorb.com/guides/blog-tutorial) などを一通りなぞってみてください。また、最後の「参考資料」でサーフィンしてみても良いでしょう。

内容は、先日本郷三丁目で行われた「[スタート Padrino](http://atnd.org/events/20705)」での発表内容をベースにしています。

## Sinatra の歴史

「Sinatra とは何か」を把握する上で、そのソフトウェアがどのように作られてきたかを見ていくのは一つの助けになるでしょう。この段落でざっくりと見ていきます。

GitHub のレポジトリの情報によれば、Sinatra のバージョン 0.0.1 は 2007 年 9 月にタグを打たれています。そして、0.1.0 として Rubygems.org に公開されたのは 2007 年 10 月ごろのようです。当時の Rails はバージョン 1.2 系で、Ruby は 1.8.6 が主に使われており、1.9.0 のリリースはようやくその年のクリスマスを越えてからでした。

最初の実装は、Kernel モジュールに直接 HTTP verb 相当のメソッドを定義するという、シンプルなものでした。

```ruby
  module Kernel

    %w( get post put delete ).each do |verb|
      eval <<-end_eval
        def #{verb}(path, &block)
          Sinatra::Event.new(:#{verb}, path, &block)
        end
      end_eval
    end

  end

```

その後、Sinatra は着実な開発が続けられていきます。

0.9.0 の段階で、Sinatra::Base と言うクラスが誕生します。これは Rack 対応のアプリケーションの要件を満たしたクラスで、これにより Sinatra は二つの書き方をサポートすることとなりました。

従来までの「クラシック」スタイル

```ruby
  require 'rubygems'
  require 'sinatra'

  get '/' do
    'Fly me to the Moon!'
  end

```

そして、より「Rack アプリケーションらしい」、クラスマクロによってルートを定義するスタイル。register のような重要なメソッドもいくつか追加されています。

```ruby
  require 'rubygems'
  require 'sinatra/base'

  class MyApp < Sinatra::Base
    get '/' do
      'Fly me to the Moon!'
    end
  end

  MyApp.run! :host => 'localhost', :port => 9090

```

そして 1.0 において、以下のような大きな変更が加えられました。

* [Tilt](https://github.com/rtomayko/tilt) の導入。これにより、各テンプレートエンジンと Sinatra との間に中間層が設けられ、Sinatra からたくさんのテンプレートエンジンが利用できるようになった。
* Sinatra::Test などの古いクラスの完全な廃止。


そうして、フィルターの導入など順調にバージョンを重ね、最近まではバージョン 1.2.6 が安定版であったと思います。そしてこの 2011 年 10 月に、Sinatra 1.3 がリリースされました。stream DSL の追加など、いくつか大きな機能追加や変更がされています。詳細は拙ブログ記事 ([1](http://blog.udzura.jp/2011/10/04/sinatra-1-3-0-and-padrino-0-10-3-released-1/)、[2](http://blog.udzura.jp/2011/10/05/sinatra-1-3-0-and-padrino-0-10-3-released-2/)) でまとめてあったりもします。

また、Sinatra DSL は他の言語のフレームワークにも影響を与えています。

* Perl の [Dancer](http://perldancer.org/)、[Mojolicious::Lite](http://search.cpan.org/~sri/Mojolicious-2.28/lib/Mojolicious/Lite.pm)
* Python の [Juno](https://github.com/breily/juno)
* Haskell の [loli](http://hackage.haskell.org/package/loli)
* [Scalatra](https://github.com/scalatra/scalatra) (Scala)、 [Graffiti](https://github.com/webdevwilson/graffiti/) (Groovy)


## Sinatra を触ってみよう

さて、読者の皆さんは、Sinatra を触ったことがありますか？

もしまだであれば、実際問題 Sinatra はすぐに試すことができます。Mac OS X、Linux のような環境で Ruby と RubyGems が導入されていれば、以下のようにブラウザから Hello, World を確認することができます。

{% highlight text %}
{% raw %}
   $ gem install sinatra

   $ cat <<EOS > app.rb
   require 'rubygems'
   require 'sinatra'
   get '/' do
     "Hello, World"
   end
   EOS

   $ ruby app.rb
   #=> http://localhost:4567/ にアクセス
{% endraw %}
{% endhighlight %}


Rails で同様なことをする場合 (controller をジェネレートし、route.rb を編集し……) や、あるいは PHP などを用いて同等のことをする場合と比較しても、非常に簡単に「ブラウザで表示する」ところまでたどり着けることがご理解いただけると思います[^1]。

もうすこし、Sinatra をいじってみましょう。まずは、ベースとなる以下の app.rb を作ってみます。

```ruby
  require 'rubygems'
  require 'sinatra/base'

  class App < Sinatra::Base
    get '/' do
      "Hello, World"
    end
  end

```

名前を入力したら挨拶をしてくれる画面を作りましょう。また、簡単なレイアウトも導入しましょう。gem のインストールに関しては、必要ならば適宜「sudo」等を補ってください。

{% highlight text %}
{% raw %}
   $ gem install haml
{% endraw %}
{% endhighlight %}


```ruby
  # encoding: utf-8
  require 'rubygems'
  require 'sinatra/base'

  require 'haml'

  class App < Sinatra::Base
    enable :inline_templates
    get '/' do
      @title = "Top"
      haml "My Way"
    end

    get '/name/:name' do
      @name = params[:name]
      @title = "Song for #{@name}"
      haml "#{@name}'s Way"
    end
  end

  App.run!

  __END__

  @@ layout
  !!! 5
  %html
   %head
    %title= @title
   %body
    %h1= @title
    %div= yield

```

少し、本格的なアプリケーションっぽくなってきました。といっても 30 行と少しなんですが……。サーバを再起動して、[http://localhost:4567/](http://localhost:4567/) や [http://localhost:4567/name/foo](http://localhost:4567/name/foo) などにアクセスしてみましょう。

このアプリケーションに、さらに、以下の機能を付けてみます。

* 簡単なロガー
* /song_for/:name にアクセスしても "hello, :name" が表示されるように内部でリライトする機能
* アプリケーションの自動リローダー


実は、ロガーはすぐに追加できます。さきほどの「enable :inline_templates」のすぐ下に１行追加するだけです。

{% highlight text %}
{% raw %}
     enable :logging
{% endraw %}
{% endhighlight %}


サーバを再起動 (Ctrl+C で止めて再起動) し、適当な URL にアクセスすれば、ログが吐き出されていることが分かります。

さらに「Rack::Rewrite」という、アプリケーション内部で URL のリライトをするミドルウェアを導入します。むろん、mod_rewrite や Nginx でも同じことができるのですが、アプリケーション内部でリライトルールを記述することは以下のメリットがあります。

* サーバアプリケーションに依存せずリライトルールが書ける。
  * これは、特にサーバアプリケーション側をいじれないようなクラウド環境、例えば heroku へのデプロイ時などに便利です。
* Rack::Test などの力を借りて、リライトルールの自動テストが書ける。


インストールは簡単です。

{% highlight text %}
{% raw %}
   $ gem install rack-rewrite
{% endraw %}
{% endhighlight %}


そうして、以下のような記述をします。「何をしているか」は一目瞭然だと思います。

```ruby
  require 'rack/rewrite'
  #...
  class App < Sinatra::Base
    #...
    use Rack::Rewrite do
      rewrite %r{^/song_for/(.*)}, '/name/$1'
    end
    #...
  end

```

実際、[http://localhost:4567/name/foo](http://localhost:4567/name/foo) と [http://localhost:4567/song_for/foo](http://localhost:4567/song_for/foo) とで同じ画面が表示されることと思います。

こうした、「use」で利用できるミドルウェアを「Rack Middleware」と呼びます。これらミドルウェアは、実は Rack に準拠しているアプリケーションフレームワーク、具体的には Ramaze や Rails などでも同じように利用可能です。逆に、後述する「register」で登録するモジュールは「Sinatra Extensions」と呼び、Sinatra、あるいは今回説明する、Sinatra を拡張したフレームワークである Padrino などの、Sinatra ベースのものでないと利用できません。

一つサンプルとして、毎回再起動するのは面倒ということで、リローダーを利用することにします。

{% highlight text %}
{% raw %}
   $ gem install sinatra-contrib
{% endraw %}
{% endhighlight %}


で、「require 'sinatra/base'」の直後に、

{% highlight text %}
{% raw %}
   require 'sinatra/reloader'
{% endraw %}
{% endhighlight %}


最後に、register でリローダの利用を宣言するだけです (サーバが Thin だと上手に動かないので、一緒に設定で WEBrick に決め打ちします)。

```ruby
  class App < Sinatra::Base
    enable :inline_templates
    enable :logging
    set :server, "webrick"
    register Sinatra::Reloader
    #...
  end

```

development 環境でのみ有効にしたい場合も簡単です。

```ruby
  configure :development do
    register Sinatra::Reloader
    set :server, "webrick"
  end

```

これでターミナルで Sinatra プロセスを立ち上げたままで、デザイン変更、ロジックの変更など、いろいろな改修を加えられます (gem の追加等の場合は再起動が必要になりますので注意してください)。

以上、ほんの数行で、たくさんの機能が追加できます。このサクサク感覚が Sinatra の醍醐味です。もちろん、ルーティングに伴ったブロックの中にザクザクとロジックを書いていくのも簡単ですし、柔軟な before/after フィルターもあります。

(ここまでのコードをまとめたものを、[こちら](https://gist.github.com/1369670) (Gist) に置いておきました)

## Sinatra の向こう側 - Padrino framework とはなにか

ここまで作ってきて、Sinatra のシンプルさと魅力を分かっていただけたかと思いますが、Sinatra で複雑なウェブアプリケーションを作ろう、となるといくつか面倒くさい点が出てきます。

* 一回一回アプリケーションのスケルトンを手作りすることになる。test や view、public のディレクトリを作成する、など
* Sinatra DSL を一つのクラスにすべて書くと、画面数が増えた際に管理しきれない、巨大なファイルになりうる
* Rails と比べた際に、例えばフォームなどのヘルパーがない、キャッシュ機構がない、ということがいちいちあり、「車輪の再発明」をせざるを得ないときがある


要は、定例化された作業を何度も繰り替えさなければならなかったり、「かゆいところに手が届かない」場面に遭遇しがちであるということです。 Sinatra 自身は、いわゆる MVC アーキテクチャに対応させるなら、「Controller」の部分の機能しか提供してくれません。Model や View は他から借りてくることになりますし、それらを統合するためのコードが毎回必要になります。

そういった「かゆいところ」をカバーし、スピーディーに、かつ Sinatra の良さを失わないように開発する一つの解決策が、Padrino framework です。

### Padrino の三つの特徴

Padrino の大きな特徴として以下の三点が挙げられます。

#### Agnostic

Padrino は、数多くの ORM、adapter、テンプレートエンジン、テスティングフレームワーク、モック、スタイルシートエンジン、JavaScriptライブラリと一緒に使うことができます。好きなものをピックアップする形でプロジェクトを作成できるということです。

Padrino 自身は、上記の機能に関しては、各コンポーネントをつなぐグルー (糊) としての役割に集中しています。結果として結合度の低さを実現しています。

#### Modularity

Padrino の各機能は、すべてまとめてフルスタックフレームワークとして利用することもできますが、必要な機能だけをまっさらな Sinatra アプリケーションに導入することもできます。各機能は、先ほど説明した「use」と「register」を用いて拡張する形で実装されているため、同じやり方で単独でも導入できるというわけです。

#### Lightweight

Sinatra でできたアプリケーションは軽量です。少し触ってみて、驚いた方も多いでしょう。Padrino は、Sinatra 単独の時とほとんど変わらないパフォーマンスを提供します。

### 具体的な機能群

さて、具体的な機能に入ってみましょう。Padrino framework は、Sinatra の上にざっくりと以下のような機能を提供してくれます。

* Rails 風 MVC パターンの導入
* 豊富な Helper
* シンプルなメール配信機能
* シンプルなキャッシュ機能
* 基本的な国際化機能
* 見易いロガー
* 開発時のリローダー
* 管理画面の自動作成
* サブアプリケーションの作成/マウント
* ジェネレータ含むコマンドラインツール
* テストの自動生成


いくつかについて詳細に見てみましょう。

まず、「Rails 風 MVC パターンの導入」ということで、Sinatra の HTTP verb を拡張し、DSL には controller メソッドが追加されます。以下は、公式ガイドからの引用です。

```ruby
  SimpleApp.controllers :admin do
    get :show, :with => :id do
      # url is generated as "/admin/show/#{params[:id]}"
      # url_for(:admin, :show, :id => 5) => "/admin/show/5"
    end

    get :other, :with => [:id, :name] do
      # url is generated as "/admin/other/#{params[:id]}/#{params[:name]}"
      # url_for(:admin, :other, :id => 5, :name => "hey") => "/admin/other/5/hey"
    end
  end

```

これにより、「Controller による画面のグルーピング」が実現でき、また、各ルーティングに名前が付くため、url_for ヘルパーによって実 URL を参照することができるようになります。そしてビューやモデルに関しても、専用のディレクトリにジェネレータにより生成することが可能になります。

また、豊富で十分なテストが書かれたヘルパー群、メール送信やキャッシュのための DSL の拡張も含まれています。これらは、それぞれ padrino-helpers、padrino-mailer、padrino-cache として単一の gem に切り出されており、先だって説明した「register」により、単独で普通の Sinatra アプリケーションにも cherry-pick できます。

```ruby
  require 'sinatra/base'
  require 'padrino-helpers'

  class Application < Sinatra::Base
    register Padrino::Helpers
  end

```

```ruby
  require 'sinatra/base'
  require 'padrino-mailer'

  class Application < Sinatra::Base
    register Padrino::Mailer

    mailer :sample do
      email :birthday do |name, age|
        subject 'Happy Birthday!'
        to      'john@fake.com'
        from    'noreply@birthday.com'
        locals  :name => name, :age => age
        render  'sample/birthday'
      end
    end
  end

```

```ruby
  require 'sinatra/base'
  require 'padrino-cache'

  class Application < Sinatra::Base
    register Padrino::Cache
    enable :caching

    get '/foo', :cache => true do
      expires_in 30 # expire cached version at least every 30 seconds
      'Hello world'
    end
  end

```

ロガー、リローダーなども、開発時には便利だと分かっていても、自分で実装するとなるとなかなか大変なものです。Padrino のロガーは非常に読みやすく、リローダーも賢いので、比較的地味な要素なのかもしれませんが、開発時のストレスがずいぶん軽減されることになるでしょう。

また、重要な機能としてサブアプリケーションの作成 / マウント機能が挙げられます。サブアプリケーションはジェネレータにより簡単に追加できます。管理画面も、サブアプリケーションの一つとして自動生成が可能で、Padrino には Scaffold がありませんが、その代わりに各モデルの管理画面を自動生成可能であり、CRUD をブラウザから実行できるようになっています。

フルスタックとして Padrino を利用する際は、padrino コマンドが使えます。サブコマンドでプロジェクトやコントローラ、モデルの自動生成、開発サーバの起動、rake タスクの実行が行えます。ジェネレータはテストも含めて自動生成してくれ、padrino rake test/spec コマンドでテストを実行可能です。なので、TDD での開発にも向いています。

以上のような機能を一通り覗いてみるためには、[Blog Tutorial](http://jp.padrinorb.com/guides/blog-tutorial) が大変有用ですが、ここでも簡単にいくつかの機能を試してみることとします。

まずは Padrino フレームワークをインストールしてみましょう。といっても Rubygems で簡単に入るのですが……。

{% highlight text %}
{% raw %}
   $ gem install padrino
{% endraw %}
{% endhighlight %}


先ほど作成した app.rb に、いくつか Padrino の提供する機能を加えてみます。

一番わかりやすいのは Padrino::Helpers でしょう。まず、以下のように変更してください。

```ruby
  # gem を追記
  require 'padrino-helpers'

  class App < Sinatra::Base
    #...
    register Padrino::Helpers

    #...
    get '/' do
      haml :index
    end

    #...
  end

```

そして、__END__ 以下のテンプレートで、ヘルパーを使うように編集します。

```ruby
  @@ layout
  !!! 5
  %html
    %head
      %title= yield_content(:title) || @title
    %body
      %h1= yield_content(:header) || @title
      %div= yield

  @@ index
  - content_for :title do
    This is title from helper
  - content_for :header do
    This is header from helper
  %p My Way

```

この状態で / にアクセスすると、確かに content_for の内容が yield_content に展開されているのが分かると思います。無論、form builder なども利用可能です。

また、ログをよりカラフルなものにしてみましょう。Padrino::Logger::Rack は padrino-core に含まれます。

```ruby
  require 'padrino-core'
  #...
  class App < Sinatra::Base
    # Sinatra 自体のログを disable
    disable :logging

    use Padrino::Logger::Rack, "/"
    #...
  end

```

さらに、キャッシュを導入してみましょう。現状では Padrino::Routing に依存しているので、キャッシュの単独導入は少し複雑です。

```ruby
  require 'padrino-core'
  require 'padrino-cache'

  class App < Sinatra::Base
    # Sinatra::Reloader とは相性が悪いのでコメントアウトする
    #...
    set :app_name, "App"
    register Padrino::Routing
    register Padrino::Cache
    enable :caching

    #...
    get '/heavy_contents', :cache => true do
      expires_in 60 # 60 秒でキャッシュクリア
      sleep 5 # とても重い処理の代わり
      "Process done!"
    end
  end

```

これで、まずは [http://localhost:4567/heavy_contents](http://localhost:4567/heavy_contents) にアクセスしてみます。当然表示に 5 秒かかります。ですが、次に、画面をリロードした際には、すぐに返ってくるはずです。この URL のコンテンツをキャッシュしたからですね。

これだけたくさんの機能を追加するのであれば、はじめからフルスタックの Padrino を利用したほうがいいかもしれません (フルスタックの Padrino は、より一層あなたの開発を楽にしてくれます) が、いずれにせよ、簡単に導入できることはお分かりいただけたでしょう。そして、これらのライブラリ群が、「お決まりの処理」をやってくれるので、開発者はより本質的なロジックの記述に専念できる、ということも理解いただけたでしょう。

(以上の作業をまとめたコードは、[こちら](https://gist.github.com/1369671) (Gist) に置いておきました)

## さらなる深みへ - Extensions と Middleware の自作、プラグイン

さて、ここから先の内容は、ある程度以上 Ruby、そして Web 開発全般に詳しい方でないと、分かりにくい部分があるかもしれません。

以上のような形で、各機能を Rack Middleware や Sinatra Extension に切り出していくことで、コードの見通しがよくなり、変更にも強いアプリケーションが出来上がることでしょう。「関心事の分離」の一形態と考えても良いかもしれません。このような開発スタイルを全面的にサポートしていることは、Sinatra の強みであり、それを "Sinatra Way" で拡張した Padrino は多くの場面でその恩恵にあずかれます。

そして、開発の途中で、ある機能を切り出したい、そのために Rack Middleware や Sinatra Extension を開発したい、と言う場面が出てくるでしょう。実際問題、それらの開発は想像以上に簡単にできます。以下に道しるべだけでも書いておきます。

### Rack Middleware

まず、Rack Middleware の作り方です。

そのまえに、「Rack」と言う仕組みについて簡単に三行で説明すると、

* Ruby の、様々なサーバーと様々なアプリケーションフレームワークをつなぐ規約
* アプリケーションのインスタンスは call(env) に反応しなければならない
* アプリケーションのインスタンスは最終的に __[status_code, {"Header" =&gt; "value"}, ["response_body"]]__ の三つ組を返す


というものです。Rack Middleware と言うのは、上記 Rack Application の条件を満たしたインスタンスをラップするもので、要するに以下の規約を満たしていれば大丈夫です。

* ミドルウェアのインスタンスは call(env) に反応しなければならない
* ミドルウェアのインスタンスは最終的に __[status_code, {"Header" =&gt; "value"}, ["response_body"]]__ の三つ組を返す
* ミドルウェアは、initialize 時の第一引数にアプリケーションを取る


簡単な Rack Middleware の実装を見てみましょう。以下のような config.ru (Rack アプリケーションの標準的な設定ファイルです) を作成し、同じディレクトリで _rackup_ を実行すれば立ち上がります。

```ruby
  # encoding: utf-8
  require 'kconv'
  require 'open-uri'
  require 'rack'
  require 'zalgo'

  class Rack::Glitch
    def initialize(app)
      @app = app
    end

    def call(env)
      orig_res = @app.call(env)
      res = Rack::Response.new orig_res[2]
      res.body = res.body.map do |txt|
        txt.gsub!(/EUC-JP/i, "UTF-8")
        txt.gsub!(/Ruby(?:ist)?/i){|matched| Zalgo.he_comes(matched, :size => :mini)}
        txt.gsub!(/<head.*>/, %q{<head><base href="http://jp.rubyist.net/magazine/?0035-ForeWord" />})
      end
      res["Content-Length"] = res.body.map(&:bytesize).inject(:+).to_s
      res.finish
    end
  end

  target = "http://jp.rubyist.net/magazine/?0035-ForeWord"

  use Rack::Lint
  use Rack::Glitch
  run lambda {|env|
    [200, {"Content-Type" => "text/html"}, [open(target).read.toutf8]]
  }

```

_Rack::Glitch_ は、Rubyist Magazine に出てくる「Ruby(ist)」と言う文字列に対して、今流行りのグリッチ処理を仕掛けて格好良くするための Rack Middleware です。るびまのページが EUC-JP なので少し面倒なことをしているんですが、基本的には：

* initialize の際にアプリケーションをラップする
* 内部で、res.body に対して文字列変換処理を仕掛けている
* また、Content-Type ヘッダーのサイズが不一致であると Rack::Lint の警告が出るので、修正している


ということをしているだけです。簡単そうでしょう？　HTTP 自体の仕組みに詳しければもっといろいろなイタズラが仕掛けられると思います。
![padrino_glitch_s2.png]({{base}}{{site.baseurl}}/images/0036-SinatraReintroduction/padrino_glitch_s2.png)

[RubyistMagazine 35 号 巻頭言](http://jp.rubyist.net/magazine/?0035-ForeWord)を利用。Ruby、Rubyist と書かれた部分がグリッチされている

### Sinatra Extensions

続いて、Sinatra Extensions についてですが、こちらはもっと簡単で、

* register された際に、self.registered(app) と言うフックが呼ばれる
* register したモジュールのメソッドは、 Sinatra アプリの「クラスマクロ」として使える


というだけです。たとえば、Padrino::Helpers Extensions は大まかに言って以下のような実装です。

```ruby
  module Padrino
    module Helpers
      class << self
        def registered(app)
          app.set :default_builder, 'StandardFormBuilder'
          app.helpers Padrino::Helpers::OutputHelpers
          app.helpers Padrino::Helpers::TagHelpers
          app.helpers Padrino::Helpers::AssetTagHelpers
          app.helpers Padrino::Helpers::FormHelpers
          app.helpers Padrino::Helpers::FormatHelpers
          app.helpers Padrino::Helpers::RenderHelpers
          app.helpers Padrino::Helpers::NumberHelpers
          app.helpers Padrino::Helpers::TranslationHelpers
        end
        alias :included :registered
      end
    end # Helpers
  end # Padrino

```

基本的な作り方としては、registered の中で app のクラスマクロ (use、helpers、get/post などの verbs、set など) を呼ぶやり方が良いでしょう。むろん、class_eval のような上級黒魔術も使えます。

これら、Rack Middleware や Sinatra Extensions が実際にどう作られているかは、以下のリポジトリが参考になると思います。

* [rack-contrib](https://github.com/rack/rack-contrib)
* [sinatra-contrib](https://github.com/sinatra/sinatra-contrib)
* [padrino-contrib](https://github.com/padrino/padrino-contrib)


一つ二つ、短いものを眺めてみれば、作り方の実感が沸くことと思います。コードがなによりの教科書です。

使い分けとしては、基本的には Rack Middleware として実装できないかを検討することを勧めます。そうすることで Sinatra/Padrino のみならず、 Rails はじめ他の Rack 対応フレームワークでも再利用できるため、幸せになる人が増えると思われるためです。逆に、Sinatra の DSL の追加などは、Extensions で実現したほうがよい場合が多いでしょう。Extensions の開発には、たとえば『[メタプログラミングRuby](http://www.amazon.co.jp/dp/4048687158/)』のフックメソッドの項 (5 章 7 節) が参考になると思います。

もう一点、これは Padrino の独自機能ですが、「plugin」と言う機構でお決まりの作業を自動化することもできます。以下のようなコマンドで利用可能です。

{% highlight text %}
{% raw %}
   $ padrino g plugin https://raw.github.com/padrino/padrino-recipes/master/plugins/heroku_plugin.rb
{% endraw %}
{% endhighlight %}


プラグインについては、 [padrino-recipes](https://github.com/padrino/padrino-recipes/tree/master/plugins) をご覧ください（このリポジトリにあるプラグインは、例えば「heroku_plugin.rb」ならば "padrino g plugin heroku" のように短い名前で利用できます。自作プラグインをプッシュしてみても良いでしょう）。

## Sinatra を使った開発とそのエコシステムについて

今までのサンプルコードでは、「最小限のフレームワークの上に、必要な機能を盛り付ける」という、言ってみればビュッフェスタイルの開発を意識しています。要するに、Sinatra と言う皿の上に、ロガー、キャッシュ、ヘルパー、認証と言った料理をたくさん盛り付けていくわけです。逆に、Rails のようなフレームワークはフルコース・スタイルであるといえるかもしれません[^2]。

どちらが絶対的に良い、ということは一概には言えないでしょう。ただ、筆者の考えとしては、このビュッフェスタイルの開発は、上手にやれば気を回すべき関心事が適切に分離されるので、バグを追いかけやすく、またテストもしやすい、そしてコードの見通しが良くなる、といったメリットがあります。

すべてのウェブアプリケーションに Ruby on Rails が必要かというと、実際はそうでもないように思います。 Rails の敷いている路線は特急列車なのかもしれません。特急の止まる駅に行くぶんには一番高速な交通網の一つでしょうが、行きたいところに止まるとも限りませんし、それが必要なほど急いでいるとも限りません。特急料金もかかります。普通の列車、バス、レンタカー、いろいろな乗り物から選んだ方が、より納得感のある旅が出来そうですし、何より楽しいと思いませんか？

やりたいことをやるための乗り物として、Ruby であれば他に [Cramp](http://cramp.in/)、あるいは他の言語であれば [node.js](http://nodejs.org/) のようなフレームワークもありますが、その中の大事な使える選択肢の一つとして Sinatra と Padrino を加えていただければ、いち Sinatra/Padrino フリークとしてこれほど嬉しいことはありません。

最後に、Sinatra の上に盛り付けるビュッフェ形式の開発のコツと、心構えをご紹介します。

まず、「その欲しい機能は Rack 層で実現できないか？」ということを考えてみましょう。例えば、以下のような機能については既に Rack Middleware としての実装が存在します。

* Basic/Digest 認証
* Twitter などの各種ソーシャルな認証
* 認証情報の管理
* URL のリライト
* 脆弱性対策 (Sinatra 1.3 よりデフォルトで有効化)
* Captcha の利用 (Rack::Recaptcha)
* Jpmobile の多くの機能は Rack 層で実現しています


また、先ほど紹介した rack-contrib、sinatra-contrib、padrino-contribのリポジトリにも有用な拡張が存在するかもしれません。gem で簡単に入るものですので、覗いてみると良いでしょう。

話題の Asset Pipeline についても、たとえば padrino-sprockets のような実装があります。大事なことは、無闇な車輪の再発明は避けて、できる限りあるものを使う、もしそのあるもので不足であれば、その開発レポジトリに pull request を送るなどして、貢献をする。オープンソースへの貢献と言うのも大げさなくらいで、Sinatra や Padrino 周辺の開発は、まだまだ若々しく、みんなでワイワイと作っていこうという雰囲気です。

まずは使ってみて、そして何かできそうであれば気軽に pull request を送ってみてください。そうすることが、Sinatra 周辺の開発エコシステムを盛り上げ、ひいてはウェブ開発全体を豊かで楽しくすることに繋がっていくのだと思います。

## 参考資料＋イベント情報

Rack 日本語リファレンス by [@yhara](http://twitter.com/yhara) さん

* [http://route477.net/w/?RackReferenceJa](http://route477.net/w/?RackReferenceJa)


Sinatra についての gihyo.jp での連載。 [@yhara](http://twitter.com/yhara) さん、 [@tsuyoshikawa](http://twitter.com/tsuyoshikawa) さん

* [小規模Webアプリのためのフレームワーク，Sinatra](http://gihyo.jp/dev/serial/01/ruby/0007)
* [Sinatra 1.0の世界にようこそ](http://gihyo.jp/dev/serial/01/ruby/0041)
* [実世界のSinatra](http://gihyo.jp/dev/serial/01/ruby/0042)


このお二方の尽力があって、ぼくも Sinatra を思いっきり使うことができているのだと思います。

Padrino に関しては、[拙ブログ "BLOG.UDZURA.JP"](http://blog.udzura.jp/) にもいくつか情報を載せています。

* [Sinatra 1.3.0 &amp; Padrino 0.10.3 がリリースされました。ざっくり紹介(1)。](http://blog.udzura.jp/2011/10/04/sinatra-1-3-0-and-padrino-0-10-3-released-1/)
* [Sinatra 1.3.0 &amp; Padrino 0.10.3 がリリースされました。ざっくり紹介(2)。](http://blog.udzura.jp/2011/10/05/sinatra-1-3-0-and-padrino-0-10-3-released-2/)
* [Padrino＋MongoDB＋Herokuを使って、5分でWikiアプリ作成する](http://blog.udzura.jp/2011/02/23/app-in-5-min-with-padrino-mongodb-heroku/)


先日の[スタート Padrino 勉強会の発表資料](http://www.slideshare.net/udzura/startpadrino)も参考になるでしょう。

また、Sinatra、Padrino ともに公式サイトのドキュメントが充実していますので、是非一読ください。

* [http://www.sinatrarb.com/](http://www.sinatrarb.com/)
* [http://jp.padrinorb.com/](http://jp.padrinorb.com/) (日本語) / [http://www.padrinorb.com/](http://www.padrinorb.com/)


日本語でざっくり追いかけたい方は、

* [Sinatra - 始めよう](http://www.sinatrarb.com/intro-jp.html)
* [Why - Padrino](http://jp.padrinorb.com/pages/why)
* [Guide Blog Tutorial - Padrino](http://jp.padrinorb.com/guides/blog-tutorial)


という流れをお勧めしておきます。

最後の最後に、Sinatra/Padrino で仲間を増やしたい！　と言う方にいくつかイベントの紹介を。

まず、Lokka という Sinatra をベースとした CMS があり、その CMS のためのハッカソン、通称「Lokkathon」が毎週ほぼ定期的に開かれています。

* [ATND検索での検索結果](http://atnd-kensaku.net/?m=list&search=Lokkathon&area=)


このイベントは lingr のチャットなども開放しているので、まずはオンラインで、予定が合えば会場提供のフィヨルドさんへ、といろいろな形での参加が可能です。

また、京都の意識の高い破滅的な学生達によって「Padrino 黒ミサ」と言うイベントが 2011/12/10 に開催予定です[^3]。関西闇 Ruby 会議といい、つくづくあちらは瘴気が濃いですね。

* [Padrino 黒ミサ in 京都](http://atnd.org/events/21442)


関西在住の方はぜひご参加を検討してみてください。

Enjoy hacking Sinatra!

## 著者について

近藤うちお ([@udzura](http://twitter.com/udzura) / [udzura.jp](http://udzura.jp))

[富士山マガジンサービス](http://www.fujisan.co.jp)で Rails や Groovy などのプログラマをやりつつ、Padrino framework のドキュメント邦訳、rspec-padrino などの gem の開発をしています。US ローファイロックが好き。[ブログ](http://blog.udzura.jp)もやっています。

[^1]: Windows においても、たとえば NogakuDo (http://www.artonx.org/data/nougakudo/jman.html) に同梱されている Ruby などであれば問題なく動くと思われますし、NogakuDo ならば Windows 向けの高速な Rack 対応サーバ (Ennou) も入るそうなので、Rails のみならず Sinatra も高速に動作させられることと思います。もし動かなければ作者の arton さんにフィードバックを送ることも出来るでしょう。
[^2]: どこかの誰かは「二郎だ」などと喩えていましたけどね……(w
[^3]: 2011 年 11 月現在
