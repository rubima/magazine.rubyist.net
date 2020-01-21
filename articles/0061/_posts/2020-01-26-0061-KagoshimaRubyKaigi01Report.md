---
layout: post
title: RegionalRubyKaigiレポート 鹿児島Ruby会議01
short_title: 鹿児島Ruby会議01レポート
tags: 0061 regionalRubyKaigi
post_author: kurotaky
created_on: 2020-01-26
---
{% include base.html %}

## はじめに

2019年11月30日に[鹿児島Ruby会議01](https://k-ruby.github.io/kagoshima-rubykaigi01/)が開催されました。
鹿児島だけでなく、日本全国から多くのRubyistが集まりました。今回はその様子をレポートします。

### K-Rubyについて

鹿児島Rubyコミュニティ（K-Ruby: Kagoshima Ruby Community）
2011/05/26 鹿児島でRubyのコミュニティを立ち上げました。プログラミング好きの集まりです。

K-Rubyのホームページ: https://k-ruby.github.io/

## 開催概要

### テーマ

プログラミング言語Rubyを通して越境する

### 開催日

2019-11-30（土）13:00 - 18:45

### 会場

[mark MEIZAN](https://mark-meizan.io/about)

### 主催

K-Ruby

### 参加者

約80名

### 公式サイト

<https://k-ruby.github.io/kagoshima-rubykaigi01/>

### 公式タグ

[#k_ruby](https://twitter.com/hashtag/k_ruby/)

## セッションの内容について

シナプスの中野さんが書かれた[鹿児島Ruby会議01に参加してきました](https://tech.synapse.jp/entry/2019/12/25/113000)を見ると詳しく書かれていますが、今回のるびまのレポートでは写真多めに

## Opening

オープニングではK-Rubyの発起人である[tamochia](https://twitter.com/tamochia)より、K-Rubyのこれまでのあゆみについて発表がありました。

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/opening.jpg)

実はKagoshimaのKではなく、Karaimo(唐芋)のKだったという衝撃の発表からはじまりました。

## Ruby 3 の型解析に向けた計画（仮）[招待講演]

最初は招待講演で[mametter](https://twitter.com/mametter)さんのRuby 3 の型解析に向けた計画（仮）でした。
Ruby2.7で導入される新機能について、興味深いユースケースを交えて紹介していただきました。

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/mametter.jpg)

## bruby

[田中さん](https://www.facebook.com/takaaki.tanaka.54)のbrubyの発表です。
世の中の.shファイルを.rbファイルで置き換えるという実験的な試みに挑戦されていました。

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/tanaka.jpg)

## ruby-jp

[pocke]さんは[Ruby界隈の大統一Slackワークスペースがほしい](https://pocke.hatenablog.com/entry/2019/08/02/181140)のエントリを書かれた方で、ruby-jpの話をされていました。鹿児島のRubyコミュニティの `#k-ruby` チャンネルもあるので、みなさん是非参加してみてください！

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/pocke.jpg)

- ブログ: [鹿児島Ruby会議01に参加した](https://pocke.hatenablog.com/entry/2019/12/04/005440)
- 発表資料: https://speakerdeck.com/pocke/ruby-jp

## ruby-vipsを利用した画像処理Tips

[ミヤハラ](https://twitter.com/TakashiMiyahara)さんによる、画像処理ライブラリlibvipsのラッパーであるruby-vipsに関する発表でした。
後半では導入事例についても解説いただきました。質問に対する補足説明に関して以下のブログで書かれていたので、気になる方はぜひ読んでみて下さい。

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/miyahara.jpg)

- ブログ: [鹿児島Ruby会議01で発表しました](https://nyagato.hatenablog.jp/entry/2019/12/12/183000)
- 発表資料: https://speakerdeck.com/takashimiyahara/image-processing-tips-using-ruby-vips

## Haconiwaが越えたあの夏〜3年間を振り返る

[udzura](https://twitter.com/udzura)さんが開発しているOSSの[Haconiwa](https://github.com/haconiwa/haconiwa)の発表でした。
さすがに10分で3年間振り返るのは結構大変だったと思いますので、次回開催時はぜひ基調講演でお願いします！

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/udzura.jpg)

- 発表資料: https://speakerdeck.com/udzura/haconiwa-for-3-years

## RubyのOSSコードリーディング

[Osamtimizer](https://twitter.com/osamtimizer)さんの発表では、コードリーディングのやり方やOSSのコード読んでみて変わったことについての発表でした。
最近はGitHubでブラウザだけでもコードが読みやすくなっています。Rackのコードの話を読んだ実体験はこれからコードリーディングをしようとしている人の参考になると思いました！

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/osamtimizer.jpg)

- 発表資料: https://speakerdeck.com/osamtimizer/ruby-oss-code-reading

## 福岡の方から参りました Fukuoka.rb です

[Fukuoka.rb](http://fukuokarb.github.io/)から参加の[ODA](https://twitter.com/jimlock)さん。
Fukuoka.rbの歴史と変化についてされていました。今後OSSパッチ会などが福岡で開催されたら参加してみたいです！

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/jimlock.jpg)

- ブログ: [鹿児島 Ruby 会議 01 に行ってきた](https://jinroq.hatenablog.jp/entry/2019/12/01/183502)
- 発表資料: https://speakerdeck.com/oda/fu-gang-falsefang-karacan-rimasita-fukuoka-dot-rb-desu

## かごっま弁のDeep LearningをRubyできばっ

[tanaken0515](https://twitter.com/tanaken0515)さんの発表では鹿児島弁の機械学習をRubyでやりたいということで、DeepLearningの入門とRubyでどのように動かしていくか丁寧に解説していました。これからDeepLearningやってみようという方の参考になる発表でした。鹿児島弁は結構難しいので今後の展開に期待です！

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/tanaken.jpg)

- ブログ: [鹿児島Ruby会議01に参加しました](https://tech.pepabo.com/2019/12/13/kagoshima-rk01/)
- 発表資料: https://speakerdeck.com/tanaken0515/introduction-of-deep-learning-for-rubyist

## How to make a gem with Rust

[sinsoku_listy](https://twitter.com/sinsoku_listy)さんはRustでgemを作る方法について発表されていました。
サンプルは[sinsoku/wasabi](https://github.com/sinsoku/wasabi)や[sinsoku/rusty_rails](https://github.com/sinsoku/rusty_rails)で確認できます。Dockerで動かせるので便利ですね！

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/sinsoku.jpg)

- 発表資料: https://speakerdeck.com/sinsoku/how-to-make-a-gem-with-rust

## あまり知られていないRubyの便利機能

[znz](https://twitter.com/znz)さんはあまり知られていないRubyの便利機能について、ひとつひとつ解説されていました。
普段あまり使わないメソッドなどリファレンスマニュアルに間違いなどを見つけたら[rurema/doctree](https://github.com/rurema/doctree)にissueを立てたりPull requestを送りましょう！

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/znz.jpg)

- ブログ: [鹿児島Ruby会議01に参加して発表してきました](https://blog.n-z.jp/blog/2019-11-30-kagoshima-rubykaigi01.html)
- 発表資料: https://slide.rabbit-shocker.org/authors/znz/kagoshima-rubykaigi01/

## "regional” wasn’t going to mean “provincial”

[kakutani](https://twitter.com/kakutani)さんの発表では地域Ruby会議について「RubyKaigiでできないことをどんどんやってくれ！」という言葉に勇気をもらいました。2019年は地域Ruby会議の開催が多かった年のようです。10分の発表だと整理しきれないボリュームだと思うので、次回の招待講演などで是非よろしくお願いします！

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/kakutani.jpg)

- 発表資料: https://speakerdeck.com/kakutani/kagoshima-rubykaigi01

## Rubyで作るネット回線の自動速度測定ツール

[中野](https://twitter.com/ryonkn)さんのRubyで速度測定ツールを作った話では、ISPの現場で必要とされる通信速度を計測するツールを開発した話でした。
中野さんは鹿児島Ruby会議01の開催日が誕生日でした。おめでとうございます！

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/ryonkn.jpg)

- ブログ: [鹿児島Ruby会議01に参加してきました](https://tech.synapse.jp/entry/2019/12/25/113000)
- 発表資料: https://speakerdeck.com/ryonkn/automatic-network-bandwidth-measurement-tool-built-with-ruby

## Location-based API with Ruby

[ダビ](https://www.facebook.com/djGrill)さんと[ヨヨ](https://www.facebook.com/yoannes.geissler.3)さんは位置情報を用いたアプリケーションを作っていて、RailsからPostGISを利用する方法やマルチDBのお話をしてくれました。

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/daviyoyo.jpg)

## Rails Girlsのお話や、初めての方向けのコミュニティについてなどお話[招待講演]

最後は招待講演の[emorima](https://twitter.com/emorima)さんのRails Girlsなどのコミュニティの話でした。

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/emorima.jpg)

発表資料: https://www.slideshare.net/MayumiEmori/rails-girls-199846026

## closing

最後はみんなで集合写真を撮りました！

![]({{base}}{{site.baseurl}}/images/0061-KagoshimaRubyKaigi01Report/closing.jpg)

## 懇親会

懇親会では焼酎やさつま揚げなど鹿児島ならではの食事もありました。Fukuoka.rbの皆さまから日本酒の差し入れもいただきました。ありがとうございます！
コーヒーブレイクでは鹿児島の[010coffee](https://twitter.com/010coffee)さんのコーヒーが提供されていました。

## スポンサー

今回の開催にあたって、スポンサーになって下さった企業を以下に紹介します。
今回残ったスポンサー費用に関しては、鹿児島Ruby会議02の運営費用やRails Girls Kagoshima 1stの開催費用にて活用させていただきます。ありがとうございます。

### スポンサーリスト

* [GMOペパボ株式会社](https://pepabo.com/)
* [株式会社リリー](https://www.lilli.co.jp/corporate)
* [株式会社シナプス](https://corp.synapse.jp/)
* [株式会社ユニマル](http://unimal.jp/)
* [株式会社W・I・Z](http://www.wiz-net.jp/)
* [株式会社現場サポート](https://www.genbasupport.com/)

### ツール提供スポンサー

* [esa.io](https://esa.io/)

## 参加者のブログ

* http://serina-diary.jugem.jp/?eid=12

## おわりに

2020年の6月頃に[Rails Girls Kagoshima 1stも開催予定みたいで](https://twitter.com/railsgirls_kago/status/1219125183207723008)ますます盛り上がりをみせてきた鹿児島のRubyコミュニティ、これからも盛り上がっていくことを楽しみにしています！
