---
layout: post
title: RegionalRubyKaigi レポート (xx) 東京Ruby会議12
short_title: RegionalRubyKaigi レポート (xx) 東京Ruby会議12
post_author: 東京Ruby会議12 実行委員会
tags: regionalRubyKaigi
created_on: 2025-01-27
---

{% include base.html %}

## RegionalRubyKaigi レポート (xx) 東京Ruby会議12

(ここに『はじめに』が入る）

## キーノート

## John Hawthorn『Scaling Ruby @ GitHub』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


## Kohei Suzuki『Ruby と Rust と私』

* 録画: https://example.com/

最後のキーノートでは、Kohei Suzukiさんが、CLIツールの開発とISUCON（競技型Webアプリチューニングコンテスト）における言語移植の経験をもとに、RubyとRustの特徴を比較しました。RubyとRustといえば、Ruby3.1でRust実装のYJITが導入されて以降、注目を集めている組み合わせです。多くのRubyistがRustに興味を持ちつつも、使いこなせていないのが実情だと思います。発表ではどのように比較されるのか、非常に興味深い内容でした！

CLIツール開発の観点では、Rubyの柔軟性と拡張性の高さが強調されました。Rubyでは `require` や `const_get` を用いることで動的にコードを読み込み、機能を自由に拡張できます。この特徴により、カスタマイズ可能なCLIツールの開発が容易になります。一方で、CPU負荷の高い処理ではGVL(Global VM Lock)の影響を受けやすく、並列化には工夫が必要です。また、JSONのパースにおいては、型チェックや存在チェックを自前で実装する必要がありますが、protobufを活用することで型安全なデータ変換が可能になる点が紹介されました。

対してRustは、静的型付けの影響でプラグインの配布や管理が難しくなるという課題が挙げられました。しかし、I/Oを許可しない場合は[Envoy proxyのようにWebAssemblyを利用した拡張](https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/advanced/wasm)が有効であり、I/Oを許可する場合は[hashicorp/go-plugin](https://github.com/hashicorp/go-plugin)のようにgRPCサーバーを起動する実行可能ファイルとしてプラグインを配布する手法が適しているとされました。さらに、スレッドを起動することでマルチコア並列処理が可能になり、高速な処理を実現できます。JSONのパースにおいても、[Serde](https://serde.rs/)を活用することで型安全なデータ変換が簡潔に行える点がRustの利点として紹介されました。

言語選択のポイントとして、拡張可能なCLIを作成する際にはRubyが適しており、静的型付けによる制約を受けるRustではプラグインの配布や管理が複雑になるため、Rubyの方がシンプルに実装できます。一方、並列処理が求められる場合にはRustが適しており、マルチコアの活用が容易であることがメリットとして挙げられました。加えて、複雑なJSONの処理においてはSerdeを利用できるRustの方が、より簡潔な記述が可能になるとのことでした。

ISUCONにおける言語移植の経験についても語られました。この競技では、Go、Ruby、Rust、Pythonなど様々な言語で実装されたWebアプリを高速化することが求められます。Kohei Suzukiさんは、ここ数回のISUCONでGoで書かれた基準実装をRubyやRustに移植する作業を担当し、その経験をもとにしたエラーハンドリング、リソース管理、Webフレームワークの違いについて比較を行いました。

Rubyでは例外を用いたエラーハンドリングが主流ですが、RustではResult型と?演算子を活用したエラーハンドリングが一般的です。リソース管理の観点では、Goのdefer、Rubyのブロック、RustのDropトレイトが比較されました。Webフレームワークについては、sinatra+mysql2のRubyスタックと、Axum+SQLxのRustスタックが取り上げられ、Rubyの記述量の少なさと可読性の高さが評価される一方で、RustのDeriveマクロを用いた型安全なデータ変換の強みが紹介されました。全体として、書き方に大きな差はないものの、型が保証される分Rustのほうが使いやすい場面があるとのことでした。ただし、ISUCONの競技環境ではRustのコンパイルの遅さがネックとなることもあるようです。

今回の発表では、RubyとRustの特性を比較しながらも「コードを短くする工夫」が両言語の共通点として挙げられました。RubyではメタプログラミングやDSLを活用することでコードの記述を簡潔にできます。一方、RustではDeriveマクロを利用することで型安全性を維持しながら記述量を削減することが可能です。さらに、両言語とも if や match/case を式として扱えるため、スッキリとしたコードが書ける点も共通しています。
CLIツール開発やISUCONでの言語移植での経験を踏まえて、用途によって使い分けていくのが良いとのことです。

懇親会では、Kohei Suzukiさんのチームの半数がRustを活用しており、CLI用途で複数のツールをRustで開発しているという話を伺いました。なかなか仕事でRustを書く機会がないRubyistも、CLIツールの開発を通じてRustを試してみるのも良いかもしれませんね！

(alpaca-tc)


## セッション

### Keynote: 『Scaling Ruby @ GitHub』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。


(your name)

### 前田 修吾『Ruby製テキストエディタでの生活』

* 録画: https://example.com/

ランチ明けは、前田 修吾さんによる自作のRuby製テキストエディタ[shugo/textbringer](https://github.com/shugo/textbringer)での生活の発表がありました。

発表は、エレファント・カシマシのアルバム『生活』に収録されている「晩秋の一夜」の歌詞から始まり、火鉢を囲む生活への憧れと新婚当時の思い出が語られ、そこから情報社会におけるノスタルジーの象徴としての端末環境へと話が展開しました。Ruby製エディタを開発した背景として、そういった古いものへの憧れや、開発のシンプルさがあるそうです。

デモでは、選択範囲の文字を大文字にするupcase_region機能の実装をライブコーディングで行いました。エディタをスライドにして発表をしつつ、その端末上でエディタ自身のコードを書き換えて、その場でコマンドを追加して実行するという、まさにライブコーディングの実演でした。さらに、日本語入力機能としてT-Codeを用いた入力や、Groongaを活用したメール機能についても紹介されました。

発表の中で、制作のすすめとして「SNSなどの評価を気にせず、自分のためにソフトウェアを作ること」の重要性が強調されました。スライドには、宇野常寛さんの「庭の話」からの引用がありました。

> 人間は「どうしてもほしいがまだ世界には存在しないもの」を求めて（自分でつくるしかなくなり）「制作」をはじめる。  
> 自分がほしいものを誰もつくってくれないので自分でつくるしかない、という思いを実現した時の快楽は他のものでは代替できない。

この言葉は、聴者である自分の心に強く響くものでした。他の聴者にとっても、プログラミングをはじめたばかりの頃の純粋な喜びを思い出し、自分のために何かを作るという本質的な楽しさを再認識するきっかけとなったのではないでしょうか。

「どうしてもほしいがまだ世界には存在しないもの」を自分で作り、それを自分の生活の一部として使い続ける。その姿勢にこそ、開発の醍醐味があり、Rubyと共に暮らすことの魅力があります。前田 修吾さんの発表は、ものづくりの原点を思い出させてくれる、刺激に満ちたセッションでした。

(alpaca-tc)


### ぺん！『全てが同期する! Railsとフロントエンドのシームレスな連携の再考』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### ryopeko『functionalなアプローチで動的要素を排除する』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### tokujiros『ゼロからの、2Dレトロゲームエンジンの作り方』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### yumu『Ruby×AWSで作る動画変換システム』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### moznion『simple組み合わせ村から大都会Railsにやってきた俺は』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### Hiromi Ogawa『Writing PDFs in Ruby DSL』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### buty4649『mrubyでワンバイナリーなテキストフィルタツールを作った』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### morihirok『混沌とした例外処理とエラー監視に秩序をもたらす』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### Kasumi Hanazuki『Ruby meets secure DNS and modern Internet protocols』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


## 『Regional.rb and the Tokyo Metropolis』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)

## 会場や廊下のようす
