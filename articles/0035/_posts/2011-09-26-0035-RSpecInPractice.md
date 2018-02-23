---
layout: post
title: 改めて学ぶ RSpec
short_title: 改めて学ぶ RSpec
tags: 0035 RSpecInPractice
---
{% include base.html %}


* Table of content
{:toc}


書いた人 : 赤松 祐希 ([@ukstudio](http://twitter.com/ukstudio))

## はじめに

当記事は Ruby のテスティングフレームワーク、RSpec の解説記事です。 入門記事ではなく、比較的実践的な内容を目指しているので it や describe やテストの実行の仕方など最低限の RSpec の知識ある人を対象としています。

RSpec は今やメジャーなテスティングフレームワークとなりましたが、実は日本語での情報はあまりありません。[^1]
そういった背景から大多数の人が RSpec をうまく使いこなせているとは言えず、RSpec らしくないテストコードを見かけることが多々あります。

この記事の目的はそういった状況を少しでも改善するために、RSpec に興味がある、もしくは使っているが今一使いこなせてるように感じない人に向け RSpec の使い方を指南することです。

## xUnit っぽいコードから RSpec らしいコードへ

### xUnit っぽい RSpec のコード

ここでいう「xUnit っぽい」というのは、簡単に言えば RSpec の機能を使いこなすことなく、it を xUnit のテストメソッドと同じように扱ってしまっているものをさします。

```ruby
  describe Stack do
    before do
      @stack = Stack.new
    end

    it '#pushの返り値はpushした値であること' do
      @stack.push('value').should eq 'value'
    end
    it 'スタックが空の場合、#popの返り値はnilであること' do
      @stack.pop.should be_nil
    end

    it 'スタックに値がある場合、#popで最後の値を取得すること' do
      @stack.push 'value1'
      @stack.push 'value2'
      @stack.pop.should eq 'value2'
      @stack.pop.should eq 'value1'
    end

    it '#sizeはスタックのサイズを返すこと' do
      @stack.size.should eq 0

      @stack.push 'value'
      @stack.size.should eq 1
    end
  end

```

上記のテストコードは RSpec でスタック構造をあらわす Stack クラスに対して書かれたものです。Stack クラスは push、pop、size の 3 つのメソッドを持ちます。

xUnit では基本的にテストメソッドは全てフラットに定義されます (最近ではそうじゃないものも増えてきましたが) ので、このテストコードは xUnit ぽいテストコードと言っていいでしょう。テストメソッドがそのまま it に置き換わっただけですし、before ブロックも setup メソッドのようにしか使っていません。

### describe と context

さきほどのテストコードをいくつかの手順を踏んで修正してみましょう。まずは describe です。describe は RSpec でテストコードを書くときは必ず一つは登場するものですが、同じレベルで並べたりネストさせたりすることができます。

```ruby
  describe Stack do
    before do
      @stack = Stack.new
    end

    describe '#push' do
      it '返り値はpushした値であること' do
        @stack.push('value').should eq 'value'
      end

      it 'nilをpushした場合は例外であること' do
        lambda { @stack.push(nil) }.should raise_error(ArgumentError)
      end
    end

    describe '#pop' do
      it 'スタックが空の場合、#popの返り値はnilであること' do
        @stack.pop.should be_nil
      end

      it 'スタックに値がある場合、#popで最後の値を取得すること' do
        @stack.push 'value1'
        @stack.push 'value2'
        @stack.pop.should eq 'value2'
        @stack.pop.should eq 'value1'
      end
    end

    describe '#size' do
      it '#sizeはスタックのサイズを返すこと' do
        @stack.size.should eq 0

        @stack.push 'value'
        @stack.size.should eq 1
      end
    end
  end
```

describe を使うことでテストコードに構造がうまれました。各テストケースがグルーピングされることによって、テストケースが何についてテストを行なっているのかわかりやすくなります。

次に context です。context は describe のエイリアスでしかありませんが使う目的が違います。ひとことで言うなら、 describe はテストする対象をあらわし、 context はテストする時の状況をあらわします。

```ruby
  describe Stack do
    before do
      @stack = Stack.new
    end

    describe '#push' do
      context '正常値' do
        it '返り値はpushした値であること' do
          @stack.push('value').should eq 'value'
        end
      end

      context 'nilをpushした場合' do
        it '例外であること' do
          lambda { @stack.push(nil) }.should raise_error(ArgumentError)
        end
      end
    end

    describe '#pop' do
      context 'スタックが空の場合' do
        it '返り値はnilであること' do
          @stack.pop.should be_nil
        end
      end

      context 'スタックに値がある場合' do
        it '最後の値を取得すること' do
          @stack.push 'value1'
          @stack.push 'value2'
          @stack.pop.should eq 'value2'
        end
      end
    end

    describe '#size' do
      it 'スタックのサイズを返すこと' do
        @stack.size.should eq 0

        @stack.push 'value'
        @stack.size.should eq 1
      end
    end
  end
```

今回、describe はメソッド単位でわけました。理由としてはテストケースを書くときは何らかのメソッドを対象としていることがほとんどのため、このようにわけた方がテストが書き易いことが多いためです。またメソッド単位でわけることでドキュメントとしても読み易くなります。

ですが、テストの対象となるものはメソッドだけとは限りませんし、複数のオブジェクトのコラボレーションをテストしたいこともあるでしょう。そのときは素直に自分がわかりやすいと思うように describe をわければいいでしょう。メソッド単位にこだわる必要はあまりありません。

#### 段階的に仕様をテストコードに落とし込む

describe と context の概念は個人的には非常に重要な概念だと思っています。というのもアプリケーションの仕様をテストコードに落とし込むにあたって、思考ツールとして機能するためです。

例えば、先程の Stack クラスについてテストコードを書くときに、大抵まずはどのメソッドから実装しようかを考えると思います。その時に push メソッドから実装しようとしたと考えたとしましょう。

まずは push メソッドをテスト対象とする describe を用意します。

```ruby
  describe Stack do
    describe '#push' do
    end
  end
```

対象が決まったら、次はそのメソッドを呼び出す状況を考えます。push メソッドの場合、最初に思いつくのは、そのまま値を保存する状況でしょう。この時は、まだ他に context がないのでそのまま it にしてしまうことができます。

```ruby
  describe Stack do
    describe '#push' do
      it '値が保存されること'
    end
  end

```

正常値について考えたら、異常値についても考えるので、nil を保存しようとした時に例外が発生する状況について考えます。先程の正常値とは状況が違うので、今度は context をわける必要があります。

```ruby
  describe Stack do
    describe '#push' do
      context '正常値' do
        it '値が保存されること'
      end

      context 'nilの場合' do
        it '例外になること'
      end
    end
  end

```

このように describe、context、it と順番を踏むことで仕様を段階的にテストコードに落とし込んでいきやすくなります。describe と context を使うことでアプリケーションの仕様を整理し、設計を行ないやすくなります。

### subject

RSpec では subject を使うことで should のレシーバを省略することができます。先程のテストコードの一部を subject を使って書き直してみます。

```ruby
  describe '#pop' do
    subject { @stack.pop }

    context 'スタックが空の場合' do
      it '返り値はnilであること' do
        should be_nil
      end
    end

    context 'スタックに値がある場合' do
      before do
        @stack.push 'value1'
        @stack.push 'value2'
      end

      it '最後の値を取得すること' do
        should eq 'value2'
      end
    end
  end

```

subject のメリットはテスト対象が明確になること、そしてほぼ強制的にひとつのテストケースにひとつのアサーションしか書けなくなることです。テストを書くときに「今何をテストしているのか」ということを意識するのは重要です。describe を切った時点である程度明確になっていますが、subject に比べると若干弱いのは否めません。subject を使うと例えばメソッドを実行した後のオブジェクトの状態をテストしているのか、もしくはメソッドの返り値をテストしているのかという普段つい曖昧にしがちな部分もはっきりと分けることができます。

```ruby
  describe Array, '#delete' do
    subject { [1,2,3].delete(3) }
    it { should eq 3 }
  end

  describe Array, '#delete' do
    before do
      @array = [1,2,3]
      @array.delete(3)
    end
    subject { @array }
    its(:size) { should eq 2 }
  end

```

そして、should のレシーバを省略することでひとつのテストケースにひとつのアサーションしか書けなくなります。一般的にテストケースにはひとつのアサーションを書くのがよいとされており、subject をうまく使うことで自然とそのようなテストを書くようになります。

### describe のネスト と subject

場合によっては、関連先のオブジェクトについてもテストしたい場合があります。例えば User クラスと それに関連する Profile クラスなどが考えられます。この場合、subject を使って should のレシーバを省略すると関連先のオブジェクトにアクセスできないのでテストすることができません。解決するには 新たに describe をネストさせてもう一度 subject を定義しましょう。

```ruby
  describe User, '#create!' do
    before { @user=User.create! }
    subject { @user }
    it { should_not be_new_record }

    descirbe Profile do
      subject { @user.profile }
      it { should_not be_new_record }
      its(:name) { should eq 'AKAMATSU Yuki' }
    end
  end

```

このようにして関連先のオブジェクトもテストすることができます。Rails のアプリケーションを開発している場合、こういうケースは結構あるのではないかと思います。

もうひとつ、 its を使う方法もあります。テストする箇所が少ない場合はこちらでもいいでしょう。

```ruby
  describe User, '#create!' do
    subject { User.creat! }
    it { should_not be_new_record }
    its(:profile) { should_not be_new_record }
    its('profile.name') { should eq 'AKAMATSU Yuki' }
  end

```

### it に文字列を渡すのか、渡さないのか

さて、途中から書き方を変えていたので気づいた方もいるかもしれませんが、it に与える文字列は省略することができます。このように書くと、「it should be nil」といった風に RSpec のコードをそのまま英文のように読めるため文字列を渡さずともそれなりにテストの内容をそのまま読めるようになります。

RSpec のよくある議論のひとつに、it に文字列を渡すのかどうかというものがあります。筆者の感覚ですと RSpec の最新版を絶えず追っているような人は文字列を省く傾向があるように思えます。筆者も基本的には省いて RSpec のコードのみでテストを表現するようにしています。

理由としては、it に文字列を渡す書き方だとコメントとコードの乖離と同じような問題があるためです。最近のよいコードの書き方の指針のひとつに「コメントを書かなくても内容がわかるコードを書く」というものがあります。理由としてはコメントとコードの両方があるのは DRY (Don't Repeat Yourself) ではなく、コメントもしくはコードのどちらかだけが修正され内容が一致しなくなるといった問題が起きるためです。

RSpec の it と文字列にも同じことが言えます。中のテストケースが修正されているにもかかわらず、it の引数の文字列が修正されず内容が一致しなくなることは十分にありえます。また、文字列を毎回渡しているとどうしてもテストコードの行数が長くなってしまい見通しがわるくなってしまいます。

とは言え、省略した場合に何も問題がないわけでもありません。私は日本人ですし、多分この記事を読まれている方のほとんども日本人でしょう。日本人ならやはり日本語で書かれている方がわかりやすいはずです。また、RSpec の実行オプションに「--format documentation」を指定した時のドキュメントもわかりづらくなってしまいます。例えば先程の Stack クラスの 「最後の値を取得すること」というテスト内容が「should eq 'value2'」となってしまい仕様が読み取れません。

{% highlight text %}
{% raw %}
 Stack
   #pop
     スタックが空の場合
       返り値はnilであること
     スタックに値がある場合
       最後の値を取得すること
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
 Stack
   #pop
     スタックが空の場合
       should be nil
     スタックに値がある場合
       should == value2
{% endraw %}
{% endhighlight %}


こちらはいくつか解決する方法があります。1つは context に具体的な値を入れてしまう方法、もうひとつは カスタムマッチャを定義してしまうことです。

```ruby
  RSpec::Matchers.define :be_latest_value do |expected|
    match do |actual|
      actual == latest_value
    end
  end

  describe Stack do
    before { @stack = Stack.new }
    describe '#pop' do
      subject { @stack.pop }

      context 'スタックが空の場合' do
        it { should be_nil }
      end

      # 具体的な値をcontextに書く
      context 'スタックの最後の値が"value2"の場合' do
        before do
          @stack.push 'value1'
          @stack.push 'value2'
        end

        it { should eq 'value2' }
      end

      # カスタムマッチャでメッセージを調整する
      context 'スタックに値がある場合' do
        let(:latest_value) { 'value2' }
        before do
          @stack.push 'value1'
          @stack.push latest_value
        end

        it { should be_latest_value }
      end
    end
  end

```

{% highlight text %}
{% raw %}
 Stack
   #pop
     スタックが空の場合
       should be nil
     スタックの最後の値が"value2"の場合
       should == value2
     スタックに値がある場合
       should be latest value
{% endraw %}
{% endhighlight %}


context で具体的な値を明示することで RSpec の出力から最後の値を取得する仕様だというのが推測できます。カスタムマッチャは定義したものがそのまま出力されるので、こちらの方がより仕様としてわかりやすいでしょう。

ですが、実際筆者がここまでやるかというとあまりやりません。せいぜい、context の文言を気にする程度でしょうか[^2]。なぜならプログラマとしては RSpec が出力するドキュメントよりテストコードの方が重要なため、RSpec の出力結果だけを見るということはあまりないためです。なので、テストコードが読みやすく書かれているのであれば、ドキュメントとして意味がわかりにくい文章が出力されていてもあまり気にならないでしょう。

結論としては、筆者としては it には文字列を使わない書き方をおすすめします。やはり文字列とテスト内容が DRY ではないというのが理由としては大きいです。また、今回はサンプルが小さいのであまり気にならないと思いますが、実際はもっとたくさんのテストケースがあるのが普通です。そうなると文字列を省いた方がテストコード全体がコンパクトになります。

以上の理由から個人的には文字列を使わない書き方をおすすめしますが、当然文字列をちゃんと書くという人もいます。[^3]なので、自分なりにでいいので、どちらがいいのか考えてみてください。どちらにもいい点悪い点はあるので絶対的にどちらが正しいというのはありません。

### let でデータ以外の部分だけを共通化する

RSpec には let という機能があります。subject などに比べるとあまり知られておらず、知っていても使い方がよくわからないという方も多いようなので解説したいと思います。

```ruby
  descirbe 'let' do
    let(:foo) { 'foo' }
    specify { foo.should eq 'foo' }
  end

```

let はブロックの評価値が、引数として渡されたシンボルと同名の変数に格納されます。上記の例ではブロックの評価値が文字列 'foo' でシンボルが :foo なので foo という変数名に文字列 'foo' が格納されています。動作としては遅延評価される仕組みになっており[^4]、実際に呼び出しされるまでは実行されません。また、同じテストケース内ではブロックの評価値はキャッシュされており、複数回呼び出したときに毎回処理を行なうということはおきません。

テストを書くとき、事前処理や呼び出すメソッドは同じでも使うデータだけが違うという場合があります。その時はそれぞれの describe や context の before の中で同じ処理を毎回書くか、テスト用のヘルパーメソッドを書くなどするしかありませんでしたが、let を使うともう少しスマートに書くことができます。

```ruby
  describe User, '#admin?' do
    before do
      @user = User.new(:name => 'jack')
    end
    subject { @user }

    context 'admin' do
      before do
        @user.role = Role.new(:role => :admin)
      end

      it { should be_admin }
    end

    context 'not admin' do
      before do
        @user.role = Role.new(:role => :normal)
      end

      it { should_not be_admin }
    end
  end

```

User クラスは内部に Role クラスを持ち、その Role の状態によって admin? メソッドの結果がかわります。このテストコードは let を使わず before と subject だけで書かれています。admin の context と not admin の context の違いは Role クラスに渡す引数だけです。

```ruby
  describe User, '#admin?' do
    before do
      @user = User.new(:name => 'jack')
      @user.role = Role.new(:role => role)
    end
    subject { @user }

    context 'admin' do
      let(:role) { :admin }
      it { should be_admin }
    end

    context 'not admin' do
      let(:role) { :normal }
      it { should_not be_admin }
    end
  end

```

let を使うとデータの定義の部分だけを抜き出すことができるので、Role の設定もひとつの before の中ですませることができます。先程のテストコードよりこちらの方が DRY でコードの見通しもよくなっています。これが let の最もオーソドックスな使い方だと思います。

もちろん、単純にインスタンス変数の置き換えとしても使うことができます。このあたりは好みの問題の気も若干しますが、データの定義を宣言的に書くことができるので大体の場合は見やすくなるでしょう。

```ruby
  describe Stack, '#pop' do
    let(:stack) { Stack.new }
    subject { stack.pop }

    context 'スタックが空の場合' do
      it { should be_nil }
    end

    context 'スタックに値がある場合' do
      let(:oldest_value) { 'value1' }
      let(:latest_value) { 'value2' }

      before do
        stack.push oldest_value
        stack.push latest_value
      end

      it { should eq latest_value }
    end
  end

```

### shared_context

RSpec の context はさきほど説明した通り、テストの状況を分けるために使うものですが context 自体は describe のエイリアスなので特になにかをしてくれるというわけではありません。実際にテストの状況をわけるためには before や subject などを使う必要があります。

実は同じコンテキストでもひとつの context の中にまとめられないことが多々あります。例えば、複数のメソッドのテストで同じコンテキストを使いたい時などがそうです。

```ruby
  describe '#method_a' do
    context '#context_a' do
      before {} # DRYじゃない
    end
  end

  describe '#method_b' do
    context '#context_a' do
      before {} # DRYじゃない
    end
  end

```

describe と context のネストを逆にすることで解決できそうな気もしますが、普通あるメソッドに対するテストは複数のコンテキストで行いますから今度は同じメソッドに対するテストがバラバラに記述されてしまいます。

```ruby
  context '#context_a' do
    before {}

    describe '#method_a' do
    end

    describe '#method_b' do
    end
  end

  context '#context_b' do
    before {}

    describe '#method_a' do
    end

    describe '#method_b' do
    end
  end

```

バラバラになるとはいえ、これはこれでうまく構造化できているような気がします。ですが、これにはひとつ大きな問題があります。先程、段階的に仕様をテストコードに落とし込むという話で最初に describe を分けるところからはじめました。それと同じ理由で、これからテストしようと思う describe があってその次にテストする状況としての context があるので context が describe より上に来るのは自然ではありません。なので私はこの書き方はおすすめしません。

これを解決するためには shared_context を使います。shared_context はその名前の通りコンテキスト (テストを行なうときの状況) を共有するための機能です。

```ruby
  shared_context '要素がふたつpushされている' do
    let(:latest_value) { 'value2' }
    before do
      @stack = Stack.new
      @stack.push 'value1'
      @stack.push latest_value
    end
  end

  describe Stack do
    describe '#size' do
      include_context '要素がふたつpushされている'
      subject { @stack.size }
      it { should eq 2 }
    end

    describe '#pop' do
      include_context '要素がふたつpushされている'
      subject { @stack.pop }
      it { should eq latest_value }
    end
  end

```

shared_context を使うことで複数箇所にちらばる同一処理をまとめることができます。shared_context は shared_context が書かれたファイルを require することでも使えるようになるので別のスペックファイルでも使うことができます。

## 情報源

RSpec を使うとなったときに使い方についてどこで知ればいいのかと困る人も多いようです。実際、日本語での情報はあまり多くありません。本記事はそういう状況を少しでも改善できたらと思い書きましたがやはりこれでも十分ではありません。

なので現時点ではやはり大元のドキュメントを参照するのが一番でしょう。[rspec.info](http://rspec.info/) は現在ほぼ更新されていないので、Relish の方の [RSpec Documentation](http://www.relishapp.com/rspec) を見ることをおすすめします。

Relish は Cucumber のシナリオをドキュメントとして表示してくれるので基本的にはこれが最新のドキュメントと思えばいいでしょう。ただ、Relish のドキュメントは API ドキュメントに近く、使い方はわかってもそれを活用する方法がわからない場合もあります。例えば私は最初 let のメリットがよくわからず、しばらく手元で let を使ったテストコードを何回か書いて理解したりしました。

この辺りの問題はなかなかむずかしく、ググって調べるか人に聞くなどするしかありません。もちろん自分で考えるという方法もあります。人に聞く場合は twitter などで発言すれば誰かが答えてくれるかもしれません。

RSpec に関するコミュニティは私は [Testing w/ Rails using RSpec in Japanese](https://github.com/testing-rails-rspec-ja/community) ぐらいしか知りませんが、あまり活発に活動しているわけでもありません。ただ少なくとも私は普段からチェックしていますし、Facebook にグループがあるのでそちらで質問を投げてもらえればわかる範囲でお答えできます。他の人も見てれば答えてくれるでしょう。もちろん、今この記事を見ているあなたも答えてもらって大丈夫です。むしろぜひ答えてください。github に wiki があるのでそちらに自分の知っていることを書くことも歓迎します。

## 終わりに

RSpec はよく「難しい」とか「構文がわかりづらい」と言われます。Rubyist はものごとをきっと Ruby のコードで考えるのでそのコードと RSpec の DSL にギャップがあるからなのかなと個人的には思っています。正直、この辺は慣れの問題でしょう。もちろん、どうしても受け付けないという人はいると思います。

そういう人はまず describe と context のふたつから始めてみてください。仕様をテストするという点ではこのふたつを理解できれば十分だと個人的には思っています。it の中も Test::Unit のテストケースと同じように書いてしまっていいでしょう。

そのうちにテストコードを DRY にしたくなると思います。そうしたときに初めて subject や let、shared_context などの機能を使うとよいでしょう。RSpec はテストコードを DRY にするという点で非常に優秀なテスティングフレームワークです。その分、機能が多く複雑に見えるかもしれませんが、ひとつずつ使い込なしていけばいいでしょう。

これが私の知っている RSpec の全てというわけではありません。他にも伝えたいことはいろいろとありましたが、それをするとひとつの本になりかねないので省略させてもらいました。この記事が RSpec をもっと使いこなしたいという方の参考になれば幸いです。

## 著者について

赤松 祐希 ([@ukstudio](http://twitter.com/ukstudio))

フリーランスの Ruby プログラマ。最近は主に[株式会社スケールアウト](http://scaleout.jp/)のお手伝いをさせてもらってます。あと、Ruby での TDD 入門本を現在執筆中です。落ちなければ来年ぐらいには出る気がします。みんな買ってね。

[^1]: 編注 : 以前るびまでは、[スはスペックのス]({% post_url articles/0021/2007-09-29-0021-Rspec %})という連載がありました。
[^2]: カスタムマッチャのこの使い方は個人的には気に入っていますが、この使い方だと定義が増えすぎてしまうので基本的には避けています。
[^3]: RSpec Best Practice の Jared さんがそうです。[[0032-TranslationArticle]]
[^4]: 編注 : 遅延評価しない(正格評価される) let! というメソッドも用意されています。
