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

（自己紹介と背景説明を書く）

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

`define_unary_aggregation(function)` は Arrow の Compute Function の名前を受け付けてそれを呼び出すメソッドを定義するためのメソッドです。これは、例えば `#count` や `#mean`のような、関数の引数がなく結果として一つのスカラーを返すメソッドを定義するために使います。同類のクラスメソッドとして、`#abs`のような引数を取らずに結果を Vector で返すメソッドを定義するための `define_unary_element_wise` や、 `#==` のような引数を取って結果を Vector で返すようなメソッドを定義するための `define_binary_element_wise` があります。

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

Ruby らしい別名として、`#count_uniq` も用意してみました。

#### ドキュメントを付加する

いよいよこれにドキュメントを付与していきます。ポイントを箇条書きにしてご説明します。

- クラスメソッドで共通のドキュメントは `@!macro[attach]` でクラスメソッドに付加します (1)。

- 全部に共通ではないが適宜利用するマクロはインスタンスメソッドの上の方で定義します (2)。

- メソッド固有のドキュメントはメソッド定義のすぐ上に書きます (3)。

- `@!method` で引数とオプションを書きます (4)。

- メソッドの別名は alias_method で書きます (5)。 実装上はクラスメソッド経由で定義することもできるが、このようにするとドキュメントで 'Also known as:' として正しく表示されます。

```ruby
module RedAmber
  class Vector
    class << self
      private

      # @!macro [attach] define_unary_aggregation    # (1)
      #   [Unary aggregation function] Returns a scalar.
      #
      def define_unary_aggregation(function)
        define_method(function) do |**options|
          datum = exec_func_unary(function, options)
          get_scalar(datum)
        end
      end
    end

    # @!macro count_options                          # (2)
    #   @param mode [:only_valid, :only_null, :all]
    #     control count aggregate kernel behavior.
    #     - only_valid: count only non-nil values.
    #     - only_null: count only nil.
    #     - all: count both.

    # Count the number of unique values.             # (3)
    #
    # @!method count_distinct(mode: :only_valid)     # (4)
    # @macro count_options                           # (2)
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
    alias_method :count_uniq, :count_distinct        # (5)
  end
```

この結果生成されたドキュメントは、 [RedAmber YARD Vector#count_distinct](https://red-data-tools.github.io/red_amber/RedAmber/Vector.html#count_distinct-instance_method) にあります。

該当するYARDのドキュメントは [YARD document / Tags](https://rubydoc.info/gems/yard/file/docs/Tags.md#macro) にあります。


### 2. YARDドキュメントでコード部分に等幅フォントを指定する方法

### おわりに
