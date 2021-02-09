---
layout: post
title: RegionalRubyKaigi レポート (77) 大阪Ruby会議02
short_title: 大阪Ruby会議02
post_author: 五島 僚太郎
tags: 0061 regionalRubyKaigi
created_on: 2020-02-02
---

{% include base.html %}

## RegionalRubyKaigi レポート (77) 大阪 Ruby 会議 02

### はじめに

* 日時：2019年9月15日（日）10:00〜17:00（懇親会: 18:00〜）
* 場所：大阪科学技術センター(8階大ホール)
* 主催：naniwa.rb(ナニワアールビー)
* 後援：Ruby関西(ルビーカンサイ)
* 写真：[大阪Ruby会議02写真一覧](https://photos.google.com/share/AF1QipNbb4h-ZltI557NQui7y3Ok4c69p4TgjfSQNgUEB3ZH-F-skPIoGt948S0kFDPiaw?key=RUFZdE8xUTFzX1lHdVc5VFREdkpLc1NKbXlIUkhn)
* Togetter： [https://togetter.com/li/1405373](https://togetter.com/li/1405373)
* 公式タグ・Twitter：[#osrk02](https://twitter.com/hashtag/osrk02)

 ![all.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/all.jpg)

## 大阪Ruby会議とは

2018年7月21日（土）に大阪Ruby会議01が初めて開催されました。<br>
以前までは関西Ruby会議という規模で開催していましたが、より地域に密接したRuby会議にしようというということになり、ローカルな大阪Ruby会議として開催されました。<br>
第2回となる今回も大阪市にある[科学技術センター](http://www.ostec.or.jp)で開催しました。<br>
総勢153名(運営スタッフ含む)の方にご参加いただきました。<br>

## TechTalks(午前の部)

### オープニング

![ogom.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/ogom.jpg)

* 発表者
  * 尾籠さん([@ogomr](https://twitter.com/ogomr))

今回のRuby会議のテーマとロゴについて発表してくださいました。<br>
->[スライド](https://speakerdeck.com/ogom/osaka-rubykaigi-02)

### [スポンサートーク]開発メンバーの課題の探し方: 株式会社エイチーム

![ateam.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/ateam.jpg)

* 発表者
  * Yamaguchi Kentaさん([@kytiken](https://twitter.com/kytiken))

大規模なPHP=>Rails移管プロジェクトに対して、MBTI(Myers-Briggs Type Indicator)という心理学的分類を活用し、メンバー間のクセや気をつけるポイントを意識。<br>
チーム内でフォローできる箇所を探せるようにした知見を共有していただきました。<br>
それぞれの連携や役割分担が難しいチーム開発だからこそ、個人の特性や心理的なタイプなどを予め知っておくことは大切かもしれません。<br>

### [テックトーク]Ruby Security The hard way

![shibata.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/shibata.jpg)

* 発表者
  * 柴田 博志さん([@hsbt](https://twitter.com/hsbt))

Rubyに脆弱性が見つかった時の対処方法について<br>
報告/発見した脆弱性をトリアージするフローや実際に報告された事例をもとに対応した例を共有していただきました<br>
検証にかかるコストと報告にかかるコストの非対称性、報告する側も意識しながらレポートを書かないといけないなとしみじみ思いました<br>

### [テックトーク]チャットボットのすすめ: 株式会社Ruby開発

  ![nishiyama.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/nishiyama.jpg)

* 発表者
  * 西山 和広さん([@znz](https://twitter.com/znz))

チャットボットは勉強にもなるし活用次第ではとても面白いものが作れる。<br>
実際に作成したボットやボットの種類を例にして知見を共有していただきました。<br>
セキュリティに関する話題にも言及していて、明日からでも使える知見<br>
チャットというUIが非エンジニアにとっても扱いやすいことから、自分もよく使うので勉強になりました。<br>
->[スライド](https://slide.rabbit-shocker.org/authors/znz/osakarubykaigi02-chatbot/)<br>

### [キーノート]プログラミングを一生の仕事にする〜顧問プログラマを8年続けてわかったこと〜

![nishimi.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/nishimi.jpg)

* 発表者
  * 西見 公宏さん([@mah\_lab](https://twitter.com/mah_lab))

ソフトウェア開発のカタチが変わりつつあるということがまとめられています。<br>
ライブ設計力とそれを支える自己研鑽。<br>
顧問プログラマがどんなお仕事か、どんな能力が必要とされるかを発表して頂きました。<br>
要件をヒアリングしたり、質問したり、何を実装するのにどれくらいかかったかを意識、振り返り、日常で使っている武器を磨き続けることが大切なんだなとわかりました。<br>
->[スライド](https://www.slideshare.net/rootmoon/20190915-ruby02-keynote)<br>

## ランチタイムLT

![lunch.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/lunch.jpg)

ランチタイムに飛び入りLTを行いました<br>
本当に突然はじまったので、写真だけのご紹介!!<br>

## TechTalks(午後の部)

### [スポンサートーク]アジャイルウェアとその現場について: 株式会社アジャイルウェア

![agileware.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/agileware.jpg)

* 発表者
  * 川端 光義さん
  * 福田 健人さん

会社の環境とこれから目指すところ、現状について発表して頂きました。<br>
会社の設備も様々、抱える課題も様々で、本当に働くって面白いなと思いました。<br>

### [スポンサートーク]エンジニア転職のノウハウ: エネチェンジ株式会社

  ![enechange.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/enechange.jpg)

* 発表者
  * 川西 智也さん([@cuzic](https://twitter.com/cuzic))

転職を考えているエンジニアのレベル別に、やってみて欲しいことをまとめてくださっています。<br>
また会社の選定についても発表していただきました。<br>
転職を考えていなくても次のスキルアップに参考になる知識が盛りだくさんでした。<br>
->[スライド](https://www.slideshare.net/cuzic/ss-172060603)<br>

### [テックトーク]子どものためのプログラミング道場 『CoderDojo』を支えるRailsアプリケーシ ョンの設計と実装

![yasukawa.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/yasukawa.jpg)

* 発表者
  * 安川　要平さん([@yasulab](https://twitter.com/yasulab))

CoderDojoの活動に対して、スクレイピング、podcastなど、裏で支えるRuby/Railsの活用方法についてまとめて頂きました。<br>
Rubyの裏方ぶりもすごいですが、CoderDojoの開催数の推移がすごい...<br>
->[スライド](https://speakerdeck.com/yasulab/case-study-of-how-coderdojo-japan-uses-ruby)<br>

### [テックトーク]Ruby/Rails Benchmarking and Profiling with TDD

![wakaba.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/wakaba.jpg)

* 発表者
  * Uemori Yasutomoさん([@wakaba260yen](https://twitter.com/wakaba260yen))

「推測するな、計測せよ」<br>
パフォーマンス改善の際に、意識する格言です<br>
Ruby/Railsアプリケーションのパフォーマンスに関するテストについて発表していただきました。<br>
パフォーマンスチューニングの際に、何度も計測する機構を最初に準備することが改めて大切だと気づきました。<br>
->[スライド](https://www.slideshare.net/ssuser21f9f1/rubyrails-benchmarking-and-profiling-with-tdd)<br>

### [テックトーク]Suppress warnings

![pocke.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/pocke.jpg)

* 発表者
  * Kuwabara Masatakaさん([@p\_ck\_](https://twitter.com/p_ck_))

Rubyが持つWarningの機構について解説<br>
その閾値を変更することで、よきせぬバグを防げることとOSSにコントリビュートする機会が増えるという発表をしてくださりました。<br>
warningはともすれば目を反らしがちですが、それに向き合うことで得られるリターンの大きさがわかる発表でした。<br>
log-level上げてみよう!ってなります<br>
->[スライド](https://speakerdeck.com/pocke/suppress-warning)<br>

### [スポンサートーク]Railsの起動速度を上げる裏方のgemについて: 株式会社インゲージ

  ![ingage.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/ingage.jpg)

* 発表者
  * 石田 游さん([@ishiyu](https://twitter.com/ishiyu))

Railsの起動速度を上げる裏方gem、spring, bootsnapについて。<br>
実際に速度改善がされているか、実測値の計測もされていて、どれくらい上記のgemが起動速度改善に影響しているか発表していただきました。<br>
Rails触りはじめに初心者を泣かせるカワイイgemの話で、何度もハマったなとしみじみ<br>

### [テックトーク]Concerns about Concerns

![willnet.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/willnet.jpg)

* 発表者
  * 前島 真一さん([@netwillnet](https://twitter.com/netwillnet))

Concernのおまじないについて解説、Concernを用いる時のアンチパターンについて発表してくださいました。<br>
アンチパターンに引っかかることをしたことがあるような...現在もその負債を返しています。<br>
増やさないためにチームで認識をすり合わせることも大切ですね。<br>
->[スライド](https://speakerdeck.com/willnet/concerns-about-concerns)<br>

### [テックトーク]Fat Modelに対処するための考え方と6つのリファクタリングパターン

![hotate.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/hotate.jpg)

* 発表者
  * 保立 馨さん([@purunkaoru](https://twitter.com/purunkaoru))

Fat Modelにしないために気をつけることと、チーム内での認識のすり合わせ、パターン化によるリファクタリングの実例について発表していただきました。<br>
リファクタリングのお話v2です。<br>
Concernの話で、「モデルにビジネスロジックを移す」からのキレイなパス回しになっています笑<br>
こちらもチーム内での認識合わせと、役割を意識したコード分割が大切としみじみ感じさせられます<br>
->[スライド](https://speakerdeck.com/hotatekaoru/fat-modelnidui-chu-suru-6tufalserihuakutaringupatan)<br>

### [テックトーク]What a cool Ruby-2.7

![joker.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/joker.jpg)

* 発表者
  * Hashidate Tomohiroさん([@joker1007](https://twitter.com/joker1007))

Ruby2.7で追加された新しい機能を駆使し、新しいスタイルのコーディングについて発表して頂きました。<br>
うー。や、やばい...<br>
->[スライド](https://speakerdeck.com/joker1007/what-a-cool-ruby-2-dot-7-is)<br>

### [テックトーク]いつでもどこでもクールなRubyを書く方法

![yebis.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/yebis.jpg)

* 発表者
  * Fukuda Kentoさん([@yebis0942](https://twitter.com/yebis0942))

Rubyが更新され便利な記法が登場しても、稼働するRubyのバージョンが合ってなければそれは使えません<br>
そこで新しい記法を利用して、旧記法にトランスパイルする方法/その課題を発表してくださいました。<br>
特別な事情で言語のバージョンを上げられないケースは少なからずありそうです...<br>
そんな時にこのようなツールがあると感激!<br>
baberuという命名も好きです<br>
->[リポジトリ](https://github.com/vzvu3k6k/baberu)<br>
->[スライド](https://vzvu3k6k.github.io/talk-write_cool_ruby_everywhere/)<br>

### [テックトーク]Ruby 3の型解析に向けた計画

![endo.jpg]({{base}}{{site.beseurl}}/images/0061-OsakaRubyKaigi02Report/endo.jpg)

* 発表者
  * Endoh Yusukeさん([@mametter](https://twitter.com/mametter))

Ruby3系に向けて、型解析機能の構想と進捗、便利さ、つらみについて発表してくださいました。<br>
特にコンテナ型。。。<br>
つらみをすごく感じた発表でしたが笑、3系がとても楽しみになります!<br>
ますますコミッターの方々に頭が上がらなくなりますm(_ _)m<br>

## ご協力頂いた企業様(五十音順)

[株式会社アジャイルウェア](https://agileware.jp/)　[株式会社インゲージ](https://ingage.co.jp/) [株式会社エイチーム](https://www.a-tm.co.jp/)　[エネチェンジ株式会社](https://enechange.jp/)　[株式会社Ruby開発](https://www.ruby-dev.jp/)

## 著者について

### 五島 僚太郎([@510\_five](https://twitter.com/510_five))

有限会社SCC大阪で社内のICT化促進やシステム運用を担当、受託開発も行ってます。<br>
