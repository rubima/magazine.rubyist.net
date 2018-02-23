---
layout: post
title: Ruby ビギナーのための CGI 入門 【第 1 回】 3 ページ
short_title: Ruby ビギナーのための CGI 入門 【第 1 回】 3 ページ
tags: 0011 CGIProgrammingForRubyBeginners
---
{% include base.html %}


[目次ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners %})
[前ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-2 %})
[次ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-4 %})

* Table of content
{:toc}


## Ruby のプログラムに馴れよう

準備も済んだし早速 CGI プログラムを作る……というのも良いのですが、
Ruby に馴れていない状態で
Ruby で書かれた CGI プログラムを読んだり書いたりしても
なかなか理解出来ないでしょう。
CGI プログラム作りの前に
先に Ruby でプログラムを作るために
最低限必要な Ruby の基本を学びます。

私たちが話す言葉と同じで
Ruby にも文法や規則のようなものがあります。
こういった文法や規則は馴れることが重要です。
これから Ruby のプログラムを幾つか紹介するので、
出来るだけ皆さん自身でそのプログラムを
RDE に打ち込んで実行し結果を確かめて 
Ruby に馴れて下さい。

### Ruby のプログラムを実行しよう

初めに Ruby のプログラムを実行する方法を紹介します。
Ruby のプログラムを実行する方法は幾つかありますが、
ここでは RDE から Ruby のプログラムを実行する方法を紹介します。
その手順は下のようになります。

1. Ruby のプログラムを RDE で開く
1. メニューの 実行 → 実行 を選択する


試しにやってみましょう。
C:\rubima011-cgi\ というフォルダーに 
print.rb という Ruby プログラムがあります。
これを使います。

まずは print.rb を RDE で開きます。
メニューの ファイル → 開く から print.rb を選びます。
これで下と同じ内容が RDE に表示されます。

{% highlight text %}
{% raw %}
print 123
{% endraw %}
{% endhighlight %}


この print.rb というプログラムは 123 を表示します。
実行して確認してみましょう。
メニューの 実行 → 実行 を選択します。

プログラムが実行されると、
RDE の下の方にあるコンソールウィンドウの色が変わり、
その後に 123 と表示されます。
「Completed」も表示されていますが、これは RDE が print.rb の
実行が終了したよということを表示しています。
![rde_execute.jpg]({{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-3/rde_execute.jpg)

RDE に Ruby プログラムを入力して
それを保存してから、実行する方法もあります。
具体的には下のような手順になります。
この方法は次の節で紹介します。

1. Ruby のプログラムを RDE に打ち込む
1. ファイルに保存する
1. メニューの 実行 → 実行 を選択する


Ruby プログラムの実行方法を覚えないと、
プログラムを書くことも試すことも出来ません。
自分で何度か試して実行方法を身につけましょう。

### Ruby のプログラムでデータを表示しよう

Ruby プログラムの実行方法が分かったところで
Ruby プログラムでデータを表示する方法を覚えましょう。
CGI プログラムでは数値や文字などのデータ (主に HTML) を表示することが多く、
データを表示出来なければ CGI プログラムを作ることが出来ません。

先ほど print.rb で 123 という数値を表示させましたね。
そこで使われた print というのがデータを表示する方法の一つです。
試しに print.rb を自分で作って print を使ってみましょう。

RDE でメニューの ファイル → 新規作成 を選ぶと、
新しいファイルを編集することが出来るようになります。
そこに「 print 123 」と打ち込んで 
メニューの ファイル → 保存 を選んで
print1.rb として保存します。
保存したらメニューの 実行 → 実行を選んで下さい。
print.rb と同じように 123 と表示されます。

print の使い方をもう少し詳しくみてみましょう。
print は下のように使います。

{% highlight text %}
{% raw %}
print (データ)
{% endraw %}
{% endhighlight %}


print は (データ) で指定されたデータを表示する Ruby の命令です。
「print 123」の例では 123 が (データ) に相当します。 
(データ) の部分には色々な種類のデータを指定することが可能です。
文字や数値などはその一例です。

違い例でも試してみましょう。
下の内容を print.rb と同じように実行してみて下さい。
この Ruby プログラムは整数・小数・文字を表示させます。

{% highlight text %}
{% raw %}
print 123
print 12.4
print "s"
{% endraw %}
{% endhighlight %}


"s" というのはアルファベットの小文字の s を表します。
文字についてはこのすぐ後で説明するので、
今はこういうものだと思って下さい。
上のプログラムを実行すると下のように表示されます。

{% highlight text %}
{% raw %}
12312.4s
{% endraw %}
{% endhighlight %}


何故このように表示されるのでしょうか？
Ruby のプログラムを実行すると、
その内容が上から順番に実行されます。
上の場合なら

1. print 123
1. print 12.4
1. print "s"


という順番ですね。これを頭の中で順に実行してみましょう。
1 行目が実行された段階では

{% highlight text %}
{% raw %}
123
{% endraw %}
{% endhighlight %}


と表示されます。
次に 2 行目が実行されると、

{% highlight text %}
{% raw %}
12312.4
{% endraw %}
{% endhighlight %}


と表示されます。
print は前に表示されたデータのすぐ後ろに
データを表示するので、
上のように 123 と 12.4 がつながってしまいます。
最後の 3 行目が実行されると、

{% highlight text %}
{% raw %}
12312.4s
{% endraw %}
{% endhighlight %}


となります。皆さんの中には
下のように複数行に表示されると思った人もいるでしょう。

{% highlight text %}
{% raw %}
123
12.4
s
{% endraw %}
{% endhighlight %}


このように表示することも可能ですが、
それには Ruby における文字について学ばなければなりません。

### 文字 (文字列) で遊んでみよう

CGI では頻繁に HTML を表示します。
その HTML というのは文字の集まり(文字列)です。

例えば、

{% highlight text %}
{% raw %}
<html>
<head></head>
<body>Ruby</body>
</html>
{% endraw %}
{% endhighlight %}


という HTML 
(HTML の文法からみると良い HTML ではありませんが、
説明を簡単にするためにこの HTML を使います) 
はアルファベットや「&lt;」「&gt;」「/」などの文字の集まりです。

皆さんが作る CGI プログラムでは多くの場合、HTML を扱います。
HTML を扱うということは文字処理を行うということになり、
CGI プログラムでは文字処理は避けて通れません。
そこで、ここでは Ruby で文字列を作る方法やその表示方法を学んでおきましょう。

ところで、先ほど文字列という言葉が出てきましたね。
文字列というのは簡単に言えば文字の集まりのことです。
プログラムの解説では文字列という言葉を使うので、
この連載でも今後は文字列という表現を使います。
覚えておいて下さい。

では、最初は文字列を作ってみましょう。
Ruby で文字列を作るのはとても簡単です。
文字列にしたい部分を「'」や「"」で囲います。
今回は、「"」で囲んだ文字列について説明します。

まず、RDEに下の内容を打ち込んで、実行してみて下さい。

{% highlight text %}
{% raw %}
print "<html><head></head><body>Ruby</body></html>"
{% endraw %}
{% endhighlight %}


どうでしょうか？期待したように表示されましたか？
おそらく上に書いた HTML と違って、
一行にまとめて出力されてしまったことと思います。
では、複数行に表示させるにはどうすれば良いでしょうか？
いくつか方法がありますが、ここでは
print で改行を表示させる方法をとることにします。

メモ帳や Microsoft Word で行を変える時に「Enter」キーを
押して行をかえますよね。
あれは「Enter」キーを押すことで
メモ帳や Word に改行を入力しているから行がかわるのです。
同様に print で改行を表示させると、
その後に表示されるデータは次の行から表示されます。
これを使って HTML を複数行に表示しましょう。

Ruby では文字列を「"」で囲んだ場合、
改行を「\n」と書く決まりになっています。
このことを使って例で示した HTML を表示させてみます。

{% highlight text %}
{% raw %}
print "<html>\n"
print "<head></head>\n"
print "<body>Ruby</body>\n"
print "</html>\n"
{% endraw %}
{% endhighlight %}


今度はちゃんと複数行に表示されたと思います。

次に下の内容を RDE で実行してみて下さい。
「12312.4s」を複数行に表示させるという先ほど質問の答えがこれです。
「\n」は単独で使うことも出来ます。

{% highlight text %}
{% raw %}
print 123
print "\n"
print 12.4
print "\n"
print "s"
print "\n"
{% endraw %}
{% endhighlight %}


Ruby には puts という命令があり、
これを使うと最後に改行が無い場合に改行を追加してくれます。
先ほどの HTML を puts で表示させてみましょう。

{% highlight text %}
{% raw %}
puts "<html>"
puts "<head></head>"
puts "<body>Ruby</body>"
puts "</html>"
{% endraw %}
{% endhighlight %}


ところで、「"」で文字列を作ると言いましたが、
「"」そのものを表示させたい場合はどうしたら良いのでしょうか？
答えは「\\"」です。下の内容を RDE 打ち込んで実行してみて下さい。
3 つ目の「"」が文字列の区切りになっていて、
2 つ目の「\\"」は「"」と表示されていますね。

{% highlight text %}
{% raw %}
print "文字列にしたい部分を\"で囲むと、Ruby はそれを命令や変数ではなく文字列として扱います。\n"
{% endraw %}
{% endhighlight %}


「"」で囲われた文字列では「\\"」「\n」以外にも
「\」とそれに続く一文字に特別な意味を持つ場合があります。
それに関しては別の機会に紹介することにします。

最後に下のようなプログラムを考えてみましょう。

{% highlight text %}
{% raw %}
puts "abc" + "123"
{% endraw %}
{% endhighlight %}


「abc123」と表示されますね。
このプログラムでは最初に "abc" + "123" が実行され、
その後にその結果が puts で表示されます。

文字列同士の足し算というのは Ruby では文字列の結合を意味するので、
下の二つは計算の結果同じデータになります。

{% highlight text %}
{% raw %}
"abc" + "123"
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
"abc123"
{% endraw %}
{% endhighlight %}


文字列同士の足し算を先に行うということを考えると、
上のプログラムの流れは下のようになります。

1. "abc" + "123" を計算する
1. "abc123" という結果になる
1. "abc123" が puts で表示される


プログラムは上から順番に 1 行づつ実行されますが、
同じ行の中でも実行される順番があります。
詳しい事はまた説明しますが、
「+」は print や puts よりも先に実行されるということを
覚えておいて下さい。

### まとめ

ここでは Ruby のプログラムの作り方やその実行方法、
文字列、 print, puts という Ruby の命令を紹介しました。

Ruby には print や puts 以外にも沢山の命令があります。
Ruby のプログラムを作る時は print, puts のような Ruby の命令を
いくつか組み合わせて自分の望む動作を行わせます。
CGI プログラムを作る時も全く同じです。
大きく違うのは CGI というルールに従わなければならない点です。

[目次ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners %})
[前ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-2 %})
[次ページへ]({% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-4 %})


