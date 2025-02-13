---
layout: post
title: RegionalRubyKaigi レポート (xx) 東京Ruby会議12
short_title: RegionalRubyKaigi レポート (xx) 東京Ruby会議12
post_author: 東京Ruby会議12 実行委員会
tags: regionalRubyKaigi
created_on: 2025-01-27
---

{% include base.html %}

## RegionalRubyKaigi レポート (xx) 東京Ruby会議12

(ここに『はじめに』が入る）

## キーノート

## John Hawthorn『Scaling Ruby @ GitHub』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


## Kohei Suzuki『Ruby と Rust と私』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


## セッション

### Keynote: 『Scaling Ruby @ GitHub』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。


(your name)

### 前田 修吾『Ruby製テキストエディタでの生活』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### ぺん！『全てが同期する! Railsとフロントエンドのシームレスな連携の再考』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### ryopeko『functionalなアプローチで動的要素を排除する』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### tokujiros『ゼロからの、2Dレトロゲームエンジンの作り方』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### yumu『Ruby×AWSで作る動画変換システム』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### moznion『simple組み合わせ村から大都会Railsにやってきた俺は』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### Hiromi Ogawa『Writing PDFs in Ruby DSL』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### buty4649『mrubyでワンバイナリーなテキストフィルタツールを作った』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### morihirok『混沌とした例外処理とエラー監視に秩序をもたらす』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)


### Kasumi Hanazuki『Ruby meets secure DNS and modern Internet protocols』

* 録画: https://example.com/

RubyKaigiのNOCチームを長く担当されている花月かすみさんによる、DNSの暗号化の自動構成を行うためのプロトコルの紹介と、その検証のためにQUICライブラリのラッパーを実装した、という話です。

Domain Name System(DNS)は最も身近にはドメイン名からIPアドレスを得るための方法として用いられていますが、実際にはドメイン名にあらゆるデータを紐付けられるキーバリューストア、階層型分散データベースとしてインターネットに欠かせない存在となっています。しかしDNSは一般に使われている方式(UDPポート53でクエリを行う、通称「Do53」)では暗号化されておらず、カンファレンスのネットワークを含む公衆WiFiでは盗聴に対して脆弱であるということが知られています。カンファレンスにおいてはWiFiどころかそのへんを転がしているケーブルに対してMan-in-the-Middle攻撃することも容易です。そこで現代ではDNS over TLS(DoT), DNS over HTTPS(DoH; この中にはHTTP/2を使うものとHTTP/3を使うものがある), DNS over QUIC(DoQ)といった、クライアントとリゾルバ(※)の間の通信を暗号化することで盗聴に対して保護する方式が提案されています。

(※: 正確にはRFC 9499 Section 6でいう"Recursive Resolver"のこと。「フルサービスリゾルバー」、「キャッシュDNSサーバー」と呼ばれることもある)

DNSの暗号化を行うにあたって、クライアントに対してこのサーバーはDNSクエリの暗号化に対応しています、という情報を伝えることで自動構成を行いたい、という要望があります。これを実現するためにAdaptive DNS Discovery(ADD)というワーキンググループがIETFで活動しており、標準として提案されたプロトコルとしてDiscovery of Designated Resolvers(DDR; RFC 9462)、DHCP and Router Advertisement Options for the Discovery of Network-designated Resolvers (DNR; RFC 9463)があります。前者はmacOSやiOS、後者は一部のWindowsで使われているそうです。RubyKaigi 2023以降ではDoT, DoH, DDRを提供しており、だいたい半分くらいのDNSクエリが暗号化されていたそうです。

DNSは動作するプロトコルの組み合わせが非常に多く、また「少し壊れててもそれっぽく動いちゃう」ので、検証プログラムを実装することにしたそうです。RubyでDNS over QUICを検証するにあたってRubyのQUIC実装がほとんどなかったことから、ngtcp2というCで書かれたQUIC実装にRubyバインディングを実装しました。この実装の工夫として、Ruby本体で進行中の並行処理の機能に影響されないようI/Oまですべてをngtcp2に任せるのではなくI/OはRubyで引き取るようにした、という点が挙げられていました。QUICは通常のTCPではカーネルが行う再送処理をアプリケーション側で巻き取ることで高速化を得ていますが、代わりにアプリケーションはその実装を頑張らなければいけないという性質があり、QUICの約束する効率化を実現するためには単にラッパーを書くだけでは足りず考えることが多い、ということを実感できました。

なかなかRubyの文脈でネットワークの裏側の話を聞くことがなかったのでとても新鮮でした。「動いて当たり前」と思われているネットワークの裏にこのような努力が埋まっているということを多くの人が感じていただければ、プロトコル実装仲間としてはとても嬉しいです。

(sylph01)


## 『Regional.rb and the Tokyo Metropolis』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)

## 会場や廊下のようす
