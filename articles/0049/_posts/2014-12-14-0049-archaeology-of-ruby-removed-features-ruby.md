---
layout: post
title: Ruby 考古学 消された機能編
short_title: Ruby 考古学 消された機能編
tags: 0049 archaeology
---


書いた人：西山さん([@znz](https://twitter.com/znz))

## はじめに

[RubyKaigi2014 で発表した内容](http://rubykaigi.org/2014/presentation/S-KazuhiroNISHIYAMA)の紹介です。

ruby を使い始めた時はバージョン 1.4 系で、
そのバージョンより後で削除された機能で気になったものについての話をしました。

### リリースに入った後、消された機能

まず過去のリリースに入っていたのに、消された機能の話です。

#### Safe Level 4

最近のリリースで削除された大きな機能として、
safe level 4 があります。

元々 Ruby の sand box 機能として safe level は不完全で、
safe level 自体の削除の提案がされたことも何度かありました。

そういう経緯もあり、2013 年の GitHub Tokyo drinkup で削除が合意されたようです。
その場で safe level 4 を使っていた tDiary の開発者の賛成もあったようです。

その後の redmine 上での議論では、
JRuby では長い間 safe level をサポートしていなかったが、特に指摘されたことはなかったとか、
ActiveScriptRuby は safe level 3 を使っているなどの意見があったため、
4 未満の safe level はセキュリティ機能としてではなく、
バグ発見用のフェイルセーフ機能として残ることになったようです。

詳しい経緯は
[Feature #8468: Remove $SAFE - ruby-trunk - Ruby Issue Tracking System](https://bugs.ruby-lang.org/issues/8468)
をご覧ください。

その結果、 2.1.0 では safe level の 4 は廃止されて、
4 を設定しようとすると ArgumentError が発生するようになりました。

その前の 1.9.1 で untrust が導入されて
少しセキュリティ対策が強化されたこともあったのですが、
活用されることなく 2.1.0 では deprecated になり、
taint と同じ動作になってしまいました。

#### '.' が $LOAD_PATH から削除

セキュリティ関係といえば、
1.9.2 からセキュリティ上の理由で '.' (ドット) が $LOAD_PATH からひっそり取り除かれました。
理由としては実行コマンドの検索パスがカレントディレクトリを含んでいないのと同じ理由です。
代わりに require_relative を使ってください。

#### $KCODE

ruby 1.9 の多言語化対応の影響で $KCODE の代わりに Encoding を使うようになりました。
そして $KCODE の参照は常に nil がかえってくるようになり、
$KCODE への代入は無視されるようになりました。

#### Regexp のオプション

一方 $KCODE 関連だった正規表現リテラルの n e s u オプションはまだ残っています。
互換性のために残っているので、そのうちなくなるかもしれません。
(そして、もしかすると代わりに a オプションが増える可能性があるかもしれません。)

{% highlight text %}
{% raw %}
     //n.encoding #=> #<Encoding:US-ASCII>
     //e.encoding #=> #<Encoding:EUC-JP>
     //s.encoding #=> #<Encoding:Windows-31J>
     //u.encoding #=> #<Encoding:UTF-8>
{% endraw %}
{% endhighlight %}


#### $= (ignore case)

もう一つ、グローバル変数と言えば $= を true にすると
ハッシュのキーの文字列などで大文字小文字を無視することが出来るという機能がありました。

使ったことがある人はほとんどいないと思いますが、
1.8 で影響範囲が限定的になり、
1.9 でそういう機能はなくなりました。

ドキュメントに残っていることがありますが、もう使えないので、
見かけても無視してください。

Perl 由来の機能かと思ったのですが、
Perl では別の意味なので、
少し調べた範囲では由来は不明でした。

#### $deferr など

{% highlight text %}
{% raw %}

 * $deferr  → $stderr
 * $defout  → $stdout
 * $stderr= → STDERR.reopen
 * $stdin=  → STDIN.reopen
 * $stdout= → STDOUT.reopen
{% endraw %}
{% endhighlight %}


さらに昔の話になりますが、
ruby 1.7 の頃には $defout や $deferr というグローバル変数があって、
子プロセスに影響しない出力先変更に使われていましたが、
今は $stdout と $stderr に統一されて、
子プロセスに影響するリダイレクトは reopen を使うようになりわかりやすくなりました。

今は子プロセスに影響しないリダイレクトは $stdout や $stderr への代入で、
子プロセスに影響するリダイレクトは reopen を使うということを覚えておけば良いと思います。

さらに言えば、今は子プロセスを起動するときにリダイレクトなどを柔軟に指定できる
Process.spawn などのメソッドを使う方がおすすめです。

#### if cond: のように : をつけられる隠し機能の削除

ruby 1.8 までは if の条件式の後ろなどに : を付けられるという隠し機能がありましたが、
キーワード引数と衝突するという理由で取り除かれました。

隠し機能のはずなのになぜか使われていて、修正が必要だった gem などもあったようです。

#### File.exists?

{% highlight text %}
{% raw %}
 * File.exist?  (recommend)
 * File.exists? (deprecated)
{% endraw %}
{% endhighlight %}


Ruby 本体のメソッド名は出来るだけ三単現のsを付けないというルールがあるので、
File.exists? は以前警告が出ていたのですが、
何かのミスだったのか警告が一度出なくなって、
また出るようになったという経緯があります。

そういう経緯もあってメソッド自体はまだ残っていますが、
警告も出るようになっているので、
そのうち消されると思います。

### 開発版のみに入っていた機能

続いて開発版のみに入っていた機能についての話です。

#### Symbol &lt; String in 2006 (1.9.0-dev)

ruby 1.9 の開発版の一時期に Symbol が String を継承するように変更されていた時期がありましたが、
問題が多かったため、元通り継承関係のないクラス階層に戻されました。
[matz 日記](http://www.rubyist.net/~matz/20061107.html#p03)には理由として
「caseとかでのバグをたくさん生んでしまう」
と書かれていました。

その影響もあり Symbol に String っぽい挙動が残っています。

その後 methods メソッドのように返り値が String から Symbol に変わったなどの影響もあり、
継承関係はなくなったものの Symbol を String に似た扱いにするメソッドが ruby 1.8 までに比べると
ruby 1.9 以降では多くなっています。

{% highlight text %}
{% raw %}
 ruby 1.8.7:
   // =~ :s
   #~> TypeError: can't convert Symbol into String
   methods[0].class #=> String
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 ruby 1.9.3:
   // =~ :s #=> 0
   methods[0].class #=> Symbol
{% endraw %}
{% endhighlight %}


#### __send

ruby 1.9 の開発版の途中で send が今の public_send 相当の private メソッドは呼べないという変更が入り、
__send と __send! というメソッドが導入されたことがあったのですが、
アクセス制限を回避して private メソッドを呼び出すために send を使っていることが多く、
影響が大きすぎたため、元に戻されて public_send というメソッドが導入されました。

#### Real multi-value (to_splat)

{% highlight text %}
{% raw %}
 * to_splat (!= to_ary) (!= to_a)
 * svalue, avalue, mvalue
 * 例: a, b = mvalue
{% endraw %}
{% endhighlight %}


これも ruby 1.9 の開発版での話なのですが、
2006年頃に真の多値を導入しようとしていた時期があり、
to_ary とは別に to_splat というメソッドが呼ばれるようになっていた時期があったのですが、
リリースされることなく to_splat などは消えました。

リリースされずに消えたので、確認できないので間違っているかもしれませんが、
多重代入のときなどに to_a や to_ary の代わりに to_splat を呼ぶようになっていたのだと思います。

#### Symbol.find in 2.2.0-dev

{% highlight text %}
{% raw %}
* Symbol.find(str) -> symbol or nil
  * Return the related symbol if the symbol already exists.
  * Return nil if not.
* revision 47543
  * Removed because of Symbol GC
  * If you still want this, request again on Redmine.
{% endraw %}
{% endhighlight %}


[前日のなりさんの Symbol GC の発表](http://rubykaigi.org/2014/presentation/S-NarihiroNakamura)で話があったように、
ruby 2.1 までは Symbol は GC の対象ではなかったため、
ruby 2.2 の開発版で Symbol が既に存在するかどうか調べるメソッドが追加されました。

しかし、 2.2.0 で Symbol GC が導入されたため、
リリースに入ることなく削除されました。

それでも必要だと思ったら、redmine で再度リクエストしてくださいとコミットログに書いていました。

#### statfs in 2.2.0-dev

次に ruby 2.2 の開発版にのみ存在した statfs の話です。
statfs.f_type がテストに必要ということで、
[IO#statfs と File::Statfs](https://bugs.ruby-lang.org/issues/9772) がとりあえず追加されて、
各種 OS 対応など、みんなで変更していたのですが、5月17日の開発者会議で
「色々込み入ってるので core には入れないで test 配下へ. 欲しいということがあったら gem にしてください.」
という理由で却下され、最低限の機能だけ test 配下に入り、一般に使える機能としては入りませんでした。

## まとめ

最後にまとめです。

いくつかの機能は開発版だけで消えてしまっています。
またいくつかの機能は互換性のために入らなかったり他の機能になったりしています。

入らなかったり削られたのがなぜなのかを考えることで、
今後の新機能の提案に生かしていただければ、
ということで終わります。


