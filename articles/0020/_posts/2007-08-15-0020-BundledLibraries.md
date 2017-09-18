---
layout: post
title: 標準添付ライブラリ紹介 【第 13 回】 正規表現 (2)
short_title: 標準添付ライブラリ紹介 【第 13 回】 正規表現 (2)
tags: 0020 BundledLibraries
---


書いた人：西山

## はじめに

Ruby には便利な標準添付ライブラリがたくさんありますが、なかなか知られていないのが現状です。そこで、この連載では Ruby の標準添付ライブラリを紹介していきます。

今回は、何回の連載になるのか未定の正規表現についての話の続きです。

## 正規表現

### グロブとの違い

シェルや Dir.glob や File.fnmatch で使えるグロブのパターンと混同するという間違いがたまにあります。

グロブの「*」は正規表現では「.*」に、グロブの「?」は正規表現では「.」と似た意味になります。(パスの区切り文字の扱いや、Unix ではドットファイルの扱いや Windows 上では拡張子の扱いなどがあるため厳密には違います。)

グロブの文字クラスは「[a-z]」などのように似ています。
文字クラスの後に「*」が続いて「[a-z]*」のようになっていると、グロブでは英小文字で始まる任意のファイル名という意味になります。これを正規表現と混同してしまうと英小文字だけからなる文字列となり、二文字目以降に英小文字以外がある場合も含まれてしまって悩んでしまうことになります。

### 最左最長マッチ

Ruby の正規表現は基本的には最左最長マッチです。

#### 最左

ここではまず「/bc|ab/ =~ "abc"」という処理を考えてみます。
以下はこう読んでいっているはずと言うだけで細部は実際の処理とは違う可能性があります。

1. まず "abc" の先頭の a の前の位置を考えます。ここでマッチするのは「\A」や「^」です。幅 0 のアトムがないので、文字列の次の位置を調べます。
1. 次に文字列の「a」の位置です。ここで「bc」の「b」がマッチするか考えます。マッチしないので、次の選択肢の「ab」にうつります。
1. 「ab」という正規表現の「a」とマッチするか調べます。マッチするので文字列側は「a」と「b」の間に移動します。
1. 正規表現に幅 0 のアトムがないので、文字列の次の「b」の位置に進みます。
1. 正規表現の次のアトムの「b」が文字列の「b」にマッチします。
1. 正規表現の終わりなので、正規表現がマッチしました。


これで「$&amp;」は「ab」になります。

Ruby の正規表現では最左とは、

* 文字列の中でマッチする位置のうち、一番最初 (左) でマッチする
* 選択はマッチするもののうち、一番左のものがマッチする


という意味だとわかります。

#### 最長マッチ

最左最長マッチの最長とは「/\w+/ =~ "abc"」という場合に、1 回以上なら「a」だけでもマッチになりますが、最長マッチのため「abc」にマッチすることになります。

最左最長マッチは、最長よりも最左が優先です。たとえば「/a|\w+/ =~ "abc"」だと最左のところで説明したように「\w+」よりも選択の左の「a」が先にマッチするため、正規表現全体としては「abc」ではなく「a」にマッチすることになります。

### クロイスタ

「//i」の代わりに「(?i:〜)」などのように「(?」と「:」の間にオプションを書く記法をクロイスタと言います。
Ruby では Regexp#to_s でこの形式になります。
正規表現をリテラルで書くときには、あまり使うことがないかもしれません。

使用例として、一時的にオプションを変えたいときに「(?m:.)」で改行を含む任意の一文字にしたり、ファイルから読み込んだ文字列から正規表現を生成するときに「(?i:rfc)\d+」などのように書いておいたりなどがあります。

### $KCODE

正規表現オブジェクトの生成時に「//u」などで kcode を指定することができます。
kcode を指定しなかった場合はマッチ時の $KCODE を使うという意味になります。
その場合でもプログラム自体はパース時の $KCODE でパースされるので、正規表現をリテラルで書く場合は読み込み時の $KCODE にも気を付ける必要があります。

#### -K オプション

ruby コマンドでの処理は大きくわけて次の 3 つの段階にわかれます。

* コマンドラインオプションの解釈
* プログラムの読み込み (パースなど)
* プログラムの実行


最初のコマンドラインオプションの解釈で -K オプションは解釈されて $KCODE が設定されるため、プログラムの読み込みにも影響します。

プログラム中で $KCODE を設定するのは、プログラムの実行の段階での設定になるため、既に終わってしまっているプログラムの読み込みに影響を与えることはできません。

ただしこれは最初に実行されるプログラムのファイルについての話で、require や load や eval はプログラムの実行の段階でプログラムの読み込みなどが行われるため、require する前の $KCODE の変更が影響します。

#### 例

例えば Shift_JIS で書かれた

{% highlight text %}
{% raw %}
p /表/s
{% endraw %}
{% endhighlight %}


というプログラム sample.rb があったとき、そのまま実行するとパース時は $KCODE が "NONE" なので、「表」が "\225\\" として扱われて、2 バイト目が「\」なので、正規表現を閉じるはずの「/」がエスケープされてしまって、正規表現を閉じる部分がみつからずに

{% highlight text %}
{% raw %}
% ruby sample.rb
sample.rb:1: unterminated string meets end of file
sample.rb:1: syntax error, unexpected tSTRING_END, expecting
tSTRING_CONTENT or tREGEXP_END or tSTRING_DBEG or tSTRING_DVAR
%
{% endraw %}
{% endhighlight %}


となり、パースに失敗してしまうことがわかります。

これはコマンドラインの -K オプションで指定するか shebang 行 (1 行目の #! で始まる行) で $KCODE が "SJIS" になるように指定すれば解決します。

{% highlight text %}
{% raw %}
% ruby -Ks sample.rb
/表/s
% cat sample2.rb
#!/usr/bin/ruby -Ks
p /表/s
% ruby sample2.rb
/表/s
%
{% endraw %}
{% endhighlight %}


プログラム中で $KCODE を設定する方法では、パース時点の $KCODE には影響しないため、エラーになります。

{% highlight text %}
{% raw %}
% cat sample3.rb
$KCODE = 'S'
p /表/s
% ruby sample3.rb
sample3.rb:2: unterminated string meets end of file
sample3.rb:2: syntax error, unexpected tSTRING_END, expecting
tSTRING_CONTENT or tREGEXP_END or tSTRING_DBEG or tSTRING_DVAR
%
{% endraw %}
{% endhighlight %}


メイン部分のプログラムを US-ASCII のみで書いておき、$KCODE を設定してから require や load などをするという手もあります。
$KCODE への代入は最初の一文字目しか影響しないため、"Shift_JIS" でも "SJIS" でも $KCODE は "SJIS" になります。大文字小文字も関係なく、"s" でも $KCODE が "SJIS" になります。

{% highlight text %}
{% raw %}
% cat sample4.rb
$KCODE = 's'
require 'sample'
% ruby sample4.rb
/表/s
%
{% endraw %}
{% endhighlight %}


eval を使った場合も eval 時点の $KCODE でパースされるので、次のように $KCODE を設定してから eval するという手もあります。
$KCODE の話とは直接は関係ありませんが、eval は 4 引数で使うとエラーの時に「(eval):1」のようにどこが原因なのかわかりにくいエラーメッセージではなく、指定したファイル名と行番号を元にした情報が出てくるので、エラーメッセージがわかりやすくなります。

{% highlight text %}
{% raw %}
% cat sample5.rb
$KCODE = 's'
eval DATA.read, binding, __FILE__, __LINE__+2
__END__
p /表/s
raise "sample"
% ruby sample5.rb
/表/s
sample5.rb:5: sample (RuntimeError)
        from sample5.rb:2
%
{% endraw %}
{% endhighlight %}


ERB のように間接的に eval を使う場合も $KCODE を考慮する必要があります。

{% highlight text %}
{% raw %}
% cat sample6.rb
require 'erb'
puts ERB.new('<%="表"%>').result
% ruby -Ks sample6.rb
表
% ruby sample6.rb
(erb):1: compile error (SyntaxError)
(erb):1: unterminated string meets end of file
(erb):1: syntax error, unexpected $end, expecting ')'
_erbout = ''; _erbout.concat(("表").to_s); _erbout
                                                  ^
%
{% endraw %}
{% endhighlight %}


eval する文字列をリテラルとして書いておくことも出来ます。その場合は外側のパース時点での解釈も考慮する必要があります。
わかりにくくなるので、普通はリテラルで書いた文字列の eval で US-ASCII 以外の文字列を使うのは避けるか、$KCODE は途中で変更しないことをおすすめします。

{% highlight text %}
{% raw %}
% cat sample7.rb
$KCODE = 's'
code = 'p /表/s'
puts code.dump
eval code, binding, __FILE__, __LINE__
code = "p /表\\/s"
puts code.dump
eval code, binding, __FILE__, __LINE__
% ruby sample7.rb
"p /\225\\/s"
/表/s
"p /\225\\/s"
/表/s
% ruby -Ks sample7.rb
"p /\225\\/s"
/表/s
"p /\225\\\\/s"
sample7.rb:7: compile error (SyntaxError)
sample7.rb:7: unterminated string meets end of file
sample7.rb:7: syntax error, unexpected tSTRING_END, expecting
tSTRING_CONTENT or tREGEXP_END or tSTRING_DBEG or tSTRING_DVAR
p /表\/s
        ^       from sample7.rb:7
%
{% endraw %}
{% endhighlight %}


#### $KCODE のデフォルト

あまり使うことはないと思いますが、デフォルトの $KCODE は ruby をビルドするときの --with-default-kcode=CODE で "NONE" 以外に変更することも出来ます。普通は -K オプションで明示的に指定するか、直接起動するプログラム中では US-ASCII のみを使い $KCODE をセットした後、US-ASCII 以外を含むプログラムを require するなどの方法をおすすめします。

## 後方参照 (back reference) (\1, \2, ...)

後方参照 (back reference) は [[ruby-dev:30977]](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/30977) に例があったので、これを元に説明します。
パッチの一部を引用すると以下のようになっています。

{% highlight text %}
{% raw %}
-    parse_files_matching(/\.(c|cc|cpp|CC)$/)
+    parse_files_matching(/\.(?:([CcHh])\1?|c([+xp])\2|y)\z/)
{% endraw %}
{% endhighlight %}


この中の変更前 (「-」で始まる行) の正規表現は「.c」「.cc」「.cpp」「.CC」で終わる行がある文字列にマッチする正規表現です。

変更後 (「+」で始まる行) の正規表現は「.C」「.CC」「.c」「.cc」「.H」「.HH」「.h」「.hh」「.c++」「.cxx」「.cpp」「.y」で終わる文字列にマッチする正規表現になっています。

ここで「/\.(?:([CcHh]){1,2}|c([+xp]){2}|y)\z/」のように繰り返しを使うとどうなるでしょうか。
繰り返しを使うと正規表現自体が複数回という意味になり、「.ch」などにもマッチしてしまいます。
後方参照 (back reference) では、「\1」でマッチするものは「([CcHh])」がマッチするものではなく、「([CcHh])」がマッチした「c」なら「c」と同じものが「\1」でマッチするという意味になるので、「.ch」にはマッチしなくなります。

## \G

スキャナやパーサなどを作るときに文字列の正規表現にマッチする部分を順番に切り出していきたいことがあります。そういう場合に使える可能性があるのが「\G」です。「\G」は、前回マッチした箇所の直後を表す記号です。初回は先頭にマッチします (「\A」と同じ)。
簡単な使用例を載せておきます。

{% highlight text %}
{% raw %}
str = "1 * 2 + 3"
str.scan(/\G\s*(?:(\w+)|([^\s\w]+))/) do
  if $1
    puts "w:#{$1}"
  elsif $2
    puts "W:#{$2}"
  else
    raise "unexpected input"
  end
end
{% endraw %}
{% endhighlight %}


出力例

{% highlight text %}
{% raw %}
w:1
W:*
w:2
W:+
w:3
{% endraw %}
{% endhighlight %}


scan や gsub などのように複数回マッチするメソッドでは「\G」を使う意味がありますが、sub などの一回しかマッチしないメソッドでは「\A」と同じ意味にしかならないので、「\G」の使いどころはあまり多くはなさそうです。

実際にはスキャナなどを書くときには strscan を使うのがおすすめです。

## strscan

strscan は簡単に高速なスキャナを記述できる文字列スキャナライブラリです。
RDtool などで使われています。

StringScanner オブジェクトが文字列のどこを見ているかの情報を覚えていて、前から順番に文字列を切り出していく処理に適しています。

さきほどの例を strscan を使って書き直すと以下のようになります。
出力例は同じなので省略します。

{% highlight text %}
{% raw %}
require 'strscan'
str = "1 * 2 + 3"
s = StringScanner.new(str)
until s.eos?
  s.skip(/\s*/)
  case
  when s.scan(/\w+/)
    puts "w:#{s[0]}"
  when s.scan(/[^\s\w]+/)
    puts "W:#{s[0]}"
  else
    raise "unexpected input"
  end
end
{% endraw %}
{% endhighlight %}


詳しい使い方は strscan のマニュアルなどを参照してください。

## まとめ

今回は前回載せられなかった部分と $KCODE について書きました。
$KCODE と -K オプションの話は、わかっていないと間違いやすい部分だと思ったので、例を多めにしてしっかり説明してみたつもりです。

## 著者について

西山和広。
最近は自己紹介でこの連載を書いてます、と言っています。
[Ruby hotlinks 五月雨版](http://www.rubyist.net/~kazu/samidare/)のメンテナンスもたまにやってます。

Ruby リファレンスマニュアル刷新計画は一番人手が必要そうな第 3 段階が進行中なので、[るりま Wiki](http://doc.loveruby.net/wiki/) を参考にしてお手伝いをお願いします。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}


