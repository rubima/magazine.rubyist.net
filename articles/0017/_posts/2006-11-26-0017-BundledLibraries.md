---
layout: post
title: 標準添付ライブラリ紹介 【第 10 回】 ERB
short_title: 標準添付ライブラリ紹介 【第 10 回】 ERB
created_on: 2006-11-26
tags: 0017 BundledLibraries
---
{% include base.html %}


書いた人：西山

## はじめに

Ruby には便利な標準添付ライブラリがたくさんありますが、なかなか知られていないのが現状です。そこで、この連載では Ruby の標準添付ライブラリを紹介していきます。

今回は、ERB について紹介します。

## eRuby, eruby, ERb, ERB

まず用語について説明します。

厳密には以下のような使い分けが可能ですが、(Perl と perl の使い分けと違って) 大文字で始まる Ruby と小文字で始まる ruby が使い分けられていないのと同じように、使い分けにはあまりこだわらなくても構いません。 

eRuby
: 任意のテキストファイルに Ruby スクリプトを埋め込む書式の仕様

eruby
: 前田修吾さん作の eRuby の C による実装

ERB
: 関将俊さん作の eRuby の Ruby による実装

ERb
: ERB が標準添付になる前のバージョン (ERb と ERbLight があった)

## eRuby

eRuby では任意のテキストファイルに Ruby スクリプトを埋め込めます。
基本的には、次のマークアップ (eRuby タグ) を使って Ruby スクリプトを埋め込みます。

&lt;% ... %&gt;
: Ruby スクリプト片をその場で実行

&lt;%= ... %&gt;
: 式を評価した結果をその場に挿入

&lt;%# ... %&gt;
: eRuby のコメント (ERB#src (後述) にも埋め込まれない)

&lt;%%
: 「&lt;%」をその場に挿入 (「&lt;% ... %&gt;」の中ではそのまま)

%%&gt;
: 「&lt;% ... %&gt;」などの中で「%&gt;」になる (「&lt;% ... %&gt;」の外では「%%&gt;」のまま)

% で始まる行
: ERB で trim_mode (後述) が '%' の時、また、eruby ではいつでも、Ruby スクリプト片をその場で実行

%% で始まる行
: ERB で trim_mode (後述) が '%' の時、また、eruby ではいつでも、% で始まる行になる

その他の部分 (地の文) はそのまま出力されます。

eRuby は HTML や XML に限らず、任意のテキストファイルの出力に使用できます。

## ERB

では、eRuby を実際に使うためのライブラリである ERB について解説します。

### 基本的な使い方

ERB の一番基本的な使い方では、eRuby スクリプトを ERB.new の第一引数に指定して ERB オブジェクトを生成して、result メソッドで結果を文字列で取得します。

例:

{% highlight text %}
{% raw %}
require 'erb'
str = "hoge"
erb = ERB.new("value = <%= str %>")
puts erb.result(binding)
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
value = hoge
{% endraw %}
{% endhighlight %}


あまり良い例ではありませんが、ここでは例としてかけ算の九九の表を生成するスクリプトを作ってみました。

{% highlight text %}
{% raw %}
require 'erb'
puts ERB.new(DATA.read).result(binding)
__END__
 <% (1..9).each do |y| %>  <%= y %><% end %>
<%
(1..9).each do |x|
%><%= x %><%
  (1..9).each do |y|
%><%= sprintf '%3d', x*y %><%
  end
%>
<% end %>
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
   1  2  3  4  5  6  7  8  9
1  1  2  3  4  5  6  7  8  9
2  2  4  6  8 10 12 14 16 18
3  3  6  9 12 15 18 21 24 27
4  4  8 12 16 20 24 28 32 36
5  5 10 15 20 25 30 35 40 45
6  6 12 18 24 30 36 42 48 54
7  7 14 21 28 35 42 49 56 63
8  8 16 24 32 40 48 56 64 72
9  9 18 27 36 45 54 63 72 81
{% endraw %}
{% endhighlight %}


まず 1 行目で ERB を使うために erb ライブラリを require しています。

次に DATA.read で __END__ 以降の内容を読み込んでいます。
ここでは例を簡単にするために Ruby スクリプトの末尾に __END__ を使って eRuby スクリプトを埋め込んでいますが、普通は別ファイルから読み込みます。

そして読み込んだ eRuby スクリプトを使って ERB オブジェクトを生成して、result メソッドを使って結果の文字列を取得しています。
result メソッドの引数に組み込み関数 binding を使って取得した Binding オブジェクトを指定しています。

最後に結果の文字列を puts を使って出力しています。

### ERB#run

ERB#run は ERB#result の結果をそのまま標準出力に出力します。
結果の文字列を加工したり、他の処理に利用したりする場合は ERB#result を使う必要がありますが、出力するだけなら ERB#run が使えます。

先ほどの例ではそのまま出力するだけだったので、ERB#result の値を puts する代わりに ERB#run を使っても同じ出力が得られます。

__END__ 以降と出力例は同じなので省略します。

{% highlight text %}
{% raw %}
require 'erb'
ERB.new(DATA.read).run(binding)
__END__
{% endraw %}
{% endhighlight %}


### ERB#src

ERB#src は eRuby を Ruby スクリプトに変換したソースを返します。
Ruby スクリプトに変換した結果をキャッシュしたり、eval で実行したりすることが出来ます。

上記の例のように Ruby スクリプトに直接 eRuby を埋め込んだ場合、eRuby 部分で例外が発生すると実際のファイル名と行番号とは違っていて、エラーの場所を特定しにくくなります。
そういう場合は ERB#src と eval を使って、ファイル名と行番号を指定することによってエラーの場所がわかりやすくなります。

たとえば、

{% highlight text %}
{% raw %}
#!/usr/bin/ruby -Ke
require 'erb'
now = Time.now
puts eval(ERB.new(DATA.read).src, binding, __FILE__, __LINE__+2)
__END__
今日は<%= now.stftime("%Y-%m-%d") %>です。
{% endraw %}
{% endhighlight %}


というスクリプトなら

{% highlight text %}
{% raw %}
e.rb:6: undefined method `stftime' for Sat Nov 11 12:09:15 JST 2006:Time (NoMethodError)
        from e.rb:4
{% endraw %}
{% endhighlight %}


のようになります。

### ERB#filename, ERB#filename=

attr_accessor で定義されている ERB#filename, ERB#filename= を使って、エラーメッセージ用のファイル名の取得や設定が出来ます。

ファイル名を変更するだけなら ERB#src で取得した Ruby スクリプトを eval する代わりに ERB#filename= が使えます。

使用例:

{% highlight text %}
{% raw %}
#!/usr/bin/ruby -Ke
require 'erb'
fname = ARGV.shift
erb = ERB.new(File.read(fname))
erb.filename = fname
puts erb.result(binding)
{% endraw %}
{% endhighlight %}


### binding 引数

ローカル変数やインスタンス変数を eRuby スクリプトの中で使いたい場合は、適切な場所の Binding オブジェクトを ERB#result や ERB#run に指定する必要があります。

どこで実行しても同じ結果になるスクリプトの場合は result メソッドの引数の binding を省略してデフォルトの TOPLEVEL_BINDING でも構いません。
上記の九九の例の場合は x と y というローカル変数を使っているので、eRuby スクリプトの実行前にローカル変数 x または y を使っていると、どちらも 9 に変わってしまいます。

__END__ 以降は同じなので省略します。

{% highlight text %}
{% raw %}
require 'erb'
x = y = nil
ERB.new(DATA.read).result(binding)
p x, y
__END__
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
9
9
{% endraw %}
{% endhighlight %}


### trim_mode

先ほどの例の eRuby スクリプトでは余分な改行や空白が入らないようにするために「&lt;%」や「%&gt;」などの位置がわかりにくくなっています。

HTML の場合は改行の位置や空白などは気にせずに書いても、ブラウザで表示させたときに連続する空白は単独の空白と同じ扱いになるので気にならないのですが、HTML を直接見た場合には気になってしまいます。

そこで ERB には trim_mode という機能がついています。

#### trim_mode = '-'

'-'　という trim_mode では、以下の違いがあります。

&lt;%-
: (「&lt;%-」のインデントに使われている) 行頭の空白文字を削除

-%&gt;
: 直後の改行を出力しない

「&lt;%-」と行頭の間に空白以外の文字があったり、「-%&gt;」と改行の間に (空白も含めて) 他の文字があったりすると、「&lt;%」や「%&gt;」と同じ挙動になります。

#### trim_mode の使用例

先ほどの九九の例を、ここでは Rails でデフォルトとして使われている '-' という trim_mode を使って書き直してみます。

出力例は同じなので省略します。

{% highlight text %}
{% raw %}
require 'erb'
puts ERB.new(DATA.read, nil, '-').result(binding)
__END__
 <% (1..9).each do |y| %>  <%= y %><% end %>
<%- (1..9).each do |x| -%>
<%= x -%>
  <%- (1..9).each do |y| -%>
<%= sprintf '%3d', x*y -%>
  <%- end %>
<%- end -%>
{% endraw %}
{% endhighlight %}


「&lt;%」(または「「&lt;%=」) と「%&gt;」の対応がそれぞれの行に収まっていたり、
内側のループがインデント出来たりして、最初の例より読みやすく出来ています。

読みやすく出来るようになったところで HTML (の一部) を出力するように変更してみましょう。

{% highlight text %}
{% raw %}
require 'erb'
puts ERB.new(DATA.read, nil, '-').result(binding)
__END__
<table>
  <tr>
  <%- (1..9).each do |y| -%>
    <th><%= y %></th>
  <%- end -%>
  </tr>
<%- (1..9).each do |x| -%>
  <tr>
    <th><%= x %></th>
  <%- (1..9).each do |y| -%>
    <td><%= x*y %></td>
  <%- end -%>
  </tr>
<%- end -%>
</table>
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
<table>
  <tr>
    <th>1</th>
    <th>2</th>
    <th>3</th>
    <th>4</th>
    <th>5</th>
    <th>6</th>
    <th>7</th>
    <th>8</th>
    <th>9</th>
  </tr>
  <tr>
    <th>1</th>
    <td>1</td>
    <td>2</td>
    <td>3</td>
    <td>4</td>
    <td>5</td>
    <td>6</td>
    <td>7</td>
    <td>8</td>
    <td>9</td>
  </tr>
  <tr>
    <th>2</th>
    <td>2</td>
    <td>4</td>
    <td>6</td>
    <td>8</td>
    <td>10</td>
    <td>12</td>
    <td>14</td>
    <td>16</td>
    <td>18</td>
  </tr>
(中略)
  <tr>
    <th>9</th>
    <td>9</td>
    <td>18</td>
    <td>27</td>
    <td>36</td>
    <td>45</td>
    <td>54</td>
    <td>63</td>
    <td>72</td>
    <td>81</td>
  </tr>
</table>
{% endraw %}
{% endhighlight %}


長いので途中を省略しましたが、eRuby スクリプトも出力結果も読みやすく出来るようになりました。

#### trim_mode = '%'

trim_mode に '%' を指定すると「%」で始まる行を「&lt;% ... %&gt;」と同じように Ruby スクリプトとして実行します。その行の改行は出力しません。

{% highlight text %}
{% raw %}
require 'erb'
puts ERB.new(DATA.read, nil, '%').result(binding)
__END__
% require 'mathn'
<%= 1/2 + 1/3 %>
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
5/6
{% endraw %}
{% endhighlight %}


#### その他の trim_mode

'-' と '%' の他に改行の扱いを変える '&gt;' と '&lt;&gt;' があります。

'&gt;' は行末が「%&gt;」の時に改行を出力しません。
すべての「%&gt;」が trim_mode が '-' の「-%&gt;」相当になるようなものです。
「%&gt;」と改行 ("\n") の間に空白を含めて他の文字が入っていると改行が出力されます。

'&lt;&gt;' は行頭が「&lt;%」かつ行末が「%&gt;」の行の改行を出力しません。
「&lt;% end %&gt;」とそれに対応する「&lt;% if ... %&gt;」や「&lt;% ....each do %&gt;」などの改行を出力したくない時に使えます。
行頭と行末の両方を見て改行を出力するかどうかを決めているので、trim_mode が '-' の時の「&lt;%- ... -%&gt;」と違って、行頭がインデントされていると行頭の空白も改行も出力されてしまいます。

#### trim_mode のまとめ

まとめると以下のようになります。

nil または '' または 0
: (デフォルト)

'&gt;' または 1
: 行末が「%&gt;」の時に改行を出力しない

'&lt;&gt;' または 2
: 行頭が「&lt;%」で行末が「%&gt;」の時に改行を出力しない

'-':行頭が「&lt;%-」の時に (インデントに使われている) 行頭の空白文字を削除、行末が「-%&gt;」の時に直後の改行を出力しない
'%':「%」で始まる行を「&lt;% ... %&gt;」と同じように Ruby スクリプトとして実行して改行は出力しない
'%&gt;' または '&gt;%':'&gt;' と '%' の両方
'%&lt;&gt;' または '&lt;&gt;%':'&lt;&gt;' と '%' の両方
'%-':'-' と '%' の両方

改行文字は "\n" のみを想定しているため、行末を見て改行を出力しないようになっているものは、改行が "\n" ではなく "\r\n" になっている場合も改行が出力されてしまいます。

具体的には、'&gt;' または '&lt;&gt;' の時に "&lt;% ... %&gt;\r\n" となっている、または '-' の時に "... -%&gt;\r\n" になっていると、行末に "\r" が入っていることになってしまって、改行が出力されてしまいます。

### ERB.new のその他の引数

#### safe_level

ERB.new の第 2 引数で eRuby スクリプトが実行されるときのセーフレベルを指定することが出来ます。CGI の中で使われる時は 1 が指定されることが多いようです。

safe_level を気にしない場合は nil を指定します。

間違えて 0 や今のセーフレベルを指定すると、ERB#result が呼ばれたときのセーフレベルで実行可能な内容だったとしても、実行前にセーフレベルを変更しようとして SecurityError になってしまいます。

{% highlight text %}
{% raw %}
require 'erb'
erb = ERB.new('', $SAFE)
$SAFE = 1
erb.run
{% endraw %}
{% endhighlight %}


実行例:

{% highlight text %}
{% raw %}
/usr/lib/ruby/1.8/erb.rb:736:in `result': tried to downgrade safe level from 1 to 0 (SecurityError)
        from /usr/lib/ruby/1.8/erb.rb:739:in `value'
        from /usr/lib/ruby/1.8/erb.rb:739:in `result'
        from /usr/lib/ruby/1.8/erb.rb:722:in `run'
        from e.rb:4
{% endraw %}
{% endhighlight %}


#### eoutvar

ERB.new の第 4 引数で eRuby スクリプトの中で出力をためていく変数を変更することが出来ます。
eRuby スクリプトの中で eRuby スクリプトを使う場合は変更する必要がありますが、普通は変更する必要はありません。

変更する必要がある場合というのは、たとえば以下のようなスクリプトの場合です。

{% highlight text %}
{% raw %}
require 'erb'
erb1 = ERB.new("erb1")
erb2 = ERB.new("erb2: <%= erb1.result(binding) %>")
puts "erb2 without eoutvar:"
puts erb2.result
erb2 = ERB.new("erb2: <%= erb1.result(binding) %>", nil, nil, '_erbout2')
puts "erb2 with eoutvar:"
puts erb2.result
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
erb2 without eoutvar:
erb1
erb2 with eoutvar:
erb2: erb1
{% endraw %}
{% endhighlight %}


この例では erb2 の方で変更しましたが、erb1 の方を変更しても良いでしょう。

### メソッドとして使う

今までの例では ERB オブジェクトを直接扱っていましたが、メソッドとして定義することによって、binding などを気にせずに普通のメソッドとして扱えるようになります。

eRuby をメソッドとして使う例としては、header や footer のように HTML の断片を返すといった使い方があります。

#### ERB#def_method

ERB#def_method を使うことで eRuby をメソッドとして使うことが出来ます。

メソッドということで、ここではメソッドの引数やインスタンス変数を使う例を作ってみました。

age.rb:

{% highlight text %}
{% raw %}
require 'erb'
class Hoge
  def initialize
    @year = 1993
  end
end
erb = File.open('age.erb') {|f| ERB.new(f.read)}
erb.def_method(Hoge, 'age(this_year)', 'age.erb')
puts Hoge.new.age(Time.now.year)
{% endraw %}
{% endhighlight %}


age.erb:

{% highlight text %}
{% raw %}
生まれた年: <%= @year %>
数え年: <%= this_year - @year + 1%>
{% endraw %}
{% endhighlight %}


出力例:

{% highlight text %}
{% raw %}
生まれた年: 1993
数え年: 14
{% endraw %}
{% endhighlight %}


ERB#def_method(mod, methodname, fname='(ERB)') の引数は以下の通りです。

mod
: メソッドを定義するモジュール (またはクラス)

methodname
: メソッド定義の def の右の部分

fname
: エラー表示用のファイル名

methodname は def の右の部分なので、例のように引数を付けたり、「foo(bar='bar')」のようにデフォルト引数をつけたりすることも出来ます。

#### ERB::DefMethod.def_erb_method

def_erb_method(methodname, erb) を使って、もっと簡単にファイル名だけでメソッド定義ができるようになります。

使い方は、ERbMethod を extend して、def_erb_method の引数にメソッド名とファイル名を指定します。

例:

{% highlight text %}
{% raw %}
require 'erb'
class Hoge
  extend ERB::DefMethod
  def_erb_method('to_html', 'hoge.rhtml')
end
puts Hoge.new.to_html
{% endraw %}
{% endhighlight %}


def_erb_method(methodname, erb) の引数は以下の通りです。

methodname
: ERB#def_method の methodname と同じ

erb
: 文字列ならファイル名として読み込んで ERB に変換してメソッドとして定義

erb には直接 ERB オブジェクトを渡すことも出来ます。
そのときは「erb.def_method(self, methodname)」と同じ意味になります。

先ほどの例を ERB::DefMethod を使って書き直すと、以下のようになります。

age.rb:

{% highlight text %}
{% raw %}
require 'erb'
class Hoge
  extend ERB::DefMethod

  def initialize
    @year = 1993
  end

  def_erb_method('age(this_year)', 'age.erb')
end
puts Hoge.new.age(Time.now.year)
{% endraw %}
{% endhighlight %}


#### ERB#def_module, ERB#def_class

ERB#def_module(methodname='erb') と ERB#def_class(suplerklass=Object, methodname='erb') というメソッドもあります。
これはそれぞれメソッドを定義した無名のモジュール、無名のクラスを返すメソッドです。

### ERB::Util

ERB::Util を include することで、HTML などを生成するときに便利な

* HTML の「&amp;"&lt;&gt;」のエスケープをする html_escape, h
* URL エンコードする url_encode, u


という 4 つのメソッドが使えるようになります。

h と u は eRuby の中で「&lt;a href="&lt;%=u url %&gt;"&gt;&lt;%=h str %&gt;&lt;/a&gt;」のように使うことで、「&lt;%=h ... %&gt;」や「&lt;%=u ... %&gt;」という見やすい書き方が出来るようになっています。

### 標準出力

元々の eRuby では標準出力への出力もその場所に埋め込まれるようになっていたので、eRuby 内の Ruby スクリプト片で標準出力を行った場合、eruby や (旧) ERb では出力内容がその場所に埋め込まれます。
一方、ERB とその元になった ERbLight では「&lt;%= ... %&gt;」を使わないと、そのまま標準出力に出力されてしまいます。

hello.erb:

{% highlight text %}
{% raw %}
Hello, <% print "World" %>.
{% endraw %}
{% endhighlight %}


という eRuby で、 eruby と ERB では次のような違いが出てきます。

eruby:

{% highlight text %}
{% raw %}
Hello, World.
{% endraw %}
{% endhighlight %}


ERB:

{% highlight text %}
{% raw %}
WorldHello, .
{% endraw %}
{% endhighlight %}


その場所に出力を埋め込みたい場合は、普通は print などは使わず「&lt;%= ... %&gt;」だけを使うようにすれば良いと思います。

## おわりに

今回は ERB を中心に eRuby について紹介しました。

ruby 1.8.5 の ERB では、[ERB, quote](http://www.druby.org/ilikeruby/erbquote.html) の脚注に書かかれているように、[ruby-list:41960](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/41960) で紹介されている &lt;%= ... %&gt; の出力内容を自動的にエスケープに対応するためのインターフェイスが入っています。興味があれば試してみてください。

## 関連リンク

* [ruby-man:ERB](ruby-man:ERB)
* [ERB](http://www.druby.org/ilikeruby/erb.html)
* [the erb way](http://www.druby.org/ilikeruby/erbway.html)
* [ERB More](http://www.druby.org/ilikeruby/erbmore.html)


## 著者について

西山和広。
[Ruby hotlinks 五月雨版](http://www.rubyist.net/~kazu/samidare/)や
現在の [Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)のメンテナをやっています。
[Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)はいつでも[執筆者募集中](ruby-man:執筆者募集)です。
何かあれば、マニュアル執筆編集に関する議論をするためのメーリングリスト rubyist@freeml.com ([参加方法](http://www.freeml.com/ctrl/html/MLInfoForm/rubyist)) へどうぞ。

Ruby リファレンスマニュアルは現在青木さんによる新システムに移行準備中です。
手伝っていただける方は [ruby-reference-manual ML](http://www.loveruby.net/d/20060904.html#p01) に入ってください。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}


