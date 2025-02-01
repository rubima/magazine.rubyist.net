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

takujosさんの発表ではRuby アソシエーション開発助成金にも採択された[Reight](https://github.com/xord/reight)の内部実装と利用方法について紹介されました！ReightはRubyで実装されたレトロゲームエンジンで、Reightをインストールして起動することでゲームを作るための統合開発環境が立ち上がります。統合開発環境でゲームに表示させるキャラクターやコインなどをドット絵で作ったり、それをマップ上に配置したりをGUIで行うことができます。ゲーム中のキャラクターの操作や当たり判定などはgame.rbにRubyのコードで実装します。発表中に使われたコードが[reight-examples](https://github.com/xord/reight-examples)に上がっていて、インストール後すぐに試すことができるので是非！

発表の中ではRegihtの技術スタックが紹介されていて、コンピュータグラフィックのライブラリであるOpenGLを抽象化してるレイヤーの実装や、統合開発環境のツールキット、ゲームを描画するコードを各部分のProcessing 互換 APIレイヤーなどなど、Regihtを構成している各技術について知ることができました。私が前日の前夜祭でクリエイティブコーディングのワークショップに参加していたこともあり、Processing 互換 APIレイヤーの話など「おー、おんなじようにこうやって描画するのか！」と東京Ruby会議の中での繋がりを感じられてよかったです。

普段はゲームはする専門ですが、発表を聞いてゲームを作る方の楽しみや、それが普段使い慣れてるRubyのコードでできることの良さを知り、自分もRubyで趣味の幅を広げたいな〜を感じた発表でした！

(三谷 昌平)


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

buty4649さんの発表ではテキストフィルタツールの[rf](https://github.com/buty4649/rf)について紹介されました！rfはsedやawk、jpのようなテキストフィルターツールと同じように、テキストデータの加工や整形、抽出を効率的に行えるツールです。rubyをインストールしていれば `echo matz | ruby -p -e '$_.tr! "a-z", "A-Z"'` のようにワンライナーでテキストの変換を実行することもできますが、よりタイプ数を減らして簡単に使えるツールが欲しい！！とのことでrfを開発されたそうです。mrubyを使ってワンバイナリーになっているのでrubyがなくてもインストールでき、Homebrewなどのパッケージマネージャーにも対応されています。

rfではRuby実装を独自拡張しているところもあり、読み込んだ文字列を取得する `$_` を `_` で拡張してタイプ数を1文字減らしたり、変数を定義してなくても `s+=1` のように加算代入できるようにしたりと、テキストフィルターだからこそ必要な機能やこだわりポイントが紹介されていて面白かったです！また、後半はmrubyを使ったCLIツールの作り方も紹介してくださり、私自身mrubyを使ったことはなかったので学びが多かったです。

私もrfをインストールして使い始めましたがいいですね。`rf /include/ app/controllers/xxx.rb` みたいにrubyでrubyのコードを探すのは気持ちいいです！！テキストフィルターしたいんだけど、awkとかgrepとか毎回オプション忘れるし...正規表現の書き方も忘れるし...という方にはピッタリ合うツールだと思います！！

(三谷 昌平)


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
