---
layout: post
title: RegionalRubyKaigi レポート (TODO) 松江 Ruby 会議 12
short_title: RegionalRubyKaigi レポート (TODO) 松江 Ruby 会議 12
tags: MatsueRubyKaigi12Report regionalRubyKaigi
post_author: 野坂 秀和, 田中 健, 原 悠, 佐田 明弘
created_on: 2026-06-06
---
{% include base.html %}

## RegionalRubyKaigi レポート 松江 Ruby 会議 12

2026 年 6 月 6 日（土）に松江 Ruby 会議 12 が開催されました。<br>
合計 70 名の方にご参加いただきました。<br>
今回の会場は、島根県指定有形文化財である興雲閣で開催しました。<br>
当日は晴れたので会場の建物を見ていただくのにも良い天気となりました。<br>

* 日時：2026 年 6 月 6 日（土） 12:30〜17:15 （懇親会: 18:30〜）
* 場所：興雲閣
* 主催：Matsue.rb （まつえるびー）
* 後援：日本 Ruby の会
* Togetter まとめ： [https://posfie.com/@matsuerb/p/Lq7Gzv6](https://posfie.com/@matsuerb/p/Lq7Gzv6)
* 公式タグ：[#matrk12](https://x.com/hashtag/matrk12)

![01_all.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/01_all.jpg)

### 基調講演

* 発表者
  * 卜部 昌平 氏

Rubyメンテナの卜部さんから見た、CRuby開発の歴史をたどる基調講演でした。<br>
1.8.6 頃から始まったリリースエンジニアリング、GitHub の ruby/ruby にまつわる秘話、CI の導入によって「 CI が壊れないところまで作業してから push する」ようにコミッタの意識が変わった話など、機能を実装するだけではないさまざまな側面が紹介されていて面白かったです。<br>
最後は、まずやってみてから相談すること、小さく始めること、いいタイミングで他人に引き継ぐことでタスクを抱え込まないことを教訓として挙げられました。<br>

![02_keynote.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/02_keynote.jpg)
、
### ruby.wasm で作る MIDI コントローラー

* 発表者
  * nagachika 氏
* 資料
  * [スライド](https://speakerdeck.com/nagachika/ruby-dot-wasm-dezuo-ru-midi-kontorora)

nagachika さんが RubyKaigi2026 で発表された Ruby/WASM で動くシンセサイザー／シーケンサーである "purified-synth" の紹介と、それを鳴らすための MIDIパッドコントローラー "odd-pad" の紹介でした。<br>
まるで DTM の機材のようなソフトウェアで見た目がまず格好良かったです。MIDI について基本的な仕組みや Web における利用方法の説明があり勉強になりました。最後に Android タブレットをパッドコントローラーとして音を鳴らすデモがありました。機器の不調があり想定どおりとはいかなかったようですが、音が鳴った際には会場から拍手があがっていました。

![03_session1.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/03_session1.jpg)

### Rubyで音を視る

* 発表者
  *  ydah 氏
* 資料
  * [スライド](https://speakerdeck.com/ydah/seeing-sound-with-ruby-at-marrk12)

「音」の特徴抽出をして可視化するプロセスを Ruby の DSL と絡めて発表されており、Ruby 的な DSL 記述との意外な親和性に驚きを覚えました。<br>
そうして得られた音の特徴データを WebSocket + WebGL でブラウザ上で可視化するという試みも面白く、 Ruby と「音」という一見あまり繋がって捉えられない分野がスッと頭の中で繋がる感覚が新鮮でした。<br>
また、音の特徴抽出をチューニングして音声認識に繋がる過程の実演が、音声認識の中身を感覚的に掴めて面白い体験ができました。<br>

![04_session2.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/04_session2.jpg)

### 十年目の神隠し　時の狭間に消えたタグ

* 発表者
  * sakahukamaki 氏

現在運用しているシステムにおいて、あるタグで検索したときだけタイムアウトするという謎事象について、原因の調査から解決に至るまでの過程のお話でした。<br>
一見、不可思議な挙動でも調べていくと「ああ、なるほど」という原因にたどり着くというくだりは、とても共感できるものでした。
またそこから得られた数々の教訓（「監視は重要」とか「違和感を見逃すな」とか）についても全くその通りだと思い、自分が普段行っている開発でも気をつけなけていかなければと思える発表でした。

![05_session3.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/05_session3.jpg)

### dRuby over BLE: Device-to-Device Remote Method Calls

* 発表者
  * makicamel 氏
* 資料
  * [スライド](https://speakerdeck.com/makicamel/druby-over-ble)

古くからあるdRubyを組み込みの世界に持ってこようという試みが新鮮で眼から鱗でした。<br>
そうした中でdRubyの階層モデル設計の美しさなどを再認識することができ、dRubyの可能性の拡がりを感じることができました。<br>
その上で「実は（設計の指向的な理由から）目的に対して性能要件を十分に達成できなかった」というオチも秀逸だったと思いました。<br>
利便性や直観性を確保しつつ性能要件も担保するというのがいかに難問であるかを再認識できる良いセッションでした。<br>

![06_session4.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/06_session4.jpg)

### Ruby::Boxは何に使えて何に使えないのか

* 発表者
  * joker1007 氏
* 資料
  * [スライド](https://speakerdeck.com/joker1007/ruby-boxdedekirukoto-refinementsdedekirukoto)

似て非なる機能である「Ruby::Box」と「Refinements」について、その特徴と向いてそうな利用方法についてのお話がありました。<br>
Refinements はあまり使ったことはなかったのですが、実は結構使い所があるということがわかり（今更）、自分のプロジェクトでも使ってみようと思いました。
Ruby::Box については、このセッションの後の LT で tagomoris さんからも話があり、今後の進展に期待が膨らみました。

![07_session5.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/07_session5.jpg)

### LT

* 言語オーケストレーションRubyPyMillの紹介
   * 発表者
      * 井上 浩 氏
   * 資料
      * [スライド](https://drive.google.com/file/d/1gw7aWQxC_VrlbqCIPaiaohtxwO8pLbDq/view)

TODO

![08_LT1.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/08_LT1.jpg)

* rubyで松江城の石垣を調査しよう！
   * 発表者
      * 土居 悠輝 氏

TODO

![09_LT2.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/09_LT2.jpg)

* Rubyでベクトル検索してみた
   * 発表者
      * yhara 氏
   * 資料
      * [スライド](https://docs.google.com/presentation/d/1j_yVHV7UpPNylwkmp4LF7OQ_hrF6NjY0rFBs6KCL66U/edit?slide=id.p#slide=id.p)

TODO

![10_LT3.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/10_LT3.jpg)

* The NotImplementedError Problem in Ruby
   * 発表者
      * koic 氏
   * 資料
      * [スライド](https://speakerdeck.com/koic/the-notimplementederror-problem-in-ruby)

TODO

![11_LT4.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/11_LT4.jpg)

* Endless Ruby
   * 発表者
      * 西田 雄也 氏
   * 資料
      * [スライド](https://slide.rabbit-shocker.org/authors/nishidayuya/2026-06-06-matrk12-endless_ruby/)

TODO

![12_LT5.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/12_LT5.jpg)

* ブラウザ完結型mruby/c環境の実践 〜ロボコンから授業・ハッカソンまで〜
   * 発表者
      * 杉山 耕一朗 (sugiymki) 氏

TODO

![13_LT6.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/13_LT6.jpg)

* Rubyと演奏したい。〜その第一歩〜
   * 発表者
      * 5hun 氏
   * 資料
      * [スライド](https://speakerdeck.com/5hun/rubytoyan-zou-sitai-sonodi-bu)

TODO

![14_LT7.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/14_LT7.jpg)

* Lightning Talk on Steam Deck with Ruby
   * 発表者
      * S.H. 氏

TODO

![15_LT8.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/15_LT8.jpg)

* 自分だけのRubyを1から作る
   * 発表者
      * pocke 氏
   * 資料
      * [スライド](https://me.pocke.me/make-your-own-ruby/)

TODO

![16_LT9.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/16_LT9.jpg)

* IRB 1.18で学ぶローカル変数とメソッド呼び出し
   * 発表者
      * 前田 修吾 氏
   * 資料
      * [スライド](https://github.com/shugo/matrk12)

TODO

![17_LT10.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/17_LT10.jpg)

* おれがBoxだ
   * 発表者
      * tagomoris 氏
   * 資料
      * [スライド](https://speakerdeck.com/tagomoris/mastering-ruby-box)

TODO

![18_LT11.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/18_LT11.jpg)

### 卜部 昌平 氏 & まつもと ゆきひろ 氏の対談

* 発表者
   * 卜部 昌平 氏 & まつもと ゆきひろ 氏
* 司会
   * 高尾 宏治 氏

山陰地方出身のまつもとさん、卜部さんに子どものころの話やプログラミングとの出会いなどについて語っていただきました。
お二人ともプログラミングを始めたときは本を読んで勉強したとお話されていて懐かしさを覚えました。<br>
会場からの質問コーナーでは、koic さんより NotImplementedError についての問題提起(?)がありました。
まつもとさんから例外クラスの体系や NoImplementedError の位置づけのお話があり、例外クラスひとつとってもいろいろ難しいなと考えさせられました。


![19_talk.jpg]({{base}}{{site.baseurl}}/images/0066-MatsueRubyKaigi12Report/19_talk.jpg)

## 謝辞

### スポンサー様

* [株式会社アンドパッド](https://andpad.co.jp/)
* [ファーエンドテクノロジー株式会社](https://www.farend.co.jp/)
* [株式会社ネットワーク応用通信研究所](https://netlab.jp/)

## 著者について

### 佐田 明弘 ([@sada4](https://x.com/sada4))

Matsue.rb 代表。松江 Ruby 会議 12 実行委員長。

### 野坂 秀和 ([@hnozaka](https://twitter.com/hnozaka))

Ruby とサッカーをこよなく愛する松江市在住の Ruby プログラマ。

### 田中 健

Ruby プログラマ。松江 Ruby 会議が久しぶりのイベント参加。

### 原 悠 ([@yhara](https://x.com/yhara))

Shiika の作者。最近の興味はスキューブとヨーヨー。
