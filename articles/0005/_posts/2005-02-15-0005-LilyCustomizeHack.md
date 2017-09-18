---
layout: post
title: lily でブログカスタマイズ 【最終回】
short_title: lily でブログカスタマイズ 【最終回】
tags: 0005 LilyCustomizeHack
---


* Table of content
{:toc}


## はじめに

「[lily でブログカスタマイズ第1回]({% post_url articles/0003/2004-11-15-0003-LilyCustomizeHack %})」では、lily の導入と基本的な記事の投稿方法を解説しました。

「[lily でブログカスタマイズ第2回]({% post_url articles/0004/2004-12-17-0004-LilyCustomizeHack %})」では、デザインをカスタマイズするための flavour という仕組みを解説しました。

ここまで連載を読んできてくださった方は、既に lily を使って自分の好みのデザインのブログを作ることが出来ます。しかし、実際に運用するブログを作る場合、ここまでの説明だけでは不十分な要素があります。

例えば過去記事へのリンクを一覧表示したい、カテゴリ別記事へのリンクを一覧表示したいという場合、lily 本体の機能だけでは月別、カテゴリ別の記事表示は出来てもリンクの一覧は作成できないので、ユーザが flavour に手作業で書き込んでいくことになります。これでは間違いも発生しそうですし、なんのためにブログツールを使ってサイト構築するのか分からなくなってきます。

それ以外にも一般的なブログやWeb日記と呼ばれるサイトには

* コメント
* TrackBackの送受信
* リンク元の表示
* 検索機能
* 似たサイトの一覧表示


などがありますが、これらにいたっては lily の標準機能では実現できないものばかりです。

しかし、lily 公式サイトの「標準セット」をインストールすると、[標準のブログの画面](http://www.mikihoshi.com/rubima/d/lily.cgi)に「コメント入力欄」や「リンク元の表示」が現れます。サイドメニューには検索欄も表示されています。

実は、これらの機能は「標準セット」に含まれている  plugin  というもので実現されている機能なのです。

## plugin て何？

> アプリケーションソフトに追加機能を提供するプログラム。
> 
> 特にウェブブラウザに多用されている。


([はてなダイアリーキーワード「プラグイン」](http://d.hatena.ne.jp/keyword/%A5%D7%A5%E9%A5%B0%A5%A4%A5%F3))

ソフトによって呼び方は変わりますが、上記の説明のようにアプリケーションに機能を追加する (比較的) 小さなプログラムを  plugin  といいます。lily ではいくつかのメソッドを定義する小さな Ruby スクリプトファイルが  plugin  として動作します。

## plugin の使い方

plugin は Ruby スクリプト (拡張子 .rb のファイル) として提供されます。利用するときには、ほとんどの場合 lily.cfg で plugin_dir に指定したディレクトリ (デフォルトでは lily インストールディレクトリ直下の plugin ディレクトリ) にファイルをアップロードするだけです。

その他の場合は、plugin ディレクトリ下にデータ保存のためのディレクトリを作る必要がある plugin があります。公式サイトで配布している plugin では comment、trackback、referer プラグインです。これらのプラグインを導入する場合は、プラグイン名と同じディレクトリ (例えば「referer」) を plugin ディレクトリ下に作成してください。

アップロード後、例えば

{% highlight text %}
{% raw %}
$archives::archives
{% endraw %}
{% endhighlight %}


のように flavour ファイルに記述すると、その位置に月別一覧ページのリンクリストが表示されます。標準添付されている flavour では、サイドメニューが head.flav に記述されているので、その中の

{% highlight text %}
{% raw %}
       <dt>Category</dt>
       <dd>
         $categories::categories
       </dd>
{% endraw %}
{% endhighlight %}


といった記述に続けて

{% highlight text %}
{% raw %}
       <dt>Category</dt>
       <dd>
         $categories::categories
       </dd>
       <dt>Archives</dt>
       <dd>
         $archives::archives
       </dd>
{% endraw %}
{% endhighlight %}


と追記すると、

{% highlight text %}
{% raw %}
Archives

        * 2004[1]
              o December[1]
{% endraw %}
{% endhighlight %}


といった具合に画面に表示されます。

## plugin を実現するテクニック

plugin の作り方を説明する前に、lily ではどのようにして plugin 機能を実現しているかを簡単に説明します。

以下は、もっとも簡単な plugin である storytitle plugin について説明します。
![storytitle.rb]({{site.baseurl}}/images/0005-LilyCustomizeHack/storytitle.rb)

3つのメソッドが定義されています。lily ではこれらのメソッドを instance_eval を使って、Lily クラスのレベルで実行します。

{% highlight text %}
{% raw %}
   Dir.glob("#{@ plugin dir}/*.rb") do |f|
     File::open(f,"r"){|src|
       begin
         self.instance_eval(src.read)
       rescue Exception
       end
     }
   end
{% endraw %}
{% endhighlight %}


plugin ディレクトリ下の拡張子「.rb」のファイルを読み込んで instance_eval を実行しています。self は自分自身、つまりここでは Lily クラスを意味します。

## plugin の実行ルール

plugin  が実行するタイミングは 2 回あります。

まず、画面出力前に lily は  plugin  のファイル名と同じメソッドを実行しようとします。

{% highlight text %}
{% raw %}
   Dir.glob("#{@ plugin dir}/*.rb"){|f|
     begin
       eval("#{File.basename(f,".*")}")
     rescue NameError
     end
   }
{% endraw %}
{% endhighlight %}


上の storytitle plugin  では storytitle メソッドが実行されます (空なので何も実行されませんが)。

次に、plugin  中で「$半角文字列::半角文字列」、という書式が記述された時です。lily は記述された位置で「半角文字列_半角文字列」というメソッドを実行し、返却された値を画面出力します。

{% highlight text %}
{% raw %}
 def get_conf(name)
   begin
     if name =~ /(.+)::(.+)/
       eval("#{$1}_#{$2}")
     else
       eval("@#{name}")
     end
   rescue NameError
     error_out()
   end
 end
{% endraw %}
{% endhighlight %}


$storytitle::page_title と記述すると、storytitle_page_title メソッドが実行されるわけです。

plugin を作る場合、この2つの呼び出しタイミングを上手く生かしてプログラミングする必要があります。

## plugin を作ってみる

それでは、実際に plugin を作ってみましょう。今回は plugin の作り方として典型的なパターンを3つ挙げ、それぞれ plugin を実装します。

### カウンタ plugin

いわゆるアクセスカウンターです。単に当日のアクセス数、昨日のアクセス数、総アクセス数を出力する簡単な plugin ですが、先に示した lily の plugin の2種類の呼び出し方法で利用されるため、サンプルとして取り上げました。

まず、ファイル名を「counter.rb」とします。この場合、counter メソッドが lily の実行時 (出力前) に呼び出されることになります。

{% highlight text %}
{% raw %}
 def counter
   dbm = DBM.open('counter')
   tmn = Time.now.strftime("%Y-%m-%d")
   if dbm['day'] != tmn then
     @count_today = 1
   else
     @count_today = dbm['today'].to_i + 1
   end
   @count_all =  dbm['all'].to_i + 1

   dbm['day'] = tmn
   dbm['today'] = @count_today.to_s
   dbm['all'] = @count_all.to_s

   dbm.close
 end
{% endraw %}
{% endhighlight %}


例では DBM を使っていますが環境依存を減らす場合は SDBM を使ったほうが良いでしょう (ソース中の DBM を SDBM に変えるだけです)。他にも GDBM、QDBM などお好みでどうぞ。

当日のアクセス数 (@count_today) と総アクセス数 (@count_all) は変数名に@をつけて Lily クラスのインスタンス変数として扱っています。インスタンス変数は以降のメソッドでも使用できるため、アクセス数を表示するメソッド内で再度 DBM で値を読み出さずに済みます。

{% highlight text %}
{% raw %}
def counter_today_disp
  @count_today.to_s
end

def counter_all_disp
  @count_all.to_s
end
{% endraw %}
{% endhighlight %}


結果、値を出力するメソッドはものすごく単純になりました。[サンプルページ](http://www.mikihoshi.com/rubima/d/)でこの plugin を動かしています。以下に全ソースのリンクを置いておきます。
[counter.rb]({{site.baseurl}}/images/0005-LilyCustomizeHack/counter.rb)

### LIRS plugin

LIRS とは、アンテナへの更新時刻通知に使われるフォーマットです。詳しい仕様は以下を参照してください。

{% highlight text %}
{% raw %}
http://aniki.haun.org/natsu/LIRS.html
{% endraw %}
{% endhighlight %}


大雑把に言えば以下の内容を順にカンマ (,) 区切りで出力 (要 gzip 圧縮) すればいいわけです。

1. ヘッダ (LIRS)
1. 更新時刻
1. 更新時刻取得時効
1. 誤差
1. コンテンツ容量
1. サイトのURL
1. サイトのタイトル
1. サイトの著者名
1. 情報取得元のURL


今回は flavour が「lirs」だった時に LIRS 形式データを出力するようにします。

{% highlight text %}
{% raw %}
def lirs
  if @flavour == 'lirs'
    print "Content-type:text/plain;charset=EUC-JP\n"
    print "Content-encoding: gzip\n\n"
    Zlib::GzipWriter.wrap($stdout){|gz|
      gz.print 'LIRS,'
      gz.print "#{get_post_time(@storys[0]).to_i},"
      gz.print "#{Time.now.to_i},"
      gz.print '+32400,0,'
      gz.print "#{@url},"
      gz.print "#{@blog_title.to_euc},"
      gz.print "#{@author.to_euc},"
      gz.print ",\n"
      gz.flush
    }

    @echo_off = true
  end
end
{% endraw %}
{% endhighlight %}

[lirs.rb]({{site.baseurl}}/images/0005-LilyCustomizeHack/lirs.rb)

この plugin を導入すると以下のようなURLでLIRS形式のデータを取得できるようになります。

[http://www.mikihoshi.com/rubima/d/lily.cgi/index.lirs](http://www.mikihoshi.com/rubima/d/lily.cgi/index.lirs)

さて、このメソッドではいくつかのインスタンス変数が使われています。Lily クラスではブログの設定情報などをインスタンス変数として持っている為、plugin で利用することが出来ます。以下に、plugin でも良く使われるインスタンス変数の例を示します。

| 変数名| 説明|
| @blog_title          | ブログのタイトル|
| @blog_description    | ブログの説明|
| @blog_language       | ブログで使用する言語(ja=日本語など)|
| @datadir             | 記事ファイルのあるディレクトリ|
| @flavourdir          | flavourのあるディレクトリ|
| @flavour             | 表示に使用するflavour名|
| @plugin dir          |  plugin のあるディレクトリ|
| @encode              | 出力データの文字エンコード|
| @author              | 著者名|
| @mail                | メールアドレス|
| @storys              | 表示する記事ファイルのパスの配列|


LIRS plugin では

1. @flavour で使用する flavour 名を調べる
1. @storys の 0 番目 (先頭の) 記事ファイルの更新時刻を取得
1. @url でサイトのURLを取得
1. @blog_title でブログのタイトルを取得
1. @author でブログの著者名を取得


のようにインスタンス変数を利用しています。なお、get_post_time とは Lily クラスのメソッドで、記事ファイルの最終更新時刻を (キャッシュしているので) 高速に取得します。また、@blog_title.to_euc のようにしているのは、LIRS の仕様で文字コードを EUC で出力するようになっているためです。

### del.icio.us plugin

[del.icio.us](http://del.icio.us/) は最近話題の URL クリッピングサービスです。類似のサービスは色々とありますが、タグによってクリップしたデータを分類したり、同じタグを付けている人がクリップしたURLを横断的に参照できるのが目新しいところです。del.icio.us plugin は、自分が del.icio.us でクリップしたURLの一覧をブログのサイドメニューに表示する plugin です。

幸いにも、del.icio.us から情報を取得する API は公開されていて、[rubyで扱うためのライブラリ](http://pablotron.org/software/rubilicious/)も存在します。ダウンロードしたライブラリ (rublicious) は $:で指定されたライブラリパス (例えば、lily.cgi と同じ階層) にアップロードしてください。なお、del.icio.us の recentAPI は日本語が変な具合に化けるので、[こちらの記述](http://jarp.jin.gr.jp/diary/200502a.html#200502031)を参考に文字コード変換処理を加えてあります。

{% highlight text %}
{% raw %}
def delicious_recent_disp
  src = "<ul>\n"
  r = Rubilicious.new(@env['delicious_user'], @env['delicious_pass'])
  r.recent.each do |post|
    title = Iconv.iconv('ISO_8859-1', 'UTF-8', post['description']).to_s
    src += %(<li><a href="#{post['href']}">#{convert(title)}</a><br/><span style="font-size: 50%">#{convert(post['extended'])}</span></li>\n)
  end

  src += "</ul>\n"
end
{% endraw %}
{% endhighlight %}

[delicious.rb]({{site.baseurl}}/images/0005-LilyCustomizeHack/delicious.rb)

Rubilicious クラスをnewする際に、引数として del.icio.us に登録しているログインIDとパスワードを渡す必要があります。上のソースでは @env というインスタンス変数を使っていますが、これは lily.cfg に記入されて内容を保持しているハッシュです。従って

{% highlight text %}
{% raw %}
delicious_user		XXXXXX
delicious_pass		XASASD
{% endraw %}
{% endhighlight %}


のように lily.cfg に記入すれば、例のように plugin 中で値を利用できます[^1]。

flavour 内では以下のようにしてサイドメニューの適当な位置に記述します。

{% highlight text %}
{% raw %}
       <dt>My Delicious</dt>
       <dd>
         $delicious::recent_disp
       </dd>
{% endraw %}
{% endhighlight %}


出力結果は以下のURLを参照してください。

[http://www.mikihoshi.com/rubima/d/lily.cgi](http://www.mikihoshi.com/rubima/d/lily.cgi)

## lily でブログカスタマイズ！　のまとめ

ここでは、改めて今まで連載してきた内容をまとめてみます。今回から読まれる方は参考に、今までお付き合いくださった方は復習としてご確認下さい。

### [第1回 lily の導入と基本的な記事の書き方]({% post_url articles/0003/2004-11-15-0003-LilyCustomizeHack %})

前半は、lily スクリプトを自分の Web サーバ (或いはレンタルサーバ) にアップロードし、最低限ブログの画面を表示するようになるまでの設定をまとめました。「FTP に余り慣れない」「パーミッションて何？」という人は、この章から見はじめた方が良いと思います。

後半では、記事をファイルに書いて FTP でアップロードするという、lily 独特の記事の投稿方法を説明しています。また、Wiki 記法など HTML のタグを直書きせずに記事を書くための「フィルタ」の使い方についても解説しました。

### [第2回 flavour のカスタマイズ方法]({% post_url articles/0004/2004-12-17-0004-LilyCustomizeHack %})

lily でブログのデザインをカスタマイズするため、flavour と呼ばれる独特の仕組みについて解説しました。同じブログでも flavour を切り替えることで全く違った見た目になったり、RSS として表示したりするサンプルも紹介しています。tDiary のテーマを利用できる flavour も配布しているので、とにかくデザインの変更から始めたい方はこの章からどうぞ。

### [第3回  plugin の仕組みと、作り方]({% post_url articles/0005/2005-02-15-0005-LilyCustomizeHack %})

今号の記事です。コメントや TrackBack など、インタラクティヴな機能を実現する plugin という仕組みについて、若干 lily の内部構造も解説しつつ、いくつかの plugin 作成を通じて説明していきました。自分で plugin を作ろうという方の参考になったでしょうか？

## 連載を終えて

当初 1 回の予定だったのですが、私の遅筆と構成力不足 (後から書きたいことが…) で 3 回の連載になってしまいました。良い意味でマニアックな他の記事に比べるとよく言えばマイルド、悪く言えば歯ごたえのない記事になってしまったかもしれません。

今回はブログとしての使用法に注力して記述してきましたが、本来 lily は軽量の CMS を想定して開発しています。現在開発中の lily2 では、blosxom 互換の仕様のうち、良いところだけを引き継ぎ、パワーユーザから初心者の方まで色々な使い方の出来る多目的なツールに生まれ変わろうとしている最中です。拙作 [wema](http://www.mikihoshi.com/wema2/test/) ともども、どこかで皆さんのお役に立てれば幸いです。

## 著者について

![food.jpg]({{site.baseurl}}/images/0005-LilyCustomizeHack/food.jpg)
なまえ：ふしはらかん。
[http://www.mikihoshi.com/d/](http://www.mikihoshi.com/d/) にて日記を書いてます。

年明けから思いがけず多忙な日々が続き、プリキュア最終回のショックも重なって丸々半日ほど体内時計がずれたのですが、後番組のプリキュア Max Heart を見てすっかり元気になり、現金な体だと我がことながら苦笑しています。
----

[^1]: lily.cfgにパスワードを書くことになるので、見られると困る方、隠したかの分からない方はdelicious.rbに直接書くことをお奨めします
