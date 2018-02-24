---
layout: post
title: Ruby ビギナーのための CGI 入門 【第 1 回】 4 ページ
short_title: Ruby ビギナーのための CGI 入門 【第 1 回】 4 ページ
tags: 0011 CGIProgrammingForRubyBeginners
---
{% include base.html %}


[目次ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners %})
[前ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-3 %})
[付録ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-Appendix %})

* Table of content
{:toc}


## 今回作る CGI プログラムについて

前置きが長かったかもしれませんが、
そろそろ CGI プログラムを作っていきましょう。

今まで Ruby で文字や数値を表示させる方法を説明してきましたが、
その方法をちゃんと覚えていますか？　
__Ruby の CGI プログラムでもデータを表示させる時は print や puts を使います__。
print, puts の使い方は普通の Ruby プログラムの時と同じです。 
自信の無い人はもう一度 RDE で print, puts の使い方を確認しておきましょう。

今号では以下の CGI プログラムを作ります。

* 練習用の CGI プログラム 3 つ
* HTML を表示するだけの CGI プログラム
* ランダムに画像を表示する CGI プログラム


一番最後の、ランダムに画像を表示するプログラムを作る時には
これまでに紹介していない幾つかの Ruby の機能を使う必要があります。
その機能の名前をここで紹介しておきます。

* 変数
* 文字列の変数埋め込み
* rand 命令


これらの機能を使いこなすだけでは駄目で、
それといっしょに CGI の約束事にも馴れていかなければなりません。
すべてを一度に説明すると対処出来なくなるので、
練習用の CGI プログラムから説明を始めて
徐々に難しいものへとステップアップしていきましょう。

今号で紹介する CGI プログラムは全部で 5 つです。
どれも非常に短いプログラムで、
初めて CGI プログラムに挑戦する人にはちょうど良いと思います。
__これらの CGI プログラムは C:\rubima011-cgi\ の中にあります__。

この連載で紹介された CGI プログラムを
そのまま実行しても良いのですが、
それだけではプログラム作りはなかなか上手くなりません。
自分で一からプログラムを作ると上達は早いのですが、
初めてプログラムを作る人にとってそれは難しいでしょう。
そこで、この連載で紹介するプログラムを
自分で入力してみたり、改造してみたりしてみて下さい。
これだけでもずいぶん違うと思います。

では、最初の CGI プログラムの紹介です。

## 数値を表示する CGI プログラム

一番最初は練習用 CGI プログラムとして
数値を表示する CGI プログラムを書きます。
まずは実際の CGI プログラムを示しましょう。
この CGI プログラムはブラウザに「123」と表示します。

foo.rb

```ruby
#!/usr/local/bin/ruby

print "Content-Type: text/html\n"
print "\n"
print 123

```

1 行目は shebang というものです。
Windows を使っている人にはほとんど関係ありません。
将来的には必要になりますが、今は無視して下さい。

3 行目で変な文字列 (Content-Type ...) を表示していますが、
これは CGI という枠組みを使うためのおまじないです
(じゃあ、何故こんなものを書くんだと言われそうですね。後で説明します)。

5 行目は分かるでしょう。print.rb の時と同じで「123」を表示させます。

### RDE から実行

CGI プログラムとして実行する前に RDE から foo.rb を実行してみましょう。
foo.rb をCGI プログラムとして実行した場合と RDE から実行した場合では
表示される内容に違いがあるからです。
RDE でどのように表示されるのかよく観察しておいて下さい。

RDE で実行すると下のように表示されます。

{% highlight text %}
{% raw %}
Content-Type: text/html

123
{% endraw %}
{% endhighlight %}


元のプログラムの 3, 4 行目に "\n" が出てきていますね。
これは CGI での文の区切りを表します。
一般に CGI では "\n" が文の区切り (改行のようなもの)
として使われます。

### CGI プログラムとして実行

皆さんの中には早く CGI プログラムとして実行したいという人がいると思いますが、
その前にもう一つやる事があります。
それはサーバーを起動することです。
CGI プログラムを実行するのはサーバーですから、
サーバーを起動しないと CGI プログラムを実行出来ません。

既に述べたようにサーバーはダウンロードしてもらった
[rubima011-cgi.zip]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-4/rubima011-cgi.zip)
の中に含まれています。
C:\ に rubima011-cgi.zip を展開した方は
C:\rubima011-cgi のフォルダーに server.rb
というファイルがあるはずです。
これがサーバーとなる Ruby プログラムです。
server.rb 自体の説明は省きます。
やりたいことは サーバーを作ることではなく、
CGI のプログラムを書くことですからね。

この server.rb をダブルクリックで実行します。
下のようなメッセージが表示されたらサーバーの起動は成功です。
表示が微妙に違うかもしれませんが、それを気にする必要はありません。
![server_invoke.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-4/server_invoke.jpg)

もし、コマンドプロンプト (黒いウィンドウ) だけが表示されて
メッセージが表示されない場合はこのウィンドウに
「Enter」キーを入力してみて下さい。上記のメッセージが表示されると思います。
メッセージが表示された状態でブラウザで 
[http://localhost:8080/](http://localhost:8080/) にアクセスしましょう。
ブラウザのアドレスバーに
[http://localhost:8080/](http://localhost:8080/) と打ち込むか、このリンクをたどって下さい。
下図のように server.rb のあるフォルダーにあるファイルの一覧が表示されます。
これで CGI のプログラムを実行する環境が整いました。
![localhost.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-4/localhost.jpg)

念のためもう一度再度繰り返しますが、
__CGI のプログラムを実行する時は CGI プログラムの実行前に server.rb を実行しておいて下さい__。
サーバーは CGI プログラムの実行役なので、
サーバーが起動しないと CGI プログラムは実行されません。

もし、server.rb でどうしても上手くいかないという時には
[付録ページ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-Appendix %})
で違う方法を紹介しています。
トライしてみて下さい。

サーバーが起動したら
[http://localhost:8080/foo.rb](http://localhost:8080/foo.rb) にアクセスしてみましょう。
リンクをクリックしてみて下さい。
こうする事でサーバーが foo.rb を
CGI プログラムとして実行してくれます。
ブラウザに「123」が表示されましたか？
![foo.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-4/foo.jpg)

うまく「123」が表示されない場合、
まずは foo.rb に Ruby の文法ミスがないかをチェックして下さい
(文法に間違いがあると、翻訳機の Ruby が文句を言ってきます)。
RDE で再度実行してエラーが無いか試してみると良いでしょう。
RDE で実行してもエラーが無い場合はコマンドプロンプトの表示を見て下さい。
CGI プログラムの実行に問題があると、ここにエラーメッセージが表示されます。
例えば、

{% highlight text %}
{% raw %}
[2005-09-14 19:46:57] ERROR Premature end of script headers: C:/rubima011-cgi/foo.rb
{% endraw %}
{% endhighlight %}


などと表示される場合は foo.rb の 3, 4 行目が正しいか確認して下さい。

### CGI と RDE で実行した時の違い

CGI で実行した場合と RDE で実行した場合とを比較してみて下さい。
CGI で実行した結果を見るには、ブラウザに表示された HTML のソースを見る必要があります。

CGI で実行すると、foo.rb の
3行目の "Content-Type: text/html\n" と 4行目の "\n" が消えていますね。
これは server.rb がその部分を解釈して消してしまったからです
(正確に言うと、server.rb が解釈してその部分を再発行し、
ブラウザが見せないようにしているのですが……)。
なぜ server.rb が 3, 4 行目を解釈するのかというとそれが CGI の約束事だからです。
その理由を真面目に説明しようとすると大変ややこしいので、
今はそれが CGI の約束事だからという答えで我慢して下さい。

3 行目の __"Content-Type: ..." という行は必ず付けなくてはなりません__。
もちろん例外はありますが、
その説明は余裕のある時にしたいと思います。
この 3 行目は CGI プログラム(今の場合は foo.rb)の実行結果が
どういう種類なのかを示します。
CGI プログラムの実行結果は、ほとんどの場合 HTML ですので、
Content-Type: text/html とします。

Content-Type には text/html 以外の値も使うことが出来ます。
例えば、上のような場合なら本来は text/html よりも text/plain を使うべきです。
text/plain というのは何の形式でもない普通の文字列データという意味です。
他にどのような値が指定出来るのか興味のある人は調べてみて下さい。

__4 行目の「\n」も必須です__。
この行は空白行を表し、これが無いと server.rb はエラーを起こします。
この空白行を表示した後にブラウザに表示させたいデータ (主に HTML) を表示させます。

3, 4 行目で表示させた文字列はほとんどの CGI プログラムで同じです。
馴れないうちは無条件に CGI プログラムの先頭に
この 2 行を付けておくと良いでしょう。
2 行で書くのが面倒なら下のように 1 行で済ませることも可能です。

{% highlight text %}
{% raw %}
print "Content-Type: text/html\n\n"
{% endraw %}
{% endhighlight %}


## 変数を使った CGI プログラム

次に Ruby の「変数」という機能を使った CGI プログラムを書いてみましょう。
ここから少しずつ難しくなるので、挫けないように頑張って下さいね。
ブラウザで [http://localhost:8080/foo2.rb](http://localhost:8080/foo2.rb) にアクセスして
CGI プログラムとして実行させてみて下さい。

foo2.rb

```ruby
#!/usr/local/bin/ruby
 
print "Content-Type: text/html\n\n"
a = "Hello World"
print a
print "\n"

```
![foo2.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-4/foo2.jpg)

Hello World と表示されたでしょうか？　
4, 5 行目の「a」というのが「変数」という機能です。

まずは何故変数という機能が必要かという説明をしましょう。
変数を使う大きな理由の一つが後でデータを使いまわすことが
出来ることです。

例えば、下のプログラムを考えてみましょう。
太郎君に挨拶をするプログラムです。
1, 2 行目で使った文字列が 3, 4 行目でも出てきていますね。

{% highlight text %}
{% raw %}
puts "こんにちは"
puts "太郎君"
puts "こんにちは" + "太郎君"
puts "こんにちは" + "、" + "太郎君"
{% endraw %}
{% endhighlight %}


もし、データの使い回しが出来れば、
プログラムを打ったり修正したりするのが楽になります。
また、打ち間違いも減りますよね。
こうした目的に変数を使うことが出来ます。

このプログラムと同じ内容のプログラムを変数を使って
書き直してみましょう。
今はプログラムの意味は分からないかもしれませんが、
簡単になっていることが分かると思います。

{% highlight text %}
{% raw %}
a = "こんにちは"
b = "太郎君"
puts a
puts b
puts a + b
puts a + "、" + b
{% endraw %}
{% endhighlight %}


これ以外にも変数を使えば、
時刻やHTML のフォームの内容に従って表示を変えたり
する事が出来ます。
残念ながら上記のようなプログラムは今号では紹介しませんが、
変数を使う事でプログラムの幅が随分と広がってきます。
この機会に是非覚えておきましょう。

変数とは何か……。
筆者も変数が何かということに一生懸命悩んだことがありました。
筆者の話はともかく一言で Ruby の変数を説明すると、
変数というのは __データへの目印__ です。

{% highlight text %}
{% raw %}
a = 123
{% endraw %}
{% endhighlight %}


これは「a」という変数を 123 というデータへの目印にするという意味です。
目印を付ける時は 123 という数値だけではなく、
「2*2*2*2*2」という式の結果 (この場合は 32 という数値データ)
にも使うことが出来ます。

{% highlight text %}
{% raw %}
a = 2*2*2*2*2
{% endraw %}
{% endhighlight %}


上の二つを図で書くと下のようになります。

{% highlight text %}
{% raw %}
┌──┐           ┌───┐
│ a  │ ────> │ 123  │
└──┘           └───┘

┌──┐           ┌──――──―──――┐
│ a  │ ────> │ 32 (2*2*2*2*2の結果) │
└──┘           └──――───────┘
{% endraw %}
{% endhighlight %}


ところで、数学では等号 「=」 を左辺と右辺が等しいという意味で使いますが、
Ruby においては少し意味が違います。
左辺で指定した変数に右辺の指すデータへの目印になれという意味があります。
馴れないうちは戸惑うかもしれませんが、
使っているうちに違和感がなくなってくるでしょう。

そろそろ実際に変数を使ってみます。
まずは下の内容を RDE で実行してみて下さい。

{% highlight text %}
{% raw %}
puts 123 + 1
{% endraw %}
{% endhighlight %}


これは変数を使っていませんが、
124 が表示されます。
このプログラムを実行した時はまず 123 + 1 が計算され、
その結果が puts で表示されます。

同様に下のプログラムを実行すると、124 が表示されます。
a は 123 という数値の目印なので、
a + 1 は 123 + 1 と同じ計算をすることになり、
その結果、124 が puts で表示されます。

{% highlight text %}
{% raw %}
a = 123
puts a + 1
{% endraw %}
{% endhighlight %}


次にこれはどうでしょう？

{% highlight text %}
{% raw %}
a = 1
b = 2
puts a + b
{% endraw %}
{% endhighlight %}


a + b では 1 + 2 と同じ計算をするので、3 が表示されます。
下の例だと、どうなるでしょう？

{% highlight text %}
{% raw %}
a = 100
b = -30
c = a - b
puts c
{% endraw %}
{% endhighlight %}


c = a - b では c = 100 - (-30) と同じ計算がされ、
c は計算結果の 130 というデータへの目印になります。
その後、4 行目で c という目印が付いたデータ、
この場合は 130 が表示されます。

だんだんと分かってきたでしょうか？　
ここでは変数に a, b, c などのアルファベットを使いましたが、
Ruby の変数には数字、アルファベット、「_」の組み合わせを使うことが出来ます 
(厳密にはちょっと違いますが)。

最後に一番最初のプログラムについて考えてみましょう。

{% highlight text %}
{% raw %}
a = "こんにちは"
b = "太郎君"
puts a
puts b
puts a + b
puts a + "、" + b
{% endraw %}
{% endhighlight %}


1, 2 行目は変数 a が "こんにちは" という文字列への、
変数 b が "太郎君" という文字列への目印になれという意味です。
3, 4 行目は変数 a, b の目印が付いているデータを
puts で表示させます。
そのため 3, 4 行目は

{% highlight text %}
{% raw %}
puts "こんにちは"
puts "太郎君"
{% endraw %}
{% endhighlight %}


と同じ意味になります。
5 行目は同じように

{% highlight text %}
{% raw %}
puts "こんにちは" + "太郎君"
{% endraw %}
{% endhighlight %}


を意味します。この例は前ページに出てきた文字列の結合ですね。
最後の 6 行目は皆さんが自分で考えてみましょう。
5 行目と基本的には同じです。

ここまできたらもう一度 foo2.rb に戻ってみましょう。

foo2.rb

```ruby
#!/usr/local/bin/ruby
 
print "Content-Type: text/html\n\n"
a = "Hello World"
print a
print "\n"

```

foo2.rb の 4 行目では変数 a を "Hello World" への目印にしています。
その後の 5 行目で変数 a の目印が付いているデータ、つまり、
"Hello World" を print で表示しています。

## 文字列の変数埋め込みを使った CGI プログラム

3 つ目は変数埋め込みを使った例です。
文字列の変数埋め込みは、後でランダムに画像を表示する時に使います。
ここではその機能に馴れることが目的です。

では、実例を見てみましょう。まずは下のプログラムを
RDE で試してみて下さい。
2 行目の puts では何が表示されるでしょう？

{% highlight text %}
{% raw %}
a = 123
puts "a = #{a}"
{% endraw %}
{% endhighlight %}


"a = 123" と表示されますね。
このように「"」で囲った文字列の中で #{} を使うことで #{} の中の
変数が指すデータを文字列に埋め込むことが出来ます。
上の場合、変数 a は 123 への目印ですから、
"a = #{a}" の #{a} という部分に 123 が埋め込まれ、
"a = 123" となります。その後、 puts によって "a = 123"
が表示されます。

次に下の例を試してみて下さい。

{% highlight text %}
{% raw %}
a = "こんにちは"
puts a
b = "太郎君"
puts b
puts "はじめまして。#{a}、#{b}。"
{% endraw %}
{% endhighlight %}


RDE で実行すると下のように表示されます。

{% highlight text %}
{% raw %}
こんにちは
太郎君
はじめまして。こんにちは、太郎君。
{% endraw %}
{% endhighlight %}


最後の行の

{% highlight text %}
{% raw %}
puts "はじめまして。#{a}、#{b}。"
{% endraw %}
{% endhighlight %}


では変数 a は "こんにちは" への目印で、
変数 b は "太郎君" への目印です。
そのため 「"はじめまして。#{a}、#{b}。"」 の #{a} には
"こんにちは" が埋め込まれ、#{b} には
"太郎君" が埋め込まれます。
その結果、"はじめまして。こんにちは、太郎君。" となり、
それが puts で表示されます。

これで少し馴れてきたと思います。
CGI プログラムでも試してみましょう。
[http://localhost:8080/foo3.rb](http://localhost:8080/foo3.rb) にアクセスしてみて下さい。


```ruby
#!/usr/local/bin/ruby

print "Content-Type: text/html\n\n"

a = 1
b = 2
c = a + b
print "a = #{a}\n"
print "b = #{b}\n"
print "c = #{c}\n"

```

![foo3.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-4/foo3.jpg)

a = 1 b = 2 c = 3 と表示されます。
7行目までが実行された時点で
変数 a が 1、変数 b が 2、変数 c が 3 への目印となっています。
8-10 行ではそれらの変数が指すデータを
文字列に埋め込んで ブラウザに表示させます。

## HTML を表示する CGI プログラム

foo2.rb の CGI プログラムへのリンクを持った HTML を表示させます。
これまで CGI プログラムで HTML を表示させていませんから、
ここで HTML を表示させる練習をしておきましょう。

[http://localhost:8080/foo4.rb](http://localhost:8080/foo4.rb) にアクセスしてみて下さい。

foo4.rb は下の HTML と同じ内容を表示します。
![foo4.html]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-4/foo4.html)

foo4.rb

```ruby
#!/usr/local/bin/ruby

print "Content-Type: text/html\n\n"

print "<html>\n"
print "<head><title>foo4.rb</title></head>\n"
print "<body>\n"

print "<a href='foo2.rb'>foo2.rb</a>\n"

print "</body>\n"
print "</html>\n"

```
![foo4.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-4/foo4.jpg)

foo4.rb では文字を何回かに分けて print で HTML を表示させます。
もう少し簡単に表示する方法もありますが、
今回はこのような方法をとります。
print の代わりに puts を使ったり、
他の CGI プログラムへのリンクに変更したり、
色々改造して遊んでみて下さい。

## 複数の画像から一つの画像を選んで表示する CGI プログラム

今号の最終目的です。ようやくここまでたどり着きました。
最後ですから気合を入れ直して CGI プログラム作りに取り組んで下さい。
今までよりはかなり難しいです。
ここでは今まで紹介してきた機能と rand 命令を使って
CGI プログラムを作ります。

ダウンロードしてもらった rubima011-cgi.zip の中には
cat0.jpg cat1.jpg cat2.jpg ... cat9.jpg という猫の画像が
C:\rubima011-cgi\images にあります。
この画像をランダムに一つ表示する CGI プログラムを作ります。

まずは rand 命令の説明をしましょう。
rand というのは乱数を作るための Ruby の命令です。
説明するより試した方が分かりやすいかもしれません。
下のプログラムを RDE で何回も実行して下さい。

{% highlight text %}
{% raw %}
a = rand 10
print a
{% endraw %}
{% endhighlight %}


0 以上 10 未満の整数が色々と表示されると思います。
rand というのは 0 以上の整数を一つだけ同じ確率で生成します。
rand の後ろの 10 というのは 0 以上 10 未満の整数という指定です。
もし、0 以上 5 未満の整数が必要なら

{% highlight text %}
{% raw %}
rand 5
{% endraw %}
{% endhighlight %}


とします。

これを使ってランダムに画像ファイルの名前を表示させてみます。
下のプログラムが images/cat0.jpg 〜 images/cat9.jpg
の画像へのリンクを表示させるプログラムです。
変数埋め込みと rand 命令を組み合わせていますね。

{% highlight text %}
{% raw %}
a = rand 10
print "images/cat#{a}.jpg"
{% endraw %}
{% endhighlight %}


ここまで出来たら HTML を表示する CGI プログラムと img タグの
組み合わせでランダムに画像を表示させることが出来ます。
実際のプログラムは下のようになります。
何回か [http://localhost/rubima011-cgi/foo5.rb](http://localhost/rubima011-cgi/foo5.rb) 
にアクセスしてみて下さい。
アクセスのたびに違う画像が表示されるでしょうか？

foo4.rb と大きく違うのは 9、10 行目だけですね。
その 2 行で rand と文字列の変数埋め込みを使っています。
これまでに説明した機能を使っているので、
どうしてこれで上手くいくのか是非自分で考えてみて下さい。


```ruby
#!/usr/local/bin/ruby

print "Content-Type: text/html\n\n"

print "<html>\n"
print "<head><title>foo5.rb</title></head>\n"
print "<body>\n"

a = rand 10
print "<img src=\"images/cat#{a}.jpg\">\n" 

print "</body>\n"
print "</html>\n"


```

![foo5.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-4/foo5.jpg)

## 後片付け

これで今号の CGI プログラムはすべて紹介しました。
後片付けをして CGI プログラム作りを終わりましょう。

RDE を実行している人はメニューの ファイル → 終了 を選んで下さい。
コマンドプロンプトが残っている人はサーバーが起動しっぱなしです。
サーバーを終了させましょう。
コマンドプロンプトの右上の×ボタンを押して下さい。
他の Ruby プログラムを実行していない場合は
Ctrl + Alt + delete で Windows のタスクマネージャーを出して、
そこから ruby.exe を選んで終了させることも出来ます。

もし、付録ページの内容に従ってファイヤーウォールを無効化している人がいたら
それを有効化しておきましょう。

## おわりに

最後の CGI プログラムまでたどりつけたでしょうか？　
少し工夫して CGI プログラムを作れば
動きのある Web ページの作成が可能であることが分かると思います。
今号は CGI プログラムの作り始めなので、
内容を分かり易くするためにいい加減な説明を一杯しています。
余裕のある方はいい加減な説明がどこにあるのか探してみて下さい。
今後、連載中に余裕があればもう少しきちんとした説明を行いたいと思います。

次回は HTML のフォームを使った CGI プログラムを作って
それを公開用サーバーに設置してみます。

## 参考文献 というか リンク

HTML に書かれた文章です。筆者の見解に基づいて
下にいくほど難しくなるように並べています。

* [はじめてのWebドキュメントづくり](http://www.asahi-net.or.jp/%7Esd5a-ucd/www/)
* [初心者のためのホームページ作成講座 ](http://members.jcom.home.ne.jp/jintrick/Personal/markup.html)
* [ごく簡単なHTMLの説明 -- 30分間(X)HTML入門 ](http://www.kanzaki.com/docs/html/lesson1.html)
* [Webページを作る心がけ](http://www.hyuki.com/writing/pagemake.html)
* [HTML 4.01仕様書邦訳](http://www.asahi-net.or.jp/~sd5a-ucd/rec-html401j/cover.html)
* [HTML 4.01 Specification](http://www.w3.org/TR/1999/REC-html401-19991224/)


CGI の枠組みについて書かれた文章へのリンクです。
本当はこれらの文章を見ながら CGI プログラムを作るのが望ましいのですが、
初めてプログラムを作る人が読むには難しいと思います。
今はこういう文章が存在するということだけ覚えておいて下さい。

* [The Common Gateway Interface (CGI) Version 1.1 RFC3875 日本語訳 ](http://suika.fam.cx/~wakaba/-temp/wiki/wiki?RFC%203875)
* [The Common Gateway Interface (CGI) Version 1.1 RFC3875 ](http://www.ietf.org/rfc/rfc3875)
* [The WWW Common Gateway Interface Version 1.1 日本語訳 ](http://www.nilab.info/docs/cgi/draft-coar-cgi-v11-03-clean-jp.html)
* [The WWW Common Gateway Interface Version 1.1 ](http://cgi-spec.golux.com/draft-coar-cgi-v11-03-clean.html)


Ruby

* [オブジェクト指向スクリプト言語 Ruby](http://www.ruby-lang.org/ja/) Ruby の 本家サイトです。分からないことがあれば、ここにあるリファレンスマニュアルを参照……して欲しいのですが、初めての人には少し難しいかもしれません。
* [FirstStepRuby](https://github.com/rubima/rubima/blob/master/first_step_ruby/first-step-ruby-2.0.md) Ruby を習い始める時の情報がまとまっています。今号で Ruby のインストールは済んだので、チュートリアルや書籍の情報を参照すると良いでしょう。
* [Ruby で CGI を作ろう](http://www.rubycgi.org/cgi_explanation/index.htm)  Ruby で CGI プログラムを作ろうというサイトです。対象が Ruby-1.6.x であるため内容が古くなってきています。


## 謝辞

この記事をレビューしてくださった方々、
本当にありがとうございました。
アルファベット順 (漢字の方はローマ字に変換) でお名前を
掲載させて頂きます。

* hatamoto さん
* 小波秀雄 さん
* ｍｒさん
* 徳冨 さん
* その他、レビューしてくださった方々


また、今回は編集者の方々には大変お世話になりました。
心よりお礼申し上げます。

## 筆者について というか 猫について

CGI プログラムで使った写真は筆者の実家の猫をデジカメで取ったものです。
白い方が雌で、縞がある方が雄です。
体格は縞のある方が大きいのですが、
2 匹でケンカをすると白い方が勝ってしまいます。
お転婆さんで困ったものです(でも、可愛いんですよ)。

## バックナンバー

{% for post in site.tags.CGIProgrammingForRubyBeginners %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}

[目次ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners %})
[前ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-3 %})
[付録ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-Appendix %})


