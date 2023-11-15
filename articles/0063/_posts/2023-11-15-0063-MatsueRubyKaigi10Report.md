---
layout: post
title: RegionalRubyKaigi レポート (82) 松江 Ruby 会議 10
short_title: RegionalRubyKaigi レポート (82) 松江 Ruby 会議 10
tags: 0063 MatsueRubyKaigi10Report regionalRubyKaigi
created_on: 2023-11-15
---
{% include base.html %}


## RegionalRubyKaigi レポート 松江 Ruby 会議 10

### はじめに

2023 年 9 月 16 日（土）に松江 Ruby 会議 10 が開催されました。<br>
新型コロナウイルスの影響で前回から 5 年が経過してからの開催となりました。<br>
合計 55 名の方にご参加いただきました。<br>

* 日時：2023 年 9 月 16 日（土） 13:00〜18:00 （懇親会: 19:00〜）
* 場所：松江オープンソースラボ
* 主催：Matsue.rb （まつえるびー）
* 後援：日本 Ruby の会
* Togetter まとめ： [https://togetter.com/li/2228242](https://togetter.com/li/2228242)
* 公式タグ：[#matrk10](https://twitter.com/hashtag/matrk10)

![01_all.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/01_all.jpg)

### Names, Modules, and Namespaces

* 発表者
  * tagomoris 氏([@tagomoris](https://twitter.com/tagomoris))
* 資料
  * [スライド](https://speakerdeck.com/tagomoris/help-collisions-isolate-the-worlds)

最初の発表は tagomoris 氏より「Names, Modules, and Namespaces」というタイトルで、クラス・モジュールの Collisions(衝突)とその回避のためのプロポーザル実装の話でした。<br>
Ruby の内部実装に踏み込む濃い内容の発表でしたが、軽妙なトークで会場は盛り上がりました。<br>
また、tagomoris 氏から「実家が近くて育児を任せることができてとても参加しやすいイベント」というコメントもいただき、ほっこりする一場面もありました。<br>

![02_session1.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/02_session1.jpg)

### 歴史の長い Ruby on Rails アプリケーションにおける技術的負債との戦い

* 発表者
  * 大倉 圭介 氏([@okeicalm](https://twitter.com/okeicalm))

6 年開発を続けた Rails アプリをフォークして、別プロダクトとして新規開発した案件を踏まえた発表でした。<br>
技術的負債は事業を続けてこられた結果なので、リスペクトを持って取り組む課題と言われたことが印象に残りました。<br>
課題だった gem を削減したこと(Rails の標準的な gem に代替)。デザインパターンの改善など課題ごとに紹介がありました。<br>
特にマイクロサービス化の結果として生じた課題について、会場から共感する反応が多くありました。<br>

サービス提供中の改善は難しいため、サービスのリリース前がチャンスであると強調されていました。<br>
また、システム改善 Day を設定する取り組みを行なっており、その中で不要なコードの削除が特に進んだとのことでした。<br>

![03_session2.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/03_session2.jpg)

### ruby.wasm でブラウザを酷使してみよう

* 発表者
  * lni_T / ルニ氏([@lni_T](https://twitter.com/lni_T))
* 資料
  * [スライド](https://speakerdeck.com/lnit/ruby-wasm-2023-matsuerubykaigi)

RubyKaigi 2022 で発表され、その後も改良が進められている ruby.wasm(WebAssembly)についての発表でした。<br>
2023 年 7 月にリリースされた ruby.wasm 2.1 の改良点の紹介など、現在の ruby.wasm がどこまでできるようになっているか、というホットな内容でした。<br>
サンプルコードを紹介しつつ、DOM 操作、Canvas 操作、オーディオ操作などのデモがあり、最終的には ruby.wasm 上で動作するゲームのデモがあり、観客からは拍手が起こっていました。<br>

![04_session3.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/04_session3.jpg)

### This is not Ruby

* 発表者
  * yhara 氏([@yhara](https://twitter.com/yhara))
* 資料
  * [スライド](https://docs.google.com/presentation/d/1N_lq28e73DgFjxWu5HJkTjN6duSpLOTUxGaz-6mVo70/edit#slide=id.p)
  * [Shiika](https://github.com/shiika-lang/shiika)

"Ruby っぽいけど Ruby じゃない"、自作プログラミング言語「Shiika」が紹介されました。<br>
直感的に書ける言語がいいが、型は書きたい。そんな「静的型言語で書きやすさ志向」という既存言語にはあまりない領域を狙ったプログラミング言語でした。<br>
インスタンスを作らない特別な型やクラスの上にメタクラスを用意するなど、もし Ruby が静的型付け言語だったらこんな感じだったかも？という興味深い視点を聞くことができました。<br>

![05_session4.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/05_session4.jpg)

### ソースコード参照 URI の考察と作成したツールの紹介

* 発表者
  * 西田 雄也 氏([@nishidayuya](https://twitter.com/nishidayuya))
* 資料
  * [スライド](https://slide.rabbit-shocker.org/authors/nishidayuya/2023-09-16-matrk10-permanent_uri_and_dpu/
)
  * [dpu](https://github.com/nishidayuya/dpu)

ブランチ名(例えば、master や main)を使った URI は、開発が進むと以前に参照したときとコードが変わる場合があり困ることについての考察でした。<br>
この問題は参照先を permalink にすると避けられますが、例えば GitHub のブラウザの画面から permalink をコピーするのは手間なため、Ruby で permalink を作成するツール ["dpu: determine permanent URI"](https://github.com/nishidayuya/dpu) を作ったそうです。<br>
実際にエディタの拡張からツールで生成した URL を呼び出すデモがありました。<br>
ツールもあるので、ソースコードを参照するのにブランチ名(master や main)を使った URI はやめようと呼び掛けられました。<br>

![06_session5.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/06_session5.jpg)

### mruby-esp32 におけるペリフェラル API の実装検討

* 発表者
  * 岡嵜 雄平 氏([@Y_uuu](https://twitter.com/Y_uuu))
* 資料
  * [スライド](https://speakerdeck.com/yuuu/mruby-esp32niokeruperihueraruapinoshi-zhuang-jian-tao)
  * [mruby-esp32](https://github.com/mruby-esp32/mruby-esp32)

ESP32 上で mruby を動かすための mruby-esp32 をご紹介いただき、そのペリフェラル API への取り組みについてお話しいただきました。<br>
ペリフェラルとは周辺機器のことで、その周辺機器を扱うための API とのことでした。<br>
現在は処理系ごとに仕様が違いますが、ペリフェラル API の共通の仕様を決める動きがあるとご紹介いただきました。<br>
また、mruby-esp32 のペリフェラルクラスの作成についてお話しいただきました。<br>
今回のデモ用に基板も製作されてきたとのことで、実際にデモで赤い LED を光らせた時は会場が盛り上がりました。<br>

![07_session6.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/07_session6.jpg)

### LT

* mrbgems のすべて
  * 発表者
    * まつもと ゆきひろ 氏([@yukihiro_matz](https://twitter.com/yukihiro_matz))

LT の最初の発表者として、まつもと ゆきひろ 氏に発表していただきました。<br>
mruby におけるパッケージマネージャ、mrbgems の紹介でした。<br>
すでに 300 を超える mgem が公開されているとのことでした。組み込み向け言語でパッケージマネージャがあるケースは少ないそうです。<br>

![08_LT1.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/08_LT1.jpg)

* 最近の小・中学生のプログラミング事情
  * 発表者
    * 高尾 宏治 氏([@takaokouji](https://twitter.com/takaokouji))

全国と松江におけるプログラミング事情のご説明でした。<br>
前半は全国のお話で、12 年前はフローチャートによるプログラミング教材だったものが、JavaScript と HTML で本格的な EC サイトを作る内容になってきたとのことです。<br>
後半は松江のお話で、15 年前に中学生 Ruby 教室で Ruby Shoes を使っており、8 年前から中学校の授業でも Smalruby 1.0 で Ruby を使うようになり、現在は小中学校で Smalruby 3 を使うようになったとのことです。<br>
松江では Ruby City MATSUE プロジェクトもあって、特に小中学生でも Ruby を学ぶ環境が整っていると印象的でした。<br>

![09_LT2.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/09_LT2.jpg)

* mruby/c + smalruby → Matz 葉がにロボコン
  * 発表者
    * 杉山 耕一朗 氏
  * 資料
    * [Matz 葉がにロボコン](https://www.shimane-oss.org/kani-robo/)

カニロボをプログラミングで動かして競う「Matz 葉がにロボコン」の紹介でした。<br>
カニロボは、mruby/c が動作するマイコンを搭載しており、Smalruby でプログラミングして動かすとのことでした。<br>
ロボコンが継続する教育の機会（一回の講座で終わらない）となっているそうです。<br>
年内に安来で「Matz 葉がにロボコン」の地区大会が開催され、来年に松江で「Matz 葉がにロボコン」の開催を予定されているそうです。<br>

![10_LT3.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/10_LT3.jpg)

* gtk4 gem の使い方
  * 発表者
    * 進藤 元明 氏([@motoakira](https://twitter.com/motoakira))
  * 資料
    * [スライド](https://www.slideshare.net/ssuser0ef4681/gtk4gemusagepdf)

GTK2、GTK3 に次ぐ GTK4 対応のグラフィックライブラリ「gtk4 gem」の紹介でした。<br>
非常にシンプルなコードでプリミティブやフォーム（温度の入力・変換フォーム)を表示することができるサンプルが紹介されました。<br>

![11_LT4.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/11_LT4.jpg)

* 古民家 DX と Ruby
  * 発表者
    * きむら しのぶ 氏([@mix_dvd](https://twitter.com/mix_dvd))
    * 余村 氏
  * 資料
    * [カシマ電脳基地](http://blueomega.jp/digitbase/kashima.html)

古民家を購入して DX のテストフィールドとして使っているお話でした。<br>
また、開発された[sensingplaza](https://rubygems.org/gems/sensingplaza)というアナログデータの収集や機器の状態変化、ロケーション情報を扱う Rails アプリケーションの紹介がありました。<br>

![12_LT5.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/12_LT5.jpg)

* Ruby で人工透析装置の IoT 化
  * 発表者
    * 東 裕人 氏
  * 資料
    * [スライド](https://www.docswell.com/s/8539470196/5DE9MV-2023-09-19-110739)

人工透析装置と電子カルテの情報を相互にやりとりする通信装置の開発事例紹介でした。<br>
通信装置にはラズパイを利用し、ラズパイの全てのタスクを Ruby アプリケーションで実現されているそうです。<br>
また、Ruby アプリケーションは講演者の東 裕人 氏が開発している組込システムのためのアプリケーションフレームワーク「Alone」を採用されているそうです。<br>
島根県立中央病院で、この通信装置(24 台)を約 2 年間安定して運用しているとのことでした。<br>

![13_LT6.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/13_LT6.jpg)

* 自作キーボードの組み立て
  * 発表者
    * 高田 芳和 氏([@teeta32](https://twitter.com/teeta32))
  * 資料
    * [スライド](https://www.docswell.com/s/8833899131/KGXWJ8-2023-09-22-141904)

会場に参加されていた他の方々が使用されている自作キーボードの写真も表示され、今回挑戦した動機についてお話しいただきました。<br>
自作キーボードは今回が初めて作成されたとのことで、慣れない作業に戸惑いながらも完成させたとのことでした。<br>

![14_LT7.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/14_LT7.jpg)

* Ruby City MATSUE 2.0
  * 発表者
    * 曽田 周平 氏

Ruby City MATSUE プロジェクトのバージョンアップ版である Ruby City MATSUE 2.0 をご紹介いただきました。<br>
前身のプロジェクトから、人材育成・交流を進化させ、更に新規事業開発などを追加されたとのことです。<br>
市役所でプロジェクトを担当できる確率は 1.99%とのことで、担当できることは「ラッキー！」<br>
事業的テーマ、教育的テーマ、お祭り的テーマがあり、2.0 プロジェクトではバスケット B リーグの試合で冠スポンサーも行うとのことでした。<br>

![15_LT8.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/15_LT8.jpg)

* perfect_toml: Ruby で書かれた高速 TOML パーサ
  * 発表者
    * 遠藤 侑介 氏([@mametter](https://twitter.com/mametter))
  * 資料
    * [perfect_toml](https://github.com/mame/perfect_toml)

STORES に移籍されたフルタイム Ruby コミッタの遠藤 侑介 氏から、Ruby から TOML ファイルを読むための gem、perfect_toml の紹介でした。<br>
既存のものと比べると、最新仕様に対応している、シンプルで速い実装になっているという特徴があるそうです。<br>

![16_LT09.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/16_LT09.jpg)

* イベント協賛の価値を見直そう
  * 発表者
    * 井上 浩 氏([@Inoue_0852](https://twitter.com/Inoue_0852))

LT の最後の発表者として、Ruby のイベントの協賛について井上 浩 氏にお話しいただきました。<br>
過去に開催された Ruby のイベントの各企業の協賛数がグラフでスライドに表示され、どの企業がイベントの協賛に多く取り組まれているのかをご紹介いただきました。<br>
見知った企業名が表示されるため、会場も興味深く聞いていました。<br>

![17_LT10.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/17_LT10.jpg)

* ビンゴ

残念ながら諸事情で LT の発表者が 1 人参加できなかったので、ビンゴをしました。<br>
ビンゴの景品をご提供いただき、ありがとうございました。<br>

* RubyKaigi 2023 ノベルティキーボードキット (1 個)
  * （前田 修吾様 ご提供）
* 「鷹の爪」×島根県自虐カレンダー (3 冊)
  * （安達 昌明様 ご提供）

![18_bingo.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/18_bingo.jpg)

### 変化と安定と (基調講演)

* 発表者
  *  なかむら(う) 氏([@unak](https://twitter.com/unak))

Ruby の安定版を保守されている Ruby コミッタのなかむら(う) 氏から、Ruby の互換性に関する発表でした。 <br>
Ruby v0.49 のようにユーザが少ない頃は、互換性のない変更も入れやすかったですが、ユーザが増えるとそうもいきません。<br>
かといって Ruby 1.8 や Python 2 のように旧版を長く保守すると、コミュニティの分断にもつながります。<br>
そのため、Ruby の各リリースは約 3 年をサポート期限としていること、また非互換が入る場合は最低 1 年は warning を出すことで機能追加と滑らかな移行の両立を目指しているとのことでした。<br>

![19_keynote.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/19_keynote.jpg)

### なかむら(う) 氏 ＆ まつもと ゆきひろ 氏の対談

* 発表者
  * なかむら(う) 氏([@unak](https://twitter.com/unak))
  * まつもと ゆきひろ 氏([@yukihiro_matz](https://twitter.com/yukihiro_matz))

なかむら(う) 氏と、まつもと ゆきひろ 氏のざっくばらんな対談でした。<br>
Ruby との関わりやお仕事といった普段の生活から始まり、Ruby コミュニティの話題で盛り上がりました。<br>

- なかむら(う) 氏
    - 普段
        - 夜に Ruby の安定版のために Issue を見ている。
        - 最近は週に 1 日 Ruby を保守する日を作って対応している。
        - 平日日中は普通にお仕事をしている。
            - 自分の一番好きなことを仕事にすると、好きが嫌いになるということもあるため、食べるのは Ruby でなくてもいいかなと思っている。
    - 安定版に入れる／入れないは、なかむら(う) 氏が判断
        - 非互換な変更やセキュリティフィックスでないもの、ロジックが違いすぎてどんな非互換が入るかわからないものは入れない判断をする。
        - 最近の macOS で出てきた関連のものはなるべく入れるようにしている。
- まつもと ゆきひろ 氏
    - 松江に引越した当初は普通にお仕事をしていた。
    - 2003 年頃から直接売上を上げる仕事ではなくなった（フェローに就任）
    - 2013 年ぐらいから技術顧問が増えて、CRuby そのものへのコミットは減っていった。1.8 の頃はほぼ 100%書いていたけれども、今となっては 1 割切ったと思う。
    - ここ 10 年ぐらいは mruby を作るのとコミッターの人たちとみんなで相談しながら Ruby の方向性を決めて RubyKaigi や Ruby Conference など、基調講演で発表している。
- Ruby コミュニティ
    - Ruby のリリース時のミスを見かねて、卜部さん([@shyouhei](https://twitter.com/shyouhei))がリリースマネージャーを引き受けられたときのように、助けてやらないといけないという観点からコミュニティに入ってきた方は結構いそう。
    - コミュニティが健全で、その Ruby を使う市場があるっていう状態になっていれば、エンジニアの先はある。企業が支援してくれるほどのコミュニティを維持できて良かった。
    - Ruby がある程度広まった時点で、Ruby という存在に対して企業さんやユーザーさん含めてその期待に応えたいなと思っていろいろ行動してきた。
    - kateinoigakukun さん([@kateinoigakukun](https://twitter.com/kateinoigakukun))や国分さん([@k0kubun](https://twitter.com/k0kubun))など、Ruby コミュニティには定期的に新しい方が入ってきて成果を残される。すごい。

![20_talk.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/20_talk.jpg)

## 謝辞

### スポンサー様

[ガーネットテック 373 株式会社](https://garnettech373.com/)

## 著者について

### 佐田 明弘 ([@sada4](https://twitter.com/sada4))

Matsue.rb 代表。松江 Ruby 会議 10 実行委員長。

### 西田 雄也 ([@nishidayuya](https://twitter.com/nishidayuya))

松江の Rubyist ．ぷよぷよで娘たちにボコボコにされる．

### 原 悠 ([@yhara](https://twitter.com/yhara))

Shiika の作者。最近の興味はスキューブとヨーヨー。

### 野坂 秀和 ([@hnozaka](https://twitter.com/hnozaka))

Ruby とサッカーをこよなく愛する松江市在住の Ruby プログラマ。

### 田中 健

Ruby プログラマ。松江 Ruby 会議が久しぶりのイベント参加。

### 高田 芳和 ([@teeta32](https://twitter.com/teeta32))

松江在住のエンジニア。最近、Matsue.rb に通っている。
