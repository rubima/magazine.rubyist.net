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

- RubyKaigiのNOCチームを長く担当されている方
- セッションの内容
  - Rubyとの生活という意味ではRubyKaigiが近づくと本番のネットワーク機材と同じセットアップで生活するらしい
  - DNS
    - ドメイン名にあらゆるデータを紐付けられるキーバリューストア、階層型分散データベース
    - 今回はクライアントとリゾルバの間の通信をセキュアにする話
    - 何で？
      - Do53は平文。80年代に生まれてからずっと変わってない
      - 公衆WiFiは盗聴が可能ということが知られている
        - WPA2 Personalは事前共有鍵(PSK)が公知なら盗聴に対して脆弱
        - 転がしてあるケーブルはだれてもMITMできる
        - でその上で平文DNSが流れている！
    - 平文DNSを暗号化する取り組み
      - DoT
      - DoH
        - `GET /dns-query?dns={base64(query)}`
        - H2あるいはH3、TLSで暗号化
      - DoQ
        - QUICのストリーム
        - DoH/3に比べてH3がないぶんマシ
    - クライアントの自動構成をしたい
      - 従来のDHCPやIPv6 RA(RDNSS)はリゾルバのIPアドレスのみ伝えるのでリゾルバがどんな暗号化に対応しているかを伝えない
      - 日和見暗号化
      - Adaptive DNS Discovery
        - DDR (RFC 9462): リゾルバとクライアントの間で暗号化プロトコルをネゴシエーション
          - `resolver.arpa.` という特殊用途ドメイン名で自身の対応プロトコルを公開する
            - `arpa.` の権威サーバーが返すわけではなく、リゾルバーがこれのqueryに答える
          - macOS, iOS
          - `resolver.arpa.` のSVCB(Service Binding)レコードを書く
          - RubyKaigi 2023（以降）ではDoT, DoH, DDRを提供
          - だいたい半分くらいのDNSクエリが暗号化できた
        - DNR (RFC 9463)
          - Windows Insider
    - 検証プログラムがほしい
      - 野生のDNSのプロにミスを指摘された
      - DNSは壊れててもそれっぽく動いちゃう
      - プロトコルの組み合わせが多く検証が難しい
      - Ruby界に足りてないのがQUIC
        - ngtcp2（Cで書かれたQUIC実装）のRubyバインディングを書いた
        - できるだけ薄いラッパー
          - IOは呼び出し側で管理。並行プログラムのプリミティブに影響されたくない
        - 一方メモリ安全性はほしい
        - 通常のTCPクライアントは再送処理をカーネルがやるが、QUICではアプリケーションがやる
          - (個人メモ) カーネルの面倒事をマッチョな実装者が引き受けることで代わりに高速化を得ているんですねえ
        - (個人メモ)
          - ngtcp2 - ruby (ruby上でUDPSocketを作る) - kernel という形で実装してる
          - これはIOとconcurrencyをRuby側で面倒見たいので全部丸投げにできない

(sylph01)


## 『Regional.rb and the Tokyo Metropolis』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)

## 会場や廊下のようす
