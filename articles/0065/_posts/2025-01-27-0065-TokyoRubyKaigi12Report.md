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

moznion さんの発表内容は、Rails と Perl の違いを比較しながら、それぞれの特徴をもとにした開発スタイルに焦点を当てたものでした。
それらの違いを「Simple vs Easy」の構図で語っていた点が印象的です。

例えば、Rails は、規約があるフルスタックなフレームワークで Easy に作れる仕組みがある一方、隠蔽されている部分が複雑です。
一方で、Perl などの Simple 組み合わせでは、必要なものだけを組み込めたり、自分たちのベストプラクティスを作れたりする柔軟性があります。
とはいえ、Simple と Easy は完全に相反するものではないという点が重要なポイントです。

Rails と Perl などの Simple 組み合わせは、それぞれが Easy と Simple を両立しています。
Rails は、作るための仕組みは Easy ですが、ビジネスロジックは Simple に実現できます。
一方、Perl などの Simple 組み合わせは、最大公約数的な Easy ではなく、ドメインに特化した Easy を Simple とともに得られます。

私は Simple 組み合わせ村の経験はあまりありませんが、自社のドメイン知識をベースにシステムを考えていくことで、確かにドメインに特化した Easy と Simple が得られるのだろうと感じました。
逆に Rails は "Rails Way" という言葉があるように、最大公約数的な Easy と Simple を目指しているのだなという気づきも得られました。

特に印象的だったのは、「Simple 組み合わせでは自分たちに最適化したベストプラクティスを作れるので、レールを外れることを恐れなくて良くなる」という部分です。
Rails を書いている身としては、レールに沿っているかを気にする場面があるので、確かにと共感しました。
レールに沿ったものがベストプラクティスであるため、ベストプラクティスを考える手間はある程度省けており、ドメインロジックの実現に集中できるということなのだと思いました。

改めて Rails の立ち位置を考える機会となった発表でした！

[The Rails Doctrine.](https://rubyonrails.org/doctrine) もこちらの発表内容と合わせて読めるとより楽しめるかもしれませんね。

(dak2)


### Hiromi Ogawa『Writing PDFs in Ruby DSL』

* 録画: https://example.com/

Ogawa さんは、Ruby DSL を使って PDF を生成するという内容でした。

PDF の仕様の話をすると、ヘッダー / ボディー / クロスリファレンステーブル / トレイラー の4つで構成されているようです。
その内、ボディー部のオブジェクトの構造は下記のようになっています。（一部省略）

```
1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj
2 0 obj << /Type /Pages /Kids [ 3 0 R ] /Count 1 >> endobj
3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [ 0 0 720 405 ]
  /Resources 4 0 R /Contents 5 0 R >> endobj
...
xref
0 6
0000000000 65535 f
0000000009 00000 n
0000000058 00000 n
0000000115 00000 n
0000000227 00000 n
0000000319 00000 n
```

この構造を見ると、Catalog -> Pages <-> Page -> コンテンツストリーム という流れが見えてきます。
Catalog がエントリポイントとなり、Pages が描画するページを探し、Page で実際のコンテンツをたどる流れです。

また、数字の羅列はクロスリファレンステーブルというもので、ファイル内の各オブジェクトの位置を一覧化した情報です。
例えば `0000000009 00000 n` という記述は、「このオブジェクトは PDF ファイルの 9 バイト目にある」ということを示しています。

この情報があることで、PDF の任意のページにランダムアクセスが可能になります。もしこの情報がなければ、目的のページにアクセスするために 1 ページ目から順に読む必要があるでしょう。
しかし、人間がこの計算を行うのは難しいため、DSL 側でオフセット計算をしながら PDF を組み立てる仕組みになっていました。

```ruby
class OffsetIO
  attr_reader :offset
  def initialize(io)
    @io = io
    @offset = 0
  end
  def <<(b)
    @io << b
    @offset += b.bytesize
  end
end

code do
  content <<~RUBY, style: JotPDF::Tokyork12::Highlighter::Ruby
    def obj
      @io << "obj "
      yield
      @io << " endobj"
    end
  RUBY
  list x: 350, y: 150, size: 25, color: 0xffffff do
    item "Ruby にはブロックがある"
  end
end
```

紹介のあったコードの一部を抜粋しましたが、`<<` メソッドを使ってクロスリファレンステーブルのバイトサイズを計算しつつ、content ブロック内で PDF の中身を組み立てる構造になっています。
ブロック構文を利用することで階層構造が視覚的に明確になり、code ブロックの中に content の内容や list の内容が含まれるという構図がわかりやすくなっています。

適度な粒度で抽象化されていく DSL の構築過程をとても楽しんで拝見しました。
業務で使っているツールなどをハックして再実装する試みは、そのツールとの機能差分を比較でき、より深い理解につながるので良いですよね！
私も何か Ruby で再実装できないかと考えさせられました。

さらに、発表のスライド自体もご自身が作った DSL で生成されていたというオチも素晴らしかったです（笑）。

(dak2)


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
