---
layout: post
title: 標準添付ライブラリ紹介 【第 11 回】 zlib
short_title: 標準添付ライブラリ紹介 【第 11 回】 zlib
tags: 0018 BundledLibraries
---
{% include base.html %}


書いた人：西山

## はじめに

Ruby には便利な標準添付ライブラリがたくさんありますが、なかなか知られていないのが現状です。そこで、この連載では Ruby の標準添付ライブラリを紹介していきます。

今回は、zlib について紹介します。

## Ruby/zlib とは？

Ruby/zlib は zlib を Ruby から使うための拡張ライブラリです。
gzip ファイルの読み書きもサポートします。

### zlib とは？

zlib とは、gzip や PNG で使われている可逆圧縮アルゴリズムのライブラリです。
可逆圧縮とは、完全に元に戻せる圧縮です。
主にプログラムやテキストなどの内容が変わると困るものに使われています。

それに対して、完全には元に戻らない圧縮を不可逆圧縮 (非可逆圧縮) といい、画像や音声などで使われています。
zlib は可逆圧縮のみで不可逆圧縮は出来ません。

## Zlib::Deflate と Zlib::Inflate

Zlib::Deflate で圧縮、Zlib::Inflate で元に戻すことが出来ます。
元に戻すことは展開や伸張などとも言います。

### 簡単な使い方

クラスメソッドの Zlib::Deflate.deflate と Zlib::Inflate.inflate を使うと、扱えるものが String だけという違いはありますが、Marshal.dump と Marshal.load と同じような感じで、簡単に圧縮したり元に戻したり出来ます。

{% highlight text %}
{% raw %}
require 'zlib'
str = 'some string'
p str.size  #=> 11
data = Zlib::Deflate.deflate(str)
p data.size #=> 19
p Zlib::Inflate.inflate(data) #=> "some string"
str *= 100
p str.size  #=> 1100
data = Zlib::Deflate.deflate(str)
p data.size #=> 29
{% endraw %}
{% endhighlight %}


最初の 11 バイトしかない文字列の圧縮では逆にサイズが増えてしまっています。
これは元の文字列に無駄がほとんどなくて圧縮できないため、zlib が zlib のデータを区別出来るようにつけているヘッダによるオーバーヘッドによるサイズの増加の方が大きくなってしまっているためです。

次に圧縮の効果がわかりやすいように同じ文字列を 100 回繰り返した文字列を圧縮すると、しっかり圧縮できていることがわかります。

### 圧縮レベル

gzip コマンドでは、オプションで --fast や --best のように圧縮レベルを指定できます。
Zlib::Deflate.deflate も同じように第 2 引数で圧縮レベルを指定できます。

Zlib::BEST_SPEED は速度優先で圧縮率は低く、Zlib::BEST_COMPRESSION は圧縮率優先で速度は遅くなります。
Zlib::DEFAULT_COMPRESSION は第 2 引数を省略したときと同じで、Zlib::NO_COMPRESSION は圧縮しません。
圧縮しないというのは、既に圧縮されているものなど、さらに圧縮はほとんど期待できないものを Zlib に入れたい時に使うものだと思います。

{% highlight text %}
{% raw %}
require 'zlib'
str = 'some string'*100
p str.size                                                   #=> 1100
p Zlib::Deflate.deflate(str, Zlib::BEST_SPEED).size          #=> 32
p Zlib::Deflate.deflate(str, Zlib::BEST_COMPRESSION).size    #=> 29
p Zlib::Deflate.deflate(str, Zlib::DEFAULT_COMPRESSION).size #=> 29
p Zlib::Deflate.deflate(str, Zlib::NO_COMPRESSION).size      #=> 1111
{% endraw %}
{% endhighlight %}


ここではあらかじめ用意されている定数を使いましたが、0 から 9 の数値を直接指定することも出来ます。

### ストリームとして使う

今までの例では、文字列を直接圧縮や展開していたため、クラスメソッドを使っていました。

これらのクラスメソッドでは対象となる文字列が全てメモリ上に存在しないといけないため、巨大なデータを扱う場合にはメモリ消費量が大きくなってしまいます。このような場合には、Zlib::Deflate や Zlib::Inflate のオブジェクトを生成してストリームとして扱うとよいかもしれません。

Zlib::Deflate.new と Zlib::Inflate.new は Zlib::ZStream を継承していて、同じようにストリームとして使えます。

ここでは Zlib::Deflate の例だけ示しておきます。

{% highlight text %}
{% raw %}
require 'zlib'
z = Zlib::Deflate.new(Zlib::BEST_COMPRESSION)
data = ''
100.times do |i|
  data << z.deflate("some string")
end
data << z.finish
z.close
p data.size #=> 29
{% endraw %}
{% endhighlight %}


この使い方の場合、圧縮されたデータ全体は、毎回の Zlib::Deflate#deflate の返値と Zlib::Deflate#finish の返値をつなげたものになります。
Zlib::Deflate#deflate の返値だけや Zlib::Deflate#finish の返値だけでは圧縮されたデータにならないので注意してください。

その他のメソッドの使い方については、Ruby のリファレンスマニュアルや zlib 自体のドキュメントを参照してください。

## Zlib::GzipReader と Zlib::GzipWriter

Zlib::GzipReader で gz ファイルの読み込み、Zlib::GzipWriter で gz ファイルの書き込みが出来ます。

### Zlib::GzipReader

Zlib::GzipReader を使うと gz ファイルを普通のファイルと同じように読み込むことが出来ます。

ここでは、あらかじめ、

{% highlight text %}
{% raw %}
echo hoge > hoge
gzip -9 hoge
{% endraw %}
{% endhighlight %}


などで hoge.gz を用意しておくと次のように File.open と同じような感じで読み込むことが出来ます。
(gzip コマンドのない環境では、次項の Zlib::GzipWriter の例を元にして hoge.gz を作成してください。)

{% highlight text %}
{% raw %}
require 'zlib'
Zlib::GzipReader.open('hoge.gz') do |gz|
  p gz.read #=> "hoge\n"
end
{% endraw %}
{% endhighlight %}


あらかじめ IO オブジェクトがあって、その中に gzip のデータがある場合は、Zlib::GzipReader.wrap で読み込むことが出来ます。
バイナリデータを扱うため、あらかじめ wrap する IO オブジェクトは open のモードに 'b' を入れたり binmode を使ったりして、バイナリモードにしておく必要があることに注意してください。

{% highlight text %}
{% raw %}
require 'zlib'
File.open('hoge.gz', 'rb') do |f|
  Zlib::GzipReader.wrap(f) do |gz|
    p gz.read #=> "hoge\n"
  end
end
{% endraw %}
{% endhighlight %}


ここでは close 忘れの心配のないブロック付きの方法だけを紹介しましたが、File.open などと同じようにブロックなしで呼び出して、後から close するという使い方も可能です。
読み込み部分も read の他に each や gets など、IO の一般的なメソッドもあります。
詳しくはリファレンスマニュアルを参照してください。

### Zlib::GzipWriter

Zlib::GzipWriter を使うと普通のファイルと同じように書き込むことで gz ファイルを作ることが出来ます。

{% highlight text %}
{% raw %}
require 'zlib'
Zlib::GzipWriter.open('hoge.gz') do |gz|
  gz.puts 'hoge'
end
{% endraw %}
{% endhighlight %}


これで

{% highlight text %}
{% raw %}
echo hoge > hoge
gzip hoge
{% endraw %}
{% endhighlight %}


で作成したものとほぼ同じ内容の hoge.gz が出来ます。

Zlib::GzipReader と同じように wrap メソッドもあります。
これも Zlib::GzipReader と同じようにバイナリモードにする必要があることに注意してください。

{% highlight text %}
{% raw %}
require 'zlib'
File.open('hoge.gz', 'wb') do |f|
  Zlib::GzipWriter.wrap(f) do |gz|
    gz.puts 'hoge'
  end
end
{% endraw %}
{% endhighlight %}


### gzip コマンドと同じ gz ファイルを作成する

gzip コマンドと完全に同じ内容のファイルを作成するには、次のようにします。

{% highlight text %}
{% raw %}
require 'zlib'
orig = 'hoge'
Zlib::GzipWriter.open('hoge.gz', Zlib::BEST_COMPRESSION) do |gz|
  gz.mtime = File.mtime(orig)
  gz.orig_name = orig
  gz.puts File.open(orig, 'rb'){|f| f.read }
end
{% endraw %}
{% endhighlight %}


つまり、gz ファイルには更新日時や元のファイル名が入っていると言うことです。
詳しくはリファレンスマニュアルや zlib のドキュメントを参照してください。

## まとめ

今回は zlib について紹介しました。

ある程度大きなデータをインターネット経由で転送するときなどに使うと便利だと思います。
実際に HTTP で Content-Encoding に使われるなど、zlib の圧縮方式は広く使われています。

## 著者について

西山和広。
[Ruby hotlinks 五月雨版](http://www.rubyist.net/~kazu/samidare/)や
現在の [Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)のメンテナをやっています。

Ruby リファレンスマニュアルは現在青木さんによる新システムに移行準備中です。
手伝っていただける方は[るりま Wiki](http://doc.loveruby.net/wiki/) を参考にしてお手伝いをお願いします。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}


