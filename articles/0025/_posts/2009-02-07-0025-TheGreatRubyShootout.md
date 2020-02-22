---
layout: post
title: Ruby 仮想マシン・ガチンコバトル (2008 年 12 月版)
short_title: Ruby 仮想マシン・ガチンコバトル (2008 年 12 月版)
created_on: 2009-02-07
tags: 0025 TheGreatRubyShootout
---
{% include base.html %}


〔訳注: 本記事は [The Great Ruby Shootout](http://antoniocangiano.com/2008/12/09/the-great-ruby-shootout-december-2008/) の翻訳です。〕

著者: [Antonio Cangiano](http://antoniocangiano.com/about/)、作成日: 2008 年 12 月 9 日  〔翻訳: 桑田 誠〕

----

長らくお待たせした、Ruby 仮想マシン・ガチンコバトルを公開します。
このレポートでは、総合的なベンチマーク集を使って複数の Ruby 実装のパフォーマンスを比較しています。
テストした実装は、[Ruby 1.8](http://www.ruby-lang.org/en/) (通称 MRI), [Ruby 1.9](http://www.ruby-lang.org/en/downloads/) (通称 Yarv), [Ruby Enterprise Edition](http://www.rubyenterpriseedition.com/) (通称 REE), [JRuby 1.1.6RC1](http://jruby.codehaus.org/), [Rubinius](http://rubini.us/), [MagLev](http://ruby.gemstone.com/), [MacRuby 0.3](http://www.macruby.org/trac/wiki/MacRuby), [IronRuby](http://www.ironruby.net/) です。

## 免責事項

[前回の対決](http://antoniocangiano.com/2007/12/03/the-great-ruby-shootout/)と同様、結果を紹介する前に、読者には以下の重要事項を考慮することを強くお勧めします。

* [Engine Yard](http://www.engineyard.com/) はこの Web サイト (訳注：[Zen and the Art of Programming](http://antoniocangiano.com/)) のスポンサーであり、Rubinius プロジェクトの非常に広範囲なスポンサーでもあります。言うまでもありませんが、これらのことによって Rubinius に関してのデータに何らかの手心を加えて報告するようなことはありません。


* 本稿を深読みしすぎないように。またどんな最終的な結論も下さないように。これらの面白いプロジェクトはそれぞれ異なる利点と欠点があり、またそれぞれに存在理由があります。それらについては本稿では取り上げません。各プロジェクトの成熟度と完全性はそれぞれ異なってます。もっといえば、すべての実装が同じ最適化レベルを享受しているわけではありません。本稿は、こういうものと受け止めてください -- これは、現状のRuby の実装についての、興味深くて面白そうな比較記事です。


* 本稿に掲載されている結果はほんの数ヶ月のうちに変わる可能性があります。そうなればこのブログでまた対決を行なうでしょう。もしお望みなら、[フィードを購読してください](http://feeds.feedburner.com/ZenAndTheArtOfRubyProgramming);


* ベンチマークした範囲は限定されています。なぜなら、各実装における単一機能すべてをテストすることも、また可能なプログラムをすべて含めることもできないからです。スピードという観点で、一般的な見解を提供してくれるマイクロベンチマーク集であるに過ぎません。現実世界のパフォーマンスを予言してくれるような絶対的に正確なものというわけではありません。


* 多くの人にとって興味があるのは、テストで使用した各 VM が、Ruby on Rails 配備スタックにどれだけの改善をもたらしてくれるかという点です。ある VM A が VM B より 3 倍速いとして、Rails が 1 分あたりに処理できるリクエスト数も 3 倍になるだろうという仮定はしないでください。そんなことはないですから。とはいっても、VM がより速いというのはいいニュースだし、稼働中の Rails アプリケーションにプラスの影響を与えるのは間違いありません。


* これらのテストは筆者が自由に使えるマシンで行なっています。皆さんの環境では、結果が変わってくるでしょう。[^1][^2]。自分が興味を持った VM と、自分のハードウェアと、自分が必要とする/使用するプログラムを使ってテストを行なうようお願いします。


* 本稿では簡単のため、「仮想マシン」と「インタプリタ」をはっきり区別せず、どちらも単に「仮想マシン (VM)」と呼んでいます。


* いくつかのベンチマークは、エンドユーザより VM 実装者にとって大変興味深いでしょう。というわけで、もしテストで使用したベンチマークがばかばかしい/不適切/説得力のないものだと思ったら、[Ruby Benchmark Suite](http://github.com/acangiano/ruby-benchmark-suite/tree/master) にコードを寄贈してください。受理されれば、次回の対決に含まれるでしょう。


* 最後に、世の中には 3 種類のウソがあることを頭に入れておいてください: [ウソ、ひどいウソ、そして統計](http://en.wikipedia.org/wiki/Lies,_damned_lies,_and_statistics)。


## テストで使用された Ruby 実装

メイン対決には、現在の Ruby Benchmark Suite を実行できた Ruby 実装をすべて含めています。
これに含まれるのは、Ruby 1.8.7 (p72、ソースからコンパイルしたものと、apt-get でインストールしたもの)、Ruby 1.9.1 (trunk、p5000、リビジョン 20560)、Ruby Enterprise Edition (1.8.6-20081205)、JRuby 1.1.6RC1、Rubinius (trunk から)、Ruby 1.8.6 (p287、One-Click Installer を使用) です。
最後の Ruby 1.8.6 は Windows Vista Ultimate x64 で、それ以外は Ubuntu 8.10 x64 でテストしています。
ベンチマークに使用したハードウェアは筆者のデスクトップワークステーションで、CPU が Intel Core 2 Quad Q6600 (2.4 GHz)、メモリが 8GB です。
JRuby は -J-server オプションつきで実行され、スタックサイズは 4MB を指定しています (これはある再帰的なベンチマークを最後まで実行するのに必要でした)。
タイムは 5 回繰り返したうちの最もよいものを報告しており、また起動時間や、クラスやメソッドを最初に構文解析したりコンパイルするのにかかる時間は含まれていません。
いくつか新しいテストでは、さまざまな入力サイズが使われています。

MagLev チームは筆者に、今回のベンチマークのために MagLev の初期アルファバージョンを提供してくれました。
この VM はまだ十分には成熟しておらず Ruby Benchmark Suite を実行できないため、古いバージョンの Ruby Benchmark Suite とカスタムスクリプトを使い、Ubuntu 8.10 x86 上でテストしています。
MagLev のテストは、(メインベンチマークと同じ名前であっても) ベンチマークは異なりますが、メイン対決で使用したのと同じマシンで Ruby 1.8.6 (p287) と一緒にテストしています。

MacRuby 0.3 と Ruby 1.8.6 (p114) は、前のバージョンの Ruby Benchmark Suite を使って Mac OS X Leopard 上でテストしました。
筆者の MacBook Pro は死んじゃったので (あーあ)、このベンチマークは Quad-Core Intel Xeon 2.8 GHz プロセッサを 2 つと 18 GB RAM を搭載した Mac Pro で行なっています。

IronRuby (trunk より) と Ruby 1.8.6 (p287) は、前のバージョンの Ruby Benchmark Suite を使い、メイン対決で使ったのと同じクアッドコアマシンを使って Windows Vista x64 上でテストされました。
MagLev と MacRuby と IronRuby についての数々のレポートは 5 回繰り返したうちの最もよいものを採用しており、起動時間も含まれています。
IronRuby on Mono は、IronRuby の複数のバージョンと Mono の 2 つのバージョンを使って試行錯誤したにも関わらず、筆者のマシンでは動かなかったのでテストできませんでした。
Ruby 1.8.6 (p287) は Windows 上で 2 回テストされていることに注意してください。
1 つ目は現在の Ruby Benchmark Suite を使ったメイン対決で、2 つ目は IronRuby と比較するために古いベンチマークを実行したときです。

__注意__: すごくやりたくなるだろうとは思いますが、別々の対決での結果を使って各実装を比較するのはやめてください。
異なるベンチマークおよび/または異なるマシンを使ってテストした VM を直接比較するのは大変危険です。
唯一意味のある比較ができるのは、4 つのグループそれぞれの中においてだけです。

## メイン対決

下の表は、メインの実装における実行時間を表しています。
表はかなり幅が広いので、リンクをクリックして新しいタブにデータを表示させてください。

![main_time_small.gif](http://antoniocangiano.com/images/shootout3/main_time_small.gif)

([詳細はここをクリック](http://tinyurl.com/6r58lc))

緑の太字で表示されているデータは、(今回の基準としている) GNU/Linux での Ruby 1.8.7 より高速な VM であることを表しています。
また背景が黄色のデータはそのベンチマークで最高速の実装であることを、赤字で示されたデータは基準より遅いことをそれぞれ表しています。
Timeout はスクリプトの実行が現実的な時間では終わらなかったため (自動的に) 中断させられたことを表しています。
最終行に示された値は、すべての VM でエラーにならずに実行されたベンチマークだけを共通部分集合として取り出し、それらの実行時間の合計値 (秒) を表しています。
Vista 上での Ruby 1.8.7 をはじめとして、基準となる VM で実行がエラーとなった場合は他のものを使っています (色づけのためだけに使用)。

![main_geomean_small.gif](http://antoniocangiano.com/images/shootout3/main_geomean_small.gif)

([詳細はここをクリック](http://tinyurl.com/599a3b))

基準値となる時間をベンチマークの時間で割っています。
こうすることで、各実装がそのベンチマークにおいて「何倍速いか」がわかります。
2.0 であれば 2 倍高速であり、0.5 であれば半分の速度しかない (2 倍遅い) ことになります。
また表の最後にある幾何平均 (geometric mean) を見れば、メインとなる Ruby インタプリタに対して「平均として」どのくらい速いかまたは遅いかが分かります。
これらの値は前述の合計時間と同じように、各 VM で問題なく実行できた 101 個のテストだけを対象にして計算されています。

もっと簡単にするために、各実装でのテストの比率の幾何平均を棒グラフにしてみました:

![chart_geomean_small.png](http://antoniocangiano.com/images/shootout3/chart_geomean_small.png)

筆者は、データそれ自身に語らせることが好きですが、これらの結果について簡単にコメントしておきましょう。
いくつかの簡単な考察だけですが。

問題なく実行できたテストでの比率の[幾何平均](http://en.wikipedia.org/wiki/Geometric_mean)は置いといて、ソースからコンパイルされた Ruby MRI は Ubuntu でインストールされている Ruby と Vista 上の One-Click Installer より 2 倍高速でした。
./configure &amp;&amp; make &amp;&amp; sudo make install と sudo apt-get install ruby-full との間にはまさに超えられない壁があり、本番環境では容易に採用するわけにはいきません。
これらの数字は私たちの多くがすでに知っている事実を再度見せつけてくれました: Ruby は Windows 上ではとりわけ遅いのです (しかし [世の中では Windows ユーザが多数を占めている](http://groups.google.com/group/capistrano/msg/f5213577eaeadc47?pli=1)のも確かです)。

パフォーマンスの点でいえば、Rubinius が Ruby 1.8.7 や他の高速な VM に追いつくためにはまだすべきことが残っています。
特にタイムアウトとなったテストの数が多いことは問題です。
しかし Rubinius は過去 1 年で改善されており、正しい道筋を辿っていると筆者は思います。

Ruby Enterprise Edition はソースからコンパイルされた Ruby 1.8.7 と同等の速度です。
これは、Ruby Enterprise Edition が Ruby 1.8.6 にメモリ消費量を削減するためのパッチをあてたバージョンであることを考えると、妥当な結果でしょう (メモリ消費量は現在のベンチマークでは測定されないパラメータです)。

優秀な結果について話すと、Ruby 1.9.1 と JRuby 1.1.6 は両方とも__たいへん__優秀でした。
遅いメインインタプリタに対して、相対的に速い 2 つの代替物を私たちは遂に手に入れたのではないでしょうか。
前述の結果と 2、3 のテストでの例外とを考えると、この 2 つの実装は (ソースからコンパイルされた) Ruby 1.8.7 よりも平均して約 2〜2.5 倍速く、また apt-get でインストールされた Ruby 1.8.7 や Vista 上の One-Click installer より約 4〜5 倍高速です。
繰り返しますが、すべてのプログラム (特に Rails) が同じだけ速くなるわけではありません。
しかしそれでも、これらの結果には勇気づけられます。

## MagLev

数ヶ月前に Avi Bryant が最初のベンチマークを公開してからというもの、MagLev については数多くの噂が飛び交っていました。
今回、私たちは遂に MagLev を使ったテストを行うことができました。
下の表は、古いバージョンの Ruby Benchmark Suite をもとにした MagLev のベンチマーク集を、MagLev と Ruby 1.8.6 (p287) で実行して得られた時間を表しています:

![maglev_time.png](http://antoniocangiano.com/images/shootout3/maglev_time.png)

そしてこちらが比率です:

![maglev_geomean.png](http://antoniocangiano.com/images/shootout3/maglev_geomean.png)

これを見ると、MagLev が MRI よりずっと高速な部分もあれば、ずっと遅い部分もあることがわかるでしょう。
改善できる部分はたくさんあると思っていますが、少なくとも MRI より 2 倍は高速であり、初期段階でこの結果であれば間違いなく将来有望です。

## MacRuby

MacRuby 0.3 を Mac OS X 10.5.5 上で実行した時間です:

![macruby_time.png](http://antoniocangiano.com/images/shootout3/macruby_time.png)

そして MRI を基準にした比率です:

![macruby_geomean.png](http://antoniocangiano.com/images/shootout3/macruby_geomean.png)

MacRuby は比較的新しいので、これらの結果はそう悪くありません。
まだ多くの作業が必要ですが、始まったばかりのプロジェクトとしてはよい成績です。

## IronRuby

最後に (これが最後だと約束しましょう)、IronRuby と Ruby 1.8.6 の表を 2 つ紹介します:

![ironruby_time.png](http://antoniocangiano.com/images/shootout3/ironruby_time.png)

![ironruby_geomean.png](http://antoniocangiano.com/images/shootout3/ironruby_geomean.png)

IronRuby は Windows 上の Ruby 1.8.6 より遅く、また GNU/Linux 上の Ruby 1.8.7 よりずっと遅いという結果になりました。
これは驚くようなことではありません。
このプロジェクトは .NET との統合に注力しており、また RSpec 通過比率を改善することで言語実装に追いつこうとしています。
反対に、パフォーマンスの最適化および/またはチューニングはあまり注力されていません (RubyConf 2008 での [John Lam によるプレゼンテーション](http://rubyconf2008.confreaks.com/ironruby.html) による)。
次回の対決では改善されたもので測定できるでしょう。

## まとめ

全体的に、素晴らしい結果が出たと思います。
遅くてメモリリークもある Ruby 1.8 (MRI) は過去のものです。
今こそコミュニティは前に進み、よりよく、より速いものに移行すべき時期です -
そして現在のところそのための興味深い代替物を私たちは手に入れています。

筆者の希望としては、次回の対決では、MagLev、MacRuby、IronRuby がベンチマーク集を実行できるようになり、かつ互いに直接比較できるようになっていることを望みます。
また Tim Bray の XML ベンチマークや、Rails や Merb アプリケーションでの「Pet Shop」サンプルのようなものや、とりわけメモリ使用量の統計を含めたいと思います。

メイン対決の Excel ファイルは[こちら](http://antoniocangiano.com/files/MainShootout3.0.xls)になります。
差し当たり、これで全部です。
[この記事にコメント](http://antoniocangiano.com/2008/12/09/the-great-ruby-shootout-december-2008/#respond)したり、[筆者のフィードを購読](http://feeds.feedburner.com/ZenAndTheArtOfRubyProgramming)したり、[Hacker News](http://news.ycombinator.com/item?id=391301) や [Reddit](http://www.reddit.com/r/programming/comments/7ic05/the_great_ruby_shootout_december_2008/) や [DZone](http://www.dzone.com/links/the_great_ruby_shootout_december_2008.html) や StumbleUpon や [Twitter](http://twitter.com/) などでこのリンクを共有したり宣伝するのは自由に行なっていただいて構いません。
この対決をまとめあげるのは骨の折れる作業でしたので、これについての評判を広めてくれる人全員にたいへん感謝します。
次回までは……

__追記 (2008 年 12 月 10 日)__:
本記事は 2 つの重要事項について昨日の結果を修正するために更新されました。
筆者のコメントも同様に、修正された図に対する見解へと修正しました。
〔訳注: 日本語版は修正後のものを翻訳〕

本記事を楽しんでいただけたら、[目次](http://antoniocangiano.com/table-of-contents/)もチェックしてください。
また [RSS フィード](http://feeds.feedburner.com/ZenAndTheArtOfRubyProgramming)も購読してみてください。

(編集：くげ)
----

[^1]: 訳注: "your mileage may vary." って何???
[^2]: 訳注: "「あなたの状況は異なるかもしれません」というような意味です。もともとは車のCMで燃費(mileage)は乗り方によって異なることを明示する注釈として使われたフレーズから誕生したものだそうです - matz
