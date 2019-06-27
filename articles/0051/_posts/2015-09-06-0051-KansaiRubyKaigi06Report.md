---
layout: post
title: RegionalRubyKaigi レポート (54) 関西 Ruby 会議 06
short_title: RegionalRubyKaigi レポート (54) 関西 Ruby 会議 06
tags: 0051 KansaiRubyKaigi06Report regionalRubyKaigi
---
{% include base.html %}


書いた人：ogom

## 関西 Ruby 会議 06

### はじめに

2015 年 7 月 11 日に開催された関西 Ruby 会議 06 の当日の様子をレポートしたものです。

![P1030151](http://regional.rubykaigi.org/kansai06/assets/img/report/P1030151.JPG)

### 開催概要

開催日
:  2015 年 7 月 11 日 (土)

開催会場
:  エムオーテックス新大阪ビル エムオーテックスホール

参加者数
:  190 名

ハッシュタグ
:  #kanrk06

主催
:  Ruby 関西

テーマ
:  Enjoy Programming

公式サイト
:  [http://regional.rubykaigi.org/kansai06/](http://regional.rubykaigi.org/kansai06/)

まとめ
:  [スライドまとめ](http://matome.naver.jp/odai/2143661425669201301)

### オープニング

参加者が 230 名も登録されていましたが、手慣れたメンバーと当日スタッフの連携でスムーズに受付ができました。<br />
会場は大通りから少し中に入った所なので、当日スタッフが道案内をしてくれたのもよかったです。
![01-P1030040.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/01-P1030040.JPG)

スタッフは朝の 8 時 30 分には集合をしていましたが、参加者も 9 時頃には集まり始めていました。<br />
Doorkeeper で募集をしていたので、みなさん「アプリでチェックイン」の準備して並んでいます。
![02-P1030080.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/02-P1030080.JPG)

基調講演、講演、LT を含めると発表者は 17 名でした。その発表者の司会を務めた 3 名です。<br />
マイクランナーも傾斜のある階段を俊敏に駆け回っていました。
![03-P1030145.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/03-P1030145.JPG)

#### Ruby にみるプログラミングスタイルの進化

基調講演: まつもと ゆきひろ さん

タイトルはプログラミングスタイルの進化ですが、_まつもと ゆきひろさん_の進化も拝見することができました。

今では聞く事のない言葉もいくつか紹介されていました。<br />
当時はコンピュータが高価だったので、コンパイラの気持ちになってノートに書いて勉強した。(無いコン族)<br />
「私が言語を設計してはいかんのか？」となり、想像上の「ぼくの考えた最強の言語」が生まれる。(ペーパープロトタイピング)<br />
![04-P1030204.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/04-P1030204.JPG)

社内のアプリケーションを作成していたが、会社の方針転換で保守の要員となった。<br />
しかし、そこがプログラミング言語の _Ruby_ が生まれるきっかけになったそうです。
![05-P1030335.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/05-P1030335.JPG)

ウェブアプリケーションの全盛で _Ruby_ が広く使われ始めた。(作者としては不本意)<br />
DSL (抽象化を一段上げる) や、メタプロも活用の貢献も大きい。
![06-P1030387.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/06-P1030387.JPG)

プログラミングスタイルの進化にバージョン管理ツールの進化が影響をあたえた。<br />
(昔々はフロッピーディスクに _tar_ でファイルをまとめて世代管理をされていた逸話がありました。)

* RCS (ロック・アンド・モディファイ)…… 職場が荒れた。
* CVS (エディット・アンド・マージ)…… 職場に平和が戻る。
* svn (アトミック・コミット)…… ネットワークが必要。
* git (分散バージョン管理)…… ネットワークが不必要。


そして、_GitHub_ の登場でオープンソースがしてきた開発の手法を会社の社内の開発でもするようになった。
![07-P1030349.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/07-P1030349.JPG)

質問タイムでは、「島根は好きです！」と即答していました。(前日の前夜祭でなにかあったらしい？　)<br />
また、_まつもと ゆきひろ さん_は C 言語のプラグラマーなので、「Ruby 会議はアウェー感」の回答に会場が賑わいました。

![P1030476](http://regional.rubykaigi.org/kansai06/assets/img/report/P1030476.JPG)

### スポンサー LT

スポンサーの特別枠で 5 人の LT がありました。<br />
Ruby ビジネスフォーラムではスーツ率が高いそうです。
![08-P1030512.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/08-P1030512.JPG)

こちらは_関西 Ruby 会議 06_ の集合写真です。(圧倒的な私服率の高さでした。)

![m-P1030570.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/m-P1030570.JPG)
![m-P1030568.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/m-P1030568.JPG)
![m-P1030571.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/m-P1030571.JPG)

### Rails ガイドを支える技術

講演: @yasulab さん

Rails ガイドを継続的に更新していく技術をデモンストレーションを交えて紹介されていました。<br />
プロの翻訳者の八田さんがパワフルに翻訳を進めて行かれるそうです。
![09-P1030526.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/09-P1030526.JPG)

「Rails ガイド電子版を今日に出版するために、前夜祭の参加を諦めました。」<br />
「夜中の 3 時までコミットしていました。」…… 会場からの大きな拍手！　 ( 88888888 )
![10-P1030540.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/10-P1030540.JPG)

### 200 万 Web サイトを支える ロリポップ！　と mruby

講演: @harasou5 さん

_mruby_ と _mod_mruby_ で大量のアクセスに対応することができます。
![11-P1030563.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/11-P1030563.JPG)

_mod_mruby_ の紹介で、ヒゲの松本さんの紹介に会場は「？？？」の空気になりました。<br />
(スライドの_まつもと ゆきひろ さん_と_松本 亮介さん_にはどちらもヒゲがあります。)
![12-P1030564.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/12-P1030564.JPG)

### スモウルビー 1.0：小学 3 年生から始める Ruby プログラミング

講演: @takaokouji さん

スモウルビーは Scratch のように子供でも簡単にプログラミングを楽しめます。<br />
野球のリトルリーグのようなプログラミング少年団を目指して活動をされています。
![13-P1030579.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/13-P1030579.JPG)

スモウルビーで「ねずみとねこの追いかけっこゲーム」のライブコーディングがありました。<br />
限られた時間でゲームを作り、そのゲームもライブでクリアするパフォーマンスで盛り上がりました。
![14-P1030575.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/14-P1030575.JPG)

### RSpec、Minitest、使うならどっち？

講演: 伊藤 淳一 さん

Qiita で Ruby の部、Rails の部、RSpec の部は全て 1 位のストックを獲得されています。<br />
_xUnit 形式 vs Spec 形式_ や _RSpec vs Minitest_ をとても丁寧に解説されていました。
![15-P1030588.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/15-P1030588.JPG)

_伊藤 淳一 さん_は主観的に選ぶなら _RSpec_ だそうです。<br />
「_Minitest_ は DIYer 気質が強い方に好まれる。」という分析 (仮説)
![16-P1030593.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/16-P1030593.JPG)

### Rails パフォーマンス基本のキ

講演: @joker1007 さん

社内の Qiita では圧倒的な 1 位でストックを獲得されています。<br />
パフォーマンスが悪くなる要因を例を見ながらの解説でした。(特に _serialize_ は気を付けて使うべし！　)
![17-P1030615.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/17-P1030615.JPG)

検知と計測のためのツールの紹介の中には _@joker1007 さん_ が作った Activerecord::Cause という Gem もありました。<br />
「最も大事なことは、壊れた窓を放置しない」の言葉は身に突き刺さりました。
![18-P1030610.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/18-P1030610.JPG)

### API server/client development using JSON Schema

講演: @izumin5210 さん

「Kobe.rb と Asakusa.rb から来ました。」これが一番言いたかったようです。<br />
JSON Schema は YAML で記述できます。(JSON は _{}_ と _""_ の入力で shift キーが死ぬんじゃないか！？　)
![19-P1030617.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/19-P1030617.JPG)

「テスト支援ツールとしての _JSON Schema_ がイケてる使い方です。」<br />
_SOAP_ おじさんからの _まさかり_ がくるそうですが、きちんと議論をしたいそうです。
![20-P1030620.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/20-P1030620.JPG)

### LT 大会

#### サーバサイドなおじさんが SPA を趣味で初めて作ってみたときにわかった n のこと (仮)

LT: @muryoimpl さん

![P1030645](http://regional.rubykaigi.org/kansai06/assets/img/report/P1030645.JPG)

#### 受託開発と RubyGems

LT: @koic さん

![P1030663](http://regional.rubykaigi.org/kansai06/assets/img/report/P1030663.JPG)

#### 派遣エンジニアが業務に Ruby を取り入れるまで

LT: @hayabusa333 さん

![P1030679](http://regional.rubykaigi.org/kansai06/assets/img/report/P1030679.JPG)

#### インフラの人が Chef や Serverspec (ほか) が Ruby だったおかげですこしプログラムをするようになった

LT: @sawanoboly さん

![P1030710](http://regional.rubykaigi.org/kansai06/assets/img/report/P1030710.JPG)

#### ActiveAdmin Better Practices

LT: @ShinsukeKuroki さん

![P1030723](http://regional.rubykaigi.org/kansai06/assets/img/report/P1030723.JPG)

### キーワードパラメータを支える技術

基調講演: 笹田 耕一 さん

キーワードパラメータは _Ruby 2.2_ で速くなりました。<br />
(会場では使っている人は少なかったですが、速くなったのでどんどん使いましょう。)
![21-P1030792.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/21-P1030792.JPG)

シンボル GC の改善が _Ruby 2.2.2_ で対応してると思っていたら、その修正が入っていなかった。<br />
「Ruby _2.2.3_ ではなおっているかも？　」
![22-P1030794.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/22-P1030794.JPG)

_Ruby 2.2_ からの インクリメンタル GC で大幅に改善がされています。<br />
(グラフのピンと跳ね上がるポイントを押さえる事ができています。)
![23-P1030800.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/23-P1030800.JPG)

_笹田 耕一 さん_をイベントに招待すると _Ruby_ のクオリティーが上がるそうです。(スライドのネタ作りため！)<br />
それと、_笹田 耕一 さん_も C 言語のプラグラマーなので、Ruby 会議はアウェー感！？
![24-P1030847.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/24-P1030847.JPG)

参加者は朝からのたくさんの発表を真剣に聞き入っていました。<br />
また、質問タイムには積極的に手を挙げて会場を盛り上げて頂きました。
![25-P1030633.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/25-P1030633.JPG)

### クロージング

大勢の参加者や発表者、スタッフ・スポンサーのおかげで関西では最大級の _Ruby_ のイベントは大成功に終わりました。<br />
アフターパーティーも 70 名の参加者で賑わいました。(席に座らずあちこちで立ち話で盛り上がるほどでした。)

![m-P1030886.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/m-P1030886.JPG)
![m-P1030888.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/m-P1030888.JPG)
![m-P1030892.JPG]({{base}}{{site.baseurl}}/images/0051-KansaiRubyKaigi06Report/m-P1030892.JPG)

### ノベルティ

関西 Ruby 会議 06 のノベルティーです。T シャツとバック、ステッカーの 3 種です。<br />
(ステッカーは前夜祭と懇親会でのみ配られたレアアイテムです。)

![novelty](http://regional.rubykaigi.org/kansai06/assets/img/report/novelty.jpg)

### るびま 担当

レポート: 尾篭 盛 (ogom)

写真提供: 田又 利土 (rito)

![P1030582](http://regional.rubykaigi.org/kansai06/assets/img/report/P1030582.JPG)


