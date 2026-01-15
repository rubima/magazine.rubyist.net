---
layout: post
title: RegionalRubyKaigi レポート (92) TokyuRuby 会議 16 レポート
short_title: RegionalRubyKaigi レポート (92) TokyuRuby 会議 16 レポート
tags: 0066 tqrk regionalRubyKaigi
post_author: motohiromm
created_on: 2026-01-10
---
{% include base.html %}

## はじめに

TokyuRuby 会議 16 は、東京での Regional RubyKaigi として、2025 年 11 月 29 日に開催されました。 本記事はその様子をレポートしたものです。

## 開催概要
### 開催日

2025 年 11 月 29 日 (土曜日) 14:00 - 19:30

### 開催場所

GMOインターネットグループ株式会社様

### 主催

Tokyu.rb

### 参加者数

およそ 80 名

### 公式ページ

[TokyuRuby 会議 16](https://tokyurubykaigi.github.io/tokyu16/)

### 公式タグ ・ X　 (旧 Twitter ) 　

\#tqrk16
\#GMOインターネットグループ
\#GMOYours

## TokyuRuby 会議とは

TokyuRuby 会議は、Ruby に興味のあるエンジニアが集う Tokyu.rb が主催する LT 大会です。

第一回からの特徴として、

* 「食べ物・お酒を持ち寄る」
* 「その場で抽選を行い参加者から LT 発表者を選出する」
* 「基調講演は当日の投票で選ぶ」

などがあります。

## 開会式

各々が持ち寄った料理とお酒が並んで会場がすでに賑わう中、実行委員長の奥谷さんの挨拶で TokyuRuby 会議が開会しました。

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/explanation.jpg" alt="説明する奥谷さんと司会の小川さん" width="500px">


実行委員長挨拶のあと、スポンサーの皆さんによる趣向を凝らしたスポンサートークが行われました。

* 今年も素晴らしい会場を提供してくれた GMOインターネットグループ株式会社 様
* 昨年同様、ミルクボーイ風漫才で会場を大いに盛り上げていた 株式会社 mov 様
* 好きな古典の紹介からモノづくりの楽しさを語ってくれた ブルーモ証券株式会社 様
* 有志の皆さんが結集して熱いコミュニティ愛を見せてくれた Omotesando.rb 様
* 美味しいビールの提供とともに乾杯の音頭をとってくれた 株式会社リブセンス 転職ドラフト 様

乾杯の活気そのままに、ライトニングトークがスタートしました。

## LT 大会の様子

前回と同様、公募による LT 3 部構成をはじめ、抽選 LT、そして恒例の AcceptLT と終始会場は盛り上がっていました。
どの発表も個性豊かで見応えのあるものでしたが、その中で著者が個人的に印象に残ったものを紹介します。

### 自作ゲームに使える gem 作ってみた

新卒えんじにゃさんによる、ソシャゲガチャシステムの自作 gem の紹介でした。

ガチャの確率計算は、メモリ圧迫の懸念だけでなく課金対象ゆえに計算ミスが訴訟リスクに繋がりかねないとのことで、重み付け計算を利用した処理について解説しました。
自身の衝撃的な近況報告も相まって、その圧倒的なプレゼン能力に会場全体が引き込まれていました。

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/shinsotu_enginya.jpg" alt="発表する新卒えんじにゃさん" width="500px">

### あなたの知らない Date のひみつ

今年 2025 年は「昭和 100 年」ということで、Date クラスに隠されたマニアックなメソッドとその存在理由について語ったのは expajp さんです。

修正ユリウス日を表す Date.mjd、国ごとの改暦日の違いを反映する Date.england / Date.italy を紹介し、Date クラスに複雑なメソッドがある理由として「暦そのものが複雑」と述べました。
「暦は最悪のシステム」とあえて強い言葉で表現し、「仕様は宇宙、稼働数百年、ユーザー数億人、バグれば死人が出て、分割も不可能」とその絶望的な仕様を列挙していました。
馴染み深い Date クラスの深淵を覗き見れてとても興味深かったです！

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/expajp.jpg" alt="発表する expajp さん" width="500px">

### ぼっちが秘める可能性 〜孤高の Rubyist が語る交流会サバイバル術〜

5hun さんからは、ぼっちの交流会参加時の心得についての発表でした。

冒頭で提示した「解決策：何もしない」という正攻法から一転、「酒を飲んで色々な不安を無理やり吹き飛ばす！」という結論に、どっと笑いが起きていました。
食べて飲んで自分を満たしシンプルに考えるというぼっち交流の心得を、システム開発のシンプルさの重要性に結びつけ、make_ruby_friend メソッドのコード例を用いて解説しました。
make_ruby_friend メソッドの最終的な実装「drink して talk する」は、飲食を楽しみながら交流する TokyuRuby 会議のコンセプトと見事に合致していて、説得力抜群でした！

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/5hun.jpg" alt="発表する 5hun さん" width="500px">

### るびま王チャレンジ

るびまの筆頭メンバーである neko314 さんは「るびま王チャレンジ」と題して全 15 問のるびまクイズを出題しました。

「るびまは何の略？　 (答え：Rubyist Magazine )」の誰でもわかる問題から、「るびまのリポジトリ名は何？　 (答え：magazine.rubyist.net )」と意外と知られていない問題、「2025 年に初めてるびまにコントリビュートした人数は何人？　 (答え：neko314 さん調べで 16 人)」といったコアな問題まで多岐にわたっていて、全員参加してとても盛り上がりました！
最後に、みなさんもコントリビュートして一緒にるびまにコミュニティの歴史を残していきましょうと呼びかけました。

るびまのメンバーになりたい方は[こちら](https://github.com/rubima/magazine.rubyist.net/blob/master/CONTRIBUTING.md)。

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/neko314.jpg" alt="発表する neko314 さん" width="500px">

### 抽選 LT & accept LT

今回の抽選 LT は 2 人選ばれました。

1 人目の登壇者である T-takemi さんからは、業務での失敗談の発表でした。
「次の仕事どうしよう」と覚悟を決めたというエピソードでは、会場から思わず笑いが漏れる一幕もありました。
エンジニアなら誰もがヒヤリとする実体験をありのままに共有してくれたのが印象的でした。

2 人目の登壇者は、FjordBootCamp 受講生の samovar さん！
「私の好きなもの」というタイトルで大好きなブルパップ銃について発表しました。
「銃！？」と驚きと笑いが巻き起こり、まさに文字通りの「飛び道具」的な発表となりました。
今後は技術的な発表ができるように引き続き学習を頑張りたいと最後に述べると、会場全体から温かな応援の拍手が送られました。

当日の飛び入り参加枠である accept LT では 8 名の発表が行われ、個人開発や技術、キャリアに至るまで幅広いテーマで発表が繰り広げられました。
参加者それぞれのこだわりと熱量が伝わってくる、非常に活気ある時間となりました。

## 料理・お酒の様子

今回もみなさんの手によって美味しい料理とお酒がたくさん集まりました。
いつも温かな持ち寄りを本当にありがとうございます！

大人気ですぐに売り切れてしまった arimo さんのチキンはるまき、味がしみしみの kaiba さんの駆け出し静岡おでん、辛そうで辛くなかった tagomoris さんの辛くないチキンとエビ麻辣炒め、八角がスパイシーな sinsoku さん・ Judeee さんの魯肉飯風豚の角煮など、どれもこだわりの詰まった一品ばかりでした。さらに、rira100000000 さんの牛すじ煮や kwappa さんのあつあつおでんなど温かい美味しい料理も並びました。
飲み物も、安定した銘柄のビールや日本酒から、様々な果実酒、おしゃれなワインやジン、見たことのない珍しいお酒まで幅広く揃いました。
お酒が進むおつまみだけでなく、チーズケーキや生どら焼き、シュトーレン、ドーナツ、お団子といったデザート類も充実しており、飽きずにずっと楽しめるラインナップでした。

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/sponsor_beers.jpg" alt="スポンサーからのビール" width="400px">
<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/foods_drinks.jpg" alt="テーブルに並ぶ料理とお酒" width="250px">
<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/foods.jpg" alt="テーブルに並ぶ料理" width="400px">

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/shizuokaoden.jpg" alt="kaiba さんの静岡おでん" width="350px">
<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/gyusujini.jpg" alt="rira100000000 さんの牛すじ煮" width="350px">
<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/foods2.jpg" alt="tagomoris さんのチキンとエビ麻辣炒めと shimoju さんの酢鶏" width="350px">


## 各王について

今回も飯王・酒王・ LT 王が参加者の投票によって決定しました。
王に選ばれたみなさんには記念アクリルブロックが贈呈されました。

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/acrylic_block.jpeg" alt="贈呈されたアクリルブロック" width="250px">
<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/touhyou_kekka.jpg" alt="投票結果" width="500px">


### 飯王

昨年実行委員長を務めた kishima さんが単品・合算ともに飯王に選ばれました。　おめでとうございます！

これまでスタッフとして培ってきた飯王メソッドを活かして今回満を持して飯王へエントリーされたとのことでした。
ほろほろと柔らかいチキントマト煮、クセがなくお酒がすすむ鳥レバーペーストとクラッカー、美味しかったです！

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/meshio_foods.jpg" alt="kishima さんのごはん" width="450px">
<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/meshio_kishima.jpg" alt="飯王 kishima さんの発表" width="450px">
<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/meshio_method.jpg" alt="kishima さんの飯王メソッド" width="250px">

### 酒王

酒王は単品・合算ともに kwappa さんが選ばれました！

なまちゃんのラオホ (燻製ビール) は印象に残る味わいで話題になっていました。　おでんの出汁割りも好評でした。
おめでとうございます！

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/sakeo_drink.jpg" alt="なまちゃんのラオホ" width="350px">
<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/sakeo_kwappa.jpg" alt="酒王の kwappa さん" width="350px">

### LT 王

「 LT の様子」でも紹介した新卒えんじにゃさんが選ばれました！

過去のコミケでの挫折と努力の経験から「正しい方向性で努力すれば必ず人は成長できる」と熱く語ってくれました。
最後に「私はつよつよ Rubyist になります！」と力強い宣言もあり、その決意に会場全体から大きな拍手が送られていました。
おめでとうございます！

<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/LTO_shinsotu_enginya.jpg" alt="LT 王新卒えんじにゃさんの発表の表紙" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0066-TokyuRubyKaigi16Report/LTO_shinsotu_enginya2.jpg" alt="LT 王新卒えんじにゃさんの発表の結論" width="500px">


## TokyuRuby 会議スタッフメンバー

今回は奥谷さんが初めて実行委員長を務めました。

実行委員長・投票アプリ開発：奥谷梨沙

司会: 小川伸一郎

会計: u1tnk

アナウンス: 関学

LT 抽選: maimu

広報: 濵口昌武

クリエイティブ: garammasala29

グッズ制作: shokola

るびま担当: もとひろ

## まとめ

美味しいものを食べて飲んで最初から最後までわいわい盛り上がった今回の TokyuRuby 会議 16 も、 Ruby コミュニティの熱量と絆を再確認させてくれる最高の時間となりました。

また、今回も GMOインターネットグループ株式会社 様に会場をお借りしました。会場係として終日奔走してくれた yancya さん、ikaruga さん、ikechi さん、kenchan さんに、心から感謝いたします。ありがとうございました！

最後になりますが、素晴らしい発表をしてくれた登壇者のみなさん、盛り上げて支援してくれたスポンサーのみなさん、そして自慢の料理とお酒を持ち寄ってくださった参加者のみなさん、本当にありがとうございました！
また次回お会いしましょう！

## Tokyu.rb とは

Tokyu 沿線を軸に (沿線外の参加も大歓迎)、Rubyist を中心とした技術者がオフラインで集まるコミュニティです。
食事やお酒を楽しみつつ、Ruby の話題で盛り上がったり、新しい仲間との出会いを楽しんだりしています。
まずは [Facebook](https://www.facebook.com/groups/928069233888488/) グループからお気軽にご参加ください。

## 著者について

もとひろ みきこ ([@motohiromm](https://x.com/motohiromm))
TokyuRuby 会議 16 るびま担当。Rails エンジニア。FjordBootCamp 卒業生。
