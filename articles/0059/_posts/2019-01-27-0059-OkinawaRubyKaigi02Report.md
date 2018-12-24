---
layout: post
title: RegionalRubyKaigi レポート (70) 沖縄　ruby 会議 02
short_title: RegionalRubyKaigi レポート (70) 沖縄 Ruby 会議 02
tags: 0059 OkinawaRubyKaigi02Report
post_author: kousy, 仲座 李香, 島袋 雄太
created_on: 2019-01-27
---
{% include base.html %}

# Regional RubyKaigi レポート 沖縄 Ruby 会議 02

### はじめに

* 日時：2018年3月10日（土）12:30〜18:00（懇親会: 18:30〜）
* 場所：琉球大学
* 主催：Okinawa.rb（おきなわるびー）
* 後援：一般社団法人 日本Rubyの会
* 動画(Youtube)：[https://www.youtube.com/playlist?list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA](https://www.youtube.com/playlist?list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)
* 写真：[沖縄Ruby会議02グループ写真](https://www.dropbox.com/sh/s2mw6gvsj052fta/AABDnWKwdsAtQiDX9g9315OUa)
* Togetterまとめ： [https://togetter.com/li/1207061](https://togetter.com/li/1207061)
* 公式タグ・Twitter：[#okrk02](https://twitter.com/hashtag/okrk02)


### Red Data Tools

![@kou's photo](https://dl.dropboxusercontent.com/s/d9rpl58ax2tyjbg/okrk02-4.jpg?dl=0)

* 発表者: [@kou](https://github.com/kou)

Red Data ToolsというRubyでデータ処理を行うというプロジェクトに関するお話をして頂きました。Rubyでのデータの扱い方について詳しくお話しされていました。

プロジェクトを進める上でのポリシーや具体的な開発例を紹介しておられ、一緒に開発してくれる仲間を募集中とのことでした。

[=> 動画でみる](https://www.youtube.com/watch?v=PI2M6qeHi_g&index=2&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


### RailsでOSSのWebアプリケーションを書くための 'ことはじめ'

![@kami-zh's photo](https://dl.dropboxusercontent.com/s/gauh9kcj7ubgcct/okrk02-22.jpg?dl=0)

* 発表者: [@kami-zh](https://github.com/kami-zh)

RailsでOSSのWebアプリケーションを書くためのことはじめというタイトルでお話を頂きました。
開発中のRepostという日報共有アプリの話に始まり、Stimulus.jsの特徴や具体的な使い方についてのお話を詳しく解説されていました。

フロントが得意でないサーバーサイドの方々も、Railsの話題の一部として取っつきやすかったでしょう。
OSSはプライベートな時間を割いていることが多く、作りたいものとやりたいことにフォーカスすることが大切であると教えていただきました。

[=> 動画でみる](https://www.youtube.com/watch?v=gwBRTx4OKEw&index=3&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


### TracePoint Tips Talk

![@_shimanman's photo](https://dl.dropboxusercontent.com/s/bermiy9i208czf3/okrk02-34.jpg?dl=0)

* 発表者: ([@_shimanman](https://twitter.com/_simanman))

Ruby2.0から実装された組み込みのクラスであるTracePointについてのTipsを熱く語って頂きました。様々なイベントをフックできる便利な機能がある一方で、知名度が低い為紹介しようと思ったとのことです。

例えばupcaseメソッドで小文字が返って来るバグが発生した時にTracePointを知っていると原因がわかるとのことで、サンプルコードを用いて紹介をしてくださいました。

[=> 動画でみる](https://www.youtube.com/watch?v=JSlaEVHUeLc&index=4&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


### A ripper based syntax highlighter

![@pocke's photo](https://dl.dropboxusercontent.com/s/463s0f4oucgv1ge/okrk02-46.jpg?dl=0)

* 発表者: [@pocke](https://github.com/pocke)

ご自身で開発中のRipperをベースにしたIroというSyntax Highlighterについてお話して下さいました。

VimのプラグインであるIro.vimはRubyで書かれているそうです。一見Vimの話のようで、Rubyでの正規表現についても分かりやすく解説されていました。

Highlighterが元になっていてVim以外のエディタでも使用できるように、Iro.vimからRubyのハイライトを行うコードを抜き出したものがIro gemだそうです。正規表現で書かれている既存のSyntax Highlighterでは、解決できない問題を解決できるとのことでした。

また、Iroで将来はSQLのコードのハイライトや他のエディタもサポートしてみたいとのことでした。

[=> 動画でみる](https://www.youtube.com/watch?v=cfq2n7E-VOQ&index=5&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


### CPU＋FPGAプラットフォームのためのRubyベースの開発環境

![@maruusa83's photo](https://dl.dropboxusercontent.com/s/wfdvmwf4b9e515e/okrk02-57.jpg?dl=0)

* 発表者: [@maruuusa83](https://github.com/maruuusa83)

マイコンと組み合わせてFPGAを導入し，Rubyでサクサク書きたいという想いからCPU＋FPGAプラットフォームのためのRubyベースの開発環境について語って頂きました。

また、Rubyの資産を使ってできることを面白いと感じており、Rubyに決めたというお話をして下さいました。未踏事業にも採択されている@Maruuusa83さんのハードウェアについてお話は、ソフトウェア寄りの話が多かった今回の沖縄Ruby会議02では印象的でした。

[=> 動画でみる](https://www.youtube.com/watch?v=OvKeniy4k08&index=6&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


### ActiveRecord::ConnectionAdapters の下の世界

![@koic's photo](https://dl.dropboxusercontent.com/s/l8zwoffkaz24de5/okrk02-62.jpg?dl=0)

* 発表者: [@koic](https://twitter.com/koic)

Ruby on Railsのコントリビューターである@koicさんよりActiveRecord::ConnectionAdaptersの下の世界というタイトルでRailsの中の話をお聞きすることが出来ました。

ActiveRecord::ConnectionAdaptersでモデル経由での呼び出しに対して、RDBMSごとに理にかなったSQLを組み立てることが必要であるとお話しして下さいました。

今回の沖縄Ruby会議の中でも特に技術レベルの非常に高いトークでした。

[=> 動画でみる](https://www.youtube.com/watch?v=GESDVnQvtzw&index=7&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


### はじめてのアジャイル開発×Railsで得たこと

![@puremoru0315's photo](https://dl.dropboxusercontent.com/s/93bdwtf6dq6luvy/okrk02-67.jpg?dl=0)

* 発表者: [@puremoru0315](https://twitter.com/puremoru0315)

enPiTという人材育成プログラムにて学生6人で10週間で開発した「アトオス」というサービスの開発の裏側を語って頂きました。

はじめてのアジャイル開発をRailsで行った際の苦労や工夫した点について、コードを見せつつ説明されていました。現在もサービスは継続中なので改善案を募集中とのことです。

[=> 動画でみる](https://www.youtube.com/watch?v=ZxunpQJYMxc&index=8&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


### Fast Code for Ruby

![@284km's photo](https://dl.dropboxusercontent.com/s/nunxq1mipbtzvxw/okrk02-72.jpg?dl=0)

* 発表者: [@284km](https://twitter.com/284km)

ベンチマーカーで測定し速度を確かめながらRubyで速いコードを書くというお話をして下さいました。速さの定義とその条件、またコードの読みやすさにも注意を払わなければいけないとのことでした。

最新のRubyを知っていると仕事が楽しくなるそうで、Rubyの実装を覗き、Fast CodeというRubyの楽しみ方を紹介していただきました。

[=> 動画でみる](https://www.youtube.com/watch?v=tyEpalAnoG0&index=9&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


### 文系から半年でRuby（Sinatra, Rails）を学んだら人生変わった

![@masayoshi-tokumoto's photo](https://dl.dropboxusercontent.com/s/girn7gt7wcuerf7/okrk02-96.jpg?dl=0)

* 発表者: [@masayoshi-tokumoto](https://twitter.com/Masah201707)

文系大学生が半年間Ruby(Sinatra, Rails)を学んだら人生が変わったというお話をして頂きました。

文系の人間から見たWebの印象、モチベーションの保ち方、チュートリアルの具体的な進め方に始まり、初学者がRubyを学び始めて就職するまでのプロセスをご自身の体験を元に話されていました。

特に初学者向けの学習方法を詳細に紹介しており学習中の疑問点や感情など、プログラミングに対しての苦手意識をなくすお話もして下さいました。

[=> 動画でみる](https://www.youtube.com/watch?v=Ihp8QhEa4Cw&index=10&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


### 大規模Railsアプリのマイクロサービス化・序章

![@yotaro-fujii's photo](https://dl.dropboxusercontent.com/s/gtdae0ui2uz7qu9/okrk02-102.jpg?dl=0)

* 発表者: [@yotaro-fujii](https://github.com/yotaro-fujii)

今回の沖縄Ruby会議スポンサーでもあるSansan社での大規模Railsアプリのマイクロサービス化についてお話を頂きました。

全ての機能がRailsで動いていると、エンジニア全員が全体を把握しないといけなかったりトラブルなどの問題の切り分けがあったりして難しいそうです。しかし、マイクロサービス化によってデリバリー速度やチームの生産性が向上した経験から新しい技術をトライしやすくなったとのことでした。

幅広い層に分かりやすいトークでした。

[=> 動画でみる](https://www.youtube.com/watch?v=HLtMIli0H2o&index=11&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


### Ruby をデータサイエンス分野に対応させる活動の現況

![@mrkn's photo](https://dl.dropboxusercontent.com/s/yfkrwny49vw05vw/okrk02-118.jpg?dl=0)

* 発表者: [@mrkn](https://twitter.com/mrkn)

ラストを飾ったのは@mrknさんによるPyCallのお話でした。

現状、Rubyはデータ可視化に弱いという問題提起に始まり、Rubyをデータサイエンス分野に対応させるべく開発予定のRed VisualizerやPythonからRubyをコールバックできるPycall.rbのお話でした。Pythonの資産であるPycallをRubyで活用し，深層学習の巨人の肩に乗ろうとデータサイエンス分野に対応させる活動をデモを通して紹介してくださいました。

また、各プロジェクトを横断するコミュニティの必要性の話もあり本会の締めに相応しいトークでした。

[=> 動画でみる](https://www.youtube.com/watch?v=uaNqGqEf1zc&index=12&list=PLNLYzHXJU2-84dl1iyRuGMJS9F2_7rArA)


## 謝辞

### ご協力いただいた企業様

[株式会社Speee](https://speee.jp/), [YassLab株式会社](https://yasslab.jp/ja), [株式会社ミノタケ](https://www.facebook.com/pages/category/Company/%E6%A0%AA%E5%BC%8F%E4%BC%9A%E7%A4%BE%E3%83%9F%E3%83%8E%E3%82%BF%E3%82%B1-161795527346669/), [Sansan株式会社](https://jp.corp-sansan.com/)

## 著者について

### 島袋 雄太 ([@shima_beee](https://twitter.com/shima_beee))

駆け出しエンジニア

### 仲座 李香 ([@The_Na_Ka](https://twitter.com/The_Na_Ka))

沖縄の女性エンジニアを増やして仲間を作りたい人

### kousy ([@kou_sy](https://twitter.com/kou_sy))

琉球大学理学部4年次のWebエンジニア
