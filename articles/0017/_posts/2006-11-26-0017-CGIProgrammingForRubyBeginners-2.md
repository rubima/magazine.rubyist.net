---
layout: post
title: Ruby ビギナーのための CGI 入門 【第 5 回】文字コードと排他処理 2 ページ
short_title: Ruby ビギナーのための CGI 入門 【第 5 回】文字コードと排他処理 2 ページ
tags: 0017 CGIProgrammingForRubyBeginners
---
{% include base.html %}


[前のページへ]({% post_url articles/0017/2006-11-26-0017-CGIProgrammingForRubyBeginners-1 %})
[目次へ]({% post_url articles/0017/2006-11-26-0017-CGIProgrammingForRubyBeginners %})
[次のページへ]({% post_url articles/0017/2006-11-26-0017-CGIProgrammingForRubyBeginners-3 %})

## 目次

* Table of content
{:toc}


## 掲示板の今回の変更点

すでに述べたようにここからは文字コードの処理、
排他処理を行っていきます。
今回の改造はこの 2 点に絞ります。

先に変更後の掲示板のファイル構成を説明しておきます。
今号の rubima017-cgi.zip を解凍すると、その中には bbs, old_bbs の 2 つフォルダがあります。
old_bbs には前回の掲示板が、bbs には今号の修正後の掲示板があります。
今号の修正点に関してはそれぞれのフォルダの対応するファイルを見てもらうことになります。

bbs フォルダの中には

* bbs01.rb
* update01.rb
* update02.rb
* bbs.html
* theme


があります。
bbs01.rb、update01.rb、update02.rb は
文字コードや排他処理の修正後の bbs.rb や update.rb になります。
詳しい変更点については本文を参照して下さい。

old_bbs フォルダには

* bbs.rb
* update.rb
* bbs.html
* theme


があります。
old_bbs の bbs.rb は前回の掲示板の bbs02.rb の名前を bbs.rb に変更するように修正しています。
他は前回と変わりません。

## 文字コードの処理

最初に文字コードの処理を行いましょう。

すでに説明したように CGI プログラムでは
フォームデータの文字コードは決まっていません。
そのため文字コードのことを考えずにフォームデータを処理すると、
文字化けが起きたり、色々と不都合が起きます。
そのためにフォームデータの文字コードを変換して、
実質 1 つの文字コードを扱えば良いという状況にしていきます。

方言の例えで説明してみましょう。
日本には様々な方言があり、それらが混在した文章を見せても
ほとんどの人にとってはチンプンカンプンでしょう。
しかし、標準語の日本語に翻訳してやれば読めるようになります。
これと同じことを文字コードでも行います。

では、どの文字コードにまとめるのが良いのでしょうか。
この連載を読んでいる人は Windows を使っている人が多いでしょう。
そういった点では Shift_JIS が一番便利だと思います。
しかし、CGI プログラムでは Shift_JIS だと、少々困ることがあります。
そのためこの連載では EUC-JP をお勧めします。

### フォームデータの文字コードを変更

まずは以前の update.rb を下に載せます。

update.rb 

```ruby
#!/usr/local/bin/ruby

require "cgi"

c = CGI.new
message = c["t"]

f = open("bbs.dat", "a") 
f.write(message + "\n")
f.close

print "Content-type: text/html\n\n"

print <<EOF
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
  <title>form</title>
</head>
<body>

書き込みありがとうございました。
<a href="bbs.rb">一行掲示板へ</a>

</body>
</html>
EOF

```

次に文字コードの変更に対応した update01.rb です。

update01.rb 

```ruby
#!/usr/local/bin/ruby

require "cgi"
require "kconv"

c = CGI.new
message = c["t"]

f = open("bbs.dat", "a") 
f.write(Kconv.toeuc(message) + "\n")
f.close

print "Content-type: text/html\n\n"

print <<EOF
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=euc-jp">
  <title>form</title>
</head>
<body>

書き込みありがとうございました。
<a href="bbs.rb">一行掲示板へ</a>

</body>
</html>
EOF

```

10 行目で Kconv を使って文字コードを EUC-JP に変更し、
それを bbs.dat に保存しています。
これで、bbs.dat には EUC-JP で書き込みが保存されていきます。
これで新規の投稿は EUC-JP で保存されます。

この変更を施しても、すでに bbs.dat に保存されているデータは元のままです。
すべての bbs.dat を EUC-JP にするには 古いデータを破棄するか、
古いデータを EUC-JP に変換するかのいずれかが必要になります。
今まではテスト運用しかしていないでしょうから、
古いデータを破棄するのが一番簡単でしょう。

ここで変更したのはわずか 1 行です。
文字コードの変換は Kconv にお任せなので、やり方さえ分かれば、変更自体は簡単です。
むしろ問題はプログラムのどこで文字コードの変換が必要なデータが生じるかという点でしょう。
掲示板のような小さなプログラムであれば、
文字コードの変換が必要なデータが生じる部分は少ないのですが、
プログラムが大きくなるにつれ
文字コードの変換が必要な部分が多くなってきます。

文字コードの分からないデータはフォームデータや
自分のプログラムが作っていないファイルの内容を読み込んだ時などに生じますが、
これはプログラムを作る皆さんが自分で把握しなければなりません。
自分で CGI プログラムを作る時は注意しましょう。

### 掲示板の各ファイルの文字コード

掲示板を構成するファイルは

* update.rb
* bbs.rb
* bbs.dat
* bbs.html


の 4 つです。

これらのファイルの文字コードもすべて EUC-JP に統一します。
bbs.dat は先ほどの変更ですでに対応が済んでいます。
そのため残った 3 つのファイルの文字コードを EUC-JP に変更します。
bbs.dat だけ EUC-JPに変わっても
他のファイルの文字コードが Shift_JIS だと、
文字コードが混在してしまい文字化けの原因になりますからね。

手動で文字コードを変換する時には
[@IT 文字コードを変換する](http://www.atmarkit.co.jp/fwin2k/win2ktips/395codeconv/codeconv.html)
に説明がありますので、そちらを参考にしてください。

ファイルの文字コード以外にも修正するところがあります。
掲示板の各ファイルには HTML の文字コードが
何であるかを示した部分がところどころにあります。
例えば、bbs.html の場合、

{% highlight text %}
{% raw %}
 <meta http-equiv="Content-Type" content="text/html; charset=euc-jp">
{% endraw %}
{% endhighlight %}


上のように meta タグの content 属性に charset という
文字コードを指定する部分があります。
この連載では今まで文字コードはすべて Shift_JIS でしたので、
この部分は Shift_JIS でした。

今号からは EUC-JP に統一しますので、
上記のような HTML の meta タグの部分もすべて EUC-JP に変える必要があります。
update.rb や bbs.rb では HTML を表示させるので、
こうした部分の meta タグも変更しなくてはいけません。
気をつけて下さい。

### おまけ - NKF について

ここからは少し難しいことを説明していきます。
余裕がある人は読んでもらったら良いですが、
そうでない人は後回しでも構いません。

実は Kconv は自分で文字コードの変換をしていません。
内部で NKF という機能を利用しているだけです。
nkf という日本語の文字コードを変換するプログラムがあり、
そのプログラムを利用して Ruby から使えるようにしたのが NKF です。
通常の使用なら Kconv で十分ですが、
文字コードの変換の際に細かい調整をするなら NKF を直接使用しなければなりません。

実は Kconv には問題があります。
詳細は説明しませんが、Kconv で文字コード変換をする時には
内容についても若干の変換がなされてしまいます。
そうした細かい変換が気に入らないという人は require "kconv" の後ろに下記の

{% highlight text %}
{% raw %}
 module Kconv

   def self.toeuc(s)
     ::NKF.nkf('-exm0', s)
   end

   def self.tosjis(s)
     ::NKF.nkf('-sxm0', s)
   end

   def self.tojis(s)
     ::NKF.nkf('-jxm0', s)
   end

 end
{% endraw %}
{% endhighlight %}


というプログラムを加えることで Kconv の問題を回避することが出来ます。
この部分は難しいので、今はプログラムの内容を理解できなくても構いません。

## 排他処理

ここからは排他処理を行っていきます。

前ページでは触れませんでしたが、
読み込み、書き込みによって flock の使い方が若干異なります。
注意して下さい。

### File::LOCK_EX, File::LOCK_SH

前ページでは File オブジェクトの flock メソッドを使って排他処理を行いました。
その際、flock の引数に File::LOCK_EX という File クラスの定数を使用しました。
ここでは flock に指定できる定数について見ていきましょう。

まず File::LOCK_EX です。
この定数は前ページでも使いました。
File::LOCK_EX を flock の引数に指定すると、
File オブジェクトが指すファイルは同時に 1 つしか開けません。
このため File::LOCK_EX はファイルへの書き込みをする時に
指定することが多くなります。

File::LOCK_SH は同じファイルを同時に開いても構わない時に指定します。
ファイルへの書き込みがなければ、
ファイルを何度読み込んでも同じデータが得られるわけですから、
同時にファイルを開いても問題は起きません。
例えば、bbs.rb は掲示板を表示するだけなので、
File::LOCK_SH を利用することになります。
ちなみに、LOCK_SH が指定されている間は
書き込みを防ぐために LOCK_EX による flock は処理待ちになります。
この点は注意が必要です。

flock に指定する定数に関してはこの 2 つを知っておけば
困ることは少ないでしょう。

### update.rb の改造

最初に update.rb の改造を行います。
update.rb の排他処理には前ページと同じく File::LOCK_EX を使います。
排他処理の修正後のファイル名は update02.rb です。

update.rb は行数が多いので、排他処理を行う部分だけを下に載せます。
flock に LOCK_EX を指定して
bbs.dat を同時に開けないようにしています。

update02.rb

{% highlight text %}
{% raw %}
f = open("bbs.dat", "a")
f.flock(File::LOCK_EX)
f.write(Kconv.toeuc(message) + "\n")
f.close
{% endraw %}
{% endhighlight %}


### bbs.rb の改造

次に bbs.rb です。
こちらは書き込みを行わないので、先ほどの説明のように LOCK_SH を使います。
排他処理の修正後のファイル名は bbs01.rb です。

LOCK_SH を指定すると、LOCK_SH の効果がなくなるまで
LOCK_EX は出来なくなります。
こうすることでファイルの内容が突然変わることを防ぐことが出来ます。

では、LOCK_SH を指定する場合についても見てみましょう。
bbs.rb も flock の部分を抜粋するだけにとどめます。
排他処理の部分で違うのは 1 行 だけです。

bbs01.rb 

{% highlight text %}
{% raw %}
f = open("bbs.dat", "r")
f.flock(File::LOCK_SH)
arr = []
l = f.gets

while l
  arr << CGI.escapeHTML(l)
  l = f.gets
end
f.close
{% endraw %}
{% endhighlight %}


これとは別にファイル名を bbs01.rb に変更するために 5 行目を

{% highlight text %}
{% raw %}
filename = "bbs01.rb"
{% endraw %}
{% endhighlight %}


としていますが、これは排他処理とは関係ありません。

[前のページへ]({% post_url articles/0017/2006-11-26-0017-CGIProgrammingForRubyBeginners-1 %})
[目次へ]({% post_url articles/0017/2006-11-26-0017-CGIProgrammingForRubyBeginners %})
[次のページへ]({% post_url articles/0017/2006-11-26-0017-CGIProgrammingForRubyBeginners-3 %})


