---
layout: post
title: Ruby ビギナーのための CGI 入門 【第 2 回】 ページ 2
short_title: Ruby ビギナーのための CGI 入門 【第 2 回】 ページ 2
tags: 0012 CGIProgrammingForRubyBeginners
---
{% include base.html %}


[前ページへ]({% post_url articles/0012/2005-12-23-0012-CGIProgrammingForRubyBeginners-1 %})
[目次ページへ]({% post_url articles/0012/2005-12-23-0012-CGIProgrammingForRubyBeginners %})
[次ページへ]({% post_url articles/0012/2005-12-23-0012-CGIProgrammingForRubyBeginners-3 %})

* Table of content
{:toc}


## HTML フォームについて

皆さんの中には HTML フォームについて知らない人もいるかもしれません。
ここで簡単に HTML フォームについて触れておきましょう。
下に HTML フォームのスクリーンショットを載せています。
とりあえず図を眺めてみて下さい。

HTML フォームのスクリーンショット
![form_example.jpg]({{base}}{{site.baseurl}}/images/0012-CGIProgrammingForRubyBeginners-2/form_example.jpg)

スクリーンショットを見ると、
このフォームには下のような部品があることが分かりますね。

* 自由に書き込みが出来るところ (テキストフィールド)
* チェックするところ (チェックボックス)
* 投稿ボタン (サブミットボタン)


Web ページの読者はこうした部品を通じて
投稿内容をテキストフィールドに書き込んだり、
チェックボックスの項目を選択したりします。
読者がフォームに書き込んだ内容は
サブミットボタンが押されると CGI プログラムに渡ります。

フォームのデータを受け取った CGI プログラムは
そのデータに従って処理の方法を決めたり、
実際にデータを処理したりします。
掲示板への書き込みもその 1 例です。
フォームデータの処理については後ほど詳しく説明しますので、
今は処理の流れを大まかにつかんで下さい。

上記の図の HTML ソースを読んでみましょう。
下にソースを示します。
![form.html]({{base}}{{site.baseurl}}/images/0012-CGIProgrammingForRubyBeginners-2/form.html)

目に付くのは form タグと input タグですね。
form タグに囲まれた部分がフォーム全体で、
その中には部品を表すタグを配置出来ます。
この例では部品となるタグに input タグが使われています。

input タグは type 属性によって部品の種類を変えられます。
この例ではテキストフィールド、チェックボックス、サブミットボタン
の 3 種類の部品が使われています。
input タグ以外にも部品を表すタグは存在します。
それについては一般的な HTML の説明を読んで下さい。

### name 属性

上記の HTML の input タグをもう一度見てみましょう。
全ての input タグに name 属性が付いていますね。
__name 属性というのはそれぞれの部品についた名前です__
(input タグ以外の部品を表すタグにも name 属性が付きます)。

name 属性は部品の名前で、
それぞれの部品を区別するために使われます。
name 属性にはいくつかの利用法があり、
もっとも頻繁に使われる場面の一つがフォームデータを送信する時です。
フォームデータを送信する時は各部品の name 属性と
その値が一緒に送信されます。
name 属性はそれぞれの部品を区別するために利用されます。

例えば、上記の HTML のテキストフィールドに書かれたデータが欲しい時は
t という名前を使ってテキストフィールドの値を調べることが出来ます。
その具体的な方法については後ほど説明します。

いくつか例外はありますが、
name 属性は部品ごとに違う値にしておく方が良いでしょう。
実生活で別人 2 人が同じ名前だと、
名前を呼ぶ時に困りますよね。
それと同じで name 属性を同じにすると、
名前が重なってしまって各部品のデータを調べる時に困ることがあります。

## 山彦もどき

さて、今号最初の CGI プログラムです。
ここでは「山彦もどき」を作ります。
皆さん知っているように山彦というのは
山や谷にしゃべった内容が返ってくることで、
「山彦もどき」というのは HTML フォームのテキストフィールドに書かれた内容が
そのまま表示される CGI プログラムのことです 
(勝手に筆者が命名しました)。

前号では CGI プログラムでデータを表示する方法を学びましたから、
HTML フォームのデータを受け取ることが出来れば
そのデータを表示して「山彦もどき」は完成です。
そういうわけで、まずは HTML フォームのデータを受け取る方法を
学んでいきましょう。

### HTML フォーム と CGI プログラム の関係

既に述べましたが、
HTML フォームは Web ページの読者が
情報を入力するところです。
そして、ページの読者が入力したデータは
CGI プログラムに渡されます。
この時の HTML フォームと CGI プログラム のデータの流れを
見ていきましょう。

#### フォームへの書き込み - 掲示板への投稿を例にして

最初は皆さんにとって馴染みのある掲示板への
投稿を例にして考えてみます。
その流れは下のようになります。
ここまでは皆さん自身が経験したことがあると思います。

1. 投稿するために HTML フォームをブラウザに表示させる
1. 投稿内容を書く
1. フォームのボタンを押す
1. 投稿内容が掲示板に書きこまれて、表示される


フォームを利用した CGI プログラムを作る時には
上の 3, 4 の間の処理が重要となります。
3, 4 の間でフォームのデータがどのように処理されるか
さらに詳しく追ってみましょう。

#### 実際にフォームに書き込んでみる

具体的に話を進めるために
ここから先は下に示す HTML フォームを使います。
前号と同じように server.rb を起動して 
[http://localhost:8080/bar0.html](http://localhost:8080/bar0.html) を表示させてみて下さい。
テキストフィールドとサブミットボタンが表示されますね。

bar0.html
![bar0.html]({{base}}{{site.baseurl}}/images/0012-CGIProgrammingForRubyBeginners-2/bar0.html)
![bar0.jpg]({{base}}{{site.baseurl}}/images/0012-CGIProgrammingForRubyBeginners-2/bar0.jpg)

試しにテキストフィールドにアルファベットか数字を書いて、
サブミットボタンを押してみましょう。
ここでは「dddd」 と入力したと仮定して話を進めます。

ボタンを押すと、下のように Not Found と表示されると思います。
これは一般にファイルが無い時に表示されるメッセージです。
何故こうなるのでしょうか？
皆さんも少し考えてみてください。
![not_found.jpg]({{base}}{{site.baseurl}}/images/0012-CGIProgrammingForRubyBeginners-2/not_found.jpg)

#### form タグの action 属性

この答えは bar0.html の内容と関係します。
もう一度 bar0.html をよく見てみましょう。
bar0.html の form タグに action 属性というのがありますね。
ここに ./not_found.rb という値があります。
ボタンを押した時にブラウザのアドレスバーに表示されている URL にも
[http://localhost:8080/not_found.rb?t=dddd&amp;s=Button](http://localhost:8080/not_found.rb?t=dddd&s=Button) のように
not_found.rb が含まれています。
この 2 つは偶然同じ値が使われているわけではなく、
ちゃんと関連があります。

action 属性にはサブミットボタンを押した時に
フォームのデータを処理する CGI プログラムを指定します。
つまり、サブミットボタンが押された時には
__action 属性に指定された CGI プログラムが実行される__わけです。
例えば、form タグの action 属性が ./not_found.rb なら、
サーバーは bar0.html と同じフォルダーにある not_found.rb 
という CGI プログラムを実行しようとします。

この例の場合、not_found.rb という CGI プログラムが無いので、
サーバーは「Not Found」というメッセージを出して
CGI プログラムを実行するのを諦めてしまいます。

#### フォームから CGI プログラムを実行

CGI プログラムが無いのなら、
とりあえず何でも良いので CGI プログラムを作って、
そのプログラムの名前を action 属性に指定してみます。
ここでは bar1.rb を用意しました。

bar1.rb 

```ruby
#!/usr/local/bin/ruby

print "Content-Type: text/html\n\n"
print "<html><head></head><body>OK?</body></html>"

```

bar1.rb という CGI プログラムは前号で作った
HTML を表示させるプログラムと構造は同じです。
[http://localhost:8080/bar1.html](http://localhost:8080/bar1.html) にアクセスして試してみて下さい。
bar1.html は action 属性を bar1.rb に変更しているだけで
他は bar0.html と同じです。
今度は下図のように OK? と表示されていると思います。

でも、bar1.rb はフォームデータを取得していませんから、
フォームの内容と関係の無い HTML しか表示出来ません。
どうしたら良いのでしょうか？
![form_get2.jpg]({{base}}{{site.baseurl}}/images/0012-CGIProgrammingForRubyBeginners-2/form_get2.jpg)

### フォームデータの受け取り

すでに気づいている人もいるかもしれませんが、
フォームのサブミットボタンを押した後、アドレスバーには

{% highlight text %}
{% raw %}
 http://localhost:8080/bar1.rb?t=dddd&s=Button
{% endraw %}
{% endhighlight %}


のように「?」の後ろに
テキストフィールドのデータが含まれています。
このデータを使えばフォームの内容に合わせて
CGI プログラムの表示する内容を変更出来ます。

#### フォームデータと環境変数

では、アドレスバーの URL に含まれる
フォームのデータを取得してみましょう。
先程、環境変数 ENV というデータを紹介しましたが、
__CGI プログラムでは ENV を使ってフォームのデータを文字列として取得出来ます__。

前ページで見たように環境変数にはたくさんのデータが含まれています。
たくさんの環境変数のデータのうち 
__「QUERY_STRING」という「名前」の環境変数に対応する「値」がフォームデータです__。
これは CGI のお約束の 1 つです。

#### フォームのデータを表示させる

では、ENV を使った「山彦もどき」のプログラムを見てみましょう。

bar_echo1.rb

```ruby
#!/usr/local/bin/ruby

print "Content-Type: text/html\n\n"
print "<html><head></head><body>"
print ENV['QUERY_STRING']
print "</body></html>"

```

ENV の使い方さえ分かれば難しいところは無いと思います。
試しに [http://localhost:8080/bar_echo1.html](http://localhost:8080/bar_echo1.html) を表示させて
テキストフィールドに「dddd」と入力し、
サブミットボタンを押して下さい。

ちなみに bar_echo1.html も bar0.html とほとんど同じです。
違うのは action 属性だけです。
![bar_echo1_1.jpg]({{base}}{{site.baseurl}}/images/0012-CGIProgrammingForRubyBeginners-2/bar_echo1_1.jpg)

確かに URL の「?」より後ろの文字列が表示されていますね。
でも、フォームに入力した内容が「dddd」なのに
それ以外に余計なものがいっぱい付いています。

#### フォームデータを作る

「dddd」以外のものを取り除く方法は幾つかありますが、
ここでは環境変数 QUERY_STRING がどのように作られているかを考え、
その方法の逆をたどって余計な部分を取り除いてみます。

フォームのデータは HTML に書かれた内容から作られるので、
まずは bar_echo1.html のフォームを見てみましょう。

bar_echo1.html
![bar_echo1.html]({{base}}{{site.baseurl}}/images/0012-CGIProgrammingForRubyBeginners-2/bar_echo1.html)

このフォームは二つの部品から構成されています。

* t という name 属性で、何も書かれていないテキストフィールド
* s という name 属性で、Button と表示されるサブミットボタン (value 属性は Button)


環境変数 QUERY_STRING を見れば分かるように
環境変数 QUERY_STRING には「dddd」以外に
「s」「t」「Button」が含まれていますね。
環境変数 QUERY_STRING の値は「t=dddd&amp;s=Button」なので、
フォームの各部品の name 属性や value 属性などが
組み合わさってフォームデータが作られていることが分かります。
テキストフィールドの場合 value 属性の代わりに
サブミットボタンが押された時のテキストフィールドの内容が使われますが、
今号では value 属性でまとめてしまいます。

フォームデータを作る方法は下のようになります。
細かい部分は省いていますが、大筋はこのやり方に従って作られます。

1. 各部品の name 属性と value 属性に必要なら前処理を行う (アルファベットや数字には前処理はしない)
1. 各部品の name 属性と value 属性を「=」でつなぐ
1. それぞれの組を「&amp;」で結合する


例えば、「dddd」とフォームに書いてサブミットボタンを押した場合、
手順 1 では前処理が行われないので
「t」「dddd」「s」「Button」の 4 つのデータが用意されます。
次の手順 2 では「t」と「dddd」、「s」と「Button」を「=」でつなげて
「t=dddd」「s=Button」の 2 つの組が作られます。
さらに手順 3 では 2 つの組が「&amp;」でつながって
「t=dddd&amp;s=Button」という 1 つの文字列になります。
これが 環境変数 QUERY_STRING の値になります。

#### フォームデータを分ける

それでは、フォームデータから必要なデータだけを取り出したい時は
どうすれば良いのでしょうか？
その方法を簡単に言うと、フォームデータを作る手順を逆に辿ります。
具体的には下のようになります。

1. 「&amp;」で分解する。
1. 「&amp;」で分解して得られた組をさらに「=」で分解し、name 属性と value 属性を得る
1. 各部品の name 属性と value 属性に前処理と逆のことを行う(アルファベットや数字はしないで良い)


実際の処理はこの後に 「山彦もどき」を作る で実際に説明します。

### 「山彦もどき」を作る

フォームのデータを取得する方法が分かったところで、
「山彦もどき」を作りましょう。
まずは「山彦もどき」全体を示します。

bar_echo2.rb

```ruby
#!/usr/local/bin/ruby

print "Content-Type: text/html\n\n"
print "<html><head></head><body>"

str = ENV["QUERY_STRING"]
print str
print "<br>"

arr1 = str.split("&")
print arr1[0]
print "<br>"
print arr1[1]
print "<br>"

arr2 = arr1[0].split("=")
print arr2[1]

print "</body></html>"

```

#### 文字列の分割 - split 命令

6 行目で環境変数 QUERY_STRING のデータ
(フォームのデータ) に変数 str という目印を付けます。
7 行目では変数 str のデータを表示させています。
これで CGI プログラムに渡されたフォームデータを確認出来ます。

ポイントは 10 行目です。
変数 str の目印の付いた文字列を「&amp;」で区切って分割しています。
split は文字列に対する命令です。
先程 Array のデータの後ろに「.」を付けて Array のデータに
命令を実行させていましたね。
それと同じで文字列にも実行可能な命令があり、
その命令の 1 つが split です。 
split は英語で「分割する」という意味があり、
括弧の中のデータに従って文字列を分割します。

実際に split を使ったプログラムを試してみましょう。
下に split を使った 4 行のプログラムを示します。
1 行目の "123".split("2") では () の中の "2" が split に渡され、
split は "123" を "2" で分割します。
その結果、"1" と "3" の 2 つに分かれて
["1", "3"] という Array になり、そのデータが puts で表示されます。
5 行目でも同様の処理が行われます。

{% highlight text %}
{% raw %}
arr1 = "123".split("2")
puts arr1[0]
puts arr1[1]

arr2 = "aaabbbcccbbbaaa".split("bbb")
puts arr2[0]
puts arr2[1]
puts arr2[2]
{% endraw %}
{% endhighlight %}


#### 命令のパラメーター

ちょっと横にそれますが、
ここで命令の使い方について触れておきます。
これまで出てきた命令には split 以外にも 
rand のようにパラメーター付きの命令がありました。
__一般に命令の後ろの () の中には命令を実行する時のパラメーターを指定します__。
「嘘付け、前号で rand 命令を紹介した時には 
rand 10 や rand 5 のように () を付けなかったじゃないか」と
後ろ指を刺されそうですが、
それは Ruby では命令の後ろに () を付けても付けなくても同じ意味になるからです。
例えば、rand 10 は rand(10) と、rand 5 は rand(5) と同じ意味を持ちます。

一般に命令を使う時には () を付ける方が良いとされていますが、
本連載で扱う範囲では () を付けないことも多いです。
それはプログラムが簡単だからです。
どんなプログラムや命令に () を付けて
どんなプログラムや命令に () を付けないかというのは
個人の好みがあるので、一概には言えませんが、
皆さんがプログラムを読んだり書いたりするうちに
自分の中のルールが決まってくると思います。
例えば、筆者は Array の length のように
パラメータ無しの命令に関しては () を付けない方が好きです。

#### split を使ってフォームデータを分ける

話を split 命令に戻しましょう。
bar_echo2.rb の 10 行目 の split 命令のパラメーターに
「&amp;」を指定して環境変数 QUERY_STRING の値を分割するのでしたね。

「dddd」をテキストフィールドに書いた場合、
フォームのデータは「t=dddd&amp;s=Button」となります。
それを split で「&amp;」で分割すれば
「t=dddd」と「s=Button」の 2 つに分かれることになります。
split 命令の結果 (Array) には変数 arr1 の目印が付きます。
split の結果を図で表すと、下のようになります。

| 0| 1|
| "t=dddd"| "s=Button"|


欲しいのは dddd が付いた方ですので、
この図から分かるように添字に 0 を使って
arr1[0] で "t=dddd" のデータにアクセスします。

これでもまだ余分なものが付いていますので、
今度は arr1[0] の "t=dddd" を「=」で分解します。
16 行目で split をもう一度使っているのはそういう理由です。
2 回目の split の結果は下図のようになります。

| 0| 1|
| "t"| "dddd"|


今度は添字の 1 に "dddd" があります。
そのため 17 行目では arr2[1] を表示し、
テキストフィールドに書かれたデータを
そのまま返しています。

#### 「山彦もどき」の実行

「山彦もどき」の実行結果は下図のようになります。
実際に試す時は 
[http://localhost:8080/bar_echo2.html](http://localhost:8080/bar_echo2.html) にアクセスして下さい。
フォームにアルファベットや数字を入れて
どのように表示されるか遊んでみましょう。
![bar_echo1_2.jpg]({{base}}{{site.baseurl}}/images/0012-CGIProgrammingForRubyBeginners-2/bar_echo1_2.jpg)

[前ページへ]({% post_url articles/0012/2005-12-23-0012-CGIProgrammingForRubyBeginners-1 %})
[目次ページへ]({% post_url articles/0012/2005-12-23-0012-CGIProgrammingForRubyBeginners %})
[次ページへ]({% post_url articles/0012/2005-12-23-0012-CGIProgrammingForRubyBeginners-3 %})


