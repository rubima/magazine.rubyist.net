---
layout: post
title: RegionalRubyKaigi レポート (60) 川崎 Ruby 会議 01
short_title: RegionalRubyKaigi レポート (60) 川崎 Ruby 会議 01
tags: 0055 KawasakiRubyKaigi01Report
---
{% include base.html %}


## RegionalRubyKaigi レポート 川崎 Ruby 会議 01

* 開催日時 -- 2016 年 8 月 20 日 (土) 13:00-17:00
* 開催場所 -- 川崎市教育文化会館 4F 第 1 ・ 2 ・ 3 学習室
* 主催 -- kawasaki.rb
* 参加者 -- およそ 70 名
* 公式サイト -- [http://regional.rubykaigi.org/kwsk01/](http://regional.rubykaigi.org/kwsk01/)
* 公式ハッシュタグ -- _#kwsk01_
* Togetter まとめ -- [http://togetter.com/li/1014759](http://togetter.com/li/1014759)


## はじめに

2016 年 8 月 20 日に川崎 Ruby 会議 01 を開催しましたので、その様子についてレポートします。

川崎 Ruby 会議 01 を主催する kawasaki.rb は、川崎で 2013 年から活動を続けている地域 Ruby コミュニティです。
毎月 1 回のペースで勉強会を開催しており、川崎 Ruby 会議 01 まで過去 38 回の勉強会を開催してきました。

川崎 Ruby 会議 01 のコンセプトは「kwsk (かわさき) バザー」です。
日頃の kawasaki.rb の多様な活動を参加者の皆様にご覧いただくことを目的に、
基調講演、kawasaki.rb のメンバによる発表、LT を行いました。

* [基調講演「Ruby で高速なプログラムを書く」 from 遠藤侑介](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l2)
* 発表
  * [「mruby を C# に組み込んでみる」 from 秋山 亮介](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l4)
  * [「Rubyist を誘う Scala の世界 ver 2.0」 from ぺら](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l5)
  * [「Ruby で Roomba をハックする」 from kon_yu](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l6)
  * [「Fat settings.yml と向き合う」 from 1syo](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l7)
  * [「この 1 年くらいの Ruby 力の伸長状況」 from 蓑島 慎一](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l8)
  * [「Rails エンジニアがサーバーレスアーキテクチャに手を出したよ」 from 清水 雄太](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l9)
* LT
  * [「Big Data Baseball with Python」 from shinyorke(シンヨーク)](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l11)
  * [「並行プログラミングと魔法の薬」 from 笹田耕一](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l12)
  * [「７カ国をさすらうグローバルなお仕事顛末記(仮題)」 from kishima](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l13)
  * [「浮動小数点数での分散の求め方」 from 村田賢太](http://magazine.rubyist.net/?0055-KawasakiRubyKaigi01Report#l14)


## 基調講演「Ruby で高速なプログラムを書く」 from 遠藤侑介
![keynote.jpg]({{site.baseurl}}/images/0055-KawasakiRubyKaigi01Report/keynote.jpg)

[GitHub](https://github.com/mame)
[Twitter](https://twitter.com/mametter)
[動画](https://www.youtube.com/watch?v=NHXaH3pkk-M&index=1&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K)
[スライド](http://www.slideshare.net/mametter/ruby-65182128)

まめさん (遠藤侑介さん) による基調講演は「Ruby で高速なプログラムを書く」でした。
内容はなんと Ruby でファミコンエミュレータを実装したというもの。
東京 Ruby 会議でも同様の発表がありましたが今回は完全版とのことです。

実装した理由の一つとして、
Ruby3 で 3 倍の実行速度を目指す Ruby3x3 というスローガンがありますが、
これに向けてベンチマークとなるようなプログラムを作ったとのことでした。

前半はファミコンのアーキテクチャとそれをどのように Ruby 上のプログラムに置き換えていったかというお話、
後半はそれらをどのように最適化していったかというお話が中心でした。

中でも最適化の四か条という話はチューニングするプログラマすべてが見て損はない内容だと思います。
詳しくは発表の動画を見ていただきたいと思いますが、項目だけ抜粋します。

1. 目標値を設定せよ
1. ボトルネックをいじれ
1. アルゴリズム最適化を考えよ
1. 効果を検証せよ


どれも、きちんと計画建てた上で実証的にチューニングを進めていくことが重要だという内容で、
大変参考になりました。

また、あえて Ruby でエミュレータを書いた理由として、
Ruby が遅くないというアピールや、
一つの言語にこだわって書くことのメリットをあげておられました。
まめさん曰く、多言語を勉強しなくてもよいというわけではないが、
広く浅くでは見えてこないものもあるとのこと。

確かに実際にエミュレータの高速化の事例を見せていただくと
言語を使い分けるより前に、
まずアルゴリズムの習熟やプロファイリングが重要だということがよくわかりました。

この基調講演を聞かせていただいて、
スタッフとして以前に一参加者としてすごくドキドキしたことを覚えています。
ディープな内容ながら初心者にも非常に参考になる内容で、
川崎 Ruby 会議のテーマにもぴったりの素晴らしい講演でした。

## 発表

普段から kawasaki.rb に参加しているメンバー 6 名が発表を行いました。

### 「mruby を C# に組み込んでみる」 from 秋山 亮介
![presentation1.jpg]({{site.baseurl}}/images/0055-KawasakiRubyKaigi01Report/presentation1.jpg)

[Twitter](https://twitter.com/kechako)
[動画](https://www.youtube.com/watch?v=GpEru8yI4cI&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K&index=2)
[スライド](http://www.slideshare.net/kechako/mruby-c)

秋山さんは kawasaki.rb の C# 要員と言える方です。
今回は mruby を C# に組み込む、という刺激的なタイトルで発表いただきました。

発表では、C# (.NET Framework) と組み込み用の Ruby である mruby の仕組み、C++/CLI で mruby のラッパを作れば C# に mruby を組み込むことができることに続き、秋山さんが開発された [csharp-mruby](https://github.com/kechako/csharp-mruby) の概要を説明いただきました。

発表での宣言どおり 9 月に開催した [kawasaki.rb #40](https://medium.com/kawasakirb/kawasaki-rb-040%E3%82%92%E9%96%8B%E5%82%AC%E3%81%97%E3%81%BE%E3%81%97%E3%81%9F-kwskrb-22f9086bb76#.7ya1l8384) で、C# と mruby で相互にメソッドの呼び出を行うデモを披露いただきました。

将来、秋山さんの csharp-mruby が完成すれば、C# から簡単に Ruby が使えるようになる日が来るのかも知れません。

### 「Rubyist を誘う Scala の世界 ver 2.0」 from ぺら
![presentation2.jpg]({{site.baseurl}}/images/0055-KawasakiRubyKaigi01Report/presentation2.jpg)

[Twitter](https://twitter.com/Peranikov)
[動画](https://www.youtube.com/watch?v=GQCiJ-LF0p0&index=3&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K)
[スライド](http://www.slideshare.net/yutomatsukubo/rubyistscala-20-65178203)

ぺらさんからはプログラミング言語「Scala」の紹介をしていただきました。

川崎 Ruby 会議 01 では、発表テーマを募集する際、
Rubyist に向けた内容であれば Ruby 言語にこだわらず自由にやろうと決めていました。
ぺらさんの発表も、テーマは Scala 言語ですが
Rubyist 向けに親しみやすく解説していただけました。

Ruby と異なり静的型付け言語の Scala ですが柔軟な型システムを持っており、
なるべく型を見せないような書き方ができることをアピールされていました。

また値はすべてオブジェクトであったり、豊富なリスト操作のメソッドを持ったりするなど、
Ruby との共通点を多く紹介していただきました。

特に驚いたのが、
Ruby のオープンクラスと似たようなことを Scala の機能で実装できるという内容でした。

Ruby を主に使っているプログラマからすると、
静的型付け言語というのはときに制約が多く不便ではないかという先入観があったりしますが、
発表を見て、少なくとも Scala はそれに当てはまらない非常に柔軟な言語であるという認識を強くしました。

### 「Ruby で Roomba をハックする」 from kon_yu
![presentation3.jpg]({{site.baseurl}}/images/0055-KawasakiRubyKaigi01Report/presentation3.jpg)

[Twitter](https://twitter.com/kon_yu)
[動画](https://www.youtube.com/watch?v=6-YBuQ8n1OE&index=4&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K)
[スライド](http://www.slideshare.net/kon_yu/rubyroomba)

kon_yu さんからは
Web カメラを搭載した Roomba を遠隔操作するシステムを完成させるまでの過程を発表いただきました。
家に居る 2 匹の愛猫の様子を仕事や旅行の間に確認したいという動機で、このシステムの開発を始められたそうです。

Roomba がシリアル通信で制御できることに注目し、Roomba に Web カメラと制御用の Raspberry PI を搭載。
自作の Ruby on Rails アプリケーションを通じて、
iPhone のブラウザから Roomba を遠隔操作するシステムを完成させておられました。

[Roomba を遠隔操作して家の猫を追いかけるデモ動画](https://www.youtube.com/watch?v=NQ9qcvOxfJk)が上映されると、
Roomba をいぶかしむ猫のかわいさも手伝って、会場が笑いに包まれていました。

### 「Fat settings.yml と向き合う」 from 1syo
![presentation4.jpg]({{site.baseurl}}/images/0055-KawasakiRubyKaigi01Report/presentation4.jpg)

[GitHub](https://github.com/1syo)
[動画](https://www.youtube.com/watch?v=FkEOuk0LJS4)
[スライド](https://speakerdeck.com/1syo/fat-settings-yml)

1syo さんからは Ruby on Rails における設定ファイル管理の課題について発表していただきました。
config/settings.yml の運用方法の一つとして、
ファイルの内容に API のキーなど機密情報が含まれるため、あえてコミットしないというやり方があるそうですが、
設定項目が増えてくると、項目の追加、変更漏れ、Rails.env の環境数の増加などの問題が出てきたとのことです。

1syo さんはこういった問題に対し、
設定ファイルを分割して管理しやすくしたり、
機密情報は環境変数から取りその他の設定はコミットしたりするなど、
一つ一つ対処法を提案されていました。

設定ファイルの運用法というのは地味ですが皆が悩むところです。
この問題についてかなり実践的な発表をしていただき、
特に Rails を運用しているエンジニアにとって大いに参考になったのではないかと思います。

### 「この 1 年くらいの Ruby 力の伸長状況」 from 蓑島 慎一
![presentation5.jpg]({{site.baseurl}}/images/0055-KawasakiRubyKaigi01Report/presentation5.jpg)

[Twitter](https://twitter.com/rojiuratech)
[動画](https://www.youtube.com/watch?v=gxLgNnWlMrI&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K&index=5)
[スライド](https://speakerdeck.com/rojiuratech/kawasaki-rubykaigi-slide)

蓑島さんは kawasaki.rb に積極的に参加いただいているメンバーです。
プログラミングに携わるエンジニアが 1 人しか居ない職場で日々奮闘されています。

ハッカソンで参加チームのほとんどが Ruby on Rails を使っていたことに刺激を受け、Ruby on Rails のブートキャンプに参加したこと。
Ruby on Rails を触って得た知見を、仕事で活用したエピソードなどを紹介いただきました。

プログラミング言語やフレームワークによらず、良い設計でシステムを作ることの大切さを、ご自身の経験から一人称で語っておられました。

Web 系の会社で Ruby を使った開発をするのとは異なる生々しい内容で、会場がわきました。kawasaki.rb の多様性を参加者の皆様にもご理解いただけたと思います。

### 「Rails エンジニアがサーバーレスアーキテクチャに手を出したよ」 from 清水 雄太
![presentation6.jpg]({{site.baseurl}}/images/0055-KawasakiRubyKaigi01Report/presentation6.jpg)

[Twitter](https://twitter.com/pachirel)
[動画](https://www.youtube.com/watch?v=6xurzhDR2Vs&index=6&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K)
[スライド](http://www.slideshare.net/YutaShimizu1/rails-ruby01)

清水さんからはサーバレス・アーキテクチャについて発表していただきました。
AWS Lambda を例に実際にどのような構成で動いているかの紹介や、
Lambda で社内の経費申請などのワークフローを処理する BOT を実装した話をしていただきました。
Slack のフック機能と、Amazon API Gateway を組み合わせて、
Slack 上に投げられた申請や承認を Lambda で処理できる仕組みを作ったそうです。

今話題のサーバーレス・アーキテクチャですが親しみやすい語り口で、
とてもわかりやすく解説していただけました。

発表を聞いて、清水さんの解説が分かりやすかったこともありますが、
思ったよりシンプルで扱いやすいアーキテクチャではないかと感じました。
今後小さな機能を実装する際に Lambda のようなサービスを利用する事例が増えていくのではないかと思います。

## LT (Lightning Talks)

事前募集で先着当選した 4 名の方が LT を行いました。
4 名のうち 2 名が Ruby コミッタという豪華な LT となりました。

### 「Big Data Baseball with Python」 from shinyorke(シンヨーク)

[Twitter](https://twitter.com/shinyorke)
[GitHub](https://github.com/Shinichi-Nakagawa)
[動画](https://www.youtube.com/watch?v=NoH-_dIJo2E&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K&index=7)
[スライド](http://www.slideshare.net/shinyorke/big-data-baseball-with-python-ichiro-suzuki-hacks-kwsk01)
[動画](https://www.youtube.com/watch?v=OcdxLTzOnA8&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K&index=8)

shinyoke さんは野球のビッグデータを主に Python を使用して分析されています。
kawasaki.rb でもその情熱的な分析結果を発表いただいてきました。

今回の LT では、MLB 一球速報のデータを Jupyter + matplotlib で可視化し、イチローが直球に強いという分析を紹介していました。
LT の完全版は、[Pycon JP 2016](https://pycon.jp/2016/ja/schedule/presentation/75/) で発表されました。

### 「並行プログラミングと魔法の薬」 from 笹田耕一

[GitHub](https://github.com/kishima)
[Twitter](https://twitter.com/kishima)
[動画](https://www.youtube.com/watch?v=OcdxLTzOnA8&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K&index=8)

Ruby コミッタの笹田さんの LT は並行プログラミングがテーマでした。

Ruby や他のプログラミング言語が取り入れている並行プログラミングの仕組みを比較し、
Elixir の並行プログラミングの仕組みが他の言語の良いとこどりであることを説明。
ご自身の翻訳された「プログラミング Elixir」を紹介いただきました。

コミッタさえ Ruby 以外の言語の話をするという点で、kawasaki.rb の文化を象徴する LT でした。

### 「７カ国をさすらうグローバルなお仕事顛末記(仮題)」 from kishima

[GitHub](https://github.com/kishima)
[Twitter](https://twitter.com/kishima)

kishima さんには、ご自身の海外の仕事の経験を紹介いただきました。
地域 Ruby 会議という性質上、テッキーな発表が多い中、働き方・考え方に踏み込んだ LT に会場も聞き入っていました。

### 「浮動小数点数での分散の求め方」 from 村田賢太

[GitHub](https://github.com/mrkn)
[Twitter](https://twitter.com/mrkn)
[動画](https://www.youtube.com/watch?v=GX3iSiDuFss&index=9&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K)
[スライド](https://speakerdeck.com/mrkn/how-to-calculate-a-variance-of-floating-point-numbers)

村田さんは Ruby コミッタとして BigDecimal の開発に携わっておられます。

LT の内容は、統計要約量を求めるメソッドを提供する enumerable-statistics.gem についてです。
この gem の分散を高速に計算する処理について、数学的な背景とアルゴリズムを説明いただきました。
最後は"enumerable-statistics.gem を作ったのでみなさん使って下さい!"と LT を締めくくりました。

## まとめ

Ruby を中心としつつも他の言語・数学・ハードウェア・働き方まで多岐にわたる、盛りだくさんな地域 Ruby 会議となりました。
kawasaki.rb の日頃の活動をご覧いただくという「kwsk バザー」のコンセプトを良い形で実現できたと思います。
川崎 Ruby 会議 01 をきっかけに、より多くの方に kawasaki.rb に足を運んでいただければ幸いです。

## 謝辞

川崎 Ruby 会議 01 のスポンサーとして素敵な T シャツを提供いただいた[株式会社 spice life](http://spicelife.jp/) 様、
そして川崎 Ruby 会議 01 の成功に向けてご助力いただいた皆様に、実行委員一同感謝いたします。

## 著者について

* 徳田農 (@snowcrush) -- プログラマ。Ruby 好きですがお仕事では Go 言語も書いていたり。
* 近藤悠太郎 -- 趣味で Ruby を書いています。kawasaki.rb には 2014 年から参加。



