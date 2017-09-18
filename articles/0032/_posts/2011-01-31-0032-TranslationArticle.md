---
layout: post
title: 海外記事翻訳シリーズ 【第 1 回】 RSpec ベストプラクティス
short_title: 海外記事翻訳シリーズ 【第 1 回】 RSpec ベストプラクティス
tags: 0032 TranslationArticle
---


訳者: 桑田誠

## この連載について

この連載では、海外の良質な記事やブログを翻訳して紹介します。

第 1 回目は、Jared Carrollさんのブログ記事「[RSpec Best Practice](http://blog.carbonfive.com/2010/10/21/rspec-best-practices/)」です。

## RSpec ベストプラクティス

RSpec は、振舞駆動の設計プロセス (behaviour driven design process) において、人間にとって読みやすい仕様を書くための優れたツールです。RSpec で書かれた仕様が、アプリケーション開発における方向と検証を行います。本記事では私たちが気づいた、エレガントで保守しやすい仕様を書くためのプラクティスを紹介します。

### まず、何をしてるのかを #describe で説明しましょう

定義するつもりのメソッドごとに、#describe を使うことから始めましょう。このとき引数にはメソッド名を指定します。クラスメソッドには名前の頭に「.」をつけ、インスタンスメソッドには頭に「#」をつけましょう。これは Ruby の標準的なドキュメントプラクティスに則っており、spec ランナーによる出力が読みやすくなります。

{% highlight text %}
{% raw %}
describe User do

  describe '.authenticate' do
  end

  describe '.admins' do
  end

  describe '#admin?' do
  end

  describe '#name' do
  end

end
{% endraw %}
{% endhighlight %}


### 次に、#context (コンテキスト) をはっきりさせましょう

メソッドの実行パスごとに、#context を書きましょう。与えられたコンテキストのもとでの〔訳注: つまり実行パスごとの〕メソッドの挙動を逐語的に指定します。

たとえば、次のメソッドには 2 つの実行パスがあります。

{% highlight text %}
{% raw %}
class SessionsController < ApplicationController

  def create
    user = User.authenticate :email => params[:email],
                                     :password => params[:password]
    if user.present?
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:notice] = 'Invalid email and/or password'
      render :new
    end
  end

end
{% endraw %}
{% endhighlight %}


対応するスペックでは 2 つのコンテキストを作成します。

{% highlight text %}
{% raw %}
describe '#create' do
  context 'given valid credentials' do
  end

  context 'given invalid credentials' do
  end
end
{% endraw %}
{% endhighlight %}


各 #context の引数における「given」の使い方に注意してください。「given」はメソッドに与えられる入力値を説明します。ほかに使える単語としては「when」があります。こちらは条件によって挙動が変わるときのコンテキストを表現するのに使えます。

{% highlight text %}
{% raw %}
describe '#destroy' do
  context 'when logged in' do
  end

  context 'when not logged in' do
  end
end
{% endraw %}
{% endhighlight %}


このスタイルに従えば、複数の #context を入れ子にすることで、より深い実行パスを明確に定義できます。

### #it でのエクスペクテーションはひとつだけにしましょう

サンプル (example) 1 つにつき 1 つのエクスペクテーション (expectation) だけを記述するように努力してください。そうすればスペックの可読性が向上します。

次のスペックはひとつのサンプルのなかにあまり関連していないエクスペクテーションが混じっています。

{% highlight text %}
{% raw %}
describe UsersController do

  describe '#create' do
    ...

    it 'creates a new user' do
      User.count.should == @count + 1
      flash[:notice].should be
      response.should redirect_to(user_path(assigns(:user)))
    end
  end

end
{% endraw %}
{% endhighlight %}


以下のようにエクスペクテーションを複数のサンプルに分解することで、挙動を明確に定義できますし、サンプルの保守もより簡単になります。

{% highlight text %}
{% raw %}
describe UsersController do

  describe '#create' do
    ...

    it 'creates a new user' do
      User.count.should == @count + 1
    end

    it 'sets a flash message' do
      flash[:notice].should be
    end

    it "redirects to the new user's profile" do
      response.should redirect_to(user_path(assigns(:user)))
    end
  end

end
{% endraw %}
{% endhighlight %}


サンプルの説明は挙動を表す現在時制の動詞で始めてください。

{% highlight text %}
{% raw %}
it 'creates a new user' do
end

it 'sets a flash message' do
end

it 'redirects to the home page' do
end

it 'finds published posts' do
end

it 'enqueues a job' do
end

it 'raises an error' do
end
{% endraw %}
{% endhighlight %}


最後に、サンプルの説明を「should」で始めないようにしましょう。「should」を使うのは冗長ですし、結果としてスペックの出力が読みづらくなります。可読性が向上すると思うなら「the」や「a」や「an」は積極的にサンプルの説明に使っていきましょう。

### 明示的にすることを心がけましょう

「#it」や「#its」や「#specify」はタイプ量を減らすことができますが、可読性が犠牲になってしまいます。それらを使った場合、サンプルの中身を読まないと、それが何を意味しているのかを把握できなくなります。

次の例を使ってドキュメントフォーマッタ出力を比べてみましょう。

{% highlight text %}
{% raw %}
describe PostsController do

  describe '#new' do
    context 'when not logged in' do
      ...

      subject do
        response
      end

      it do
        should redirect_to(sign_in_path)
      end

      its :body do
        should match(/sign in/i)
      end
        end
  end
 end
{% endraw %}
{% endhighlight %}


明示的に振舞いを記述した場合は次のようになります。

{% highlight text %}
{% raw %}
describe PostsController do

  describe '#new' do
    context 'when not logged in' do
      ...

      it 'redirects to the sign in page' do
        response.should redirect_to(sign_in_path)
      end

      it 'displays a message to sign in' do
        response.body.should match(/sign in/i)
      end
    end
  end

end
{% endraw %}
{% endhighlight %}


前者の場合、そっけなくてコードっぽい感じで出力され、「should」が何度も登場して冗長です。

{% highlight text %}
{% raw %}
$ rspec spec/controllers/posts_controller_spec.rb --format documentation

PostsController
  #new
    when not logged in
      should redirect to "/sign_in"
      should match /sign in/i
{% endraw %}
{% endhighlight %}


後者の場合、スペックが非常に明確で読みやすく出力されます。

{% highlight text %}
{% raw %}
$ rspec spec/controllers/posts_controller_spec.rb --format documentation

PostsController
  #new
    when not logged in
      redirects to the sign in page
      displays a message to sign in
{% endraw %}
{% endhighlight %}


### スペックを実行して読みやすさを確認しましょう

スペックを実行する際には常に「-format」オプションに「documentation」をつけるようにしましょう (RSpec 1.x では「-format」オプションは「nestable」と「specdoc」です)。

{% highlight text %}
{% raw %}
$ rspec spec/controllers/users_controller_spec.rb --format documentation

UsersController
  #create
    creates a new user
    sets a flash message
    redirects to the new user's profile
  #show
    finds the given user
    displays its profile
  #show.json
    returns the given user as JSON
  #destroy
    deletes the given user
    sets a flash message
    redirects to the home page
{% endraw %}
{% endhighlight %}


出力が明瞭な会話のようになるまで、サンプルの名前を変更し続けましょう。

### 適切なマッチャを使いましょう

RSpec は役に立つマッチャを数多く揃えています。これらを使うと、スペックが話しことばにより近くなります (訳注: ここでの話しことばとは英語のことです)。

私たちが好んで使うマッチャを紹介します。使う前と使った後での違いは次のようになります。

{% highlight text %}
{% raw %}
# 使用前: 二重否定
object.should_not be_nil
# 使用後: 二重否定しない
object.should be

# 使用前: 'lambda' だと低水準すぎる
lambda { model.save! }.should raise_error(ActiveRecord::RecordNotFound)
# 使用後: 'expect' と 'to' でより自然なエクスペクテーションに
expect { model.save! }.to raise_error(ActiveRecord::RecordNotFound)

# 使用前: 実直に比較
collection.size.should == 4
# 使用後: サイズを調べるより高水準なエクスペクテーションを使う
collection.should have(4).items
{% endraw %}
{% endhighlight %}


[ドキュメント](http://rspec.info/documentation/)を参照したり周りの人に聞いたりしてください。

### フォーマット

すべてのブロックで、'do..end' スタイルのブロックを使いましょう。このとき、たとえ 1 行のエクスペクテーションでも複数行のブロックを使います。可読性をより向上させるために、すべてのブロック間に空行を 1 行入れます。また、トップレベルの #describe では最初と最後に 1 行の空行を入れましょう。

比較してみます。

{% highlight text %}
{% raw %}
describe PostsController do
  describe '#new' do
    context 'when not logged in' do
      ...
      subject { response }
      it { should redirect_to(sign_in_path) }
      its(:body) { should match(/sign in/i) }
    end
  end
end
{% endraw %}
{% endhighlight %}


分かりやすく構造化したコードは次のようになります。

{% highlight text %}
{% raw %}
describe PostsController do

  describe '#new' do
    context 'when not logged in' do
      ...
  
      it 'redirects to the sign in page' do
        response.should redirect_to(sign_in_path)
      end
  
      it 'displays a message to sign in' do
        response.body.should match(/sign in/i)
      end
    end
  end

end
{% endraw %}
{% endhighlight %}


複数の開発者がいるチームでは、一貫したフォーマットスタイルを維持するのは難しいことではありますが、各チームメイトのスタイルを視覚的にパースするのを修得するために費やされる時間を節約できるので、やる価値はあります。

### まとめ

本記事では、誰にとっても読みやすくて分かりやすい仕様を書くことに関するプラクティスを紹介しました。目標は、実行してパスするだけでなく、その出力結果がアプリケーションを完全に定義しているようなスペックを書くことです。ひとつひとつの小さなステップの積み重ねが、ゴールに向かうことを助けてくれます。私たちはもっと良い方法を引き続き学んでいるところです。あなたの RSpec ベストプラクティスはどのようなものでしょうか？

### 訳者について

桑田誠。RSpecより「alias eq assert_equal」のほうが好き。


