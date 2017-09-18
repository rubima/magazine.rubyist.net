---
layout: post
title: Ruby 初級者のための class << self の話 (または特異クラスとメタクラス)
short_title: Ruby 初級者のための class << self の話 (または特異クラスとメタクラス)
tags: 0046 SingletonClassForBeginners
---


* Table of content
{:toc}


書いた人： sunaot

## はじめに
{% isbn_image_right('4873113679') %}

この記事は「最近 Ruby を始めたばかりで言語仕様についてよく知らない」という初級者や、「一通り記法は知っていて Ruby でプログラミングはできるが、その仕組みはよくわからない」という中級者へ向けて書いています。

Ruby を始めるならどんな本を読めばいいの？　とたびたび聞かれます。そんなときは決まって、「他の言語が使えるなら『はじめての Ruby』が鉄板で、あとは実際に使いながらリファレンスマニュアルをなるべく参照するといいですよ」と答えます。

そうして実際に自分で Ruby のコードを読み書きし始めた人が、決まって「あれ？」と立ち止まるところがあります。今回はその中の一つ _class &lt;&lt; self_ の話です[^1]。

リファレンスマニュアルへの参照など、より深く学ぶためのリンクもありますので、記事を読んでその仕組みに興味をもった人が理解を深めるきっかけになってくれれば執筆者冥利につきます。

## class &lt;&lt; self って？

### class &lt;&lt; self に出会うとき

Ruby のコードを読んでいると、

{% highlight text %}
{% raw %}
class Foo
  class << self
    def hello
      puts 'hello'
    end
  end
end
{% endraw %}
{% endhighlight %}


という表記に出会うことがあります。この _class &lt;&lt; self_ という謎めいた表記はいったい何なのでしょうか？

この _class &lt;&lt; self_ は特異クラスと言いまして、説明をすると大変長いものです。

まず、なにをしているかというと、これはクラスメソッドを定義するイディオムのひとつです。マニュアルにも記載があります。[クラスメソッドの定義](http://docs.ruby-lang.org/ja/2.1.0/doc/spec=2fdef.html#class_method)の特異クラス方式と書かれている箇所です。

### クラスメソッドの定義の仕方

Ruby でのクラスメソッドの定義の仕方には大きくわけて二つのやり方があります。一つは特異メソッド方式、もう一つが特異クラス方式です。

def self.method_name の特異メソッド形式
: 特異メソッド方式では、_def self.class_method_ のようにメソッド名の前にクラスメソッドを定義する対象のクラス名をつけて定義します。リファレンスマニュアルにあるように直接クラス名を書いてもいいのですが、定義するクラス自身の中に書く場合はこのように _self._ と書くことが多いでしょう。

class &lt;&lt; self の特異クラス形式
: 特異クラス方式では、_class &lt;&lt; self_ と書いた行から _end_ までの間に _def class_method_ のようにクラス名を書かずにインスタンスメソッドと同じようなメソッド定義を書いていきます。この間に書いたものはクラスメソッドとして定義されます。

どちらも正しいクラスメソッドの定義の仕方ですが、特異メソッド方式では複数のクラスメソッドをまとめて定義したい場合に都度の _self._ を書くのが面倒なため、そのようなときは特異クラス方式がとられることが多いようです。まずはこれだけわかれば Ruby を使う上で困ることは少ないでしょう。

特異クラス方式についてだけ、少し説明を補足します。まずはコードの例を見てみましょう。

{% highlight text %}
{% raw %}
# 特異クラスによるクラスメソッドの定義例
class Foo
  class << self
    def a_class_method
    end

    def another_class_method
      # 二つ定義しても self つけなくていいから便利！
    end
  end
end
{% endraw %}
{% endhighlight %}


[リファレンスマニュアルでの特異クラスの説明](http://docs.ruby-lang.org/ja/2.1.0/doc/spec=2fdef.html#singleton_class)くらいは読んでみてもいいかもしれません。
{% isbn_image_right('4048687158') %}
{% isbn_image_right('4774158798') %}
{% isbn_image_right('4274066428') %}

しかし、実はこれだけではわかったようでなにもわかっていません。特異クラスについて真剣に学ぶのであれば、初めての Ruby の著者でもある yugui さんの書いた[Ruby のメタクラス階層](http://yugui.jp/articles/768)あたりを読むのがよさそうです。さらに理解を深めたいなら、「プログラミング Ruby (ピッケル本)」、「パーフェクト Ruby」、「メタプログラミング Ruby」あたりの解説を読んでみるといいでしょう。

かつては Rails が _class &lt;&lt; self_ な特異クラス方式の書き方を多用していたため、After Rails の gem には特異クラス方式が流行っていたという印象があったのですが、執筆時点最新の Rails (ver4 系) を読むと特異メソッド方式と extend によるクラスメソッドの読み込みへ大部分が変わっていました。おかげでコードの見通しが非常によくなっています。これは学ぶべき点が多いですね。

* [v3.2.17 の ActiveRecord::Base](https://github.com/rails/rails/blob/v3.2.17/activerecord/lib/active_record/base.rb#L395)
* [v4.0.4 の ActiveRecord::Base](https://github.com/rails/rails/blob/v4.0.4/activerecord/lib/active_record/base.rb#L281)


## class &lt;&lt; self の仕組みを順に理解する

さて、日常の Ruby コードで class &lt;&lt; self を利用するための説明はここまでで終わりです。ここからは、実際に特異クラスやメタクラスを実感するために順を追って動きを見てみましょう。

### 特異メソッドの定義の仕方

#### def object.method_name 形式

Ruby では (クラスではなく) オブジェクトに対して直接固有のメソッドを定義することができ、それを特異メソッドと呼んでいます。

オブジェクトへ特異メソッドを定義するには下記のようにします。

{% highlight text %}
{% raw %}
hello = 'hello'
def hello.say(count = 1)
  count.times { print self }
end
hello.say 2 #=> hellohello

another_hello = 'hello'
another_hello.say 3 #=> NoMethodError: undefined method `say' for "hello":String
{% endraw %}
{% endhighlight %}


このとき、say メソッドは String クラスのオブジェクト 'hello' に対してのみ定義され、String クラスが拡張されたわけではありません。つまり、別の String クラスのオブジェクトへ another_hello.say(3) としても NoMethodError となります。

#### class &lt;&lt; object 形式

オブジェクトに特異メソッドを定義するにはもう一つ方法があり、オブジェクトの特異クラスをひきだして、直接特異メソッドを定義することができます。

{% highlight text %}
{% raw %}
hello = 'hello'

class << hello
  def say_world
    puts "#{self}, world"
  end
end
hello.say_world #=> hello, world
{% endraw %}
{% endhighlight %}


一見クラス定義に近い見た目ですが、これも _&lt;&lt; hello_ というところで hello オブジェクトの特異クラスを引き出しており、あくまでオブジェクトに対しての特異メソッドの定義となっています。

### class &lt;&lt; self を解釈してみる

さて、ここでクラス定義のときの特異クラスの利用へ戻ると、

{% highlight text %}
{% raw %}
class Foo
  class << self
{% endraw %}
{% endhighlight %}


としています。クラス定義のコンテキストでの self とは、Class クラスのインスタンス Foo class です。_class Foo_ とはクラスを定義するときの記法ですが、Ruby の中での理解としては、Class クラスのオブジェクトを生成し Foo というグローバルな定数へ代入しています。

つまり以下の二つはほぼ同義です。

クラス定義のシンタクス class を使って Bar クラスを定義する場合。

{% highlight text %}
{% raw %}
class Bar
  def hello
    puts 'hello'
  end
end
bar = Bar.new
bar.hello #=> hello
{% endraw %}
{% endhighlight %}


Class クラスのインスタンスを生成して、定数 Bar へ束縛する場合。

{% highlight text %}
{% raw %}
Bar = Class.new do
  def hello
    puts 'hello'
  end
end
bar = Bar.new
bar.hello #=> hello
{% endraw %}
{% endhighlight %}


ここまでくるともう少しです。

定数 Bar に入っている Class クラスのオブジェクトへ特異メソッドを定義してみましょう。特異メソッドの定義の仕方は _def object.method_name_ という形式でした。Bar のオブジェクトに特異メソッドを定義するので、_def Bar.method_name_ と定義することになります。

{% highlight text %}
{% raw %}
Bar = Class.new do
  def hello
    puts 'hello'
  end
end
def Bar.bye
  puts 'good bye'
end
Bar.new.hello #=> hello
Bar.bye       #=> good bye
{% endraw %}
{% endhighlight %}


Bar.bye という呼出しができました。これはクラスメソッドの呼出しと同じですね。つまり、クラスメソッド Bar.bye というのは、Bar に入っている Class クラスのオブジェクトへの特異メソッドの定義として読むことができます。

これにオブジェクトの特異クラスの引き出しの記法 &lt;&lt; をあわせて考えると、最初のイディオムがやろうとしていることがわかってきます。

クラスメソッドの定義は特異メソッド形式と特異クラス形式があったのでした。特異メソッド形式で定義した _def Bar.bye_ を特異クラス形式へ書きかえてみます。

{% highlight text %}
{% raw %}
Bar = Class.new do
  def hello
    puts 'hello'
  end
end
class << Bar
  def bye
    puts 'good bye'
  end
end
Bar.new.hello #=> hello
Bar.bye       #=> good bye
{% endraw %}
{% endhighlight %}


できました。せっかくなので、クラス定義をすべて class 記法での宣言の中に入れてみましょう。クラス定義の中で Bar に入ってるインスタンスを取得するには self を使うのでした。

{% highlight text %}
{% raw %}
class Bar
  def hello
    puts 'hello'
  end

  class << self
    def bye
      puts 'good bye'
    end
  end
end
Bar.new.hello #=> hello
Bar.bye       #=> good bye
{% endraw %}
{% endhighlight %}


ここでようやく最初に読んだ形が出てきました。クラスメソッドのための記法があるわけではなく、特異メソッドという仕組みを使って巧みにクラスメソッドが実現されていることがわかりますね。

## まとめ

Ruby で特異クラスと特異メソッドの記法を使ってメタクラス[^2]へアクセスし、クラスメソッドとして働くメソッド定義ができることを順に見てきました。ふだん何気なく使っているものや読んでいるコードの仕組みを調べるおもしろさが少しでも伝わったなら、この記事の目論みは成功です。Enjoy programming!! :)

## 著者について

### たなべすなお (Sunao Tanabe / @sunaot)

日本 Ruby の会、Asakusa.rb 所属 (先日ひさしぶりに参加した)。Rubyist Magazine 編集者。記事公開時点では Perl の会社ですっかり Ruby の仕事が多くなってきたプログラマ。[sunaot@github](https://github.com/sunaot) | [sunaot@twitter](https://twitter.com/sunaot)

----

[^1]: 本当は「初めての Ruby」にはさらっと解説されているのですが、よほど注意深く読んでいないと実際のコードと結びつかないでしょう
[^2]: メタクラスという呼び方はあえて説明の中では使いませんでした。初めての Ruby や記事中で紹介した yugui さんの記事では説明されているので気になる方はぜひそちらの説明を参照してみてください。
