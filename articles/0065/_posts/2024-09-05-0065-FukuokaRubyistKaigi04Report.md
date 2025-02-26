---
layout: post
title: RegionalRubyKaigi レポート (85) 福岡 Rubyist 会議 04
short_title: RegionalRubyKaigi レポート (85) 福岡 Rubyist 会議 04
tags: regionalRubyKaigi
post_author: nagachika
created_on: 2024-12-08
---
{% include base.html %}

## RegionalRubyKaigi レポート: 福岡 Rubyist 会議 04

### 概要

2024 年 9 月 7 日、福岡で 4 回目の地域 Ruby 会議である福岡 Rubyist 会議 04 が開催されました。
その様子をレポートします。

#### 開催日

2024 年 9 月 7 日(土)

#### 開催地

福岡県福岡市博多区 リファレンス駅東ビル 4F 会議室 Q

#### 主催
Fukuoka.rb/株式会社 Ruby 開発

#### 公式サイト

[https://regional.rubykaigi.org/fukuoka04/](https://regional.rubykaigi.org/fukuoka04/)

#### 公式タグ

`#fukuokark04`

### 会場について

福岡 Rubyist 会議 03 でも好評だった八女茶を提供するブースは今回も設営され、おいしいお茶をたくさんの Rubyist が楽しんだようでした。
玉露はカフェイン含有量が多いので飲み過ぎには注意です。

### セッション

#### Opening Talk

オーガナイザーの jimlock さんから会場の諸注意や八女茶の提供についてなど簡単な案内があり、オープニングキーノートスピーカーの Kevin の紹介からさっそくセッションが開始されました。

![00_jimlock.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/00_jimlock.webp)

#### Why Prism?

* 発表者
  * Kevin Newton 氏
* 資料
  * [スライド](https://speakerdeck.com/kddnewton/why-prism)

海外から福岡まで来てくれた Kevin には、CRuby 3.4 preview1 でデフォルトのパーサーとなることになった Prism の現状についてキーノートで発表していただきました。

Prism とは C 言語(C99) で実装された Ruby の parser であり、CRuby 本体に組込まれているだけでなく gem としても提供され、他の ruby 実装や AST を利用するツール類から利用されているライブラリとしての側面も持ちます。
特にエディタや IDE の支援に使う用途を考え Error Tolerant という文法上誤りがあったり書きかけの状態でも結果を返す機能や、トークンの行数/カラム数の豊富な位置情報を扱えるようにすることなどに注力されているとのこと。
従来のパーサージェネレーターを利用した LR パーサーとは違い手書きパーサーである点から、メンテナンス性に難があるというのがよくある批判ですが、本発表ではメンテナンス性を「コントリビューションの難易度を下げること。より多くの人が開発に参加できること」と定義していると述べておられました。
発表では Ruby の文法の実装が難しい点や苦労した点についても言及されていましたが、時間をかけて取り組み多くの問題を解決した結果 CRuby 3.4 の preview 版ではデフォルトのパーサーとして Prism を利用するようになったということを報告されていました。
最後に「パーサーとコンパイラを 2 つ持つことはメンテナンス上よくない」という発言で会場にピリリと緊張感が走るオープニングキーノートとなりました。

![01_kevin.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/01_kevin.webp)

#### SWAR

* 発表者
  * Matz

Podcast [ツナギメエフエム](https://tsunagi.me/) に主催者の [jimlock さんが出演された回](https://tsunagi.me/ep105/) を聴いて急遽「生活発表会」というテーマにあわせてトーク内容を変更したというまつもとさんは、mruby の String#index が CRuby と比べて 10 倍も遅いという課題を解決するための取り組みについて発表していただきました。
SIMD 命令を利用すれば高速化できるということはわかっていたものの、様々なアーキテクチャで適用できる mruby で CPU アーキテクチャごとに実装を持つのは大変なので、汎用性のある "SWAR" (SIMD within a register) という手法を利用して高速化したという経験談でした。SWAR はワード(その CPU アーキテクチャで最も一般的な整数の精度/バイト幅)に文字を詰めてビット演算を利用することで SIMD のように複数の文字の比較や検索をまとめて行うというもので、マイクロベンチマークでは CRuby より速くなるケースもあったそうです。なお Intel/AMD の CPU では実際には SSE2 の実装を書いたとのこと。
次は mruby で巨大な整数の積が遅いという報告があったので、CRuby でも利用している Karatsuba 法というアルゴリズムの実装にとりかかろうかと考えているとのことでした。
いつも RubyKaigi や RubyWorld Conference では Ruby の次期バージョンの構想などの話を聞くことが多いなかでいちハッカーとしてのまつもとさんの話を聞くことができた貴重なトークでした。

![02_Matz.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/02_Matz.webp)

#### Building a Ruby-like Language Compiler with Ruby

* 発表者
  * htkymtks 氏
* 資料
  * [スライド](https://speakerdeck.com/htkymtks/rubydetukururubymitainayan-yu-nokonpaira)

ドラゴンブック読書会というコンパイラの教科書の勉強会からやってきたはたけやまさんは TinyRuby という ruby ライクな文法をもつ Toy 言語のコンパイラを ruby で実装したプロジェクトについて発表していただきました。
実装を容易にするため扱うデータは整数のみサポートしメソッドの引数の上限も 6 つまでに制限すると仕様を削った言語で、対象とするアーキテクチャや OS も x86_64/Linux のみと絞っています。
パーサーには MinRuby という「Ruby でつくる Ruby」という書籍内で実装されているものを流用し、アセンブリファイルを出力してそれを GCC を利用して実行ファイルにアセンブルするという手法を取っているため、主に AST (Abstract Synatx Tree, 構文木)を解釈してアセンブリに変換するという部分に注力しているプロジェクトでした。
このために GCC が C 言語のソースコードに対して出力するアセンブリを [Compiler Explorer](https://godbolt.org/) というサイトを活用して参考にしつつ、ABI の勉強をしたとのこと。
また実装を進めるうえではテスト駆動開発で小さな仕様からステップバイステップで少しずつできることを増やしていくという手法を取ったということで、実際に GCC が出力するアセンブリをそのまま出力するだけの ruby スクリプトから、整数リテラルで書かれた値を終了ステータスにするだけという小さな変更を行なって「これで最初のコンパイラができました」と宣言した際には会場から感嘆の笑いが起こっていました。
コンパイラ作成というと LLVM の中間表現や実装を使うというのが多い印象ですが目的領域を絞り手作業で実装していくというのは学習目的には良いアプローチだなと感じました。

![03_htkymtks.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/03_htkymtks.webp)

#### Trying to Make Ruby's Parser Available as a Gem

* 発表者
  * shun_hiraoka (S.H.) 氏
* 資料
  * [スライド](https://speakerdeck.com/gamelinks007/trying-to-make-rubys-parser-available-as-a-gem)

ドラゴンブック読書会からの 2 人目の刺客 shun_hiraoka さんには kanayago.gem という gem のプロジェクトの取り組みについて発表していただきました。
CRuby には 3.3 から Universal Parser といって parse.y の実装を外部ライブラリとして使えるように切り出すためのベースとなるコードが提供されているものの、あまり利用事例が多くないのでこれを拡張ライブラリとして実装して gem 化するというもの。
Kanayago という名前は島根の製鉄の神の名前から取ったとのこと。
ruby スクリプトから AST を返すというインターフェースで AST は専用のクラスを定義するのではなく Array/Hash を組み合わせた構造化データとして返すようにしています。
大変だった点としては Universal Parser は parse.y が依存している CRuby の実装の関数や変数を専用のアダプタ構造体を経由してアクセスするようにしていて、この構造体に含まれる大量のシンボルを実装しないといけないこと、この構造体のレイアウトがしばしば変更されるので CRuby 本体の変更に追随する必要があることなどで、現在のところ 3.4 (2024 年 9 月現在の master ブランチ) 最新版でないと動かすことができないそうです。
このように現状まだまだ課題の多い Universal Parser ですが ruby 本体の parser 実装をツール類から使いたいという動機は強いと思うので今後どのように展開するのかが気になります。

![04_SH.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/04_SH.webp)

#### Rails Girls Fukuoka 3rd(Chie)/Rails Girls is My Gate to Join the Ruby Community(まいむ)

* 発表者
  * Chie 氏

* 発表者
  * まいむ 氏
* 資料
  * [スライド](https://speakerdeck.com/maimux2x/rails-girls-is-my-gate-to-join-the-ruby-commuinty)

Rails Girls Fukuoka 3rd を主催された Chie さんと Rails Girls Tokyo 16th のオーガナイザーを務めたまいむさんにそれぞれの Rails Girls とのかかわりやきっかけについて発表いただきました。

Chie さんが Ruby コミュニティに触れるきっかけは前回の福岡 Rubyist 会議 03 とのことで、その後 Rails Girls Nagasaki、Fukuoka Ruby Festa 2024 に参加して、エンジニアでなくても技術イベントを開催することはできるんだ、ということを実感。そして 2020 年に予定されていたもののコロナ禍の影響で無期限延期になっていた Rails Girls Fukuoka 3rd の主催に手を挙げられたとのこと。
Rails Girls Fukuoka 3rd は福岡市赤煉瓦文化館という明治時代の建築の中に設置されたエンジニアカフェで開催。国の重要文化財として指定されている建築なので気をつかうことが多かったという苦労話もありました。

まいむさんのきっかけは Rails girls Gathering Japan 2022。そこで女性エンジニアのロールモデルに触れてから Rails Girls Guide の日本語訳というプロジェクトに参加するようになったそうです。そこでは翻訳作業だけでなく、作業の流れをブログで紹介するなどより多くの人に参加してもらえるようにするための活動を開始。反響が大きく嬉しかったことから、多くの人とプロジェクトに取り組む楽しさが芽生えたとのことでした。
さらに実際のワークショップも主催した際には、非エンジニアの層にもリーチしたいという考えて広報に努力されたそうです。
そのかいあって技術系の職種ではない参加者も多く、ワークショップ終了後もプログラミングを続けている人の話をきくのがとても嬉しかったとのことでした。

![05_Chie.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/05_Chie.webp)
![05_maimu.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/05_maimu.webp)

#### パネルディスカッション: AI Big Wave(kis, kakutani, a_matsuda)

オーガナイザーの jimlock さんをモデレーターとしてきしださん(@kis)、角谷さん(@kakutani)、まつださん(@a_matsuda)によるパネルディスカッション。
お三方のキャリアの話をする、といいつつ 2000 年代の Web 業界の雰囲気や情報技術のトレンドの変化などについて語られていて、懐しい思いをしている方が多かったようです。
きしださんは福岡在住の Java コミュニティでの著名人で、Ruby 関連のコミュニティで話をする機会はあまりないので福岡 Rubyist 会議ならではの話が聞けたのではないかと思います。
おもしろすぎて細かなトピックのメモが残せてなかったのですが、ひとつだけきしださんの印象に残った発言として「2015 年ごろを最後にビジネスとしての WEB 業界というのはほぼ完成していてそれ以降新しいおもしろいものというのはあまりない」というのがあり、議論を呼んでいました。

![06_panel.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/06_panel.webp)

#### Ruby in Ruby(katsyoshi)

* 発表者
  * katsyoshi 氏
* 資料
  * [スライド](https://speakerdeck.com/katsyoshi/ruby-in-ruby-building-an-aot-compiler-with-ruby)

ドラゴンブック読書会からの 3 人目の刺客 katsuyoshi さんも vaporware-compiler というミニ言語のコンパイラについて発表していただきました。
こちらは中間表現としてアセンブリを利用してそこから ELF フォーマットのバイナリに変換するといういわゆるバックエンドの一部分に注力されたプロジェクトのようです。なおリンカはまだ未実装とのことで mold など既存のリンカを利用しているとのこと。
コンパイラについての発表は多いですがそれぞれ注力しているところが違っていて、コンパイラツールチェインは多数のステップからなりたっているので自分の興味の湧く部分からはじめるのは良い方法かもしれないと感じました。

![07_katsyoshi.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/07_katsyoshi.webp)

#### Ruby is like a teenage angst to me(udzura)

* 発表者
  * udzura 氏
* 資料
  * [スライド](https://udzura.jp/slides/2024/rubyistkaigi04/index.pdf)

コンテナエンジン、CRIU、eBPF、WebAssembly(WASM) など RubyKaigi での udzura さんの過去の発表の内容をなぞりつつ、これら低レベルレイヤの技術を ruby で扱う SDK などの提供が少ないことから、自分で実装をしてるというのが共通したアプローチであると自己分析されていました。こうした技術を ruby から扱うための実装をすることで、対象の技術の具体的で根本的な理解が深まるというメリットもあると語られていたのが印象的でした。
最近の興味は Rust を用いて mruby を WASM 上で動作させるためのプロジェクト mruby/edge や、 WASM Component Model という拡張仕様への対応など、 WASM の周辺技術とのことで、次回作が期待されます。

![08_udzura.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/08_udzura.webp)

#### What is Parser (yui-knk)

* 発表者
  * yui-knk 氏
* 資料
  * [スライド](https://speakerdeck.com/yui_knk/what-is-parser)

クロージングキーノートは従来の CRuby のパーサー parse.y からコード生成するパーサージェネレーター Lrama を開発されている yui-knk さんから。
Parser とはなにか、というタイトルですが発表内容は次第に「そもそも言語とはなにか」「文法とはなにか」と抽象度を増していきます。
Lrama もその実装のひとつである LALR パーサーは文脈自由文法と呼ばれるカテゴリの文法を解析できる手法ですが、ruby の文法は実は文脈自由ではないのに、なぜ構文解析できているのか? という疑問について、ruby は LR Attribute Grammer (属性文法) というカテゴリに属しているため LR パーサーで解析可能なのだとのこと。正しい理解かわかりませんが、Lexer が状態に応じて各トークンに属性を追加したものを LR-Parser に渡すという parse.y の実装に対応している話かなと理解しました。
これが言語実装者にとって ruby の文法が難しいものになる原因で、Lexer が状態を正しく管理する必要があるのに、それが実装上文法定義ときちんと結び付いていないためしばしば不具合や不完全な文法の導入に繋がっているという主張のようでした。
これを解決するため Lexer と Parser を一体化した PSLR/IELR といった実装方法が解決になるかもしれないという将来像についても触れられていました。
こうした取り組みの動機は ruby の新たな文法を追加する際に予期しない衝突が生まれることがあり、これをパーサージェネレーターで機械的に検出することができれば、言語デザイナ(Matz)が事前に問題を把握したうえで判断をすることができるはず、という言語開発者の支援が主眼に置かれているようです。

![09_yui_knk.webp]({{base}}{{site.baseurl}}/images/0065-FukuokaRubyistKaigi04Report/09_yui_knk.webp)

### まとめ

今回 2 つのキーノートはそれぞれパーサー(パーサージェネレーター)の作者によるものでしたが、双方の動機や向いている方向は対照的で、Kevin がコミュニティへのサポートというのを主眼に置いておりエディタやデバッガなどのツールで使えるパーサーを共通の実装で今現在提供したい、という「Ruby の利用者」「現在」を向いているのに対して、yui-knk さんは CRuby 開発者がより正確な情報やフィードバックを得られる状態で文法の検討や実装ができる状態をつくることで、将来に渡って ruby の健全な仕様追加ができるという「Ruby 開発者」「将来」をみているという印象がありました。
Kevin のキーノートでは Prism についてメンテナンス性についての批判への反論もありましたが、将来の変更への堅牢性についての心配は残ると思いますし、一方で parse.y によるパーサー実装をサードパーティーの gem などから利用する方法としての Universal Parser の実装は S.H さんの発表をみてもまだまだ発展途上で、現在は(同じ parse.y の文法規則を利用している ripper があるとはいえ)いいオプションを提示できていないというのは Prism が支持されうる大きな要因なのだろうと感じました。

## 筆者について

### nagachika

福岡市在住 ruby committer. 安定版メンテナ。CRuby のコミットを読んでコメントする [ruby-trunk-changes](https://ruby-trunk-changes.hatenablog.com/) を更新しています。
