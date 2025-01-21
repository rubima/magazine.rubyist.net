---
layout: post
title: RegionalRubyKaigi レポート (87) 松江 Ruby 会議 11
short_title: RegionalRubyKaigi レポート (87) 松江 Ruby 会議 11
tags: MatsueRubyKaigi11Report regionalRubyKaigi
post_author: 佐田 明弘, 西田 雄也, 高田 芳和, 伊東 亮, 藤井 貴
created_on: 2024-11-22
---
{% include base.html %}

## RegionalRubyKaigi レポート 松江 Ruby 会議 11

2024 年 10 月 5 日（土）に松江 Ruby 会議 11 が開催されました。<br>
合計 51 名の方にご参加いただきました。<br>
同じ日に松江城周辺をライトアップする松江水燈路というイベントも開催されていましたので、松江 Ruby 会議 11 の閉会の挨拶でご紹介させていただきました。<br>
当日は天気が晴れたこともあり、松江 Ruby 会議 11 の後でそちらのイベントも楽しんでいただけたようでした。<br>

* 日時：2024 年 10 月 5 日（土） 12:30〜17:30 （懇親会: 17:30〜）
* 場所：松江オープンソースラボ
* 主催：Matsue.rb （まつえるびー）
* 後援：日本 Ruby の会
* Togetter まとめ： [https://togetter.com/li/2445824](https://togetter.com/li/2445824)
* 公式タグ：[#matrk11](https://x.com/hashtag/matrk11)

![01_all.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/01_all.jpg)

### 基調講演: A Beginner's Complete Guide to Microcontroller Programming with Ruby

* 発表者
  * 羽角 均 氏
* 資料
  * [スライド](https://slide.rabbit-shocker.org/authors/hasumikin/Euruko2023/)
  * [picoruby/R2P2](https://github.com/picoruby/R2P2)
  * [picoruby/picoruby](https://github.com/picoruby/picoruby)
、
ご自身が開発されている R2P2 を使い、Raspberry Pi Pico(RP2040)上で Ruby を使う次のデモをされました。<br>

1. PC の端末エミュレーターから Raspberry Pi Pico に接続すると R2P2 が持っている Unix ライクなシェルが実行できる。<br>
2. ファイルシステムがあり、各種コマンドが動作する。それらコマンドは PicoRuby で書かれている。<br>
3. Vim っぽいテキストエディターを使ってコードも書ける。<br>
4. IRB を動かして Ruby のコードを対話実行できる。IRB は複数行対応している。<br>
5. lib ディレクトリーに置いたライブラリーも require で動的に読める。<br>
6. GPIO を使って Raspberry Pi Pico に接続した LED を光らせる。<br>
7. ADC を使ってチップ上の温度センサーから温度を取得する。<br>
8. I2C を使って画面出力する。<br>

途中、オームの法則やキルヒホッフの法則といった電気回路にまつわる話題もありました。<br>
諸事情により講演前日に基調講演をお願いする形となりましたが、ご快諾・ご講演いただきました。<br>

![02_keynote.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/02_keynote.jpg)

### Ruby をファミコンで動かすには

* 発表者
  * yhara 氏
* 資料
  * [スライド](https://docs.google.com/presentation/d/1gs2fgxa6P1xl0VGpuDQavdBRvCQ1KT1MgJKGDLwVKeM/edit#slide=id.p)
  * [yhara/mruby-ruby](https://github.com/yhara/mruby-ruby)
  * [yhara/nesruby](https://github.com/yhara/nesruby)

近年の RubyKaigi で往年のゲーム機で Ruby を動かす取り組みの発表が続いています。<br>
発表では Ruby プログラムである足し算(10+20)を mruby のバイトコード化し、ファミコンのエミュレーターで実行するのがデモされました。今回 yhara 氏は、ファミコンで 10 + 20 程度の足し算の mruby バイトコードを実行できる nesruby を作成されています。<br>
また、今回の取り組みにあたり mruby を作ることが mruby のバイトコードがどうやって実行されるか理解する最良の方法と Ruby で実装した mruby/ruby も作成されています。<br>
mruby/ruby は、C に詳しくない Rubyist の学習用(観賞用)にと紹介されました。<br>

![03_session1.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/03_session1.jpg)

### Rails Girls Matsue 5th を振り返る

* 発表者
  * 石川 瑞希 氏
* 資料
  * [Rails Girls Matsue 5th](https://railsgirls.com/matsue-5th.html)

昨年、2023 年 11 月 11 日に開催された Rails Girls Matsue 5th にてオーガナイザを務めていただいた石川 瑞希 氏から振り返りとともに経験談を語っていただきました。<br>
準備期間が短かったことなどもあり、低コストでシンプルなイベントを目指すとともに、一方で、Rails や Ruby にしっかり触れてもらえる機会となるよう試行錯誤したというご紹介でした。<br>
開催後のアンケートで全ての参加者から「とてもサポートしてもらえて助かった」と感謝の言葉をもらえたというお話が印象的でした。<br>
次回、Rails Girls Matsue 6th の開催も楽しみです。<br>

![04_session2.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/04_session2.jpg)

### Rubyist Magagine を続けていくということ

* 発表者
  * 金子 慶子 氏
* 資料
  * [スライド](https://speakerdeck.com/neko314/matsue-ruby-kaigi-11)
  * [Ruby30 周年記念イベントのレポート](https://magazine.rubyist.net/articles/0063/0063-ruby30thReport.html)

るびまの編集部に参加された経緯は、Ruby30 周年記念イベントのレポートを書く人を募集されていた際にご自身で書かれたこと、と説明されていました。<br>
るびまの編集は、Ruby そして Rubyist の「今」を残していきたいという思いから続けておられるとのことでした。 <br>
るびまを続けていく上で「記事、仲間、仕組み」が不足しているということで、以下のような様々なことを模索されていると紹介されていました。<br>

- 記事： RubyKaigi 2024 のフォトレポートのような参加型の記事を増やす
- 仲間： 編集部への参加は随時、募集している
- 仕組み： GitHub の README を分かりやすくする

今後の活動として、るびま 20 周年記念号をそろそろ出せるのではないかということでした。<br>

![05_session3.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/05_session3.jpg)

### gem_rbs_collection へのコントリビュートから始める Ruby の型の世界

* 発表者
  * 森塚 真年(@sanfrecce_osaka) 氏
* 資料
  * [スライド](https://speakerdeck.com/sanfrecce_osaka/contributing-gem-rbs-collection)
  * [roo-rb/roo](https://github.com/roo-rb/roo)
  * [ruby/gem_rbs_collection](https://github.com/ruby/gem_rbs_collection)
  * [ruby-jp.github.io](https://ruby-jp.github.io/)

まず Ruby の型による恩恵を受けることも多くなり、会場の参加者へ現在の Ruby の型に対する盛り上がりを共有いただきました。<br>
gem_rbs_collection のコントリビュートの仕方として [roo-rb/roo](https://github.com/roo-rb/roo) に型をつけた時の作業についてお話しいただき、以下の順番に作業されたとのことでした。<br>

1. コントリビュート先を確認
2. 開発環境の構築
3. rbs prototype rb コマンドで型を生成後に各機能に型をつける

[roo-rb/roo](https://github.com/roo-rb/roo) の method_missing で追加されるスプレッドシートの行と列に対応するメソッドに型を付ける方法について Slack の ruby-jp で相談したところ、gem パッケージで型を追加せずに必要なら各自で追加すればよいとの返答でしたので、そこは型を指定せずに PR を作成されたとのことでした。<br>
きちんとテストも書き、PR をマージできたところまでの流れをご説明いただきました。<br>

![06_session4.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/06_session4.jpg)

### low power ruby

* 発表者
  * 小倉 由弘 氏
* 資料
  * [RBoard](https://www.sjc-inc.co.jp/service/rboard)

mruby/c を搭載した RBoard をベースにして、電源を単三電池にする試みが発表されました。<br>
今回は最初の取り組みとして、CPU の sleep を実行したときのシステムの電力消費を当初の 1/100 程度に小さくでき、単三電池で sleep を 1 年以上実行できるくらいになったとのことでした。<br>

- 今回の試み
  - 消費電力がより小さいマイコンに変更
  - sleep の実行時に CPU 以外(周辺機器部分)で一定の電力消費が残っていることを見つけた
  - 周辺機器部分による電力消費を減らそうと電圧を強制的に下げると sleep を実行できなくなったが、UART の機能を止めることで 電圧を下げても sleep を実行できるようになった

![07_session5.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/07_session5.jpg)

### ruby.wasm × Service Worker でサーバーのいらないモックサーバーを作る

* 発表者
  * lni_T / ルニ 氏
* 資料
  * [スライド](https://speakerdeck.com/lnit/matrk11-ruby-wasm-msw)
  * [デモ](https://ruby-wasm-oas-mock.lnilab.net/boot.html)
  * [Lnit/ruby_wasm_openapi_msw](https://github.com/Lnit/ruby_wasm_openapi_msw)

ウェブアプリケーションをウェブブラウザー上で動作させるにあたって必要な Service Worker の解説と、作成した OpenAPI 仕様のモックサーバー、及びその作り方をご説明されました。<br>
Service Worker はフロントエンドからバックエンドへのリクエストに割り込んで処理できる、これを利用して Service Worker 上で ruby.wasm を動作することで、Ruby で書いたウェブアプリケーションをブラウザーで動作できるとのことでした。<br>
実際に OpenAPI 仕様のモックサーバーを動かすにあたり、ちょうどいい gem がなかったために自作されました。ruby_wasm.gem を使って実装した過程と、発生した問題、その解決策について次のようにご説明がありました。<br>

- textarea 要素に入力した YAML を扱うため、Indexed DB 経由で YAML を渡した。
- C 拡張の commonmarker がビルドに失敗していたため、ビルド対象から外し、LoadError 回避のために空ファイルを置いた。

![08_session6.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/08_session6.jpg)

### Ruby の日本語リファレンスマニュアルの現在と未来

* 発表者
  * 西山 和広 氏
* 資料
  * [rurema/bitclust](https://github.com/rurema/bitclust)
  * [ruby-jp.github.io](https://ruby-jp.github.io/)

Ruby リファレンスマニュアル刷新計画についてお話しいただきました。<br>
rurema は現状、文法の変更などの対応状況や NEWS の翻訳等について、何が追いついていないのかがまとまっていない状況とのことでした。<br>
その現状を打開するため、元々は RD をベースとした独自記法によって記述することになっていましたが、Markdown 対応を進めておられて、それによってドキュメントの更新に対する敷居を下げることを目指されていました。<br>
また、ドキュメントの誤字脱字なども受付中とのことで、issue に対応してくれる方、PR のレビューをしていただける方を募集しておられました。<br>
rurema についての興味や質問等については、Slack の ruby-jp の #rurema チャンネルにてご連絡くださいとのことでした。<br>

![09_session7.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/09_session7.jpg)

### RDoc の改善案をひたすらしゃべるだけ

* 発表者
  * 大倉 雅史 氏

ドキュメントを書くための作業が、楽しくなるいい改善方法があるのでは？という切り口からのお話でした。<br>
Ruby のドキュメント生成ツールとしては RDoc と YARD が代表的ですが、書いていて楽しいという点や Ruby の標準ライブラリであるためより多くのユーザーが恩恵を受けることが出来るだろう、という点から RDoc に注目して以下のような課題をいくつかご紹介いただきました。<br>

* 型を記述しても解釈できない
* RDoc が YARD を理解できれば嬉しい
* パーサー追加や他機能と連携したいが拡張性が低い

これらを解決すべく、プラグインとして拡張可能な機能を実装できないかいう構想はとても興味深いものでした。<br>
ドキュメントが楽しく書けるようになると Ruby の魅力がまた強くなりそうです。<br>

![10_session8.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/10_session8.jpg)

### まつもと ゆきひろ 氏への質問コーナー

* 発表者
   * まつもと ゆきひろ 氏
* 司会
   * 高尾 宏治 氏

事前に松江 Ruby 会議 11 の開催前に、まつもと ゆきひろ 氏への質問の募集をおこないました。<br>
30 分のうち、20 分ほどはその事前に募集いただいた質問にご回答いただき、残りの 10 分を会場に参加者から質問をしていただきました。<br>
過去に講演された発表に関する質問、モチベーションに関する質問、Ruby の言語設計に関する質問などがありました。<br>

![11_qa.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/11_qa.jpg)

### あしあと

松江 Ruby 会議 11 にご参加いただいた方に「あしあと」としてホワイトボードにメッセージを書いていただきました。

![12_qa.jpg]({{base}}{{site.baseurl}}/images/0065-MatsueRubyKaigi11Report/12_ashiato.jpg)

## 著者について

### 佐田 明弘 ([@sada4](https://x.com/sada4))

Matsue.rb 代表。松江 Ruby 会議 11 実行委員長。

### 西田 雄也 ([@nishidayuya](https://x.com/nishidayuya))

Matz-e 市在住の Rubyist ．

### 高田 芳和 ([@teeta32](https://x.com/teeta32))

松江市在住、Matsue.rb 定例会に通っています。

### 伊東 亮 ([@telegib](https://x.com/telegib))

出雲市在住 Ruby プログラマ。誕生石も Ruby です。

### 藤井 貴

日々、Ruby でコードを書いている。松江 Ruby 会議 07 以来の参加。
