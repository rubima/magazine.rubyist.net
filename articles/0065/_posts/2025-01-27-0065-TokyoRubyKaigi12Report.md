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

コラボレーションツール、チャットやオンライン授業など、複数のWebフロントエンドがリアルタイムに協調動作する必要のあるユースケースで、それらをいかにして同期させるかというテーマでした。既存のリアルタイムデータベースを使用するのではなく、Active Recordを活用すべく、RailsとReactの組み合わせで実現する方法について話されました。

バックエンドからフロントエンドに情報を送る際に重要なのは「何をどう送るか」というイベントの設計です。特にモデル間に関連がある場合には扱いが複雑で、場当たり的なイベント定義をしていくとモデル数の増加とともに破綻してしまいます。

ユースケースの分析から、データフローを一方向に制約し、「木構造を丸ごとリアルタイムに同期したい」という問題に帰着させ、それをどう実現するかという議論に移っていきます。Railsのモデルとこの木構造は単純には対応しないものの、画面ごとにデータの親子関係を考えることができ、それを木構造として扱っています。具体的な通知の実装方式として「どの単位でサブスクライブするか」「更新の事実だけを通知するのか内容も通知するのか」という2つの軸で整理し、メリット・デメリットが議論されました。

これらを実現するための一式を含むgemとして[ArSync](https://github.com/tompng/ar_sync)を開発されているとのことです。発表は「JavaScript / TypeScript / ruby.wasmとRailsの組み合わせにはあまり試されていない可能性がまだまだありそう」「僕らはRubyのポテンシャルをもっと引き出せるはず」とのメッセージで締めくくられました。

私はリアルタイムWebアプリケーションが大好物で、複数のスタックで実装した経験もあって、とても興味深く聞きました。ただ、複数のモデルが複雑に関連するようなものはあまり経験がありませんでした。発表では親が変わるケースや複数あるケースにも言及されており、これは大変そう…という気持ちになりました。現代Web技術とRuby / Railsの新たな可能性、気になります。

(darashi)


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

レポート。レポート。レポート。レポート。レポート。

(your name)


## 『Regional.rb and the Tokyo Metropolis』

* 録画: https://example.com/

レポート。レポート。レポート。レポート。レポート。

(your name)

## 会場や廊下のようす
