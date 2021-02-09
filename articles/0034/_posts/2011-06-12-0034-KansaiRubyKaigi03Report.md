---
layout: post
title: RegionalRubyKaigi レポート (22) 関西 Ruby 会議 03
short_title: RegionalRubyKaigi レポート (22) 関西 Ruby 会議 03
created_on: 2011-06-12
tags: 0034 KansaiRubyKaigi03Report regionalRubyKaigi
---
{% include base.html %}


書いた人: Aki ([@spring_aki](http://twitter.com/spring_aki))、ひがきまさる ([@higaki](http://twitter.com/higaki))、今井伸広 ([@no6v](http://twitter.com/no6v))

## はじめに

今回で 3 回目となる関西 Ruby 会議。
今回は関西内外の交流をテーマに多くの Rubyist が集まりました。
![KanRK03.jpg]({{base}}{{site.baseurl}}/images/0034-KansaiRubyKaigi03Report/KanRK03.jpg)

## 開催概要
: ![ATC.jpg]({{base}}{{site.baseurl}}/images/0034-KansaiRubyKaigi03Report/ATC.jpg)

日時
: 2010 年 11 月 5 日 (金) 13:00 - 18:00
: 2010 年 11 月 6 日 (土) 10:00 - 18:00

会場
: 大阪南港 ATC ITM 棟 6F マーレギャラリー

開催母体
: [Ruby 関西](http://jp.rubyist.net/?RubyKansai)

後援
: [日本 Ruby の会](http://jp.rubyist.net/)

同時開催
: [関西オープンソース 2010](http://k-of.jp/2010/)

今回も関西オープンソース (以下 KOF) というイベントの会場をお借りしての開催となりました。

参加者は関西 Ruby 会議に限らず、KOF のセミナーやブース展示を自由に見てまわれます。
Ruby 関西もブース出展しました。

## 1 日目

平日の金曜日ということもあり、スーツ姿もちらほら見掛けました。

### rails の今昔

発表者
: よしだあつし さん

資料
: [http://www.slideshare.net/yalab/rails-5678745](http://www.slideshare.net/yalab/rails-5678745)

はじめに Rails の歴史を振り返り、Rails が Ruby コミュニティや他のフレームワークに与えた影響についてお話いただきました。
その後、Rails3 の特徴についてお話いただきました。

質疑応答では初心者向け情報・日本語の情報はないか? Rails2 から Rails3 への移行のポイント。業務アプリに不可欠な帳票出力の方法などの質問がありました。

### リアルビジネス Ruby

発表者
: cuzic さん

資料
: [http://www.slideshare.net/cuzic/ruby-5690082](http://www.slideshare.net/cuzic/ruby-5690082)

仕事の現場では MS Office を使った面倒な仕事が沢山あり、みんな不満を抱えながらも手作業を繰り返している現状があります。
その面倒な作業を Ruby で自動化した事例をデモを交えて多数紹介していただきました。

質疑応答では想定質問集が用意されていて、自作自演の Q&amp;A が行われました。会場からは、関西に Ruby の SI 案件は多いのか? 自動化で効率を上げると、その分だけ仕事が増えるのではないか? などの生々しい質問が相次ぎました。

## 2 日目

### ステージ企画

KOF には講師と司会者の掛け合いによるショートセッションが多数用意されています。
2 日目、朝 1 番のステージに日本 Ruby の会から高橋会長が登壇しました。

#### OSS ではじめる電子書籍入門

発表者
: 高橋征義さん ([株式会社達人出版会](http://tatsu-zine.com/)/日本 Ruby の会)

司会
: 法林浩之さん ([日本 UNIX ユーザ会](http://www.jus.or.jp/))

電子書籍の各種フォーマット、ビュアー、EPUB [^1] の作成方法などを紹介していただきました。
また達人出版会の電子書籍の紹介もしていただきました。
朝早いステージでしたが会場は超満員の大盛況でした。

### [招待講演] Rails 新時代に「Ramaze」で作る簡単 iPhone/iPad 向け Web サイト

発表者
: 福井修さん (日本 Ruby の会/[iRubySystems](http://irubysystems.com/index.html))

資料
: [http://www.slideshare.net/FUKUIOsamu/20101106-ramaze](http://www.slideshare.net/FUKUIOsamu/20101106-ramaze)

福井さんは Ruby 関西の創設メンバー。まずコミュニティ結成の経緯をお話いただきました。

つづいて Web アプリケーションフレームワーク Ramaze を紹介していただきました。Ramaze は他のフレームワークに比べてシンプルで軽量だそうです。

なお発表は全て iPad で行われました。

### [招待講演] メディアアートにおけるプログラミング言語 Ruby の役割

発表者
: 江渡浩一郎さん (メディア・アーティスト／[独立行政法人産業技術総合研究所 社会知能技術研究ラボ](http://http://www.sitr.jp/)研究員)

資料
: [http://www.slideshare.net/eto/ruby-6134530](http://www.slideshare.net/eto/ruby-6134530)

代表作「[インターネット物理モデル](http://eto.com/2001/PhysicalInternet/)」の製作時、会場開館を 1 ヶ月前になっても絶賛制作中という状況で Ruby を実践投入し、短く厳しい制作期間を見事乗り切ったというお話や、宇宙熊に演歌を歌わせるというユニークなゲーム「[くまうた](http://www.jp.playstation.com/scej/title/kumauta/)」を当初 Ruby で開発していた事などが語られました。ユニークなメディアアート作品を作る中で何故 Ruby を採用したのか。また、Ruby がメディアアートに対してどのような役割を担っているのか。という話をご紹介いただきました。

KOF 来場者も多いお昼の講演だったこともあり、会場は 20 人以上の立ち見が出ていました。

もちろん著書「[パターン、Wiki、XP](http://www.junkudo.co.jp/detail.jsp?ID=0001030340)」の宣伝も抜かりなく行われ、サイン会にもたくさんの方が列をなす盛況ぶりでした。

### Ruby 初級者向けレッスン 出張版

発表者
: 小波秀雄さん

Ruby 関西の名物企画、初級者向けレッスンの出張版。
会場に用意された PC を利用したハンズオンを入替制で 2 回行いました。

Ruby に興味はあるものの、京都で開催される勉強会に参加する程ではない……そういう人が多いのか、2 回とも定員オーバーの大盛況でした。

### [招待講演] Classbox 入門

発表者
: 前田修吾さん ([株式会社ネットワーク応用通信研究所](http://www.netlab.jp/))

資料
: [http://shugo.net/tmp/KOF2010.pdf](http://shugo.net/tmp/KOF2010.pdf)

既存のクラスの拡張方法として、サブクラス化・mix-in・特異メソッド・オープンクラスについて、それらの利用方法と問題点をあげ、selector namespace [^2] と Classbox [^3] による解決策を紹介した上で、新たに実装した Refinement という機能について説明していただきました。

### Lightning Talks

#### LibraHack 後のスクレイピングを考える

発表者
: ふるかわだいすけ さん

資料
: [http://blog.mogya.com/2010/11/librahack.html](http://blog.mogya.com/2010/11/librahack.html)

ふるかわさんは[モバイラースオアシス](http://oasis.mogya.com/)の開発でスクレイピングに関する豊富な経験をお持ちです。
[LibraHack 事件](http://librahack.jp/)を踏まえ、逮捕されないスクレイピングの仕方を指南していただきました。

#### はじめての数論 with Ruby (v.v.)

発表者
: しずと さん (Ryo Nagai)

資料
: [http://www.slideshare.net/shizuto/with-ruby-v-v](http://www.slideshare.net/shizuto/with-ruby-v-v)

数学に Ruby を使ってみようということで、[完全数](http://ja.wikipedia.org/wiki/%E5%AE%8C%E5%85%A8%E6%95%B0)の探し方を紹介していただきました。
1..100_000 までの間に完全数は 4 つしかありませんでした。

#### Minami.rb のあれこれ

発表者
: つじたさとみ さん

大阪ミナミを拠点に活動している [Minami.rb](http://qwik.jp/minamirb/) の紹介と、業務後ティータイム (隔週の水曜日に開催されるもくもく会) の紹介をしていただきました。

#### じょうるり陣旗揚げ

発表者
: 山本文子さん

資料
: [http://www.sitebridge.co.jp/_files/00000901/joruri-1106.pdf](http://www.sitebridge.co.jp/_files/00000901/joruri-1106.pdf)

オープンソース CMS [Joruri](http://joruri.org/) (Japan Originated Ruby-based RESTful and Integrated CMS) と、そのコミュニティ「[じょうるり陣](http://joruri-jin.jp/)」を紹介していただきました。
飛び入り参加で発表していただきました。

#### ruby 幾何入門

発表者
: kyara さん

資料
: [http://d.hatena.ne.jp/murase_syuka/20101107/1289136625](http://d.hatena.ne.jp/murase_syuka/20101107/1289136625)

ruby-processing を使って有名なキャラクターにネギを振らせるデモを披露していただきました。

#### 5 分で理解する Ruby のリフレクション

発表者
: 大林さん

資料
: [http://www.kmc.gr.jp/~ohai/KansaiRubyKaigi3.pdf](http://www.kmc.gr.jp/~ohai/KansaiRubyKaigi3.pdf)

リフレクションとは実行時にプログラム自体の情報を問い合わせるメタプログラミングのこと。
数ある技の中から Module#method_added と Module#define_method の組み合わせを紹介していただきました。

#### Lisp + Ruby = Nendo (gem が使える Lisp で悟り体験してみよう)

発表者
: Kiyoka Nishiyama さん

資料
: [http://www.slideshare.net/KiyokaNishiyama/nendo-at-kansai-ruby-kaigi03-5698365](http://www.slideshare.net/KiyokaNishiyama/nendo-at-kansai-ruby-kaigi03-5698365)

Ruby で実装された Lisp 処理系 [Nendo](http://oldtype.sumibi.org/show-page/Nendo) を紹介していただきました。
Lisp から gem ライブラリが利用できるそうです。
Nendo で実装された日本語 IME [Sekka](http://oldtype.sumibi.org/show-page/Sekka) (石火) も紹介していただきました。

#### 5 分で作る Rails3 アプリケーション

発表者
: アジャイルかわばた さん

資料
: [http://www.youtube.com/watch?v=Wb7OrbbEXZQ](http://www.youtube.com/watch?v=Wb7OrbbEXZQ)

ライブコーディングで Rails アプリケーションを作成。
アジャイルかわばたさんは 5 分間無言でコーディングに集中したので、よしだあつしさんが代わりに解説してくれました。
![RubyLive.jpg]({{base}}{{site.baseurl}}/images/0034-KansaiRubyKaigi03Report/RubyLive.jpg)

## ジュンク堂サイン会

Ruby 会議と言えばジュンク堂。
今年もジュンク堂書店 KOF 店が開店しました。

ジュンク堂書店 KOF 店では、KOF に参加した各コミュニティが推薦する書籍が販売され、著者によるトークショー &amp; サイン会は大勢の人で賑いました。

Ruby 関係では、以下の書籍のサイン会が行われました。

* 「[Ruby on Windows](http://www.junkudo.co.jp/detail.jsp?ID=0283992668)」cuzic 著
* 「[Ruby ゲームプログラミング](http://www.junkudo.co.jp/detail.jsp?ID=0110778207)」サイロス誠 著
* 「[パターン、Wiki、XP](http://www.junkudo.co.jp/detail.jsp?ID=0001030340)」江渡浩一郎 著
* 「[たのしい Ruby 第 3 版](http://www.junkudo.co.jp/detail.jsp?ID=0111389772)」高橋征義 著, 後藤裕蔵 著


江渡さんの「パターン、Wiki、XP」は、ジュンク堂書店 KOF 店の売上げランキング第 1 位に輝きました。

----

[^1]: アメリカの電子書籍標準化団体である国際電子出版フォーラム (IDPF) が策定し普及促進しているオープンな電子書籍フォーマットの規格の 1 つ。
[^2]: 特定のスコープ においてのみ既存のクラスのインスタンスの振舞いを変えることが出来る仕組み。
[^3]: 一種のパッケージ (ネームスペース) で、 import で取り込んだクラスに対して自分のパッケージ内だけで有効な修正 (refine) を行うことを許す というもの。
