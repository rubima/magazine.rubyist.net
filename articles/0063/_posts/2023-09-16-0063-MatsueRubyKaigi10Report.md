---
layout: post
title: RegionalRubyKaigi レポート (82) 松江 Ruby 会議 10
short_title: RegionalRubyKaigi レポート (82) 松江 Ruby 会議 10
tags: 0063 MatsueRubyKaigi10Report regionalRubyKaigi
---
{% include base.html %}


## RegionalRubyKaigi レポート 松江 Ruby 会議 10

### はじめに

2023年9月16日（土）に松江Ruby会議10が開催されました。<br>
新型コロナウイルスの影響で前回から5年が経過してからの開催となりました。<br>
合計55名の方にご参加いただきました。<br>

* 日時：2023年9月16日（土）13:00〜18:00（懇親会: 19:00〜）
* 場所：松江オープンソースラボ
* 主催：Matsue.rb（まつえるびー）
* 後援：日本Rubyの会
* Togetterまとめ： [https://togetter.com/li/2228242](https://togetter.com/li/2228242)
* 公式タグ：[#matrk10](https://twitter.com/hashtag/matrk10)

![01_all.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/01_all.jpg)

### Names, Modules, and Namespaces

* 発表者
  * tagomoris 氏([@tagomoris](https://twitter.com/tagomoris))
* 資料
  * [スライド](https://speakerdeck.com/tagomoris/help-collisions-isolate-the-worlds)

最初の発表は tagomoris 氏より「Names, Modules, and Namespaces」というタイトルで、クラス・モジュールのCollisions(衝突)とその回避のためのプロポーザル実装の話でした。<br>
Rubyの内部実装に踏み込む濃い内容の発表でしたが、軽妙なトークで会場は盛り上がりました。<br>
また、tagomoris 氏から「実家が近くて育児を任せることができてとても参加しやすいイベント」というコメントもいただき、ほっこりする一場面もありました。<br>

![02_session1.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/02_session1.jpg)

### 歴史の長いRuby on Railsアプリケーションにおける技術的負債との戦い

* 発表者
  * 大倉 圭介 氏([@okeicalm](https://twitter.com/okeicalm))

6年開発を続けたRailsアプリをフォークして、別プロダクトとして新規開発した案件を踏まえた発表でした。<br>
技術的負債は事業を続けてこられた結果なので、リスペクトを持って取り組む課題と言われたことが印象に残りました。<br>
課題だった gem を削減したこと(Railsの標準的なgemに代替)。デザインパターンの改善など課題ごとに紹介がありました。<br>
特にマイクロサービス化の結果として生じた課題について、会場から共感する反応が多くありました。<br>

サービス提供中の改善は難しいため、サービスのリリース前がチャンスであると強調されていました。<br>
また、システム改善Dayを設定する取り組みを行なっており、その中で不要なコードの削除が特に進んだとのことでした。<br>

![03_session2.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/03_session2.jpg)

### ruby.wasmでブラウザを酷使してみよう

* 発表者
  * lni_T / ルニ氏([@lni_T](https://twitter.com/lni_T))
* 資料
  * [スライド](https://speakerdeck.com/lnit/ruby-wasm-2023-matsuerubykaigi)

RubyKaigi 2022 で発表され、その後も改良が進められている ruby.wasm(WebAssembly)についての発表でした。<br>
2023年7月にリリースされたruby.wasm 2.1の改良点の紹介など、現在のruby.wasm がどこまでできるようになっているか、というホットな内容でした。<br>
サンプルコードを紹介しつつ、DOM操作、Canvas操作、オーディオ操作などのデモがあり、最終的にはruby.wasm上で動作するゲームのデモがあり、観客からは拍手が起こっていました。<br>

![04_session3.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/04_session3.jpg)

### This is not Ruby

* 発表者
  * yhara 氏([@yhara](https://twitter.com/yhara))
* 資料
  * [スライド](https://docs.google.com/presentation/d/1N_lq28e73DgFjxWu5HJkTjN6duSpLOTUxGaz-6mVo70/edit#slide=id.p)
  * [Shiika](https://github.com/shiika-lang/shiika)

"RubyっぽいけどRubyじゃない"、自作プログラミング言語「Shiika」が紹介されました。<br>
直感的に書ける言語がいいが、型は書きたい。そんな「静的型言語で書きやすさ志向」という既存言語にはあまりない領域を狙ったプログラミング言語でした。<br>
インスタンスを作らない特別な型やクラスの上にメタクラスを用意するなど、もしRubyが静的型付け言語だったらこんな感じだったかも？という興味深い視点を聞くことができました。<br>

![05_session4.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/05_session4.jpg)

### ソースコード参照URIの考察と作成したツールの紹介

* 発表者
  * 西田 雄也 氏([@nishidayuya](https://twitter.com/nishidayuya))
* 資料
  * [スライド](https://slide.rabbit-shocker.org/authors/nishidayuya/2023-09-16-matrk10-permanent_uri_and_dpu/
)
  * [dpu](https://github.com/nishidayuya/dpu)

ブランチ名(例えば、masterやmain)を使ったURIは、開発が進むと以前に参照したときとコードが変わる場合があり困ることについての考察でした。<br>
この問題は参照先をpermalinkにすると避けられますが、例えばGitHubのブラウザの画面からpermalinkをコピーするのは手間なため、Rubyでpermalinkを作成するツール ["dpu: determine permanent URI"](https://github.com/nishidayuya/dpu) を作ったそうです。<br>
実際にエディタの拡張からツールで生成したURLを呼び出すデモがありました。<br>
ツールもあるので、ソースコードを参照するのにブランチ名(masterやmain)を使ったURIはやめようと呼び掛けられました。<br>

![06_session5.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/06_session5.jpg)

### mruby-esp32におけるペリフェラルAPIの実装検討

* 発表者
  * 岡嵜 雄平 氏([@Y_uuu](https://twitter.com/Y_uuu))
* 資料
  * [スライド](https://speakerdeck.com/yuuu/mruby-esp32niokeruperihueraruapinoshi-zhuang-jian-tao)
  * [mruby-esp32](https://github.com/mruby-esp32/mruby-esp32)

ESP32上でmrubyを動かすためのmruby-esp32をご紹介いただき、そのペリフェラルAPIへの取り組みについてお話しいただきました。<br>
ペリフェラルとは周辺機器のことで、その周辺機器を扱うためのAPIとのことでした。<br>
現在は処理系ごとに仕様が違いますが、ペリフェラルAPIの共通の仕様を決める動きがあるとご紹介いただきました。<br>
また、mruby-esp32のペリフェラルクラスの作成についてお話しいただきました。<br>
今回のデモ用に基板も製作されてきたとのことで、実際にデモで赤いLEDを光らせた時は会場が盛り上がりました。<br>

![07_session6.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/07_session6.jpg)

### LT

* mrbgemsのすべて
  * 発表者
    * まつもと ゆきひろ 氏([@yukihiro_matz](https://twitter.com/yukihiro_matz))

LTの最初の発表者として、まつもと ゆきひろ 氏に発表していただきました。<br>
mrubyにおけるパッケージマネージャ、mrbgemsの紹介でした。<br>
すでに300を超えるmgemが公開されているとのことでした。組み込み向け言語でパッケージマネージャがあるケースは少ないそうです。<br>

![08_LT1.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/08_LT1.jpg)

* 最近の小・中学生のプログラミング事情
  * 発表者
    * 高尾 宏治 氏([@takaokouji](https://twitter.com/takaokouji))

全国と松江におけるプログラミング事情のご説明でした。<br>
前半は全国のお話で、12年前はフローチャートによるプログラミング教材だったものが、JavaScriptとHTMLで本格的なECサイトを作る内容になってきたとのことです。<br>
後半は松江のお話で、15年前に中学生Ruby教室でRuby Shoesを使っており、8年前から中学校の授業でもSmalruby 1.0でRubyを使うようになり、現在は小中学校でSmalruby 3を使うようになったとのことです。<br>
松江ではRuby City MATSUEプロジェクトもあって、特に小中学生でもRubyを学ぶ環境が整っていると印象的でした。<br>

![09_LT2.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/09_LT2.jpg)

* mruby/c + smalruby → Matz葉がにロボコン
  * 発表者
    * 杉山 耕一朗 氏
  * 資料
    * [Matz葉がにロボコン](https://www.shimane-oss.org/kani-robo/)

カニロボをプログラミングで動かして競う「Matz葉がにロボコン」の紹介でした。<br>
カニロボは、mruby/c が動作するマイコンを搭載しており、Smalruby でプログラミングして動かすとのことでした。<br>
ロボコンが継続する教育の機会（一回の講座で終わらない）となっているそうです。<br>
年内に安来で「Matz葉がにロボコン」の地区大会が開催され、来年に松江で「Matz葉がにロボコン」の開催を予定されているそうです。<br>

![10_LT3.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/10_LT3.jpg)

* gtk4 gemの使い方
  * 発表者
    * 進藤 元明 氏([@motoakira](https://twitter.com/motoakira))
  * 資料
    * [スライド](https://www.slideshare.net/ssuser0ef4681/gtk4gemusagepdf)

GTK2、GTK3に次ぐGTK4対応のグラフィックライブラリ「gtk4 gem」の紹介でした。<br>
非常にシンプルなコードでプリミティブやフォーム（温度の入力・変換フォーム)を表示することができるサンプルが紹介されました。<br>

![11_LT4.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/11_LT4.jpg)

* 古民家DXとRuby
  * 発表者
    * きむら しのぶ 氏([@mix_dvd](https://twitter.com/mix_dvd))
    * 余村 氏
  * 資料
    * [カシマ電脳基地](http://blueomega.jp/digitbase/kashima.html)

古民家を購入してDXのテストフィールドとして使っているお話でした。<br>
また、開発された[sensingplaza](https://rubygems.org/gems/sensingplaza)というアナログデータの収集や機器の状態変化、ロケーション情報を扱うRailsアプリケーションの紹介がありました。<br>

![12_LT5.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/12_LT5.jpg)

* Rubyで人工透析装置のIoT化
  * 発表者
    * 東 裕人 氏
  * 資料
    * [スライド](https://www.docswell.com/s/8539470196/5DE9MV-2023-09-19-110739)

人工透析装置と電子カルテの情報を相互にやりとりする通信装置の開発事例紹介でした。<br>
通信装置にはラズパイを利用し、ラズパイの全てのタスクを Ruby アプリケーションで実現されているそうです。<br>
また、Ruby アプリケーションは講演者の東 裕人 氏が開発している組込システムのためのアプリケーションフレームワーク「Alone」を採用されているそうです。<br>
島根県立中央病院で、この通信装置(24台)を約2年間安定して運用しているとのことでした。<br>

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

Ruby City MATSUEプロジェクトのバージョンアップ版であるRuby City MATSUE 2.0をご紹介いただきました。<br>
前身のプロジェクトから、人材育成・交流を進化させ、更に新規事業開発などを追加されたとのことです。<br>
市役所でプロジェクトを担当できる確率は1.99%とのことで、担当できることは「ラッキー！」<br>
事業的テーマ、教育的テーマ、お祭り的テーマがあり、2.0プロジェクトではバスケットBリーグの試合で冠スポンサーも行うとのことでした。<br>

![15_LT8.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/15_LT8.jpg)

* perfect_toml: Rubyで書かれた高速TOMLパーサ
  * 発表者
    * 遠藤 侑介 氏([@mametter](https://twitter.com/mametter))
  * 資料
    * [perfect_toml](https://github.com/mame/perfect_toml)

STORESに移籍されたフルタイムRubyコミッタの遠藤 侑介 氏から、RubyからTOMLファイルを読むためのgem、perfect_tomlの紹介でした。<br>
既存のものと比べると、最新仕様に対応している、シンプルで速い実装になっているという特徴があるそうです。<br>

![16_LT09.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/16_LT09.jpg)

* イベント協賛の価値を見直そう
  * 発表者
    * 井上 浩 氏([@Inoue_0852](https://twitter.com/Inoue_0852))

LTの最後の発表者として、Rubyのイベントの協賛について井上 浩 氏にお話しいただきました。<br>
過去に開催されたRubyのイベントの各企業の協賛数がグラフでスライドに表示され、どの企業がイベントの協賛に多く取り組まれているのかをご紹介いただきました。<br>
見知った企業名が表示されるため、会場も興味深く聞いていました。<br>

![17_LT10.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/17_LT10.jpg)

* ビンゴ

残念ながら諸事情でLTの発表者が1人参加できなかったので、ビンゴをしました。<br>
ビンゴの景品をご提供いただき、ありがとうございました。<br>

* RubyKaigi 2023 ノベルティキーボードキット (1個)
  * （前田 修吾様 ご提供）
* 「鷹の爪」×島根県自虐カレンダー (3冊)
  * （安達 昌明様 ご提供）

![18_bingo.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/18_bingo.jpg)

### 変化と安定と (基調講演)

* 発表者
  *  なかむら(う) 氏([@unak](https://twitter.com/unak))

Rubyの安定版を保守されているRubyコミッタのなかむら(う) 氏から、Rubyの互換性に関する発表でした。 <br>
Ruby v0.49のようにユーザが少ない頃は、互換性のない変更も入れやすかったですが、ユーザが増えるとそうもいきません。<br>
かといってRuby 1.8やPython 2のように旧版を長く保守すると、コミュニティの分断にもつながります。<br>
そのため、Rubyの各リリースは約3年をサポート期限としていること、また非互換が入る場合は最低1年はwarningを出すことで機能追加と滑らかな移行の両立を目指しているとのことでした。<br>

![19_keynote.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/19_keynote.jpg)

### なかむら(う) 氏 ＆ まつもと ゆきひろ 氏の対談

* 発表者
  * なかむら(う) 氏([@unak](https://twitter.com/unak))
  * まつもと ゆきひろ 氏([@yukihiro_matz](https://twitter.com/yukihiro_matz))

なかむら(う) 氏と、まつもと ゆきひろ 氏のざっくばらんな対談でした。<br>
Rubyとの関わりやお仕事といった普段の生活から始まり、Rubyコミュニティの話題で盛り上がりました。<br>

- なかむら(う) 氏
    - 普段
        - 夜にRubyの安定版のためにIssueを見ている。
        - 最近は週に1日Rubyを保守する日を作って対応している。
        - 平日日中は普通にお仕事をしている。
            - 自分の一番好きなことを仕事にすると、好きが嫌いになるということもあるため、食べるのはRubyでなくてもいいかなと思っている。
    - 安定版に入れる／入れないは、なかむら(う) 氏が判断
        - 非互換な変更やセキュリティフィックスでないもの、ロジックが違いすぎてどんな非互換が入るかわからないものは入れない判断をする。
        - 最近のmacOSで出てきた関連のものはなるべく入れるようにしている。
- まつもと ゆきひろ 氏
    - 松江に引越した当初は普通にお仕事をしていた。
    - 2003年頃から直接売上を上げる仕事ではなくなった（フェローに就任）
    - 2013年ぐらいから技術顧問が増えて、CRubyそのものへのコミットは減っていった。1.8の頃はほぼ100%書いていたけれども、今となっては1割切ったと思う。
    - ここ10年ぐらいはmrubyを作るのとコミッターの人たちとみんなで相談しながらRubyの方向性を決めてRubyKaigiやRuby Conferenceなど、基調講演で発表している。
- Rubyコミュニティ
    - Rubyのリリース時のミスを見かねて、卜部さん([@shyouhei](https://twitter.com/shyouhei))がリリースマネージャーを引き受けられたときのように、助けてやらないといけないという観点からコミュニティに入ってきた方は結構いそう。
    - コミュニティが健全で、そのRubyを使う市場があるっていう状態になっていれば、エンジニアの先はある。企業が支援してくれるほどのコミュニティを維持できて良かった。
    - Rubyがある程度広まった時点で、Rubyという存在に対して企業さんやユーザーさん含めてその期待に応えたいなと思っていろいろ行動してきた。
    - kateinoigakukunさん([@kateinoigakukun](https://twitter.com/kateinoigakukun))や国分さん([@k0kubun](https://twitter.com/k0kubun))など、Rubyコミュニティには定期的に新しい方が入ってきて成果を残される。すごい。

![20_talk.jpg]({{base}}{{site.baseurl}}/images/0063-MatsueRubyKaigi10Report/20_talk.jpg)

## 謝辞

### スポンサー様

[ガーネットテック373株式会社](https://garnettech373.com/)

## 著者について

### 佐田 明弘 ([@sada4](https://twitter.com/sada4))

Matsue.rb代表。松江Ruby会議10 実行委員長。

### 西田 雄也 ([@nishidayuya](https://twitter.com/nishidayuya))

松江のRubyist．ぷよぷよで娘たちにボコボコにされる．

### 原 悠 ([@yhara](https://twitter.com/yhara))

Shiikaの作者。最近の興味はスキューブとヨーヨー。

### 野坂 秀和 ([@hnozaka](https://twitter.com/hnozaka))

Rubyとサッカーをこよなく愛する松江市在住のRubyプログラマ。

### 田中 健

Rubyプログラマ。松江Ruby会議が久しぶりのイベント参加。

### 高田 芳和 ([@teeta32](https://twitter.com/teeta32))

松江在住のエンジニア。最近、Matsue.rb に通っている。
