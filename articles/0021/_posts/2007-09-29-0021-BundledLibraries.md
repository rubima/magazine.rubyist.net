---
layout: post
title: 標準添付ライブラリ紹介 【第 14 回】 正規表現 (3)
short_title: 標準添付ライブラリ紹介 【第 14 回】 正規表現 (3)
tags: 0021 BundledLibraries
---


書いた人：西山

## はじめに

Ruby には便利な標準添付ライブラリがたくさんありますが、なかなか知られていないのが現状です。そこで、この連載では Ruby の標準添付ライブラリを紹介していきます。

今回も正規表現についての話の続きです。

## オプション

正規表現のオプションとは、リテラルの場合は「/ruby/i」のように書いたときの「i」などのことで、
「Regexp.new('ruby', 'i')」や「Regexp.new('ruby', Regexp::IGNORECASE)」のように Regexp.compile や Regexp.new の第 2 引数で指定することもできます。

オプションは正規表現の途中で「/(?i:r)uby/」のように書くことで一時的に変更できるものもあります。
これは「/〜/.to_s」で「(?-mix:〜)」のように使われていているのを見たことがあるかもしれません。ここでは一時的に m と i と x オプションを無効にするという意味になっています。
たとえば

{% highlight text %}
{% raw %}
re = /hoge/
p /foo #{re} bar/i #=> /foo (?-mix:hoge) bar/i
{% endraw %}
{% endhighlight %}


のように他の正規表現に埋め込んだときに /hoge/ の部分は i オプションが無効になります。

### i オプション

i オプションは大文字小文字を区別しない (同一視する) という意味です。

「/abc/i」や「/ABC/i」で「abc」にも「ABC」にも「Abc」にも「aBC」にもマッチするようになります。つまり、以下の例はすべてマッチします。

{% highlight text %}
{% raw %}
/abc/i =~ "abc"
/abc/i =~ "ABC"
/ABC/i =~ "abc"
/ABC/i =~ "ABC"
/ABC/i =~ "Abc"
/ABC/i =~ "aBC"
{% endraw %}
{% endhighlight %}


ただし 1.8 では「/Ａ/i =~ "ａ"」のようないわゆる全角文字の大文字小文字は区別されます。
1.9 以降ではこのような場合でもマッチすることがあるようです。(encoding 依存かもしれません。)

{% highlight text %}
{% raw %}
% ruby18 -v -Ku -e 'p(/Ａ/i =~ "ａ")'
ruby 1.8.6 (2007-09-01 patchlevel 5000) [i686-linux]
nil
% ruby-trunk -v -Ku -e 'p(/Ａ/i =~ "ａ")'
ruby 1.9.0 (2007-09-01 patchlevel 0) [i686-linux]
0
%
{% endraw %}
{% endhighlight %}


### n,s,e,u オプション

正規表現オブジェクトはグローバルな $KCODE とは別に kcode を持っています。
その kcode を設定するのが n,s,e,u オプションです。

{% highlight text %}
{% raw %}
p //.kcode #=> nil
p //n.kcode #=> "none"
p //s.kcode #=> "sjis"
p //e.kcode #=> "euc"
p //u.kcode #=> "utf8"
{% endraw %}
{% endhighlight %}


指定しなかった場合は上の例のように nil になります。
その場合はマッチ時の $KCODE の値を使うという意味になります。

バイナリデータとしてマッチしたいときに n を使ったり、$KCODE が UTF8 とは限らないプログラムの中で UTF-8 の XML などを処理するときに u を使ったりすることがあります。

m,i,x オプションと違って kcode 関係オプションは正規表現を「#{}」で埋め込むときなどに混ぜることは出来ません。
Regexp#to_s で残らないので、外側の正規表現の kcode だけになってしまいます。

{% highlight text %}
{% raw %}
p //e       #=> //e
p //e.to_s  #=> "(?-mix:)"
p /#{//e}/s #=> /(?-mix:)/s
{% endraw %}
{% endhighlight %}


### x オプション

x オプションを使うと正規表現の中に空白やコメントを入れて読みやすく書くことが出来るようになります。

マッチさせたい空白を入れたい場合は「\」でエスケープして「\ 」のように書きます。
目的によっては「[ ]」のように文字クラスを使ったりいわゆる半角空白に限定しなくても良いなら「\s」を使ったりすると読みやすくなるかもしれません。

コメントはエスケープされていない「#」から行末までです。
正規表現リテラルの中では、コメント中でも正規表現リテラルの区切り文字をそのまま書くと正規表現リテラルが閉じられて SyntaxError などの原因になることがあるので注意してください。

openssl/x509.rb では

{% highlight text %}
{% raw %}
        AttributeValue = /
          (?!["#])((?:#{StringChar}|#{Pair})*)|
          \#(#{HexString})|
          "((?:#{QuoteChar}|#{Pair})*)"
        /x
{% endraw %}
{% endhighlight %}


のように使われています。
この例では空白を入れるだけコメントは使っていませんが、「#」にマッチさせたいのでエスケープして書いています。
式展開は正規表現のコンパイル前で、空白文字やコメントの無視はマッチ時なので式展開の「#」はそのまま書かれています。

### o オプション

o オプションを付けると、一番最初に正規表現の評価が行われた時に一度だけ式展開され、同じ正規表現オブジェクトを返すようになります。
速度を最適化するためのオプションで、誤用されることもあるようなので、必要かどうかわからなければ付けないことをお勧めします。

jcode.rb ではこのように使われています。

{% highlight text %}
{% raw %}
  def end_regexp
    case $KCODE[0]
    when ?s, ?S
      /#{PATTERN_SJIS}$/on
    when ?e, ?E
      /#{PATTERN_EUC}$/on
    when ?u, ?U
      /#{PATTERN_UTF8}$/on
    else
      /.$/on
    end
  end
{% endraw %}
{% endhighlight %}


上の 3 個は PATTERN_SJIS などの式展開の内容が定数で固定なので、毎回正規表現オブジェクトを生成しなおすのは無駄なので正しい使い方です。
下の「/.$/on」はパターン部分がリテラルで固定文字列なので o オプションがなくても毎回同じ正規表現オブジェクトになるため、o オプションは不要です。他とあわせるためにあえて付けているとも考えられるので、この例では誤用とまではいいきれません。

base64.rb ではこのように誤用されていました。(すでに報告済みで現在は直っているので、最新のリリースでは修正されているはずです。)

{% highlight text %}
{% raw %}
  def b64encode(bin, len = 60)
    encode64(bin).scan(/.{1,#{len}}/o) do
      print $&, "\n"
    end
  end
{% endraw %}
{% endhighlight %}


これは len という毎回変化する可能性のある式を式展開で埋め込んでいるのに o オプションを使っているので、以下のように len の値が変わるように呼び出すと、最初の len の値で生成された正規表現が毎回使われてしまいます。

{% highlight text %}
{% raw %}
require 'base64'
Base64.b64encode("a"*100)
Base64.b64encode("a"*100, 10)
{% endraw %}
{% endhighlight %}


### m オプション

m オプションは「.」が改行にもマッチするようになります。
複数行モードという呼び方もあるようですが、Perl などの他の言語とは意味が違います。

Ruby の m オプションは Perl の正規表現の s オプション (単一行モード) と同じ意味です。Java の java.util.regex.Pattern の DOTALL や C# の System.Text.RegularExpressions の Singleline に相当します。
Perl の m オプション (複数行モード) は「^」と「$」が Ruby の正規表現の「\A」と「\Z」相当から「^」と「$」相当に変わるという意味です。Java の java.util.regex.Pattern の MULTILINE や C# の System.Text.RegularExpressions の Multiline に相当します。
現在の Ruby の正規表現では「^」と「$」が「\A」と「\Z」の意味になることはありません。昔は p オプションというものがありましたが、今は気にしなくても良いでしょう。

## % 記法

正規表現リテラルは % 記法でも書くことができます。

「%r!https?://!」や「%r!/usr/(local/)?bin/ruby!」のように「/」を含む場合に使うと読みやすく書けます。

「%Q!!」に対応する「%q!!」のような式展開をしないものはありません。

詳しいことはリファレンスマニュアルなどを参照してください。

## base64

o オプションのところでちょっと話題に出した base64 について紹介します。

base64 を使うと Base64.encode64 と Base64.decode64 で簡単に Base64 の変換が出来ます。

{% highlight text %}
{% raw %}
require "base64"
enc = Base64.encode64("some string")
puts enc                  #=> c29tZSBzdHJpbmc=
puts Base64.decode64(enc) #=> some string
{% endraw %}
{% endhighlight %}


中で pack と unpack をしているだけなので、60 オクテットごと (と最後) に改行コードが付加されるのは pack の m の仕様のままです。

## まとめ

今回は正規表現のオプションについてと base64 の紹介を書きました。

kcode まわりの挙動は m17n が入って 1.9 では今後変わっていくはずなので、[The RWiki の m17nQuestions](http://pub.cozmixng.org/~the-rwiki/rw-cgi.rb?cmd=view;name=m17nQuestions) などをチェックしておくといいかもしれません。

## 著者について

西山和広。

base64 のバグは[第 17 回 Ruby 勉強会＠関西](http://jp.rubyist.net/?KansaiWorkshop17)の Q&amp;A セッションのときに気付いて、その場で報告メールを ruby-dev に投げました。そのときの話が今回の記事のきっかけになりました。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}


