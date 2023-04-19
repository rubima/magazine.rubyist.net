---
layout: post
title: Rails Girls Tokyo 14th 開催レポート
short_title: Rails Girls Tokyo 14th 開催レポート
tags: 0062 RailsGirlsTokyo14thReport
post_author: emorima
created_on: 2023-04-01
---
{% include base.html %}

## はじめに

この記事は、2022年7月29日(金)、30日(土)に [株式会社iCARE](https://www.icare.jpn.com/)様にて開催されたRails Girls Tokyo 14thのレポートです。
記事の内容は、オーガナイザーの emorima が開催にあたり、考えたこと・感じたことを中心にまとめています。予めご承知おきください。

記事の写真は、スタッフの[anna](https://twitter.com/ae__B_)さん撮影によるものです。

<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/icare.jpg" width="700px">

## Rails Girls とは

[Rails Girls](https://railsgirls.com)は、より多くの女性がプログラミングに親しみ、アイデアを形にできる技術を身につける手助けをするコミュニティで、[ガイド](https://railsgirls.jp/)を使ってプログラミングを体験できるワークショップを開催しています。
日本では、2012年9月に[Tokyo](https://railsgirls.com/tokyo-2012-09-07.html)で初めて開催されました。

Rails Girlsのワークショップは、プログラミング未経験の方を対象に、環境構築〜Railsアプリの作成・公開までを行います。
参加者の中にはPCに慣れていない方もいるため、さまざまな躓きポイントをコーチがサポートするには、オフラインで開催するのが一番です。
そのため、2020年2月14日、15日に開催された[Tokyo 13th](https://railsgirls.com/tokyo-2020-02-15.html)以降、新型コロナ感染症の影響で、2022年6月24日、25日開催の[Kagoshima 1st](https://railsgirls.com/kagoshima-2022.html)まで、日本国内でRails Girlsワークショップは開催されていませんでした。

## Tokyo 14th 開催のきっかけとその時期の状況

Rails Girls Tokyo 14thは、[むろさん](https://twitter.com/murokaco)と[ogijunさん](https://twitter.com/ogijun)から、iCare様で開催をしたいというお話があり、開催が決まりました。

開催はきまったものの、開催予定とした2022年7月は、感染の規模がこれまで以上に拡がっており、
ニュースで伝える新規陽性者数は、日々過去最大数を記録していました。
オーガナイザーである自分が体調を崩して、開催できなくなってしまうのではないか、
開催した後に体調を崩した方が出たらどうするのか...
ニュースを見る度に、今ならまだ延期にできる...と迷う毎日でした。

今後感染状況が収束していくかもわからない状況で、「しょうがない」と諦めるのか...。

考えても答えがでない時の私の答えは、「まずやってみる」。

## 行った感染対策

事前の準備と当日の感染対策として、次のようなことを行いました。

### 事前の感染対策

事前にガールズとコーチに次の3点をイベントページ・お申し込みページ・リマインドメール・コーチの素振り時など、
必ず記載するようにしました。

* イベント参加時のマスク着用(必須)
* COVID-19ワクチンの2回目までの接種を完了(必須)
* 陽性の方、濃厚接触者にあたる方の入場禁止

また、当日の連絡先も一緒に記載していたため、急遽来られなくなった方との連絡も滞りなく行うことができました。

### 当日の感染対策　

#### 入室時

入室時の体温チェックと手の消毒の徹底をしました。
事前にiCare様に体温計・消毒液の確認をしたところ、会場にある設備を自由に使わせて頂きました。(ありがとうございます!!!)

#### ワークショップ時

各テーブルにも除菌シートを置いて頂き、いつでも気になる箇所を除菌シートで拭けるようにしました。

これまで、コーチが説明する時に、ホワイトボードを使用してもらっていましたが、感染対策で、全てスケッチブックに切り替えました。

#### ランチ時

お弁当の受け取り時に、美味しそうなお弁当の前でどれにするか迷うことで、人が密集してしまうため、
お弁当の写真を事前にSlackで流し、決まった方から一方通行でお弁当を受け取りに来てもらうようにしました。

マスクを外す飲食時が感染リスクが高まるため、黙食をお願いし、気を配っていたのですが、「何もない」と人はつい話してしまう...。
人間だもの。

「何か聞くものがあれば、話さないのでは!?」と思いつき、その場で急遽 ogijunさんにマイクを渡し、二人で「Rubyコミュニティに何をきっかけに入ったか」などの漫談(?)をすることにしました。

<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/mandan.jpg" width="700px">

#### アフターパーティ時

以前は、立食形式のパーティーを行っていましたが、今回は感染リスクを考慮して、席でコーチLTを見ていただくことにしました。

<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/afterparty.jpg" width="700px">

## ワークショップの様子

OSや経験で分けられたチームで、Webアプリケーションを作っていきます。
<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/workshop2.jpg" width="700px">

マスクをしながら、説明をしてくれるコーチは少し息苦しかったかもしれません...（ありがとうございます!）
<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/workshop1.jpg" width="700px">

おやつには、iCare様近くにある「ひいらぎ」のたいやきが出ました。
<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/taiyaki.jpg" width="700px">

感染対策を考えて、記念撮影の時もマスク着用でした。
<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/tokyo14th.jpg" width="700px">

感染対策で色々制限はありましたが、Rails Girls はやっぱり楽しいワークショップです。

## おわりに

Rails Girls Tokyo 14th 開催後、体調を崩れた方の報告もなく、無事に開催を終えることができました。

この状況下でも皆さんの協力があれば、開催できる!という自信になりました。

会場をお貸し頂いた iCare様、感染対策に配慮しながらもコーチやスタッフをしてくれた皆さん、そして参加しよう!と思ってくれたGirlsの皆さん、本当にありがとうございました!!!

マスクを外して、アフターパーティーも楽しめるRails Girls ワークショップが1日でも早く戻ってきますように!

## 書いた人

[@emorima](https://twitter.com/emorima) Rails Girls Japanメンバー、Asakusa.rbメンバー、酒とRubyを時々（福山）雅治。
