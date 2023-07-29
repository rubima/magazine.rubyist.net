---
layout: post
title: RedAmberのドキュメントを整備する際に見つけたYARDのtips
short_title: Yard tips with RedAmber
tags: 0063
post_author: heronshoes
created_on: 2023-06-23
---
{% include base.html %}

## RedAmberのドキュメントを整備する際に見つけたYARDのtips

### はじめに

[Red Data Tools](https://red-data-tools.github.io/ja/) で [RedAmber](https://github.com/red-data-tools/red_amber) という Ruby で書かれたデータフレームライブラリを作っている @heronshoes です。RedAmber は、Ruby でデータフレームを扱うためのライブラリで、Python の pandas、R の data.frame　または dplyr/tidyr がやるようなことを Apache Arrow を利用して Ruby でできるようにするためのライブラリです。RubyKaigi2023 では、「[The Adventure of RedAmber - A data frame library in Ruby](https://rubykaigi.org/2023/presentations/heronshoes.html)」というタイトルで３日目に発表しました。

##### 図1. RedAmber の DataFrame オブジェクトと Vector オブジェクト

![DataFrame in RedAmber]({{base}}{{site.baseurl}}/images/0063-yardTipsWithRedAmber/DataFrame_in_RedAmber.png)

大変ありがたいことに [2022 年度の Ruby アソシエーション開発助成](https://www.ruby.or.jp/ja/news/20221027)に採択されまして、その期間中にはコードとドキュメントの整備にも取り組みました。そしてドキュメントを整備する中で、YARD の使い方について色々知らなかった事に触れることができましたので、ここで共有させていただきたいと思います。


### 1. 動的に生成しているメソッドのドキュメント追加方法

RedAmberでは、表の各列のデータを表すオブジェクト Vector の関数的なメソッド、例えば #mean, #abs, #> などは Apache Arrow の C++で書かれた Compute Function を利用して `#define_method` で動的に生成しています。

当初はそのように動的に生成されたメソッドに対して効率的にドキュメントを付加する方法がわからなかったのですが、最終的に下記の方法に辿り着きました。ここでは、Vector の要素に対してユニークな要素の数を数えるメソッド `#count_distinct` を例にしてドキュメントを付与してみます。

#### メソッドを定義するメソッドはクラスメソッドとする

クラスメソッドにしなくても動的にメソッドを定義することはできるので最初はそうしていたのですが、ドキュメント生成のためにクラスメソッドで書いた結果、コードの見通しも良くなったように感じます。

```ruby
module RedAmber
  class Vector
    class << self
      private

      def define_unary_aggregation(function)
        define_method(function) do |**options|
          datum = exec_func_unary(function, options)
          get_scalar(datum)
        end
      end
    end
  end
end
```

`define_unary_aggregation(function)` は Arrow の Compute Function の名前を受け付けてそれを呼び出すメソッドを定義するためのメソッドです。これは、例えば `#sum` や `#mean` のような、引数がなく結果として一つのスカラーを返すメソッド(Aggregation メソッド)を定義するために使います。同類のクラスメソッドとして、`#cumsum` や `#abs` のような引数を取らずに結果を Vector で返すメソッドを定義するための `define_unary_element_wise` や、 `#>` や `#+` のような引数を取って結果を Vector で返すようなメソッドを定義するための `define_binary_element_wise` があります。

##### 図2. RedAmber の Vector オブジェクトの種類

![Vector's functional methods]({{base}}{{site.baseurl}}/images/0063-yardTipsWithRedAmber/Vector_s_functional_methods.png)

#### 個別のメソッド定義はDSL風に書く

上で定義したクラスメソッドを使って、関数的なメソッドの定義を書いていきます。必要に応じて、エイリアスを定義します。

```ruby
module RedAmber
  class Vector
    define_unary_aggregation :count_distinct
    alias_method :count_uniq, :count_distinct
  end
end
```

ここでは、Ruby らしい別名として `#count_uniq` を用意してみました。

#### ドキュメントを付加する

いよいよこれにドキュメントを付与していきます。ポイントを箇条書きにしてご説明します。

1. クラスメソッドで共通のドキュメントは `@!macro[attach]` でクラスメソッドに付加します。

2. 全部に共通ではないが適宜利用するマクロはインスタンスメソッドの上の方で定義します。
  ここでは、`mode` というオプションを使うメソッドに共通のドキュメントを定義しています。

3. メソッド固有のドキュメントはメソッド定義のすぐ上に書きます。

4. `@!method` で引数とオプションを書きます。

5. メソッドの別名は alias_method で書きます。 実装上はクラスメソッド経由で定義することもできますが、このようにするとドキュメントで 'Also known as:' として正しく表示されます。

```ruby
module RedAmber
  class Vector
    class << self
      private

      # @!macro [attach] define_unary_aggregation    # 1
      #   [Unary aggregation function] Returns a scalar.
      #
      def define_unary_aggregation(function)
        define_method(function) do |**options|
          datum = exec_func_unary(function, options)
          get_scalar(datum)
        end
      end
    end

    # @!macro count_options                          # 2
    #   @param mode [:only_valid, :only_null, :all]
    #     control count aggregate kernel behavior.
    #     - only_valid: count only non-nil values.
    #     - only_null: count only nil.
    #     - all: count both.

    # Count the number of unique values.             # 3
    #
    # @!method count_distinct(mode: :only_valid)     # 4
    # @macro count_options                           # 2
    # @return [Integer]
    #   unique count of self.
    # @example
    #   vector = Vector.new(1, 1.0, nil, nil, Float::NAN, Float::NAN)
    #   vector
    #
    #   # =>
    #   #<RedAmber::Vector(:double, size=6):0x000000000000d390>
    #   [1.0, 1.0, nil, nil, NaN, NaN]
    #
    #   # Float::NANs are counted as 1.
    #   vector.count_uniq # => 2
    #
    #   # nils are counted as 1.
    #   vector.count_uniq(mode: :only_null) # => 1
    #
    #   vector.count_uniq(mode: :all) # => 3
    #
    define_unary_aggregation :count_distinct
    alias_method :count_uniq, :count_distinct        # 5
  end
```

この結果生成されたドキュメントは、 [RedAmber YARD Vector#count_distinct](https://red-data-tools.github.io/red_amber/RedAmber/Vector.html#count_distinct-instance_method) にあります。

該当するYARDのドキュメントは [YARD document / Tags](https://rubydoc.info/gems/yard/file/docs/Tags.md#macro) にあります。クラスメソッドで定義するメソッドの種類が限られている場合は、`$0, $1, $2, ...`などの変数を使って引数の説明を入れる方法も有効だと思います。今回の例では、定義されたメソッドで受け付けるオプションの種類が一種類ではないため、上のようなやり方に落ち着きました。


### 2. YARDドキュメントにカスタム css を登録する

[YARD のドキュメント](https://rubydoc.info/gems/yard/file/docs/Templates.md) には、css ファイルを使ってドキュメントのデザインをカスタマイズするテンプレートの例が書かれています。
RedAmberのドキュメントでは `@example` を使ってコード例を多く表示させていますが、デフォルトの設定ではそれらはプロポーショナルフォントで表示されてしまいます。これを回避するために、テンプレートをカスタマイズする方法を使いました。

#### コード部分に等幅フォントを指定する例

YARD テンプレートをカスタマイズする際には YARD 標準のテンプレートと同じディレクトリ構造の中に置く必要があります。

#### カスタムテンプレートを定義

`.yardopts`にカスタムテンプレートを置くパスを指定しました。

```
--template-path doc/yard-templates
```

カスタマイズした下記のようなcssを　`doc/yard-templates/default/fulldoc/html/css/common.css` に置きました。

```
/* Use monospace font for code */
code {
  font-family: "Courier New", Consolas, monospace;
}
```

その結果、下記のように表示できました。

![DataFrame in RedAmber]({{base}}{{site.baseurl}}/images/0063-yardTipsWithRedAmber/yard_monospace_fonts.png)

このカスタマイズは YARD 本体に取り込んでいただけるよう提案していきたいと思っています。


### おわりに

YARD をちゃんと書くのは初めての経験でしたが、Ruby Association Grant の助成適用ということもあり、全てのメソッドのドキュメント化を達成することができました。大変でしたがドキュメントにまとめることでライブラリのメソッド設計を整理することもできて良かったと感じています。お気づきの点がございましたらご指摘をいただけると嬉しいです。Ruby によるデータ処理に興味がある方、Ruby で新しいことに取り組んでみたい方は、[Red Data Tools](https://red-data-tools.github.io/ja/) に来てみて下さい。[Matrix上のチャットルーム](https://app.element.io/#/room/#red-data-tools_ja:gitter.im) でお待ちしています。


### 書いた人

heronshoes (Hirokazu SUZUKI)。 ex-Twitter: [@heronshoes](https://twitter.com/heronshoes), GitHub: [@heronshoes](https://github.com/heronshoes) 。広島県福山市在住のRuby愛好家。好きなメソッドはtally、シングルクォート派。コーヒーとクラフトビールとMINIも好き。今週のコーヒーを GitHub のステータスに表示しています。
