---
layout: post
title: 標準添付ライブラリ紹介 【第 6 回】 委譲
short_title: 標準添付ライブラリ紹介 【第 6 回】 委譲
created_on: 2005-12-23
tags: 0012 BundledLibraries
---
{% include base.html %}


書いた人：西山

編集：ささだ

## はじめに

Ruby には便利な標準添付ライブラリがたくさんありますが、なかなか知られていないのが現状です。そこで、この連載では Ruby の標準添付ライブラリを紹介していきます。

今回は [ruby-man:添付ライブラリ](ruby-man:添付ライブラリ) でデザインパターンに分類されているライブラリの中から、メソッドの委譲機能を定義する forwardable と delegate を紹介します。

forwardable は 1.6.4 から標準添付されています。
delegate は初期の頃から標準添付されています。[^1]

forwardable は明示的に指定したメソッドだけを委譲するのに対して、delegate はほぼすべてのメソッドを委譲します。
委譲したいメソッドを明示的に指定する forwardable の方がわかりやすそうなので、この記事では forwardable の方から紹介します。

### 委譲とは？

オブジェクトの機能を再利用する手法の一つとして、Ruby では言語仕様としてクラスの継承とモジュールの Mix-in を提供しています。これらは、元になるクラスやモジュールの実装までもをそのまま取り込んでしまいますが、他の手段で機能の再利用を実現する手法として、委譲があります。

委譲では、再利用したい機能を自分に取り込むのではなく、その機能を持つオブジェクトに処理を依頼します。

Ruby では特に言語仕様として委譲がサポートされているわけではありませんが、委譲を実現するためのライブラリとして forwardable と delegate が用意されています。具体的には、これらのライブラリを使用することによって、あるメソッド呼び出しを他のオブジェクトのメソッドにたらい回すということを簡単に記述することができます。

## forwardable

### 概要

forwardable.rb は、

 Forwardable 
:  __クラス__に対してメソッドの委譲機能を定義するモジュール

 SingleForwardable 
:  __オブジェクト__に対してメソッドの委譲機能を定義するモジュール

の 2 つのモジュールを定義します。

### Forwardable の使用例

ここでは、Forwardable の使用例として、委譲を使ってキューを実現する例を紹介します。
この例は RDoc から持ってきました[^2]。

MyQueue クラスはいわゆる「キュー」のデータ構造を管理するクラスで、機能としては Array クラスのサブセットになります。しかし、この例ではいくつかの点を Array から変更したいと思います。

* Array#[] などは許可したくない
* push / shift ではなく、enq / deq というメソッド名にしたい
* Array#size などは使えるようにしたい


以下のプログラムはこのような MyQueue を Forwardable モジュールを利用して実現します。

{% highlight text %}
{% raw %}
require 'forwardable'

## MyQueue クラスの定義

class MyQueue
  extend Forwardable

  def initialize
    @q = []    # 委譲するオブジェクトの準備
  end

  # 望ましいインターフェースの enq() と deq() を定義
  def_delegator :@q, :push, :enq
  def_delegator :@q, :shift, :deq

  # キューにも合ういくつかの一般的な Array のメソッドをサポート
  def_delegators :@q, :clear, :first, :push, :shift, :size
end


## 利用例

q = MyQueue.new
q.enq 1, 2, 3, 4, 5
q.push 6

q.shift    # => 1
while q.size > 0
  puts q.deq
end

q.enq "Ruby", "Perl", "Python"
puts q.first
q.clear
puts q.first
{% endraw %}
{% endhighlight %}


このプログラムの出力結果は次のようになります。

{% highlight text %}
{% raw %}
2
3
4
5
6
Ruby
nil
{% endraw %}
{% endhighlight %}


同じ例を継承を使って実装すると、次の例のようになります。

{% highlight text %}
{% raw %}
class MyBadQueue < Array
  # 望ましいインターフェースの enq() と deq() を定義
  alias enq push
  alias deq shift
end

q = MyBadQueue.new
q.enq 1, 2, 3, 4, 5
q.push 6

q.shift    # => 1
while q.size > 0
  puts q.deq
end

q.enq "Ruby", "Perl", "Python"
puts q.first
q.clear
puts q[0]
{% endraw %}
{% endhighlight %}


出力例は forwardable を使った例と同じになります。

最後の行で first の代わりに [0] を使っていますが、このように Array を継承していると、Queue としては相応しくないメソッド Array#[] も呼べてしまうということが起こります (undef を利用すれば禁止することができますが、すべてのメソッドに対して undef するのは大変ですね)。

### SingleForwardable の使用例

ここでは、SingleForwardable の使用例として、委譲を使って出力機能を実現する例を紹介します。この例も RDoc から持って来ました[^3]。

例では、String クラスのインスタンスに対して、puts メソッドを STDOUT オブジェクトに委譲しています。

{% highlight text %}
{% raw %}
require 'forwardable'

printer = String.new
printer.extend SingleForwardable        # 委譲するオブジェクトの準備
printer.def_delegator "STDOUT", "puts"  # STDOUT.puts() への委譲を定義
printer.puts "Howdy!"
{% endraw %}
{% endhighlight %}


実行すると標準出力に「Howdy!」と出力されます。

この例では String のインスタンスを委譲元に使っていますが、委譲元のオブジェクトのクラスには深い意味はなく、委譲するメソッドが定義されていないオブジェクトなら何でも良いと思います。

### 使い方

まず最初に使いたいクラスまたはオブジェクトに対して extend します。
そして def_delegator などを使って委譲するメソッドを定義します。

#### extend Fowardable

Forwardable はクラスに対して extend して使います。
include ではありません。

なぜ include ではなく extend なのでしょうか。

それは、上の例で言うと MyQueue のオブジェクトのメソッド (インスタンスメソッド) を定義したいのではなく、MyQueue クラスのクラスメソッドを定義したいからです。

クラスメソッドとして定義されることによって、attr_accessor や attr_reader のようにクラス定義の中で def_delegator などのメソッドが呼べるようになります。

#### extend SingleForwardable

SingleForwardable はオブジェクトに対して extend して使います。

オブジェクトに対して extend すると、同じクラスの他のオブジェクトに影響することなく、そのオブジェクトのみにメソッド定義を追加することが出来ます。

#### def_delegator(accessor, method, ali = method)

def_delegator(accessor, method) で method が呼ばれたときに accessor に委譲するようにします。
accessor でのメソッド名をそのまま使いたい場合はこの形式を使います。

def_delegator(accessor, method, ali) と ali も指定した場合は ali が呼ばれたときに accessor の method を呼び出すようにします。
accessor でのメソッド名をそのまま使うと問題があるときに使います。

たとえば、

* 別の名前のメソッドにしたい場合 (上の使用例の enq や deq)
* 複数のオブジェクトに委譲しようとしていて移譲先のメソッド名に同じものがある場合(下の例の STDOUT.puts と STDERR.puts)
* Forwardable を使うクラスで同名のメソッドが既にある場合(後述の def_delegators の例の display)


などが考えられます。

Forwardable では def_delegator は def_instance_delegator の別名です。

SingleForwardable では def_delegator は def_singleton_delegator の別名です。

##### def_delegator の引数

accessor や method や ali は Symbol でも String でも指定することが出来ます。

accessor には インスタンス変数に限らず、STDOUT のように通常のメソッド定義の中から見えるものなら何でも指定できます。しかし無関係なものを指定してもわかりにくくなるだけなので、普通はインスタンス変数を指定するだけにしておくのが無難だと思います。

##### def_delegator の例

例としていろいろな書き方の def_delegator を並べておきます。

3 つずつのコメントアウトしている def_delegator は、その後の accessor と method を Symbol で指定しているものと同じ意味になります。

ali として :println を指定している def_delegator(:@out, :puts, :println) では println メソッドだけが定義されて、puts メソッドは定義されません。

puts メソッドを呼べているのは、その上の def_delegator(:@out, :puts) で puts メソッドが定義されているからです。

{% highlight text %}
{% raw %}
require 'forwardable'

class Foo
  extend Forwardable
  attr_accessor :out # 移譲先設定用
  #def_delegator("@out", "puts")
  #def_delegator(:@out, "puts")
  #def_delegator("@out", :puts)
  def_delegator(:@out, :puts)
  def_delegator(:@out, :puts, :println)
end
foo = Foo.new
foo.out = STDOUT
foo.puts "foo puts"
foo.println "foo println"

class Bar
  attr_accessor :out # 移譲先設定用
end
bar = Bar.new
bar.extend SingleForwardable
bar.out = STDOUT
#bar.def_delegator("@out", "puts")
#bar.def_delegator(:@out, "puts")
#bar.def_delegator("@out", :puts)
bar.def_delegator(:@out, :puts)
bar.def_delegator(:@out, :puts, :println)
bar.puts "bar puts"
bar.println "bar println"

class Baz
  extend Forwardable
  #def_delegator("STDOUT", "puts")
  #def_delegator(:STDOUT", "puts")
  #def_delegator("STDOUT", :puts)
  def_delegator(:STDOUT, :puts)
  def_delegator(:STDOUT, :puts, :println)
  def_delegator(:STDERR, :puts, :errprintln)
end
baz = Baz.new
baz.puts "baz puts"
baz.println "baz println"
baz.errprintln "baz errprintln"
{% endraw %}
{% endhighlight %}


この例を実行すると、puts や println が STDOUT の puts に委譲されます。
そして errprintln は STDERR の puts に委譲されます。
その結果、

{% highlight text %}
{% raw %}
foo puts
foo println
bar puts
bar println
baz puts
baz println
baz errprintln
{% endraw %}
{% endhighlight %}


と出力されます。

#### def_delegators(accessor, *methods)

methods で渡されたメソッドのリストを accessor に委譲するようにします。

methods のそれぞれの method に対して def_delegator(accessor, method) を呼ぶのと同じ意味になります。

Forwardable では def_delegators は def_instance_delegators の別名です。

SingleForwardable では def_delegators は def_singleton_delegators の別名です。

##### def_delegator と def_delegators の違い

def_delegator(accessor, foo, bar) と def_delegators(accessor, foo, bar) は一文字違いで意味は全く違うものになるので、注意が必要です。

* 前者は bar を accessor の foo に委譲します。
* 後者は foo と bar を accessor の foo と bar に委譲します。


##### def_delegators の例

以下の例を実行すると「b」と出力されます。

{% highlight text %}
{% raw %}
require 'forwardable'
class Hoge
  extend Forwardable
  attr_accessor :s
  def_delegators(:@s, :<<, :succ!)
  def_delegator(:@s, :display, :s_display)
end
hoge = Hoge.new
hoge.s = ""
hoge << "a\n"
hoge.succ!
hoge.s_display #=> b
{% endraw %}
{% endhighlight %}


ここで s_display の def_delegator を def_delegators と間違えると「NoMethodError: undefined method `s_display' for "b\n":String」になります。
この例の場合は NoMethodError になり、すぐに間違いに気づきますが、偶然存在するメソッドに委譲してしまった場合、わかりにくいバグの原因になるので注意してください。

### Forwardable.debug

通常は Forwardable で定義される委譲部分は backtrace に出てきませんが、Forwardable.debug を設定すると出てくるようになります。

{% highlight text %}
{% raw %}
require 'forwardable'
Forwardable.debug = true
obj = Object.new
obj.extend SingleForwardable
obj.def_delegator(:@dummy, :dummy)
obj.dummy
# 出力例:
#(__FORWARDABLE__):3:in `__send__': undefined method `dummy' for nil:NilClass (NoMethodError)
#        from (__FORWARDABLE__):3:in `dummy'
#        from -:6
{% endraw %}
{% endhighlight %}


## delegate

標準添付されているライブラリで委譲を実現するものには、delegate もあります。
forwardable は明示的に指定したメソッドだけを委譲しますが、delegate はほとんどのメソッドを委譲します。

delegate には、

* SimpleDelegator
* DelegateClass()
* Delegator


の 3 つの使い方があります。

### SimpleDelegator

一番簡単な使い方が SimpleDelegator クラスです。

#### 使用例

SimpleDelegator.new の引数に渡したオブジェクトのすべてのメソッドが委譲されます。

{% highlight text %}
{% raw %}
require 'delegate'
foo = SimpleDelegator.new([])
foo.push(1)
foo.push(2)
puts foo.size #=> 2
{% endraw %}
{% endhighlight %}


この例では、オブジェクト foo に大して呼ばれたメソッドは、すべて　SimpleDelegator.new([]) として渡した配列オブジェクトに委譲されます。

#### __setobj__

委譲先のオブジェクトは __setobj__ を使って、後で変更することも出来ます。

{% highlight text %}
{% raw %}
require 'delegate'

s = SimpleDelegator.new(%w"a b c")
puts s[1] #=> "b"
s.__setobj__(%w"A B C")
puts s[1] #=> "B"
{% endraw %}
{% endhighlight %}


ただし、普通は変更前の委譲先と変更後の委譲先のオブジェクトは同じクラスだと思われるので、SimpleDelegator のメソッドは定義し直されません。そのため、別のクラスのオブジェクトを __setobj__ すると何か問題が起きるかもしれません (1.8.3 では例外発生時のクラス部分が変わるようです)。

{% highlight text %}
{% raw %}
require 'delegate'

s = SimpleDelegator.new(%w"a b c")
puts s[1] #=> "b"
s.__setobj__("A B C")

# Array にはあって String にはないメソッド compact
s.compact #=> NoMethodError: undefined method `compact' for "A B C":String

# Array にも String にもないメソッド
s.hoge #=> NoMethodError: undefined method `hoge' for "A B C":SimpleDelegator
{% endraw %}
{% endhighlight %}


#### 継承する例

{% highlight text %}
{% raw %}
require 'delegate'

class MyString < SimpleDelegator
  def initialize(str="", default_length=120)
    @default_length = default_length
    super(str)
  end
  def shorten(length = @default_length)
    self.sub(/\A(.{0,#{length-3}}).*/) { "#{$1}..." }  # self. がないと Kernel#sub が呼ばれてしまう
  end
end

puts MyString.new("hogefuga", 5).shorten #=> "ho..."
{% endraw %}
{% endhighlight %}


### DelegateClass()

DelegateClass() はクラスを引数として受け取り、そのクラスのオブジェクトにインスタンスメソッドを委譲するクラスを定義して返す関数的メソッドです。

#### 使用例

[ruby-man:delegate.rb](ruby-man:delegate.rb) の例を元に紹介します。

{% highlight text %}
{% raw %}
require 'delegate'
class ExtArray < DelegateClass(Array)     # Step 1
  def initialize()
    super([])                             # Step 2
  end
end
p ExtArray.ancestors #=> [ExtArray, #<Class:0x402a4f24>, Object, Kernel]
a = ExtArray.new
p a.type  # => ExtArray
a.push 25
p a       # => [25]
{% endraw %}
{% endhighlight %}


まず、DelegateClass(Array) で Array のオブジェクトにインスタンスメソッドを委譲するクラス (例の中では #&lt;Class:0x402a4f24&gt;) が定義され、そのクラスを継承した ExtArray クラスを定義しています。

次に、initialize の中で super(obj) を使って親クラス (例の中では #&lt;Class:0x402a4f24&gt;) の initialize(obj) を呼び出し、委譲先のオブジェクトを obj (例では [] つまり空の Array) に設定します。

### Delegator

Delegator クラスはデザインパターンの delegator パターンを実現するための抽象クラスです。
継承して __getobj__ を再定義して使います。

具体的な使用例は SimpleDelegator の実装を見てください。

普通は DelegateClass(superclass) か SimpleDelegator を継承して使い、Delegator を使うことはないと思います。

## 終わりに

今回は、デザインパターンの委譲を実現するライブラリとして forwardable と delegate を紹介しました。

Ruby で委譲を利用する、もっと色々な使用例を見たいと思ったら、[RAA の gonzui](http://raa.ruby-lang.org/gonzui/) を使って、クラス名 (Forwardable や SimpleDelegator など) やライブラリの名前 (forwardable や delegate) などで検索してみることをおすすめします。

## 関連リンク

* [ruby-man:forwardable.rb](ruby-man:forwardable.rb)
* [ruby-man:Forwardable](ruby-man:Forwardable)
* [ruby-man:SingleForwardable](ruby-man:SingleForwardable)
* [ruby-man:delegate.rb](ruby-man:delegate.rb)
* [RAA の gonzui](http://raa.ruby-lang.org/gonzui/)


## 著者について

西山和広。
[Ruby hotlinks 五月雨版](http://www.rubyist.net/~kazu/samidare/)
や
[Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)
のメンテナをやっています。
[Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)
はいつでも[執筆者募集中](ruby-man:執筆者募集)です。
何かあれば、マニュアル執筆編集に関する議論をするためのメーリングリスト rubyist@freeml.com（[参加方法](http://www.freeml.com/ctrl/html/MLInfoForm/rubyist)）へどうぞ。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}

----

[^1]: CVS のタグをみると Ruby 1.1 の頃からのようです。
[^2]: 変更点は次の通り：(1) 頭に「require 'forwardable'」を追加 (2) Queue は thread.rb で定義されている名前と重なるので MyQueue に変更 (3) コメントを日本語に翻訳
[^3]: 変更点は (1) 頭に「require 'forwardable'」を追加 (2) コメントを日本語に翻訳
