---
layout: post
title: RegionalRubyKaigi レポート (76) Tama Ruby会議01 レポート
short_title: RegionalRubyKaigi レポート (76) Tama Ruby会議01 レポート
tags: 0060  regionalRubyKaigi
post_author: neko314
created_on: 2019-08-18
---
{% include base.html %}

## はじめに

記念すべき第1回目のTama Ruby会議が2019年7月に開催されました。
本記事はその開催レポートです。

なお登壇者名の表記は公式サイトに則っています。

## 開催概要

### テーマ

Rubyistとしての成長

### 開催日

2019-07-06 (土) 13:00 - 18:20

### 会場

GMO Yours

### 主催

Tama.rb

### 参加者

およそ130名

### 公式サイト

<https://tama-rb.github.io/tamarubykaigi01/>

### 公式タグ

#tamarubykaigi01

[ツイートまとめ(Togetter)](https://togetter.com/t/tamarubykaigi01)

## 基調講演1

### Junichi Ito: なぜテストを書くの？（または書かないの？）

テストの役割や書く目的を整理し、その目的からどのようなテストを書くと良いのか、どういう場合にはテストを書かないのか、テストを書けるようになるためのTipsを講演くださいました。

#### スライド <https://speakerdeck.com/jnchito/number-tamarubykaigi01>

## 発表の様子

### konchan: プロになるためのレビューのススメ

「コードレビューを通して成長した」というご自身の経験から、レビュイー・レビュアーとなることが具体的にどのように成長につながるのか、注意点も交えて発表されました。

#### スライド <https://speakerdeck.com/konchan/tama-ruby-kaigi-01>

### fuqda: OSS初心者がつまづきながらOSSマナーを学んでいく話

「OSS活動は強い人だけがするものではない」「この発表をきいてやってみようという気持ちになってほしい」というメッセージのもと、ご自身のOSS活動の中での経験談やそこから得た学びについて発表されました。

#### スライド <https://speakerdeck.com/fuqda/osschu-xin-zhe-gatumadukinagaraossmanawoxue-ndeikuhua-4edf8e12-a019-4fa6-bc93-5be40a788e86>

### Shu OGAWARA: brainf*ck処理系で理解するパターンマッチングをつかった疎結合な実装

Ruby2.7の新機能であるPattern Matchingって密結合な実装につながるのでは？という疑問の検証のために既存コードの書き換えをしてみた結果やその経緯を発表されました。

#### スライド <https://speakerdeck.com/expajp/06-tamarubyhui-yi-01-brainf-star-ckchu-li-xi-teli-jie-suruhatanmatutinkuwotukatutashu-jie-he-nashi-zhuang>

### ken3ypa: こわくないDSL

DSL理解のために独自DSLの作成に挑戦し、どのようなステップでどのように実装したのか、そのときのポイントやわかったことなどをお話してくださいました。

#### スライド <https://speakerdeck.com/ken3ypa/tamarubykaigi01-kowakunaidsl>

### ほたて: ぼくらのリファクタリングは裏切らない💪

リードエンジニアとして新規から携わってきたサービスの各フェーズごとの開発の様子やリファクタリングを始めたこと、継続的にリファクタリングするようになり何が良かったか、どのように成長できたか発表くださいました。

#### スライド <https://speakerdeck.com/hotatekaoru/pu-rafalserihuakutaringuhali-qie-ranai>

### しおい: たのしいOSSコードリーディング: Let's read "cookies"🍪

CookieはRailsでどのように実装されているのか、ご自身が事前に理解されたことを解説として話しながら、疑似コードリーディングのスタイルで発表してくださいました。

#### スライド <https://speakerdeck.com/coe401_/tafalsesiiosskodorideingu-lets-read-cookies>

### s_naga03: コードを「見る！書く！見てもらう！」で爆速ステップアップ！(仮)

一人よりも周りの人の力を借りたほうが成長できるということを、実際のコードレビューでのやりとりや、コードレビューしたりしてもらったりするときのマインド、アウトプットの心がけなどを通してお話くださいました。

#### スライド <https://speakerdeck.com/nagata03/kodowojian-ru-shu-ku-jian-temorau-debao-su-sutetupuatupu>

### makicamel: Dartに浮気したらRubyは最高だと再認識した話

Rubyを参考にDartで日付処理をする[date_calc](https://github.com/makicamel/date_calc)というライブラリーを作ったこと、そこで感じたRubyの素晴らしさを語ってくださいました。

#### スライド <https://speakerdeck.com/makicamel/rediscovery-of-fun-ruby>

### alitaso345: WebAssemblyをRubyにコンパイルする黒魔術コード完全解説

現在開発に取り組んでおられるWebAssemblyをRubyで動かすための[wagyu](https://github.com/edvakf/wagyu)の一部について、どのようなアプローチをとり実装しているのか解説してくださいました。

#### スライド <https://speakerdeck.com/alice345/webassemblywo-rubynikonpairusuru-hei-mo-shu-kodowan-quan-jie-shuo>

### tsuka: RubyistのためのElixir入門(以前)

「Rubyの次にどの言語を学ぶか？」という問いへの答えの一つとしてElixirを取り上げてお話されました。
その理由はElixirは関数型言語ですが文法がRubyに近いためとおっしゃっていました。
他言語は他文化であり他言語を学ぶことはRubyを理解することにつながるということをRuby愛、Exilir愛を込めてお話くださいました。

また今年の[Elixir Fest 2019](https://elixir-fest.jp/)の講演、[Erlang/OTP と ejabberd を活用した Nintendo Switch(TM)向け プッシュ通知システム 「NPNS」の 開発事例](https://speakerdeck.com/elixirfest/otp-to-ejabberd-wohuo-yong-sita-nintendo-switch-tm-xiang-ke-hutusiyutong-zhi-sisutemu-npns-false-kai-fa-shi-li)についてもご紹介くださいました。

### katsumata_ryo: 成長を期待しない目的志向実践のススメ

「成長」それ自体を目的とするのではなく、やりたいことややらなければいけないことをやっていく”過程”や”間”が成長なのだと、ご自身の場合それがどんなことだったのかを通してお話くださいました。

#### スライド <https://speakerdeck.com/katsumataryo/cheng-chang-niqi-dai-sinai-mu-de-zhi-xiang-shi-jian-falsesusume>

### okuramasafumi: 東京地域Rubyコミュニティ大全

東京各所で開催されている地域rbの概要や特徴について、聞くだけで参加したくなるような、今までありそうでなかった発表をしてくださいました。

#### スライド<https://speakerdeck.com/okuramasafumi/in-complete-guide-for-local-ruby-communities-in-tokyo>

## 基調講演2

### Kuniaki Igarashi: 白魔術師への道

五十嵐さんご本人の成長として、講演決定時にはよく知らなかったという白魔術的な手法について、調べたり手を動かしたりしてみた様子、時間を要した点等を詳細にご紹介くださいました。

#### スライド <https://speakerdeck.com/igaiga/road-to-white-mages>

## 特別企画

### 内容

事前にTwitter上で世のRubyistたちがどんなふうに成長してきたのかアンケートが実施され、特別企画として集計結果の発表がありました。

#### スライド <https://speakerdeck.com/hayashiyoshino/how-to-be-a-better-rubyist>

## まとめ

定員130名に対して231名(参加130名+補欠者52名+キャンセル待ち49名)の申込みがあるなど、開催前から大盛況のイベントでした。
運営メンバーの万全な準備や関係する皆様あっての会だったのは言うまでもないでしょうが、私が個人的に聞いた感想では「発表を初めてきく登壇者が多くてよかった」という声があり、それだけでもまだ始まって1年強のTama.rbが主催する地域RubyKaigi開催の意義があったのではないかと感じました。

記事中、1つ1つの発表について概要に留めさせていただきましたが、どの発表も大変刺激的でした。感想を述べ始めるととてもまとまらないので、「とにかくアツかった」という一言に込めさせていただきます。

## Tama.rbについて

「吉祥寺から八王子周辺のRubyやRailsが大好きなプログラマーが集まる地域Rubyコミュニティ」と言いながら最近はもっぱら渋谷や恵比寿で実施されているRubyコミュニティ。運営メンバーがどんどん多摩からいなくなっているという噂もあるが、いつかやるかもしれないTamaRuby会議02は多摩地域でやるかもしれない。
