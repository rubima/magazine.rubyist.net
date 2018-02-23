---
layout: post
title: lily でブログカスタマイズ 【第 1 回】
short_title: lily でブログカスタマイズ 【第 1 回】
tags: 0003 LilyCustomizeHack
---
{% include base.html %}


* Table of content
{:toc}


書いた人：ふしはらかん

## 自分カスタムのブログを持ってみる

ブログ、という言葉も大分浸透して来た昨今、あえてブログは何なのか語るのは「るびま」読者の方々には釈迦に説法でしょう。

最近ではISPをはじめとして様々な会社がブログを運営できるサービスを展開しています。手軽に自分のブログをもつことが出来て便利ですが、当然ながら隅から隅まで自分の使いやすいようにカスタマイズする、というわけにはいきません。やはり、ブログをカスタマイズするなら自分でサーバを借りて…ということになります。

以前はRubyのCGIを試そう、という場合、まずRubyを使えるサーバを探すのが一苦労だったのですが、幸いなことにRubyを使うことの出来るレンタルサーバーは増えてきているようです。中には無料のサービスもあるので、「ブログにもRubyにも興味はあるけど金は無い」という人にはピッタリです。

無事レンタルサーバーのサービスが見つかったら、ブログ運営プログラムとして何を選ぶか、ということになります。

### lilyって何？

Rubyでブログというと、tDiaryが頭に浮かぶ人も多いと思います。「Rubyって、tDiaryを動かすのに必要な奴だよね」と言わしめた程、Rubyを使ったプログラムの中でも利用実績、知名度共に圧倒的です。

しかし、ここでは敢えて「自分の手でブログをいじる」という観点からlilyをお勧めしようと思います。tDiaryの最新バージョン(2.0)は、テーマを同梱しない基本セットで134KB(圧縮時)のサイズがあります。これに対し、lily(0.1.5)は4分の1の31KBしかありません。プログラム本体であるlily.cgiに至ってはわずか500行（プログラム自体は400行ちょっと）です。

もちろん、軽量であるかわりにlilyには大した機能はありません。FTPでアップロードしたファイルをブログの記事として表示する、という基本的な機能以外は自分でRubyのプログラムを書いてカスタマイズしていくことになります。…それを聞いて「なんだか面白そう」と思ったあなた、しばらくお付き合い下さればと思います。

## lilyの入手とインストール

### lilyのダウンロード

lilyの公式サイトからダウンロード可能です。下記URLから「lily0.1.5 標準セット」をダウンロードしてください。ZIP形式で圧縮されているので、解凍ソフトが必要です。

[http://www.mikihoshi.com/lily/download/lilyset.html](http://www.mikihoshi.com/lily/download/lilyset.html)

ダウンロードした「lilyset015.zip」を解凍すると、lilyのプログラム本体と、設定やデザインのためのファイル類が入ったディレクトリが展開されます。

### 設定する

ディレクトリの中にある「lily.cfg」というファイルが設定ファイルになります。エディタで開いて編集していきます。

{% highlight text %}
{% raw %}
blog_title          lily
blog_description    シンプルなサイト構築システム
blog_language       ja
datadir             log
flavourdir          flavour
depth               0
num_entries         10
default_flavour     flav
file_extension      txt
show_future_entries 0
plugindir           plugin
encode              utf-8
url                 http://www.mikihoshi.com/lily
{% endraw %}
{% endhighlight %}


これは、[lily配布サイト](http://www.mikihoshi.com/lily)のlily.cfgです。lily.cfgでは、上記のように「キー名（タブ）値」の書式で1行ずつ設定を書いていきます。以下で、それぞれのキーの意味を説明します。

blog_title
: ブログのタイトルです。ページ上部とHTMLのtitleタグに設定される値になります。

blog_description
: ブログの説明文です。通常はブログタイトルの近くに 表示されます。   

blog_language
: 何の言語で記事を書くかを指定します。通常はja(日本語)で問題ないです。

datadir
: 記事ファイル（後述）のあるディレクトリを指定します。

flavourdir
: フレーバー（後述）のあるディレクトリを指定します。

plugindir
: プラグイン（後述）のあるディレクトリを指定します。

depth
: 0を指定すると、datadirで指定したディレクトリの直下のファイルしか、トップページに表示しません。通常は1を指定して、datadirのサブディレクトリ下のファイルも表示します。lily配布サイトでは0に指定し、直下にはバージョンアップ告知などのニュース記事を置き、サブディレクトリにダウンロードページの記事などを置くことで、トップにニュース記事のみが表示されるようにしています。

num_entries
: トップページに何件の記事を表示するか指定します。例えば10だと、最新の記事から数えて新しいもの10件がトップページに表示されます。

default_flavour
: 後述します。

file_extension
: 後述します。

show_future_entries
: 1を指定すると、作成日付が未来のファイルを表示します。通常は0なので表示しません。これを利用して、UNIX等のコマンドでファイルの作成日時を未来にしておくと、その日になって表示される投稿予約（Movable Typeでは最近実装されました）を行うことが出来ます。

encode
: ページをどのような文字コードで出力するか指定します。lilyではデフォルトでRSSを出力するようになっていますが、RSSの出力文字コードがutf-8になっているので、ブログ本文（HTML）のほうも合わせることをお勧めします。

url
: 通常は指定しません。後述するmod_rewriteを使ったテクニックの際に使用します。

実際にはblog_title,blog_description以外は凝った使い方をしない限り変更する必要はありません。

### rbuconvの導入

前の章で設定したように、lilyでは出力するHTMLの文字コードを指定することが出来ます。日本語を使う場合は、Windowsで主に使われるShift-JIS、Unix系で主に使われるEUC、それ以外ではUnicodeなどを使う場合が殆どです。

lilyの標準の設定では文字コードはUnicodeを使用するようになっています（プログラムソースはEUCで記述されています）。しかし、Windowsを使っている人は記事のファイルをShift-JISで書く場合が殆どでしょう。また、lilyにはオプションとしてTrackBackを受信する機能があります。TrackBackは基本的にUnicodeで送信するのがルールですが、中にはそれ以外の文字コードでTrackBackを送ってくるツールもあるようです。

上記の問題を解決するために、lilyでは[吉田氏](http://www.yoshidam.net)の[Uconvモジュール](http://www.yoshidam.net/Ruby_ja.html)を使って文字コードの変換を行っています。Uconvモジュールの導入にはソースのコンパイルが必要なため、lilyに同梱していませんでしたが、現在では吉田氏によってrubyだけで動くUconvの互換モジュール[rbuconv](http://www.yoshidam.net/diary/rbuconv-0.1.2.tar.gz)が開発されており、次バージョンからはlilyに同梱する予定です。

今回はrbuconvを別途入手して、lilyに適用することにします。rbconvをダウンロードして、解凍したファイルの中のuconv.rbとrbuconv.rb、uconvディレクトリをlily.cgiと同じディレクトリに置いて下さい。

### サーバにアップロードする

FTPでファイルをサーバにアップロードします。lilyset015.zipを解凍して出来たディレクトリ中の、以下のファイルをアップロードしてください。

* lily.cgi
* lily.cfg
* rbuconv.rb
* uconv.rb


また、以下のディレクトリは中身のファイルごとアップロードします。

* flavour
* plugin
* log
* uconv


アップロードが終わったら、lily.cgiのパーミッションを755に設定します。また、以下のディレクトリに書き込み権を設定してください（パーミッションを755などにして下さい）。

* plugin/referer
* plugin/comment
* plugin/trackback
* log
* log/test


作業が終わったらWebブラウザでアップロードしたばかりのブログが見えるかどうか試してみましょう。lily.cgiにアクセスして、設定したタイトルとテストの記事が表示されれば成功です。lilysetには以下のようなテスト記事が同梱されています。
![test.txt]({{site.baseurl}}/images/0003-LilyCustomizeHack/test.txt)

テスト記事は以下のように出力されます。

#### First Post

このエントリーはテストです。

* list1
* list2


{% highlight text %}
{% raw %}
 def foo
   bar
 end
{% endraw %}
{% endhighlight %}


> hogehoge


__太字__  ~~取り消し~~  [アンカー](http://www.mikihoshi.com/lily)

## 記事を書いてみる

### FTPを使った記事のアップロード

いよいよ記事の投稿になります。既に説明したように、lilyはサーバ上のlily.cfgで指定したディレクトリ（datadir）下にあるファイルのうち、指定された拡張子（file_extension）のファイルを記事として読み込んで表示します。そのため、lilyに記事を投稿する最も単純な方法は、手元のPCで記事を（エディタ等で）書いて、FTPでアップロードすることになります。

lily.cfgの設定を変えない場合、記事になるファイルの拡張子はtxt（テキストファイル）です。このファイルの１行目が、ブログとしてWeb上に表示されるときの、記事のタイトルになります。以降は記事本文になります。標準の設定ではHTMLを直接入力することになります。

### 各種フィルタの書き方と利用法

前章の方法は、FTPやHTMLに慣れている人にとってはtDiaryやMovable Type等のWeb上からの更新作業よりもわずらわしさが無く楽かもしれません。しかし一般的にはHTMLを毎回手で書くのはなかなか面倒です。

最近のWebアプリケーションであるBlogやWikiは、HTMLより簡単に文書構造を記述することが出来る特殊な記法を用意しています。ここではRubyで実装された代表的なWikiの一つである、Hikiの記法で記事を書く方法を解説します。
[wiki_style.rb]({{site.baseurl}}/images/0003-LilyCustomizeHack/wiki_style.rb)

上記ファイルをダウンロードし、lilyを動かしているサーバのプラグインディレクトリ(lily.cfgでplugindirで指定したディレクトリ)にFTPでアップロードします。

次に、lily.cfgの内容を一部修正します。file_extensionの行を以下のように書き換えてください。

{% highlight text %}
{% raw %}
     file_extension      txt wiki
{% endraw %}
{% endhighlight %}


このように、file_extensionには半角スペースで区切って複数の拡張子を指定することが出来ます。修正したlily.cfgをアップロードすると、拡張子wikiのファイルは、Hiki書式で書かれているものとして変換されます。例えば、前章のtest.txtと同じ記事を表示するtest.wikiは以下のようになります。
![test.wiki.txt]({{site.baseurl}}/images/0003-LilyCustomizeHack/test.wiki.txt)

なお、このWikiスタイルフィルタは[とくひろ氏](http://tokuhirom.dnsalias.org/~tokuhirom/cl/)の[公開されているソース](http://tokuhirom.dnsalias.org/~tokuhirom/cl/2004-05-04.html#2004-05-04-2)を修正してlilyのフィルタ形式にしたものです。

#### 自分でフィルタプログラムを作ってみる

HTMLを書くのも面倒だけど、Wikiの文法も結構複雑だし、覚えるの面倒くさい…というものぐさな方、10分時間を下さい。たったそれだけの時間で、簡単に記事を書くことのできるプラグインが作れます。

まず、ものぐさ用記法のルールを決めておきます。以下のようにします。

* 文中の改行はHTMLでも改行になる
* httpで始まる文字列（URL）はリンクになる
* HTMLのタグは使いたければ使える


エディタを開いて、簡単なrubyのメソッドを書きます。ものぐさ記法のフィルタなので、名前はlazy_style_filterとしましょう。フィルタのメソッドは「_filter」で終わるようにします。

{% highlight text %}
{% raw %}
def lazy_style_filter
  @body.gsub!(URI.regexp(["http","https","ftp","mailto"])){|m| %[<a href="#{m}">#{m}</a>] }
  @body = "<pre>#{@body}</pre>"
end
{% endraw %}
{% endhighlight %}


ちなみにURI#regexpはrubyのバージョン1.8.1以降のみで使えます。バージョン1.6.8などの環境で動作させたい場合は「[http://](http://)\S*」などURIとマッチする適当なパターンを指定してください。

また、HTMLタグは全く使わないので、&gt;などをそのまま表示させたいという究極のものぐさ向けには、以下のようにタグをエスケープする方法があります。

{% highlight text %}
{% raw %}
@body = CGI.escapeHTML(@body)
{% endraw %}
{% endhighlight %}


フィルタメソッドでは、@bodyと@titleという変数を操作します。@bodyには記事の本文が、@titleには記事のタイトルが入っています。上のlazy_style_filterでは、見てのとおり文中のURLをリンクに変換し、最後に文全体を&lt;pre&gt;で囲むことで、改行などの文章整形がそのまま画面に表示されるようにしています。

このソースをファイルに保存します。ファイル名は、先ほど決めたメソッド名から「_filter」を除いたものになります（拡張子は.rbです）。この場合は「lazy_style.rb」になります。

lazy_style.rbをプラグインディレクトリにアップロードしてみましょう。今まで変換なしで表示されていた、拡張子txtのファイルがものぐさ記法で変換表示されるようになったことが、テスト記事にあるGoogleのURLがリンクになることで簡単に確認できます。

#### フィルタの改良

実は、このプログラムには大きな問題があります。wiki_styleフィルタは、拡張子wikiのファイルしか変換しませんでしたが、lazy_styleフィルタはfile_extensionで定義した全ての拡張子のファイルを変換してしまいます。そのため、wiki_styleフィルタとlazy_styleフィルタを併用すると、出力されるHTMLが滅茶苦茶になってしまいます。

フィルタのメソッドで、編集中のファイルの拡張子を知るには、@fext変数を参照します。@fext変数がtxtの時のみ変換を行うようにするには、lazy_style.rbを以下のように書き換えます。

{% highlight text %}
{% raw %}
def lazy_style_filter
  if @fext == 'txt'
    @body.gsub!(URI.regexp(["http","https","ftp","mailto"])){|m| %[<a href="#{m}">#{m}</a>] }
    @body = "<pre>" + @body + "</pre>"
  end
end
{% endraw %}
{% endhighlight %}


これを応用して、1つのフィルタメソッドで、拡張子に応じて変換方法を変えることも出来ます。

### ブラウザから記事を投稿する

フィルタを使って簡単に記事を書くことが出来るようになりましたが、FTPを使ってファイルをいちいちアップロードするのが大変、という人も多いと思います。

tDiaryは、独自のファイル形式（テキストですが）で日記のデータを記録しています。Movable Typeはデータベースに記事を記録しています。これらのシステムに比べると、ただのテキストファイルに記事を記録するlily用の更新CGIを作るのはそんなに難しくありません。

lilyの次バージョンには、Webからの記事投稿を可能にする「lilypad」というプログラムが付属します。今回、lilypadのプロトタイプというか、α版にもならない簡易的なプログラムを5分ほどで書いてみました。([lilypad.zip]({{site.baseurl}}/images/0003-LilyCustomizeHack/lilypad.zip))解凍して出てくるlilypad.cgiとMainPageディレクトリを、lily.cgiと同じディレクトリにアップロードしてください。別途、[CGIKit](http://www.spice-of-life.net/cgikit/)が必要になりますのでご注意を。

このプログラムはlily.cfgを読み込んでdatadirと、file_extensionを利用しますが、逆に言うとそれ以外は単にファイルを作るだけのアプリケーションです。ちょっと考えるだけでも

* 既存の記事の読み込みと編集
* 投稿時にPingを打つ
* フィルタを通してどのように出力されるかプレビュー表示


などの機能が欲しくなります。これらの機能は（恐らく）正式配布版のlilypadではサポートされますが、今回のソースをベースに自分で改造してみるとrubyプログラミングの練習になると思います。

一例として、MainPageディレクトリ下のMainPage.rbを編集して、投稿時にPingを打つサンプルを載せておきます。今号でも連載を執筆されているMoonWolf氏の[Blog::Pingライブラリ](http://raa.ruby-lang.org/project/blogping/)を使った改造です。

```ruby
require 'fileutils'

class MainPage < CKComponent
  def init
    env = Hash.new

    File::open("./lily.cfg","r"){|f|
      f.read.each_line do |line|
        item = line.chomp.split(/\s+/)
        key = item.shift
        env[key] = item.join(' ')
      end
    }
    
    @datadir = env['datadir']
    @file_extension = env['file_extension'].split(/ /)
    @flavour = env['default_flavour']
    if env['url'] == ""
      @root_url = "http://#{request.server_name()}/lily.cgi"
    else
      @root_url = env['url']
    end

  end

  def update
    filename = Time.now.strftime("%Y%m%d%H%M%S")
  
    FileUtils.mkdir_p("#{@datadir}/#{@entry_path}")
    File.open("log/#{@entry_path}/#{filename}.#{@extension}",'w'){|f|
      f.puts @title
      f.print @body
    }
    
    @url = "#{@root_url}/#{@entry_path}/#{filename}.#{@flavour}"
  end
end

```

余談ですが、lilypadプログラムで使用しているCGIKitというWebアプリケーションフレームワークは非常に便利なのでお勧めです。CGIプログラムというと、どうしてもソース中にHTMLが混在して読みづらくなりがちですが、lilypadでは上記のMainPage.rbのようにrubyによる処理部分がHTMLと分離するので可読性が上がります。POST値とクラス変数のマッピングなども簡単な定義で出来たり、エラーになったときに原因を追いやすい（CGIKitのエラー画面が表示され、rubyのエラーのダンプを見られる）のもポイントです。

## あとがき

今回はlilyの導入と記事の書き方についてでしたが、いかがでしたでしょうか。

次回はlilyのデザインを行う上で重要な「フレーバー」について書いていきたいと思います。本家であるblosxomのフレーバーを使う方法や、tDiaryのテーマ、Movable TypeのCSSを流用する方法などをまとめていく予定です。お楽しみに。

## 著者について

![deka.jpg]({{site.baseurl}}/images/0003-LilyCustomizeHack/deka.jpg)
なまえ：ふしはらかん。kanとかfushihara kanとか伏原幹とかaliasは色々。[mikihoshiというサブクラス](http://d.hatena.ne.jp/mikihoshi/)があります。

構想1ヶ月のlilyをリリースしてruby界(?)に殴り込みをかけたものの、直後に構想10分で作った[wema(変なもの)](http://www.mikihoshi.com/wiki)のほうが反響が大きく、密かに落ち込む。

最近は変なもの2の作成に勤しみつつ、この号が発行される頃には発売されているSHARPの4GBHDD内蔵ザウルス、SL-C3000を借金覚悟で購入して弄り倒そうと目論んでいます。

その他は[http://www.mikihoshi.com](http://www.mikihoshi.com)を見て頂ければ、と。


