---
layout: post
title: RegionalRubyKaigi レポート (87) TokyuRuby会議15 レポート
short_title: RegionalRubyKaigi レポート (87) TokyuRuby会議15 レポート
tags: 0065 tqrk regionalRubyKaigi
post_author: shokola
created_on: 2024-12-01
---
{% include base.html %}

## はじめに

TokyuRuby 会議 15 は、東京での RegionalRuby 会議として、2024 年 9 月 29 日に開催されました。
本記事はその様子をレポートしたものです。

## 開催概要
### 開催日

2024-9-29 (土) 13:30 - 19:30

### 開催場所

GMOインターネットグループ株式会社様

### 主催

Tokyu.rb

### 参加者

およそ 90 名

### 公式ページ

[TokyuRuby会議15](https://tokyurubykaigi.github.io/tokyu15/)

### 公式タグ・ Twitter

\#tqrk15
\#GMOインターネットグループ
\#GMOYours

## TokyuRuby 会議とは

TokyuRuby 会議は、Ruby に興味のあるエンジニアが集う Tokyu.rb が主催する LT 大会です。
第一回からの特徴として、

* 「お酒・食べ物の持ち寄り」
* 「その場で参加者から抽選で LT 発表者を選出する」
* 「基調講演は当日の投票で LT 王を選ぶ」
* 「基調講演は当日の投票で持ち寄られた食べ物から飯王を選ぶ」

などがあります。


## 開会式

続々とやってきた参加者と共に、各々が持参したご馳走達がテーブルに集結し、会場全体が賑やかになる中、実行委員長の kishima さんの挨拶が始まりました。

「TokyuRuby 会議は肉の日( 29日 )にやり続けて 15周年、そして 15 周年にして 15 回目！」との言葉を皮切りに、力強く開会が告げられました。

そこから会場を提供してくれた GMOインターネットグループ株式会社様、ミルクボーイ風の漫才で会場を沸かせた株式会社 mov 様、サービスでお世話になっている人も多い株式会社リブセンス 転職ドラフト様と豪華なスポンサートークが行われました。持参してくれたノベルティも可愛かったです！


<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/kishima.jpg" alt="kishimaさんによる挨拶" width="500px">


## LT 大会の様子


今回の TokyuRuby 会議 では、事前応募での LT 3 部構成に加え、抽選 LT、そして恒例の AcceptLT と盛り沢山な内容でありました。
全てレベルが高いものでしたが、その中で著者が個人的に印象に残ったものを紹介します。


### 最年少による親子 LT

父 ＆ 息子ペアで LT された ryopeko さん親子(以下、お子さんのことは 子peko さんと呼ばせていただきます)。
大勢の大人に見守られている中、 子peko さんは物怖じせずに堂々と自己紹介やコメントが出来ていました。
お子さんを地域 Ruby 会議やオフィス訪問に積極的に連れて行き、仕事場を見学させたりと働く姿を見せていて、 子peko さんはそんなお父さんを「かっこいい」と思っているんだそう。微笑ましいLTに拍手喝采でした。

その後 子peko さんは銅羅係として最後まで大活躍でした(スタッフ一同感謝しています)！！


### るびま 20 周年

この記事が掲載されている媒体「るびま」は今年 20 周年！！！！とのことで、筆頭メンバーとして活躍している neko314_ さんによる発表。

Twitter で募集した記念のおたよりを掲載した記事が近日公開されるお知らせと応募者への感謝の気持ちを伝えてくれました。
現在は公開済です。[【 20 周年記念企画】 Rubyist Magazine へのたより](https://magazine.rubyist.net/articles/0064/0064-20thComments.html))。また「るびまに必要なものは記事と仲間」としてメンバー募集中！皆さん記事を書きましょう！と呼びかけました。メンバーへのなり方は[こちら](https://github.com/rubima/magazine.rubyist.net/blob/master/CONTRIBUTING.md)。


### 山手線一周 LT

フィヨルドブートキャンプ生であった suzuka_hori さんが自作のアプリを使用しながら山手線、大江戸線を一周した話をしてくれました！

[山手線一周する用のアプリ](https://www.yamanotes.com/)というニッチな需要のアプリながら、LT を聞いていると皆が挑戦したくなってくる素敵な LT でした。

開催後、実行委員長もアプリを使って見事一周していました！


### 抽選 LT

抽選 LT で当たった takkanm さんにより、昨年好評だった [KeebKaigi](https://keebkaigi.org/2023/) の第 2 回目決定の発表がなされました。その後公開された 2024 年版のサイトは[こちら](https://keebkaigi.org/2024/)。参加ページへのリンクが「 Enter 」で表現されているのがコンセプトにあっていて良いですね。
また [Asakusa.rb のサイト](https://asakusarb.esa.io/)でお馴染みの浅草寺の写真はご自身が始発で朝 5 時に撮ったものであることなどが明かされました。



### 投票アプリ開発 LT

今回の投票アプリはフィヨルドブートキャンプ生である smallmonkey117 さんが作ってくれました！
 Figma で画像設計をして作成に臨んだが、当初はユーザーとしての使い勝手の視点がなかった反省や、Tokyu メンバーに先に触ってもらったところ、「(自分が)投票した一覧が見えた方が便利」というフィードバックをもらって取り入れた話などしてくれました。

<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/ryopeko.png" alt="ryopekoさん親子" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/takkanm.jpg" alt="発表するtakkanmさん" width="500px">



## 各王


### 飯王

arimo さんが単品・合算でも共に飯王に！

前回に続き連覇となりました🎉おめでとうございます！今回のチャーシューは以前友達とラーメンを作った時にチャーシュー担当になり作った物だという話を教えてくれました。

<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/arimo.jpg" alt="発表するarimoさん" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/meal.jpg" alt="飯王のご飯" width="300px">

### 酒王

珍しいヨーグルト日本酒を持ってきた元実行委員長の ginkouno さんが酒王に。 emorima さんと他のイベントで行った酒屋で出会ったお酒だそうです！
おめでとうございます！

<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/ginkouno.jpg" alt="発表するginkounoさん" width="500px">


### LT 王

「 LT の様子」でも紹介した suzuka_hori さんが選ばれました！

山手線一周する時の注意事項を伝えたり、一緒に連れ出してくれた夫の yuki82511988 さんも途中から一緒に登壇し、ご夫婦での登壇となりました。
おめでとうございます！

<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/suzuka_hori.jpg" alt="発表するsuzuka_horiさん" width="500px">


## 料理、酒の様子

今回も持ち込みでみなさんがおいしい食べ物、飲み物をデプロイしてくれました。いつもごちそうさまです！

いつも酒の肴として抜群の物を持ってきてくれる tagomoris さんのにんにく味玉・しょうが味ホタテ、パッケージから凝っていた rira100000000 さんの天むすおむすび、 kwappa さんの単発ビアバーでも出している美味しいやつ、鯵を捌くのが大変だったであろう anzu_mmm さんのアジの南蛮漬け、良い時間帯に挽きたて淹れたてのコーヒーと一緒に出してくれる u1tnk さんのチーズケーキ、良い生ハム、初めて食べたカレーパフに牛タンのローストビーフ、お洒落サラダにシャインマスカット、安定の銘柄のビール・日本酒に、柑橘系の IPA、初めて見た凝ったお酒やパケがオシャレな洋酒・・そして中国茶とどれも最高でした。

また前回持ち寄りが大変多かった「唐揚げ」を一人も持ってこないという事実が皆さんの学習能力の高さを示していました。


<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/table.jpg" alt="料理がたくさん並んだテーブル" width="300px">
<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/u1tnk.jpg" alt="コーヒーを淹れるu1tnkさん" width="300px">
<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/omusubi.jpg" alt="おむすび" width="300px">
<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/beer.jpg" alt="IPA" width="300px">
<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/kwappa.jpg" alt="盛り付けるkwappaさん" width="300px">
<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/dish.jpg" alt="盛り付けた皿" height="350px">


## 開発した投票アプリ

「LT 大会の様子」でも紹介しましたが今回は特にとても使い勝手の良い、デザインも可愛らしいアプリになったと思います。

投票と共に送った感想が一覧で見られる機能があり、そちらが特に好評でした。

<img src="{{base}}{{site.baseurl}}/images/0065-TokyuRubyKaigi15Report/app.png" alt="投票アプリ画面" width="900px">



## TokyuRuby 会議スタッフメンバー

今回は長年 Tokyu を支えてきたベテランメンバーが引越しや子育て都合などで不在となり、いつもよりフレッシュなメンバーでの体制となりました。

実行委員長: 影山勝彦

司会: 小川伸一郎

会計: u1tnk

るびま記事担当: shokola

アナウンス: 関学

ロゴデザイン: 多田亜希

投票アプリ開発: 奥谷梨沙

広報: 濵口昌武

今回 TokyuRuby 会議 15 では 影山( kishima ) さんが実行委員長を務めました。
次回の 16 の担当は立候補してくれた奥谷( smallmonkey117 ) さんの予定です :) ！！！


## まとめ

今回は GMOインターネットグループ さんで初めての開催でした。会場係として終日奮闘してくれた yancya さん、 kurotaky さん、 myumura3 さんありがとうございました！
前回よりも人数を増やしての開催でしたので賑やかな分、皆に行き渡るようにするために労力やコストをかけて食べ物・持ち物を大量に持ち寄ってくれた皆様に感謝です。また次回お会いしましょう！

## Tokyu.rb とは

Tokyu 沿線(沿線に全く関係が無い方も OK )の技術者がオフラインで集まって、お酒やご飯を楽しもう！という Rubyist の集団。
ご飯を楽しむのも良し、 Ruby 事情について熱く語るも良し、一緒に何かをするための Ruby 仲間を探すも良し。
お気軽に [Facebook](https://www.facebook.com/groups/928069233888488/) グループよりお越しください。

## 著者について

寺嶋 章子 ([@shokolateday](http://twitter.com/shokolateday))  TokyuRuby 会議 15 レポート係。プロダクトデザイナ。
