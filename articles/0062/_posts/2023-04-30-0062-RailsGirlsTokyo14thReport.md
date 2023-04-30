---
layout: post
title: Rails Girls Tokyo 14th 開催レポート
short_title: Rails Girls Tokyo 14th 開催レポート
tags: 0062 RailsGirlsTokyo14thReport
post_author: emorima
created_on: 2023-04-30
---
{% include base.html %}

## はじめに

この記事は、2022 年 7 月 29 日 (金)、30 日 (土) に [株式会社 iCARE](https://www.icare.jpn.com/) 様にて開催された Rails Girls Tokyo 14th のレポートです。
記事の内容は、オーガナイザーの emorima が開催にあたり、考えたこと・感じたことを中心にまとめています。予めご承知おきください。

記事の写真は、スタッフの [anna](https://twitter.com/ae__B_) さん撮影によるものです。

<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/icare.jpg" width="700px">

## Rails Girls とは

[Rails Girls](https://railsgirls.com) は、より多くの女性がプログラミングに親しみ、アイデアを形にできる技術を身につける手助けをするコミュニティで、[ガイド](https://railsgirls.jp/)を使ってプログラミングを体験できるワークショップを開催しています。
日本では、2012 年 9 月に [Tokyo](https://railsgirls.com/tokyo-2012-09-07.html) で初めて開催されました。

Rails Girls のワークショップは、プログラミング未経験の方を対象に、環境構築〜Rails アプリの作成・公開までを行います。
参加者の中には PC に慣れていない方もいるため、さまざまな躓きポイントをコーチがサポートするには、オフラインで開催するのが一番です。
そのため、2020 年 2 月 14 日、15 日に開催された [Tokyo 13th](https://railsgirls.com/tokyo-2020-02-15.html) 以降、新型コロナ感染症の影響で、2022 年 6 月 24 日、25 日開催の [Kagoshima 1st](https://railsgirls.com/kagoshima-2022.html) まで、日本国内で Rails Girls ワークショップは開催されていませんでした。

## Tokyo 14th 開催のきっかけとその時期の状況

Rails Girls Tokyo 14th は、[むろさん](https://twitter.com/murokaco)と [ogijun さん](https://twitter.com/ogijun)から、iCARE 様で開催をしたいというお話があり、開催が決まりました。

開催はきまったものの、開催予定とした 2022 年 7 月は、感染の規模がこれまで以上に拡がっており、
ニュースで伝える新規陽性者数は、日々過去最大数を記録していました。
オーガナイザーである自分が体調を崩して、開催できなくなってしまうのではないか、
開催した後に体調を崩した方が出たらどうするのか……、
ニュースを見る度に、今ならまだ延期にできる……と迷う毎日でした。

今後感染状況が収束していくかもわからない状況で、「しょうがない」と諦めるのか……。

考えても答えがでない時の私の答えは、「まずやってみる」。

## 行った感染対策

事前の準備と当日の感染対策として、次のようなことを行いました。

### 事前の感染対策

事前にガールズとコーチに次の 3 点をイベントページ・お申し込みページ・リマインドメール・コーチの素振り時など、
必ず記載するようにしました。

* イベント参加時のマスク着用 (必須)
* COVID-19 ワクチンの 2 回目までの接種を完了 (必須)
* 陽性の方、濃厚接触者にあたる方の入場禁止

また、当日の連絡先も一緒に記載していたため、急遽来られなくなった方との連絡も滞りなく行うことができました。

### 当日の感染対策　

#### 入室時

入室時の体温チェックと手の消毒の徹底をしました。
事前に iCARE 様に体温計・消毒液の確認をしたところ、会場にある設備を自由に使わせて頂きました。(ありがとうございます!!!)

#### ワークショップ時

各テーブルにも除菌シートを置いて頂き、いつでも気になる箇所を除菌シートで拭けるようにしました。

これまで、コーチが説明する時に、ホワイトボードを使用してもらっていましたが、感染対策で、全てスケッチブックに切り替えました。

#### ランチ時

お弁当の受け取り時に、美味しそうなお弁当の前でどれにするか迷うことで、人が密集してしまうため、
お弁当の写真を事前に Slack で流し、決まった方から一方通行でお弁当を受け取りに来てもらうようにしました。

マスクを外す飲食時が感染リスクが高まるため、黙食をお願いし、気を配っていたのですが、「何もない」と人はつい話してしまう...。
人間だもの。

「何か聞くものがあれば、話さないのでは!?」と思いつき、その場で急遽 ogijun さんにマイクを渡し、二人で「Ruby コミュニティに何をきっかけに入ったか」などの漫談 (?) をすることにしました。

<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/mandan.jpg" width="700px">

#### アフターパーティ時

以前は、立食形式のパーティーを行っていましたが、今回は感染リスクを考慮して、席でコーチ LT を見ていただくことにしました。

<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/afterparty.jpg" width="700px">

## ワークショップの様子

OS や経験で分けられたチームで、Web アプリケーションを作っていきます。
<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/workshop2.jpg" width="700px">

マスクをしながら、説明をしてくれるコーチは少し息苦しかったかもしれません……(ありがとうございます!)
<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/workshop1.jpg" width="700px">

おやつには、iCARE 様近くにある「ひいらぎ」のたいやきが出ました。
<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/taiyaki.jpg" width="700px">

感染対策を考えて、記念撮影の時もマスク着用でした。
<img src="{{base}}{{site.baseurl}}/images/0062-RailsGirlsTokyo14thReport/tokyo14th.jpg" width="700px">

感染対策で色々制限はありましたが、Rails Girls はやっぱり楽しいワークショップです。

## おわりに

Rails Girls Tokyo 14th 開催後、体調を崩れた方の報告もなく、無事に開催を終えることができました。

この状況下でも皆さんの協力があれば、開催できる!という自信になりました。

会場をお貸し頂いた iCARE 様、感染対策に配慮しながらもコーチやスタッフをしてくれた皆さん、そして参加しよう!と思ってくれた Girls の皆さん、本当にありがとうございました!!!

マスクを外して、アフターパーティーも楽しめる Rails Girls ワークショップが 1 日でも早く戻ってきますように!

## 書いた人

[@emorima](https://twitter.com/emorima) Rails Girls Japan メンバー、Asakusa.rb メンバー、酒と Ruby を時々 (福山) 雅治。

『[はじめてつくる Web アプリケーション 〜Ruby on Rails でプログラミングへの第一歩を踏み出そう](https://gihyo.jp/book/2023/978-4-297-13468-6)』(技術評論社、2023 年 5 月 3 日発行) 著者。次号にて紹介記事を掲載予定!!!
