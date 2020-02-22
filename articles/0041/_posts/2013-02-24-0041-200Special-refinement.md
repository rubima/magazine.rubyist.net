---
layout: post
title: Refinementsとは何だったのか
short_title: Refinementsとは何だったのか
created_on: 2013-02-24
tags: 0041 200Special
---
{% include base.html %}


書いた人：前田修吾 ([@shugomaeda](https://twitter.com/shugomaeda))

## はじめに

本記事では、Ruby 2.0 に入るはずだった Refinements とはいったい何だったのか解説します。

## Refinements とは

Ruby にはクラスを再定義して拡張する機能があり、オープンクラスやモンキーパッチと呼ばれて広く利用されています。Rails などで便利に利用されている一方で、やり過ぎると大変なことになります。

例えば、標準添付の mathn を require すると、Fixnum#/ などの挙動がグローバルに変わってしまいます。

{% highlight text %}
{% raw %}
p 1 / 2 #=> 0
require "mathn"
p 1 / 2 #=> (1/2)
{% endraw %}
{% endhighlight %}


Refinements とは、モンキーパッチの影響範囲を特定のスコープに限定する機能で、筆者が提案したものです。

クラスを拡張する側は、Module#refine を使って、引数で指定されたクラスを拡張します。

{% highlight text %}
{% raw %}
# rationalize.rb
module Rationalize
  refine Fixnum do
    def /(other)
      quo(other)
    end
  end
end
{% endraw %}
{% endhighlight %}


refine のブロックでは refinement と呼ばれる匿名モジュールが self になっていて、その匿名モジュールにメソッドを追加することができるようになっています。

使う側は、使いたいファイルで

{% highlight text %}
{% raw %}
using Rationalize
p 1 / 2 #=> (1/2)
{% endraw %}
{% endhighlight %}


と書いてやれば、そのファイルでは上記の拡張が有効になりますが、他のファイルには影響が及びません。

## Refinements の仕様

Refinements の仕様は、以下の Wiki ページに詳しく記述されています。

* [Refinements Specification](https://bugs.ruby-lang.org/projects/ruby-trunk/wiki/RefinementsSpec)


ただせっかく書いたのですが、あまり読まれていないようなので、バグがあるかもしれません。

## 結局どうなった?

Refinements は Ruby 2.0 の目玉機能になるはずでした。しかし、紆余曲折があり、一時は提案者である筆者自身ももう削除しようよと言い出す始末でしたが、結局大幅に機能を限定した上で試験的な機能として導入されることになりました。

試験的な機能なので、最初に refine か using を使用した時に警告が表示されます。

{% highlight text %}
{% raw %}
$ ruby -e 'module M; refine String do end; end'
-e:1: warning: Refinements are experimental, and the behavior may change in future versions of Ruby!
{% endraw %}
{% endhighlight %}


将来仕様が変わっても文句を言わないようにしてください。

## 削除された機能

先程述べたとおり、当初の提案から様々な機能が削除されています。
ざっと挙げると以下のとおりです。

* モジュール単位で refinement を有効にする機能。
* using されたモジュールの refinement を継承する機能。
* refine で (クラスではなく) モジュールを拡張する機能。
* using された複数の refinement 間で super を順に呼び出す機能。
* module_eval や instance_eval で refinement を有効にする機能。


とくに最後のものがインパクトが大きく、言語内 DSL の実装には使いにくくなってしまいました。

これがあると、例えば松田さんの [activerecord-refinements](https://github.com/amatsuda/activerecord-refinements) のように

{% highlight text %}
{% raw %}
User.where { :name == 'matz' }
{% endraw %}
{% endhighlight %}


という感じで、ブロックの中だけで既存のクラス (この場合は Symbol) のインスタンスの挙動を変えるといったことができたのですが…。

筆者は、この機能を使って以下のようなライブラリを使ろうと思っていたので、非常に残念です。

{% highlight text %}
{% raw %}
require "sexy_regexp"
re = SexyRegexp.new { ("foo" | "bar") + (?0..?9).one_or_more }
p re.is_a?(Regexp) #=> true
p re.source #=> "(foo|bar)[0-9]+"
{% endraw %}
{% endhighlight %}


(え、機能が削られてよかったって？)

仕様をよく読むと、eval("using M; #{s}", TOPLEVEL_BINDING) のようにすれば、ブロックではなく文字列レベルでは似たようなことができることがわかると思いますが、ローカル変数の受け渡しができないので今一つ使えません。

## で、結局何でちゃんと入らなかったの？

Refinements の導入に際しては、以下のような批判がありました。

* 1. 複雑すぎる。
* 2. 仕様が明確でない。
  * ドキュメントがない。
  * RubySpec の spec がない。
* 3.  JRuby などで効率的な実装が難しい。
* 4. オレが考えたこっちの仕様の方がクールだぜ


1. については、やりたいことが複雑なのである程度は仕方ないです。

2. については前述の Wiki ページを書きましたし、RubySpec の方も十分ではないものの spec を追加しました (RubySpec はそもそも 2.0 の仕様変更にあまり対応していなかったので、そちらの修正の方が大変でした)。

3. については、module_eval の機能があるとインラインキャッシュとの相性が悪いのですが、詳しい話は割愛します。

4. は、まあ色んな意見があると思います。

他にも色々あったと思いますが、結局こういった議論が起こったのがリリース直前だったために残念な結果になってしまいました。

## おわりに

Ruby に対する筆者の主な提案実績には、continuation と protected があります (もっと有益な機能も提案した気がするのですが、思い出せません)。「二度あることは三度ある」、「三度目の正直」という二つの諺がありますが、 Refinements はどちらのケースでしょうね。

「面白そうだけど怪しげな機能の提案」をモットーにこれからも頑張りますので、次回作にご期待ください。

## 著者について

### 前田修吾

1975 年生まれのプログラマ。最近よく聴くアルバムは 1/30 にリリースされた Cloudberry Jam の『Now and Then』 (「Give Me the Night」のカバーが格好いい) と Yuri Popoff の『Lua no Ceu Congadeiro』。

URL: [http://shugo.net](http://shugo.net)


