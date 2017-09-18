---
layout: post
title: 標準添付ライブラリ紹介 【第 5 回】 enumerator
short_title: 標準添付ライブラリ紹介 【第 5 回】 enumerator
tags: 0011 BundledLibraries
---


* Table of content
{:toc}


書いた人：西山

## はじめに

### この連載について

Ruby 1.8 になって標準添付ライブラリが増えました。そんなライブラリをどんどん紹介していこうという連載です。

### 今回の記事について

今回は [enumerator](ruby-man:enumerator.so) を紹介します。
ruby 1.9 では既に組み込みとなっていて、
今後はより広く一般的に用いられるようになると思われるライブラリです。

## enumerator とは？

[Enumerable モジュール](ruby-man:Enumerable)に含まれるすべてのメソッドは、
each メソッドを利用して実現されています。

例えば、通常は String#each を用いて行毎にインデックス付きで繰り返す 
String#each_with_index で、String#each の代わりに
String#each_byte を利用してバイト毎に処理してみたいと思ったことはありませんか？

IO.foreach などで each_with_index や collect などの
Enumerable モジュールのメソッドを利用したいと思ったことはありませんか？

それを叶えるために enumerator が作られました。

## 使用例

一番簡単な例は Object#enum_for で each の代わりに使いたいメソッドを指定して、Enumerable モジュールのメソッドを続けるだけです。

コメントに書いてあるものは出力例です。

{% highlight text %}
{% raw %}
 require 'enumerator'
 'abc'.enum_for(:each_byte).each_with_index do |e,i|
   puts "#{i}: #{e}"
 end
 #=>
 # 0: 97
 # 1: 98
 # 2: 99
{% endraw %}
{% endhighlight %}


enum_for を使わない場合は、このようになります。

{% highlight text %}
{% raw %}
 i = 0
 'abc'.each_byte do |e|
   puts "#{i}: #{e}"
   i += 1
 end
{% endraw %}
{% endhighlight %}


引数を必要とするメソッドでは、enum_for の第 2 引数以降に指定すれば
そのままメソッド (下の例では each_slice) に渡されます。

{% highlight text %}
{% raw %}
 require 'enumerator'
 [0,1,2,3,4,5].enum_for(:each_slice, 2).each_with_index do |e,i|
   p [e,i]
 end
 #=>
 # [[0, 1], 0]
 # [[2, 3], 1]
 # [[4, 5], 2]
{% endraw %}
{% endhighlight %}


enum_for を使わない場合は、このようになります。
each_slice が enumerator ライブラリで定義されているメソッドなので、
require は残しています。

{% highlight text %}
{% raw %}
 require 'enumerator'
 i = 0
 [0,1,2,3,4,5].each_slice(2) do |e|
   p [e,i]
   i += 1
 end
{% endraw %}
{% endhighlight %}


クラスメソッドでも同じように使えます。

{% highlight text %}
{% raw %}
 require 'enumerator'
 p IO.enum_for(:foreach, '/etc/hosts').grep(/^127\./)
 #=> ["127.0.0.1\tlocalhost.localdomain\tlocalhost\n"]
{% endraw %}
{% endhighlight %}


enum_for を使わない場合は、このようになります。

{% highlight text %}
{% raw %}
 result = []
 IO.foreach('/etc/hosts') do |line|
   if /^127\./ === line
     result.push(line)
   end
 end
 p result
{% endraw %}
{% endhighlight %}


## enumerator で追加されるクラスやメソッド

enumerator を require することによって、

* Enumerable::Enumerator クラス
* Object#to_enum(method_name = :each, *args)
* Object#enum_for(method_name = :each, *args)
* Enumerable#enum_with_index など


が追加されます。

ruby 1.9 (2005-07-15) 以降では組み込みになったため、
require する必要はありません。
[^1]

### Enumerable::Enumerator

使用例では説明を省略していましたが、Object#enum_for（または Object#to_enum）で Enumerable::Enumerator オブジェクトが生成されます。

Enumerable::Enumerator オブジェクトの生成は、以下の 3 通りあります。どれも同じ意味になります。

{% highlight text %}
{% raw %}
 enum = obj.enum_for(method_name, *args)
 enum = obj.to_enum(method_name, *args)
 enum = Enumerable::Enumerator.new(obj, method_name, *args)
{% endraw %}
{% endhighlight %}


使用例の例で言うと、それぞれ以下の 3 つずつが同じ意味になります。

{% highlight text %}
{% raw %}
 enum1 = 'abc'.enum_for(:each_byte)
 enum1 = 'abc'.to_enum(:each_byte)
 enum1 = Enumerable::Enumerator.new('abc', :each_byte)
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 enum2 = [0,1,2,3,4,5].enum_for(:each_slice, 2)
 enum2 = [0,1,2,3,4,5].to_enum(:each_slice, 2)
 enum2 = Enumerable::Enumerator.new([0,1,2,3,4,5], :each_slice, 2)
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 enum3 = IO.enum_for(:foreach, '/etc/hosts')
 enum3 = IO.to_enum(:foreach, '/etc/hosts')
 enum3 = Enumerable::Enumerator.new(IO, :foreach, '/etc/hosts')
{% endraw %}
{% endhighlight %}


そして、以下の 2 つが同じ意味になります。

{% highlight text %}
{% raw %}
 enum.each { ... }
 obj.method_name(*args) { ... }
{% endraw %}
{% endhighlight %}


上の enum1, enum2, enum3 の例でいうと、
それぞれ以下の 2 つずつが同じ意味になります。

{% highlight text %}
{% raw %}
 enum1.each { ...block1... }
 'abc'.each_byte { ...block1... }
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 [0,1,2,3,4,5].each_slice(2) { ...block2... }
 enum2.each { ...block2... }
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 IO.foreach('/etc/hosts') { ...block3... }
 enum3.each { ...block3... }
{% endraw %}
{% endhighlight %}


Enumerable::Enumerator は Enumerable をインクルードしているので、each の他に Enumerable のメソッドも使えます。

そのため、以下のような書き方が出来ます。
途中の enum1 などの変数を使わずに書くと、
使用例のところに出てきたような書き方になります。

{% highlight text %}
{% raw %}
 enum1.each_with_index do |e,i|
   puts "#{i}: #{e}"
 end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 enum2.each_with_index do |e,i|
   p [e,i]
 end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 p enum3.grep(/^127\./)
{% endraw %}
{% endhighlight %}


### Enumerable に追加されるメソッド

enumerator を require すると、
以下のメソッドが Enumerable に追加されます。

* enum_ 系
  * Enumerable#enum_cons(n)
  * Enumerable#enum_slice(n)
  * Enumerable#enum_with_index
* each_ 系
  * Enumerable#each_cons(n) {...}
  * Enumerable#each_slice(n) {...}


enum_ が頭についているメソッドは Enumerable::Enumerator を生成するメソッドになります。

each_ が頭についているメソッドは each と同じように繰り返すメソッドで、Enumerable::Enumerator とは直接の関係はないメソッドですが、
あると便利なので enumerator で定義されています。

each_slice と each_cons は、どちらも n 要素ずつ繰り返すメソッドです。
違いは言葉で説明するよりも、以下の使用例を見た方がわかりやすいと思います。

{% highlight text %}
{% raw %}
 require 'enumerator'
 (1..7).each_cons(5) {|x| p x}
 #=>
 # [1, 2, 3, 4, 5]
 # [2, 3, 4, 5, 6]
 # [3, 4, 5, 6, 7]
 (1..7).each_slice(3) {|x| p x}
 #=>
 # [1, 2, 3]
 # [4, 5, 6]
 # [7]
 (1..7).enum_cons(5).each_with_index {|x,i| p [x,i]}
 #=>
 # [[1, 2, 3, 4, 5], 0]
 # [[2, 3, 4, 5, 6], 1]
 # [[3, 4, 5, 6, 7], 2]
 (1..7).enum_slice(3).each_with_index {|x,i| p [x,i]}
 #=>
 # [[1, 2, 3], 0]
 # [[4, 5, 6], 1]
 # [[7], 2]
 ['a', 'b', 'c'].enum_with_index.select {|x,i| p x if i%2==0}
 #=>
 # "a"
 # "c"
{% endraw %}
{% endhighlight %}


## 終わりに

今回は便利そうなのに意外と使われていないような気がする enumerator を紹介してみました。

## 関連リンク

* [ruby-man:enumerator.so](ruby-man:enumerator.so)
* [ruby-man:Enumerable::Enumerator](ruby-man:Enumerable::Enumerator)
* [ruby-man:Enumerable](ruby-man:Enumerable)


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
  - [{{ post.title }}]({{ post.url }})
{% endfor %}

----

[^1]: 互換性のために $LOADED_FEATURES に "enumerator.so" が入っているので、require しても問題はありません。
