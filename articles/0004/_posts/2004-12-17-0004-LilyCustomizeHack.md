---
layout: post
title: lily でブログカスタマイズ 【第 2 回】
short_title: lily でブログカスタマイズ 【第 2 回】
tags: 0004 LilyCustomizeHack
---


* Table of content
{:toc}


書いた人：ふしはらかん

## はじめに

「[lilyでブログカスタマイズ第1回]({% post_url articles/0003/2004-11-15-0003-LilyCustomizeHack %})」では、lilyの導入と基本的な記事の投稿方法を解説しました。

さて、ブログをカスタマイズするとして、まず思い浮かぶのはデザイン面ではないでしょうか。特にlilyの場合、折角サーバーを借りて運用するわけですから、ブログホスティングサービスでは出来無い全面的なデザインカスタマイズをしてみたいところです。

CGIが結果出力を行う場合、プログラムの中に逐一出力処理を記述していく方法と、テンプレートと呼ばれる仕組みを使う場合の2種類があります。テンプレートとは、予めどの状況でも変化しない部分（ブログならば、タイトルやサイドバー）を1つ、あるいは複数のファイルに記述しためのです。CGIの実行時に特定の部分（ブログの場合は記事そのもの）を置き換えて出力します。

lilyではこのテンプレート方式の一種である、flavour（フレーバー）という仕組みでHTMLを出力します。また、flavourはHTMLだけでなくRSSファイルなど他のフォーマットのファイルを出力するためにも利用できます。

## flavourとは？

### URLと表示内容の対応

flavourの詳細について説明する前に、lilyがどのようにして出力する画面を決定しているかの仕組みを説明します。

以下のように直接lily.cgiにアクセスすると、最近投稿した記事を何件か表示します（このときの件数はlily.cfgで設定します=&gt;[第1回]({% post_url articles/0004/2004-12-17-0004-LilyCustomizeHack %})）。

[http://www.mikihoshi.com/rubima/d/lily.cgi](http://www.mikihoshi.com/rubima/d/lily.cgi)

特定の日付の記事を表示することも出来ます。[^1]
全ての記事の中から今年投稿された記事のみを表示する場合は

[http://www.mikihoshi.com/rubima/d/lily.cgi/2004](http://www.mikihoshi.com/rubima/d/lily.cgi/2004)

というURLにアクセスします。今月のみにしぼるなら

[http://www.mikihoshi.com/rubima/d/lily.cgi/2004/12](http://www.mikihoshi.com/rubima/d/lily.cgi/2004/12)

クリスマスイブの悲痛な記事のみを表示する場合は

[http://www.mikihoshi.com/rubima/d/lily.cgi/2004/12/24](http://www.mikihoshi.com/rubima/d/lily.cgi/2004/12/24)

というURLにアクセスすることになります。

さて、最後のURLにはもうひとつのパターンがあります。

[http://www.mikihoshi.com/rubima/d/lily.cgi/test/xmas.html/2004/12/24/](http://www.mikihoshi.com/rubima/d/lily.cgi/test/xmas.html/2004/12/24/)

そして、拡張子の「html」にも意味があります。先程のURLを以下のように変えてアクセスしても、ページのデザインは変りますが、記事自体は正しく表示されます。[^2]

[http://www.mikihoshi.com/rubima/d/lily.cgi/test/xmas.flav/2004/12/24/](http://www.mikihoshi.com/rubima/d/lily.cgi/test/xmas.flav/2004/12/24/)

lilyでは、lily.cgiに続けてディレクトリとファイル名（xmas）で記事のファイル名を指定して表示することも出来ます。特例として、ファイル名が「index」の場合は、条件を満たす全ての記事を表示します（ファイル名を指定しない場合も同様です）。更に、ファイル名に続けてディレクトリを指定することで記事の時刻を限定することもできるのです。

拡張子はどのflavourを使って表示するかを決めているます。ちなみに、URLで明示的にflavourを指定しない場合は、lily.cfgで定義したデフォルトflavourが使用されます。

### 標準flavourの使い方

lilyの標準セットでは、3種類のflavourを使っています。

1つ目は、トップページ用のflavourです。コメントやトラックバック、リファラの表示が簡易版になって、サイドメニューに「最近の記事」や「最近のコメント・トラックバック」の一覧などが表示されます。（[例](http://www.mikihoshi.com/rubima/d/)）

2つ目は各記事の詳細ページ用のflavourです。コメントやトラックバックの詳細が表示され、コメント入力欄も表示されます。（[例](http://www.mikihoshi.com/rubima/d/lily.cgi/test/xmas.html)）
トップページ用のflavourの中で、各記事のPermalink（固有リンク）を、この詳細ページ用flavourを使うURLにしてあります。

3つ目はRSSを表示するためのflavourです（[例](http://www.mikihoshi.com/rubima/d/lily.cgi/index.rdf)）。flavourはHTML専用というわけではなく、使い方次第でRSSなど他のフォーマットのドキュメント出力にも使えます。その気があればPostScriptなどで出力したりも出来るはずです。

これらのflavourは、lily.cgiと同じディレクトリにあるflavourサブディレクトリに入っています。ディレクトリ内を見ると、拡張子flav,html,rdfの各ファイルが存在しているのが分かると思います。後述しますが、flavourは

* content_type.*
* head.*
* date.*
* story.*
* foot.*


の5つのファイルで構成されています（いくつかのファイルは存在しない場合もあります。「*」にはflavour名（flav,htmlなど）が入ります）。従って、これらのファイルを入れ替え、あるいは追加すれば、違うflavourを使うことが出来るわけです。

### flavourを導入する

標準flavourの説明が済んだので、それ以外のflavourを導入する方法を解説します。折角の「ブログカスタマイズ」ですので、直ぐにでもflavourを自作してみたいところですが、その前に既存のflavourを導入してみることで、flavourを扱う練習をしたいと思います。

lilyはperlで書かれたblosxomというツールをrubyに移植したものなので、blosxom用のfalvourがほとんどそのまま使えます。そこで、blosxom用flavourの配布ページからいくつかflavourを導入します。

[http://stormthestudio.hp.infoseek.co.jp/weblo/blosxom/thumbnail.html](http://stormthestudio.hp.infoseek.co.jp/weblo/blosxom/thumbnail.html)

この中の「SimpleCSS flavour」（[moleskin氏](http://d.hatena.ne.jp/moleskin/)作成）を使う方法を解説します。

1. まず、パッケージを[ダウンロード](http://moleskin.hp.infoseek.co.jp/blog/2003/11/21#simplecss)します。
1. パッケージを解凍すると、flavourファイルとCSSファイルが入っています。
1. head.html中でCSSのURLを指定している部分を、自サイトのURLに変更します
1. 自分のサーバのflavourディレクトリにアップロードします


本当はサイドバーの内容なども変更すべきですが、今回は使うための最小限の手順を解説しました。こうして導入したflavourを使った表示は、以下のURLで確認できます。
（今回は、既存のflavourとの共存のためにflavourファイルの拡張子（flavour名）をhtmlからscに変更しました）

[http://www.mikihoshi.com/rubima/d/lily.cgi/index.sc](http://www.mikihoshi.com/rubima/d/lily.cgi/index.sc)

もう一つ、tDiary互換flavourを試してみます。

1. [http://cgi.no-ip.org/cgi-bin/blosxom/data/](http://cgi.no-ip.org/cgi-bin/blosxom/data/)でblosxomのデータディレクトリを公開されているのですが、flavourディレクトリ内に拡張子tdiaryのflavourファイルがあるので、ダウンロードします。
1. tDiary互換flavourの場合はプラグインに関する記述など、変更の必要な箇所がいくつか存在します。変更したものをアップしておきます。（[tdiary.zip]({{site.baseurl}}/images/0004-LilyCustomizeHack/tdiary.zip)）
1. 自分のサーバのflavourディレクトリにアップロードします


tDiary互換flavourの導入はやや複雑ですが、tDiaryの豊富なテーマを利用することが出来ます。今回はおなじみのcloverテーマを導入してみました。

[http://www.mikihoshi.com/rubima/d/lily.cgi/index.tdiary](http://www.mikihoshi.com/rubima/d/lily.cgi/index.tdiary)

プログラムやHTMLに詳しくない人は、こうした既存のflavourを適用しつつ、少しずつ中身を書き換えてカスタマイズするのがお奨めです。

## flavourを作ってみる

### はてなダイアリー形式flavourの作成

それではいよいよflavourを自作します。今回は、[はてなダイアリー](http://d.hatena.ne.jp/)にインポートできる「はてなの日記データ形式」XMLファイルを出力するflavourを作ってみます。

はてなの日記データ形式を選んだのは構造がシンプルだからですが、実際にこのflavourを使ってlilyのblogをはてなにエクスポートし、はてなダイアリーブックサービスで本にする、などの利用法もあります[^3]。

はてなダイアリー形式のXMLファイルは、以下のような構造になっています。

{% highlight text %}
{% raw %}
<diary>
 <day date="2004-06-13" title="">
   <body>
    *[カテゴリ]記事のタイトル
    　：
    　本文
    　：
    *[カテゴリ]記事のタイトル
    　：
    　本文
    　：
    *[カテゴリ]記事のタイトル
    　：
    　本文
    　：
   </body>
 </day>
</diary>
{% endraw %}
{% endhighlight %}


それでは、flavourの仕組みを説明しながら、実際にはてなの日記データ形式flavourを作っていきます。

### flavourの構成

下図を見てもらうと分かるように、flavourの5つのファイル（content_type, head, date, story, foot）は以下の順序で組み合わさって出力されます。
![flavour.png]({{site.baseurl}}/images/0004-LilyCustomizeHack/flavour.png)

各flavourファイルを順番に説明して行きます。

#### content_type

このflavourは特殊で、HTTPヘッダの「Content-type」フィールドを指定するものです。例えば、今回作成するはてなデータ形式や、RSSのファイル等はXMLファイルです。そのため、ブラウザで正しく処理するには「Content-type」フィールドにXMLを意味する「text/xml」を出力する必要があります。
![content_type.txt]({{site.baseurl}}/images/0004-LilyCustomizeHack/content_type.txt)

content_type flavourファイルが存在しない場合、lilyは自動的にHTML用のContent-typeフィールドを出力します。そのため、一般的なHTML出力用のflavourではcontent_type flavourは不要です。

#### head

出力の先頭で1回だけ表示されるflavourです。HTML形式のflavourの場合、&lt;html&gt;から始まり、&lt;head&gt;〜&lt;/head&gt;の記述、body部の記事表示前のタイトルや注意書き表示の部分を記述します。

ちなみに、lilyの現行のデフォルトflavourではこの部分にサイドメニューの項目も記述していますが、アクセシビリティの観点から余り良くありません（携帯電話などの画面の小さい端末の場合、スクロールしないと記事本文が登場しない）。後述するfoot flavourに記述することをお奨めします。

headに限りませんが、各flavour内では、lily.cfgに定義した値や、プラグインの特殊な出力を記述することが出来ます。例えば

{% highlight text %}
{% raw %}
<h1>$blog_title</h1>
{% endraw %}
{% endhighlight %}


と記述すると、lily実行時には、lily.cfgで定義したblog_title（ブログのタイトル）に置換されます。例のようにH1で囲って文章の見出しに使ったりすることができます。それ以外もlily.cfgで定義している値は

{% highlight text %}
{% raw %}
$定義名
{% endraw %}
{% endhighlight %}


のように書くことで出力できます。

単純な定義だけでなく、月別のアーカイブリンクを出力したり、カテゴリ別のリンクを出力したりする場合は、プラグインという仕組みを使います。（プラグインについての詳細な解説は次号を予定しています）
![head.txt]({{site.baseurl}}/images/0004-LilyCustomizeHack/head.txt)

#### date

date, storyの各flavourは、表示する記事の回数分表示されます。ただし、date flavourは各日の最初だけ出力されます。例えば、2004年12月の記事を表示する際、12月1日の記事が2つ、12月3日の記事が1つだとすると、

* 12/3分のdate
* 12/3の記事のstory
* 12/1分のdate
* 12/1の記事のstory（その１）
* 12/1の記事のstory（その２）


のように出力されます。

date flavourの中では、以下の記述が、記事の投稿日時に置換されます。

* $ti 一般的な日付文字列（2004-12-24など）
* $yr 西暦年（2004）
* $mo 月（略称）（Jan,Feb-Dec）
* $mo_num 月（数字）（01-12）
* $da 日（01-31）
* $dw 曜日略称（Sun.-Fri,Sat）
* $hr 時間（01-24）
* $min 分（00-59）
* $sec 秒（00-59）


例えば、「2004年12月24日」のような表記を行う場合は、

{% highlight text %}
{% raw %}
$yr年$mo_num月$da日
{% endraw %}
{% endhighlight %}


と記述します。

はてなデータ形式では日付を意味する&lt;day&gt;と&lt;body&gt;を記述することになります。注意するのは、date flavourは各日の最初だけしか表示されないということです。そのため、&lt;day&gt;,&lt;body&gt;の前に&lt;/body&gt;,&lt;/day&gt;を追加して、直前の日の要素を閉じています。head.hatenaの最後に&lt;day&gt;,&lt;body&gt;があるのは、一番最初に表示されるdate flavour（前の日がない）のためのダミーです。
![date.txt]({{site.baseurl}}/images/0004-LilyCustomizeHack/date.txt)

#### story

storyでは、各記事の表示の仕方を記述することになります。その為、storyでは今までに説明した、

* $を使ってlily.cfgに定義した値を表示する
* 記事の投稿時刻を表示する


以外に、以下の特殊な表記を使うことが出来ます。

* $path 記事のカテゴリ（保存ディレクトリ）
* $fn 記事ファイル名（拡張子除く）
* $fext 記事ファイルの拡張子
* $title 記事のタイトル（最初の1行）
* $body 記事の本文


例えば、blogの各記事には、その記事へリンクを貼る際にPermalinkが示してあると便利ですが、$url（lilyの設置されているURL）という表記を使うことで、以下のように記述できます。

{% highlight text %}
{% raw %}
<a href="$url$path/$fn.$flavour">permalink</a>
{% endraw %}
{% endhighlight %}


$flavourの部分は「html」などのflavour名を入れてしまってもいいと思います。

はてなの日記データ形式の場合、1日の日記の中の記事のまとまり（セクション）ごとに、

{% highlight text %}
{% raw %}
*[カテゴリ]見出し
{% endraw %}
{% endhighlight %}


のようにタイトルを付けるので、story.hatenaは以下のようになります。
![story.txt]({{site.baseurl}}/images/0004-LilyCustomizeHack/story.txt)

#### foot

footは記事の表示が終わったあと、最後に出力されます。
はてな日記データ形式の場合は、タグを閉じるだけですね。
![foot.txt]({{site.baseurl}}/images/0004-LilyCustomizeHack/foot.txt)

余談ですが、大抵のblogツールやWikiツールの末尾には「Powered by ○○」とツール名が表記されています。PerlやPHPなどのツールの場合は「Powered by blosxom」のようにそのままツール名が入りますが、Rubyのツールには「Generated by ○○ Powered by Ruby」と、Rubyへのリンクを入れているものが多いです（中にはテンプレートエンジンのリンクなんかも入っていたり）。筆者はなんとなくこのRuby式の表記を気に入っていたりします。

### flavour完成

最後に完成したhatena flavourを置いておきます。（[hatena.zip]({{site.baseurl}}/images/0004-LilyCustomizeHack/hatena.zip)）また、これをサンプルのlilyに適用した場合、以下のようなXMLになります。

[http://www.mikihoshi.com/rubima/d/lily.cgi/index.hatena](http://www.mikihoshi.com/rubima/d/lily.cgi/index.hatena)

## あとがき

今回はflavourについて説明しましたが、いかがでしたでしょうか。書き終えてから「今回はほとんどRubyと関係ない」というるびまの連載として致命的な欠陥に気が付いたのですが、本連載の肝と言っても良い次回の「プラグイン解説」のためには不可欠な箇所ですので、ご容赦いただければと思います。

また、今回説明したflavourの仕組みを、lilyでどのように実現しているか興味のある方は是非lily.cgiのソースをご覧下さい。難しいことはやっていませんし、分量も少ないのでソース読みの練習材料として適材ではないかと思います。もしも分かり辛い箇所があれば、著者までフィードバックしていただけば是非次回の内容に活かしたいと思います。

## 著者について

![deka.jpg]({{site.baseurl}}/images/0004-LilyCustomizeHack/deka.jpg)
なまえ：ふしはらかん。
[http://www.mikihoshi.com/d/](http://www.mikihoshi.com/d/)にて日記を書いてます。

最近はlilyよりもwema2の開発に忙しかったり…。

[http://www.mikihoshi.com/wema2/test/](http://www.mikihoshi.com/wema2/test/)

もちろん、大幅に機能強化したlily2も構想中なので、期待せずお待ち下さい。

----

[^1]: ここで述べている記事の日付は、ファイルが作成された日付（通常はFTPでアップロードされた日付）です。
[^2]: 「xmas.html」が「xmas.flav」になっています
[^3]: 作者としては「はてなへの移行が簡単」とは言いたくないです
