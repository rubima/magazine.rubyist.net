---
layout: post
title: Rails Girls Matsue 5th 開催レポート
short_title: Rails Girls Matsue 5th
tags: 0063
post_author: 槇原 育美, 石川 瑞希
created_on: 2023-12-16
---

## はじめに

この記事は、2023年11月11日（土）に松江オープンソースラボにて開催された[Rails Girls Matsue 5th](https://railsgirls.com/matsue-5th)の開催レポートです。  
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/whiteboard.jpg" width="300px" alt="歓迎メッセージが書かれたホワイトボード">

## Rails Girlsとは

Rails Girlsは、より多くの女性がプログラミングに親しみ、アイデアを形にできる技術を身に着けるきっかけ作りと手助けをするコミュニティです。2010年にフィンランドのヘルシンキにてリンダ・リウカス氏らによって設立されたコミュニティであり、今では世界各国で活動が行われています。  
そして、Rails Girls Matsueは、5年ぶりに松江にて開催いたしました。松江ではこれまでに４回開催されており、今回で5回目となります。

## Rails Girls Matsue 5th開催のきっかけ

松江市では、毎年Rubyの最大級のイベントRubyWorld Conferenceが2日間開催され、そのイベントの前日にはRuby biz Grand prixも開催されます。その3日間はRuby色に染まる松江。だったら、「Ruby Week」と題して、Rubyに関連するイベントを色々企画しようと島根県、松江市、Ruby Associationで決まりました。その中で、ぜひ「Rails Girlsを松江で復活させてほしい」と言うお声がかかり、11月11日（土）ポッキーの日に開催することになりました。

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/ruby-week.png" alt="Ruby Weekのロゴ" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/pocky-day.jpeg" alt="ポッキーやプリッツ" width="500px">

## Rails Girls Matsue 5th準備段階

このイベントのオーガナイザーは、地域イベントへの関心を持つ方々や、過去のRails Girls Matsueに参加して情熱を持って再開を願う方々で構成され、総勢5名が集結しました。  
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/organizers.jpeg" alt="オーガナイザーの5名" width="500px">

しかし、準備期間はたったの3か月弱。  
毎週定例MTGを開催し、ファーエンドテクノロジー株式会社様のMy Redmineを活用して毎週ごとのタスク管理を実施。日々オーガナイザーの皆で進捗確認をしながら準備を進めました。  
5名とも運営は初めてということもあり、不明点ばかり。前回のオーガナイザーへのヒアリングやRails Girls Japanの皆さまにご協力頂きながら準備をしました。  
参加者に寄り添ったイベントを開催したいと思い、ワークショップのガイドが正しいのか確認のため、事前に協力者を募り、本番さながらの確認作業も行いました。初心者の方がどの部分で立ち止まりやすいのか、分からなくなるのかを一つずつ確認をし、課題を整理！ご協力いただいた皆さま、誠にありがとうございました！

## Rails Girls Matsue 5th当日について

ついに本番！ITエンジニアとして第一線で活躍されている9名の心強いコーチにご協力いただきました。前日のRubyWorld ConferenceでRails Girls Matsue 5thのことを知って急遽コーチとしてご参加してくださった方や、Rails Girls Matsue 1stからコーチをしてくださっている心強い方々も...。  
大変豪華なコーチ陣にご協力頂きとても助かりました、ご協力いただきありがとうございました！

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/coaches.jpg" alt="Rails Girls Matsue 1stのTシャツを着たコーチたち" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/meeting.jpeg" alt="当日朝のミーティングの様子" width="500px">

今回の参加者の半数は高校生ということで島根の次世代を担う方々が参加してくださいました！参加者が集まった松江オープンソースラボは華やか！

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/registration.jpeg" alt="レジストレーションの様子" width="500px">

## 開会

まず初めにオーガナイザーの紹介、Rails Girlsについての説明、一日のスケジュール確認の紹介を行いました。

## アイスブレイク

次に、場の空気を和ませて参加者の緊張をほぐすことを目的としたアイスブレイクとして、トランプを使ってチーム対抗のゲームを行いました。
机の真ん中にトランプの山を置きスライドに映ったお題に沿って並べ替えるという協力が必要なゲームで、どのチームが最も早く並べ替えられるかを競います。  
１回戦目は何も知らされずにスライドのお題通りに並べます。

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/icebreak1.jpeg" alt="アイスブレイクの様子1" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/icebreak2.jpeg" alt="アイスブレイクの様子2" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/icebreak3.jpeg" alt="アイスブレイクの様子3" width="500px">

仕組みが分かった２回戦目はチームで戦略を練ります。１回戦目とは違うお題がスクリーンに映しだされると皆さんとっても真剣な目をしてトランプに向き合い、白熱した試合が繰り広げられました！  
そして、早く並び替えを完了したチームから順に景品をプレゼント！  
景品は『はじめてつくるWebアプリケーション 〜Ruby on Railsでプログラミングへの第一歩を踏み出そう』、『ユウと魔法のプログラミング・ノート』、『RubyとRailsの学習ガイド 2023』といった、RubyやRailsの勉強に役立つ素晴らしい本です。これらの本は、著者である江森真由美氏、鳥井雪氏、五十嵐邦明氏からご寄贈いただきました。心から感謝申し上げます！

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/icebreak-prize1.jpeg" alt="アイスブレイクの賞品を受け取った様子1" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/icebreak-prize2.jpeg" alt="アイスブレイクの賞品を受け取った様子2" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/icebreak-prize3.jpeg" alt="アイスブレイクの賞品を受け取った様子3" width="500px">

## ワークショップ

アイスブレイクで各チームの雰囲気が温まったところで本番であるワークショップをスタート。  
Rails Girlsでは初日のインストール・デイで環境構築、2日目にワークショップを行うのが一般的ですが、今回は1日で完結する形で行いました。Windows、Mac、Chromebookなどいろんな環境の方が参加されましたが、GitHub Codespacesというブラウザ上で動作する統合開発環境を利用したことで環境構築に時間を取られることなくワークショップに集中できました。  
ワークショップの冒頭はオーガナイザーがひと工程ずつ説明をしていきます。

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/workshop1.jpeg" alt="ワークショップの様子1" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/workshop2.jpeg" alt="ワークショップの様子2" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/workshop3.jpeg" alt="ワークショップの様子3" width="500px">

分からないところがあると隣のコーチがすぐさまサポート。今回ありがたいことにほぼ１対１でサポートできる手厚い体制となり、誰一人取り残されることなくサクサクとWebアプリケーションが作成されていました。  
参加者の皆さんも優秀で、想定以上の早さで進めることができました。  
途中、ポッキーの日にちなんで色んな味のポッキーを準備したので、お菓子休憩では味比べをしてもらいながら、みんなで和気あいあいとワークショップが進みました♡

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/sweets-drinks.jpg" alt="会場にあったお菓子・飲み物" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/sweets.jpg" alt="会場にあったお菓子" width="500px">

## スペシャルゲスト江森真由美氏によるLT

今年のRubyWorld Conference基調講演者、江森真由美氏が松江にお越しということで特別にLTを行ってくださることに！Rubyコミュニティの結束と、Rails Girlsが提供するIT初心者のためのキッカケについて語ってくださり、コミュニティの異色な活動も紹介してくださいました（今流行っているのはルービックキューブにけん玉・自作キーボードとのこと！）。 Rubyの魅力を新たな視点で感じさせられるLTをしていただき、初めてRubyのコミュニティを知る参加者の皆さんも興味津々で聞いていました。

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/emori-session1.jpeg" alt="江森さんの講演の様子" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/emori-session2.jpeg" alt="江森さんの講演の様子" width="500px">

## スポンサーLT

そしてスポンサーLTタイム。
株式会社ロッカ様からの動画LT、今年のRuby biz Grand prix大賞を受賞されたピクシブ株式会社様からの現地LT（法被を身にまとったLTでした！）、Rails Girls Matsue 5thのために松江に足を運んでくださったTokyoDev株式会社様からの現地LT、松江からのスポンサーとして株式会社パソナ様からの現地LTを拝見しました。

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/sponser-session1.jpeg" alt="株式会社ロッカ様の動画LT" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/sponser-session2.jpeg" alt="ピクシブ株式会社様のLT" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/sponser-session3.jpeg" alt="TokyoDev株式会社様のLT" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/sponser-session4.jpeg" alt="株式会社パソナ様のLT" width="500px">

そのほかにも、会場ではスポンサー様のノベルティグッズの配布も行いました。様々なノベルティグッズがあって参加者の皆さんにも喜んでいただけたようでした！

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/promotional-giveaway2.jpg" alt="各席にセッティングされたノベルティ" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/promotional-giveaway1.jpg" alt="ノベルティが並んでいる様子" width="500px">

多くの企業様からのご協力に心より感謝いたします。

## ワークショップ２

午後からは各チームそれぞれのペースで作業を進めていきます。基本自力でぐんぐん進めていって困ったらコーチに聞く形のチームや、コーチからの説明を聞いて確実に理解を進めながらやっていくチームなど様々でした。皆さん真剣に取り組んでくださり、思い思いに自分仕様にカスタマイズするところまであっという間に進みました！  
想像以上に早く進んだので、急遽みんなでどんなところを工夫したか共有する時間を設けました！コーチに教えてもらって学んだことを発表をする人や、フォントや色合いを自己流にカスタマイズした画面を見せてくれる人など様々で、「おぉ～」や「すごい！」「かわいい！」など色々な声が飛び交う良いシェアタイムとなりました。

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/workshop4.jpeg" alt="ワークショップの様子4" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/workshop5.jpeg" alt="ワークショップの様子5" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/workshop6.jpeg" alt="ワークショップの様子6" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/workshop7.jpeg" alt="ワークショップの様子7" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/share-time1.jpeg" alt="作ったものを共有する様子" width="500px">
<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/share-time2.jpeg" alt="作ったものを共有する様子" width="500px">

## アフターパーティ

アフターパーティでは、更にお菓子や飲み物を追加し、自由に話しながら親睦を深めてもらいました！参加者の皆さんも普段なかなか話す機会がないエンジニア（コーチ）の方々と話したり、楽しそうに過ごしてくださいました。

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/after-party.jpeg" alt="アフターパーティの様子" width="500px">

途中には、松江のRubyコミュニティ「Matsue.rb」の佐田さんよりコミュニティやイベントのご紹介があり、Rails Girlsをやってさらに深めたいという方がいらっしゃったらぜひこちらのコミュニティにご参加ください！とご案内してくださいました。

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/sada-session.jpeg" alt="佐田さんのLT" width="500px">

そして、オーガナイザーの一人である大皷さんは「参加者からオーガナイザー」になられ、その経緯や思いを語ってくれました。

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/taiko-session.jpeg" alt="大皷さんのLT" width="500px">

アフターパーティ中には「次Rails Girlsをやりたい」と言ってくれる方もいらっしゃいました。オーガナイザーの我々にとってもとても嬉しいお言葉でした！

参加者の方からのアンケートでは、すべての方から「満足した」とご回答いただき、「とても楽しかった」「コーチと１対１で丁寧に教えてもらえて良かった」などのうれしい感想をいただきました。
スポンサーの皆さま、コーチの皆さま、そして参加者の皆さんのおかげでRails Girlsを無事に開催することができました。重ね重ね御礼申し上げます！

<img src="{{base}}{{site.baseurl}}/images/0063-RailsGirlsMatsue5thReport/group-shot.jpeg" alt="集合写真" width="500px">

これを機にITやプログラミング、Ruby、Railsに興味を持ってもらえたらうれしいです！
また別の機会で皆さんにお会いできることを楽しみにしております！

## 著者について

### 槇原 育美

Ruby City MATSUEプロジェクトを担当する地方公務員。RubyやITについて日々勉強中。Rails Girls Matsue 5th オーガナイザー

### 石川 瑞希

ファーエンドテクノロジー株式会社の社員。最近はRubyでAtcoderのコンテストに参加してます。Rails Girls Matsue 5th オーガナイザー