---
layout: post
title: 式と文、評価と実行、そして副作用 ―― プログラムはいかにして動くのか【前編】
short_title: 式と文、評価と実行、そして副作用 ―― プログラムはいかにして動くのか【前編】
tags: 0039 ExpressionAndStatement
---
{% include base.html %}


* Table of content
{:toc}


書いた人 : 郡司啓

## はじめに

オブジェクト指向のスクリプト言語として有名なプログラミング言語 Python は、同様にオブジェクト指向のスクリプト言語である Ruby とよく比較されているような気がします。たとえば Rubyist Magazine の記事「[Rubyist のための他言語探訪 【第 1 回】 Python]({{base}}{% post_url articles/0008/2005-07-19-0008-Legwork %})」では、 Ruby の作者であるまつもとゆきひろさんご自身が Python と Ruby を比較しています。また「達人プログラマ」として有名な [Dave Thomas 氏](http://pragdave.pragprog.com/) も、 2007 年に行われた「[日本 Ruby 会議 2007](http://jp.rubyist.net/RubyKaigi2007/)」のキーノートスピーチ「[The Island of Ruby (島国としてのRuby) ](http://jp.rubyist.net/RubyKaigi2007/Log0610-S5.html)」にて、次のように Python と Ruby について述べています。

> PythonとRuby。
> 2001年にアメリカでRubyのチュートリアルを開いた時は大盛況だった。
> Rubyって何だろう？と。
> やはり比較の対象になるのはPythonだった。
> Pythonは「そうじゃなくて、こうやるんだよ」と教えてくれる。
> 世の中にはPythonが好きな人も居るし、Rubyが好きな人も居る。
> でもなぜか 両方好きな人はあまり多くない。なぜだろう。
> 世の中には犬が好きな人も居るし、猫が好きな人も居る。これは好みの問題だ。
> PythonとRubyについても同じ。
> 彼らをかわいがった時に、 Rubyが我々に与えてくれるものと、 Pythonが我々に与えてくれるものとは違う。
> Pythonは「型」を重んじる。誰が書いてもプログラムは同じように見える。
> Rubyは「侘寂 (わびさび)」。世界は自然で、変化する。 固定されていない。
> これがRubyのすごいところなんだ。


それでは、 Python と Ruby の違いとは何でしょうか？　細かい違いは色々あると思いますが、私は Python と Ruby の本質的な違いは、「式と文の区別があること」だと考えています。今回の記事では Python と Ruby を比較しつつ、「式と文」について考えてみたいと思います。

## 式と文

皆さんはプログラムを書いていて、「これは式だ」「これは文だ」と意識して書いていますでしょうか。そもそも「式」や「文」って何でしょうか。ここでは簡単なプログラムを例にして、式と文について見ていきたいと思います。

例として次のようなプログラムを書いてみましょう。これは、名前と誕生年をインスタンス変数として持つクラス Person を定義して、名前と誕生年を引数として Person オブジェクトを生成し、 Person オブジェクトが返したあいさつを画面に出力する、という単純なプログラムになります。

```ruby
class Person
  def initialize(name, birth_year)
    @name = name
    @birth_year = birth_year
  end
  def hi
    return "My name is #{@name}, I was born in #{@birth_year}."
  end
end

person = Person.new('Taro', 1989)

puts person.hi

```

上記のプログラムを person.rb というファイル名で保存して、実行してみましょう。

{% highlight text %}
{% raw %}
$ ruby person.rb
My name is Taro, I was born in 1989.
$
{% endraw %}
{% endhighlight %}


ちゃんと挨拶をしてくれましたね。

それでは、上記のプログラムのどこが「式」で、どこが「文」なのか、分かりますか？　誤解を恐れずに簡単に言ってしまうと、戻り値を使っているものが「式」で、戻り値を捨てているものが「文」になります。

### 文

それでは、先ほどのプログラムから「文」を抽出してみましょう。まずクラス定義全体が大きな「文」になります。

{% highlight text %}
{% raw %}
class Person
  ...
end
{% endraw %}
{% endhighlight %}


次は Person クラス定義の中を見てみましょう。メソッド定義も「文」になります。

{% highlight text %}
{% raw %}
  def initialize(name, birth_year)
    ...
  end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
  def hi
    ...
  end
{% endraw %}
{% endhighlight %}


メソッド定義の中に行きます。まずは initialize メソッド定義の中を見てみましょう。変数への代入も「文」になります。

{% highlight text %}
{% raw %}
    @name = name
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
    @birth_year = birth_year
{% endraw %}
{% endhighlight %}


次は hi メソッド定義の中を見てみましょう。 return も「文」になります。

{% highlight text %}
{% raw %}
    return "My name is #{@name}, I was born in #{@birth_year}."
{% endraw %}
{% endhighlight %}


ここで Person クラス定義の中はすべて見ましたので、次に行きましょう。先程述べたとおり、変数への代入は文でしたね。

{% highlight text %}
{% raw %}
person = Person.new('Taro', 1989)
{% endraw %}
{% endhighlight %}


そして puts で画面出力をしている部分も、やはり「文」になります。

{% highlight text %}
{% raw %}
puts person.hi
{% endraw %}
{% endhighlight %}


### 式

「文」が明らかになったところで、次は「式」を見ていきましょう。「文」と異なり、「式」はその戻り値を使用しているものになります。 initialize メソッド定義の中には ２ つの代入文がありましたが、代入文の右側の変数参照は「式」になります。つまり

{% highlight text %}
{% raw %}
    @name = name
{% endraw %}
{% endhighlight %}


の右側の name は「式」になります。なぜなら、 name 変数を参照して、その戻り値を @name 変数に代入している（戻り値を使用している）ので「式」です。同様に

{% highlight text %}
{% raw %}
    @birth_year = birth_year
{% endraw %}
{% endhighlight %}


の右側の birth_year も「式」になります。

次は hi メソッド定義の中の return 文ですが、やはり return の右側の文字列は「式」になります。つまり

{% highlight text %}
{% raw %}
    return "My name is #{@name}, I was born in #{@birth_year}."
{% endraw %}
{% endhighlight %}


の "My name is #{@name}, I was born in #{@birth_year}." の部分は「式」になります。またこの文字列は Ruby ならではの機能である「[文字列への式の埋め込み](http://doc.ruby-lang.org/ja/1.9.3/doc/spec=2fliteral.html#exp)」が使われていますが、当然その中の変数参照 @name と @birth_year も「式」になります。

次に行きましょう。 Person インスタンスを生成して変数 person に代入している文のうち、

{% highlight text %}
{% raw %}
person = Person.new('Taro', 1989)
{% endraw %}
{% endhighlight %}


まず Person クラスを参照している定数 Person が「式」になります。次に、メソッド呼び出し Person.new() も「式」になります。さらにメソッドの引数である 'Taro' と 1989 もそれぞれが「式」になります。

ここはちょっと分かりづらいかもしれませんので、もうちょっと詳しく説明します。まず Person は実はクラスオブジェクトを参照するための変数（定数）です。 Ruby では[クラスを定義すると、クラス自体がオブジェクトとなり、そのクラス名の定数に代入される](http://doc.ruby-lang.org/ja/1.9.3/doc/spec=2fdef.html#class)、という仕組みになっています。なので上記の Person.new('Taro', 1989) の挙動を説明すると、まず定数 Person を参照し、その戻り値であるクラスオブジェクトに対して new メソッドを呼ぶ、という仕組みになっています。

さらに new メソッドを呼ぶ前には、引数に書かれている 'Taro' と 1989 はそれぞれ文字列オブジェクトと数値オブジェクトを生成し、それがメソッドの引数として渡されてから new メソッドが呼ばれる、という動作をしています。

さて、最後の puts の部分になります。これも変数参照している person が「式」、そしてメソッド呼び出しをしている person.hi も「式」になります。

{% highlight text %}
{% raw %}
puts person.hi
{% endraw %}
{% endhighlight %}


こちらももうちょっと詳しく挙動を説明しますと、まず変数 person を参照すると先ほど生成した Person クラスのインスタンスが戻り値として得られ、そのオブジェクトに対して hi メソッドを呼び、さらにその戻り値を puts の引数として与えている、ということになります。

### Python の場合

それでは、先ほど Ruby で書いたプログラムを Python でも書いてみましょう。ここでは Python のプログラムの書き方についての説明はしませんが、 Ruby で書いたプログラムと比較していただければ「だいたい似たようなものだなあ」と感じていただけるのではないでしょうか。

{% highlight text %}
{% raw %}
class Person(object):
  def __init__(self, name, birth_year):
    self.__name = name
    self.__birth_year = birth_year
  def hi(self):
    return 'My name is %s, I was born in %d.' \
      % (self.__name, self.__birth_year)

person = Person('Taro', 1989)

print person.hi()
{% endraw %}
{% endhighlight %}


上記のプログラムを person.py というファイル名で保存して、実行してみましょう。

{% highlight text %}
{% raw %}
$ python person.py
My name is Taro, I was born in 1989.
$
{% endraw %}
{% endhighlight %}


当然、出力結果は同じですね。

それでは、先ほど同様 Python で書いたプログラムについても「どこが式でどこが文なのか」を見ていきましょう。基本は Ruby と同様です。

### Pythonの「文」

先ほどの Ruby と同様、クラス定義[^1]全体が大きな「文」でしたね。

{% highlight text %}
{% raw %}
class Person(object):
  ...
{% endraw %}
{% endhighlight %}


次は Person クラスの定義の中を見ていきます。メソッド定義（関数定義[^2]）も「文」です。

{% highlight text %}
{% raw %}
  def __init__(self, name, birth_year):
    ...
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
  def hi(self):
    ...
{% endraw %}
{% endhighlight %}


メソッド定義の中に行きます。まずは __init__ メソッド定義の中ですが、変数への代入[^3]も「文」でしたね。

{% highlight text %}
{% raw %}
    self.__name = name
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
    self.__birth_year = birth_year
{% endraw %}
{% endhighlight %}


次は hi メソッド定義の中を見てみましょう。 return も「文」になります。

{% highlight text %}
{% raw %}
    return 'My name is %s, I was born in %d.' \
      % (self.__name, self.__birth_year)
{% endraw %}
{% endhighlight %}


ここで Person クラス定義の中はすべて見ましたので、次に行きましょう。先程述べたとおり、変数への代入は文でしたね。

{% highlight text %}
{% raw %}
person = Person('Taro', 1989)
{% endraw %}
{% endhighlight %}


そして print で画面出力をしている部分も、やはり「文」になります[^4]。

{% highlight text %}
{% raw %}
print person.hi()
{% endraw %}
{% endhighlight %}


### Pythonの「式」

次は「式」を見ていきましょう。 __init__ メソッド定義中の 2 つの代入文の右側の変数参照は「式」です。つまり、

{% highlight text %}
{% raw %}
    self.__name = name
{% endraw %}
{% endhighlight %}


の右側の name は「式」になります。同様に

{% highlight text %}
{% raw %}
    self.__birth_year = birth_year
{% endraw %}
{% endhighlight %}


の右側の birth_year も「式」になります。

次は hi メソッド定義の中の return 文ですが、やはり return の右側の文字列は「式」になります。つまり

{% highlight text %}
{% raw %}
    return 'My name is %s, I was born in %d.' \
      % (self.__name, self.__birth_year)
{% endraw %}
{% endhighlight %}


の「'My name is %s, I was born in %d.' % (self.__name, self.__birth_year)」の部分は「式」になります。さらに細かく見ると「%」演算子の左側の文字列単体「'My name is %s, I was born in %d.'」も式、「%」演算子の右側のタプル[^5]「(self.__name, self.__birth_year)」も式、さらにタプルの中の変数 self.__name と self.__birth_year も式になります。

次に行きましょう。 Person インスタンスを生成して変数 person に代入している文のうち、

{% highlight text %}
{% raw %}
person = Person('Taro', 1989)
{% endraw %}
{% endhighlight %}


まず Person クラスを参照している変数 Person[^6] が「式」になります。次に、 Person インスタンスを生成する Person()[^7] も「式」になります。さらにその引数である 'Taro' と 1989 もそれぞれが「式」になります。

最後の print 文ですが、これも変数参照している person が「式」、そしてメソッド呼び出しをしている person.hi()[^8] も「式」になります。

{% highlight text %}
{% raw %}
print person.hi()
{% endraw %}
{% endhighlight %}


### Python と Ruby の比較

Ruby と Python で同じようなプログラムを書いて比較をしてきましたが、冒頭でも書いたとおり、私は Python と Ruby の本質的な違いは、「式と文の区別があること」だと考えています。

先ほど比較してきたとおり、代入は「文」でしたね。それでは Ruby の irb で代入文を書いて実験してみましょう。ここでは単純に、変数 a に整数の 1 を代入する代入文「a = 1」を例にします。

{% highlight text %}
{% raw %}
$ irb
> a = 1
 => 1
> exit
$
{% endraw %}
{% endhighlight %}


上記のとおり、 Ruby の場合は代入文にも戻り値 (ここでは「1」) があることが分かります。

次に Python でも同様に代入文を書いて実験してみます。 Python は引数なしで実行すると、 Ruby の irb のような対話シェルを起動することができます（終了は「exit()」です）。

{% highlight text %}
{% raw %}
$ python
>>> a = 1
>>> exit()
$
{% endraw %}
{% endhighlight %}


上記のとおり、 Python の場合は代入文「a = 1」の戻り値がありません。

これはクラス定義文やメソッド定義文でも同様で、 Ruby には戻り値があり、 Python には戻り値がありません。それでは簡単なメソッド定義の例として、引数を二乗して返すメソッド (関数) square を定義してみましょう。まずは Ruby です。

{% highlight text %}
{% raw %}
$ irb
> def square(x); return x * x; end
 => nil
> square(3)
 => 9
> exit
$
{% endraw %}
{% endhighlight %}


やはり Ruby の場合はメソッド定義文にも戻り値 (「nil」) があることが分かります。

Python ではどうでしょうか。

{% highlight text %}
{% raw %}
$ python
>>> def square(x): return x * x
...
>>> square(3)
9
>>> exit()
$
>>>
{% endraw %}
{% endhighlight %}


上記のとおり、 Python の場合はメソッド (関数) 定義文「def square(x): return x * x」の戻り値がありません (分かりにくいですが、上記「...」は戻り値ではなく、メソッド定義が継続していることを表す対話シェルのプロンプトです。ここでは単に「...」プロンプトに対して改行だけを入力して、メソッド定義を終了させています) 。

Python では式と文は明確に分かれていて、式を書かないといけない場所（戻り値を必要とする場所）に文を書くとエラーになります。冒頭で引用した Dave Thomas 氏のスピーチでも、 Python の特徴を次のように述べていましたね。

> Pythonは「そうじゃなくて、こうやるんだよ」と教えてくれる。


式と文が明確に分かれていることには、メリットとデメリットがあり、それはプログラミング言語の設計者の思想が色濃く反映されていると思います。冒頭の Dave Thomas 氏のスピーチでは、次のように述べられていますね。

> Pythonは「型」を重んじる。誰が書いてもプログラムは同じように見える。


> Rubyは「侘寂 (わびさび)」。世界は自然で、変化する。 固定されていない。


後編ではそのあたりを中心に説明したいと思います。お楽しみに。

## 著者について

### 郡司啓 ([@gunjisatoshi](http://twitter.com/gunjisatoshi/))

[Asakusa.rb](http://asakusa.rubyist.net/) の花火担当（と言いつつ告知が遅れて今年の花火大会は人が集まりませんでした。すみません）。Asakusa.rb は毎週火曜日 19:30 頃から東京下町のどこかで開催されていますので、お近くをお通りの方は是非お立ち寄りを。

## 式と文、評価と実行、そして副作用 ―― プログラムはいかにして動くのか 連載一覧

{% for post in site.tags.ExpressionAndStatement %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}

----

[^1]: Python ではクラス定義の引数に親クラスを指定することで継承ができます。 Ruby と異なり、複数の引数を指定することで多重継承もできます。ここでは object クラスを継承していますが、その理由は余談が過ぎるのでここでは説明しませんので、 Python に興味がある方は調べてみてください。
[^2]: Ruby と異なり Python ではメソッドと関数の区別がなく、クラス定義中に関数を定義するとそれがメソッドになります。関数定義の第一引数 self には、そのクラスから生成されたインスタンス自体が代入されます。また Ruby の initialize メソッドに相当するのが __init__ 関数になります。
[^3]: Python でインスタンス変数を表すのは「self.変数名」です。先ほどの注でも述べましたが、関数定義の第一引数 self にはメソッド呼び出し時にインスタンス自体が代入されますので、「self.変数名」で各インスタンスの変数を参照できる、という仕組みになっています。また Python のインスタンス変数は基本的にオブジェクトの外からも参照・代入が可能ですが、変数名がアンダースコア 2 つ「__」で始まる変数はプライベート変数となり、外から参照できなくなります (これまた余談が過ぎるので詳しくは説明しませんが、厳密にはあくまで「参照しにくくしている」だけなので、参照可能だったりします。 Python に興味がある方はどういう仕組みなのか調べてみると面白いでしょう) 。
[^4]: Python 3.0 以降では print は文ではなく式になりましたが、ここでの主題とは関係ないのと、余談が過ぎるので詳しい説明は省略します。このあたりの経緯もなかなか面白いので、興味のある方は調べてみてはいかがでしょうか。
[^5]: 「無名の構造体」のこと。タプルは Ruby にはない概念なので難しいかもしれませんが、誤解を恐れずに言えば、要素数の固定された配列のようなものです。
[^6]: Ruby と同様、 Python でもクラス自体がオブジェクトで、クラス定義をするとそのクラス名の変数に代入されます。
[^7]: Ruby ではクラスの new メソッドを呼び出してインスタンスを生成しますが、 Python ではクラスに直接引数を渡してインスタンスを生成します。
[^8]: Python ではメソッド呼び出しの括弧「()」を省略できません。 Ruby と異なり Python ではメソッド（関数）もオブジェクトなので、括弧を省略するとその関数オブジェクト自体を戻り値として得ることができます。
