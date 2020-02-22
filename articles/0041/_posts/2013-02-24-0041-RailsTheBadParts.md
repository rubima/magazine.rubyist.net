---
layout: post
title: Ruby on Rails： The Bad Parts
short_title: Ruby on Rails： The Bad Parts
created_on: 2013-02-24
tags: 0041 RailsTheBadParts
---
{% include base.html %}


* Table of content
{:toc}


書いた人: 浦嶌 啓太 ([ursm](http://coderwall.com/ursm))

## はじめに

Rails での開発には様々なベストプラクティスがあります。例えば「プレゼンテーションロジックはビューではなくヘルパーに置く」「ドメインロジックはなるべくモデルに寄せる」などです。これらは総称して「Rails のレールに乗る」と表現されたりもします。

しかし残念なことに、Rails のレールに乗るだけですべてがうまくいくわけではありません。細心の注意を払って書いていたはずのコードが、時が経つにつれて肥大化し、醜くなっていく -- これをお読みの皆さんも同様の経験をお持ちではないでしょうか。

筆者は [QA@IT](http://qa.atmarkit.co.jp/) というサービスの開発に携わるにあたり、Rails での開発において陥りやすい罠について分析し、それらを解決するためにいくつかの試みを行いました。本稿はそこから得られた知見を共有することを目的として書かれています。

この記事の内容は[札幌 Ruby 会議 2012](http://sapporo.rubykaigi.org/2012/ja/) の[同名のセッション](http://sapporo.rubykaigi.org/2012/ja/schedule/details/64.html)をベースにしています。

## Rails アプリケーションの「不吉な臭い」

それでは、Rails アプリケーションのコードベースが崩壊していく要因を考えてみましょう。今回は以下の 3 点を題材とします:

### 1. 膨大な数のヘルパーメソッド

ロジックが散在したビューはとかく読み難く、メンテンスし難いものです。ではそのロジックをヘルパーに追い出しましょう……となるわけですが、ナイーブにやっているとヘルパーメソッドがどんどん増えていきます。その数 3 桁ともなると、似ているようで微妙に違うメソッドや、多分どこからも使われていないけれど怖くて消せないメソッドなどが現れてきて、新しくメソッドを足すにも「どこに書けばいいかよくわからないから一番下でいいや」という感じになってきます。ヘルパークラスを分割してみたり、メソッド名にプレフィックスを付けてみたりするも焼け石に水で、管理不能な状態に陥ります。

### 2. 散在するパーシャルとフィルター

Rails では再利用可能なテンプレートとしてパーシャルを用います。これはシンプルなケースでは適切に機能しますが、少し複雑なことをしようとすると途端に辛くなってきます。

例として「最近サインアップしたユーザの一覧を表示するパーシャル」を考えてみましょう。SNS のサイドバーによくあるアレですね。

{% highlight text %}
{% raw %}
-# app/views/application/_recent_signed_up_users.html.haml

%ul
  - User.recent_signed_up.includes(:profile).order('created_at DESC').each do |user|
    %li= link_to user.profile.name, user_profile_path(user)
{% endraw %}
{% endhighlight %}


表示するユーザを取得する部分がいかにも臭いますね。例えばログインユーザの有無によってクエリを切り替えるような仕組みになった場合、このパーシャルにロジックを足すのでしょうか。ここは大人しくコントローラに初期化ロジックを書いてみます。

{% highlight text %}
{% raw %}
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    # used by `recent_signed_up_users` partial
    @recent_signed_up_users = User.recent_signed_up.includes(:profile).order('created_at DESC')
  end
end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
-# app/views/application/_recent_signed_up_users.html.haml

%ul
  - @recent_signed_up_users.each do |user|
    %li= link_to user.profile.name, user_profile_path(user)
{% endraw %}
{% endhighlight %}


うーん、users#show に本筋とは関係ないロジックが入ってしまいました。また、このパーシャルを使うアクションすべてにこのコードをコピペしろというのでしょうか。もちろんそんなことはなくて、フィルターを使えばいいですね。

{% highlight text %}
{% raw %}
class ApplicationController < ActionController::Base
  private

  def assign_recent_signed_up_users
    @recent_signed_up_users = ...
  end
end

class UsersController
  before_filter :assign_recent_signed_up_users, only: %w(show)

  def show
    ...
  end
end
{% endraw %}
{% endhighlight %}


これで万事解決……なのでしょうか？　実際のところ、あまり状況は変わっていません。パーシャルと初期化ロジックは分離したままですし、このパーシャルを使うアクションでは忘れずにフィルターを適用しなければなりません。ひとつの関心事に対して複数の箇所を気にしないといけないというのはいかにも嫌な感じがします。このようなパーシャルとフィルターの組み合わせが増えてくると、もはや把握し切れるものではありません。

### 3. 巨大なモデル

よく言われる "Skinny Controller, Fat Model" (ロジックをなるべくモデルに寄せて、コントローラの処理を減らす) を忠実に守ると、主要なモデルがどんどん大きくなっていきます。そのモデルに特有のロジックなら仕方がないとも思えるのですが、ある特定のアクションでしか使われないロジックや、複数のモデルに跨がるロジックなども全部ごちゃ混ぜになっていて、どれがどれだかさっぱりわからない状態になります。

## 不吉な臭いに対処する

さて、これらの問題にどうやって対処すればよいのでしょうか。

### モデルを基準としてプレゼンテーションロジックを分離する

ヘルパーが抱える主な問題点は「数が増えてくると管理し切れない」ことでした。ヘルパーは構造化の仕組みを持たないため、すべてのメソッドがフラットになってしまいます。これを何らかの基準で分離できれば状況は改善されるはずです。

膨れ上がったヘルパーを眺めていると、大半がモデルを引数に取るメソッドであることに気が付きます。思考実験として、モデルのインスタンスメソッドとしてこれらを定義してみてはどうでしょうか。

{% highlight text %}
{% raw %}
class User < ActiveRecord::Base
  ...

  def display_name
    nickname || name
  end
end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
%h1= @user.display_name
{% endraw %}
{% endhighlight %}


なかなか悪くありません。あるモデルに特有のプレゼンテーションロジックを自身に持たせるというのは発想として自然ですし、分離の基準としても明快です。

とはいえおもむろにモデルにメソッドを定義するのは乱暴に過ぎますので、Presenter または Decorator と呼ばれる種類のライブラリを使います。代表的な実装として [ActiveDecorator](https://github.com/amatsuda/active_decorator) や [Draper](https://github.com/drapergem/draper) があります。両者ともビューのコンテキストにおいてモデルにメソッドを追加する機能を持ちます (相違点については後述します)。

実際の利用イメージを ActiveDecorator の例で見てみます。モデルのクラス名 + Decorator という名前のモジュールを用意しておくと、モデルオブジェクトがビューに受け渡されるタイミングで自動的に extend され、モジュールに定義したメソッドが使えるようになります。

{% highlight text %}
{% raw %}
# app/decorators/user_decorator.rb

module UserDecorator
  def display_name
    nickname || name
  end
end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
%h1= @user.display_name
{% endraw %}
{% endhighlight %}


これにより、モデル特有のプレゼンテーションロジックはそれぞれモデルに対応するモジュールに分離できるようになりました。もうヘルパーメソッドの先頭にモデル名のプレフィックスを付けなくていいのです ;)

Draper も実現することは基本的には同じですが、方式に違いがあります。ActiveDecorator はモデルオブジェクトにモジュールを extend するのに対し、Draper はモデルオブジェクトをラップするオブジェクトを作ってメソッドを移譲します。Draper の方式ではメソッドを追加する前とした後でオブジェクトの identity が変化してしまうため、よくよく注意しないとハマります。

### コンポーネントフレームワークを導入する

パーシャルとそれに付随するロジックをどのように管理するかという問いに対して、ひとつの答えとなるのが [Cells](http://cells.rubyforge.org/) というフレームワークです。

Cells は大雑把に言うとパーシャルにコントローラをくっ付けたようなものです。先ほど例に挙げた「最近サインアップしたユーザの一覧を表示するパーシャル」を Cells に置き換えてみましょう。

{% highlight text %}
{% raw %}
# app/cells/recent_signed_up_users_cell.rb

class RecentSignedUpUsersCell < Cell::Rails
  def show
    @users = User.recent_signed_up.includes(:profile).order('created_at DESC')
  end
end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
-# app/cells/recent_signed_up_users/show.html.haml

%ul
  - @users.each do |user|
    %li= link_to user.profile.name, user_profile_path(user)
{% endraw %}
{% endhighlight %}


RecentSignedUpUsersCell はコントローラに相当するもので、cell と呼びます。定義した cell はパーシャルのように任意のビューから呼び出すことができます。

{% highlight text %}
{% raw %}
= render_cell :recent_signed_up_users, :show
{% endraw %}
{% endhighlight %}


これでパーシャルと付随するロジックをひとつの論理的なまとまりとして扱うことができるようになりました。

なお、Cells の姉妹品として [Apotomo](http://apotomo.de/) というフレームワークもあります。これは Cells を拡張してリクエストを受け取れるようにする野心的な試みなのですが、いかんせん野心的すぎて開発がストップしてしまっているようです。

### モデルのコードを関心事に沿って分割する

主要なモデルは大抵複数の機能を持っています。例えば QA@IT の Question (質問) モデルには、タグ付け・バージョン管理・vote (+1 / -1) などの様々な機能があります。これらをモデルにガシガシ書いていくと、あっという間に巨大なモデルができあがります。

ひとつの機能には、それを実現するためのメソッドはもちろん、association や validation、scope の定義などのコードが必要です。ベタに書くとこんな感じでしょうか。

{% highlight text %}
{% raw %}
class Question < ActiveRecord::Base
  # associations
  ...
  has_many :tags
  ...

  # scopes
  ...
  scope :tagged_with, ->(tag) { ... }
  ...

  # validations
  ...
  validates :tags, ...
  ...

  # methods
  ...
  def do_something_for_tagging
    ...
  end
  ...
end
{% endraw %}
{% endhighlight %}


タグ付けの機能を構成するコードが上から下まで散らばってしまっています。後から見たとき、どこからどこまでがひとつのまとまりなのか把握するのは難しいでしょう。

この問題に対するシンプルな改善策として、機能のまとまりをモジュールに分割してしまうのが効果的です。先ほどのコードを例にすると、こんな感じになります。

{% highlight text %}
{% raw %}
module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :tags
    scope :tagged_with, ->(tag) { ... }
    validates :tags, ...
  end

  def do_something_for_tagging
    ...
  end
end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
class Question < ActiveRecord::Base
  include Taggable
  ...
end
{% endraw %}
{% endhighlight %}


効果は一目瞭然ですね。

### インタラクションをオブジェクトにする

複数のモデルがやり取りをしてひとつの機能を構成するような場合、そのロジックはどこに置けばよいのでしょうか。「ユーザが商品を買う」というロジックはユーザと商品、どちらの責務だと思いますか？　 色々な考え方があると思いますが、私たちのチームでは「インタラクションをオブジェクトにする」という方法を取りました。[^1]

例えば、QA@IT には「質問者が有用と思った回答を accept する」という機能があります。これは以下のような一連のロジックで構成されています。

1. 事前条件をチェックする (ex. 回答を accept できるのは質問者だけ)
1. 回答を accept 済みとしてマークする
1. 質問者と回答者にレピュテーションを付与する (自分の回答を accept した場合は除く)
1. 質問者と回答者のイベントタイムラインに「accept した」「accept された」という情報を記録する


これを分解して各モデルに分散させるのではなく、「回答を accept する」というひとつのまとまりとして表現するためにはどうしたらよいかを考えた結果、以下のようになりました。コードそのものの説明は本筋ではないため割愛させていただきますが、上記のリストと比較していただければなんとなくご理解いただけるのではないでしょうか。

{% highlight text %}
{% raw %}
class AcceptAnswerActivity < AbstractActivity
  attribute :answer
  attribute :questioner

  validates_signin_of :questioner

  validate do
    errors.add :questioner, :accepter_should_questioner unless question.author?(questioner)
    errors.add :question,   :question_should_be_open    unless question.status.open?
  end

  def do_process
    question.accepted_answer = answer
    question.status = :solved
    question.save!

    if answer.author?(questioner)
      create_event :accept_answer,   question.author, answer, false
      create_event :answer_accepted, answer.author,   answer, false
    else
      repute :accept_answer,   question.author
      repute :answer_accepted, answer.author

      create_event :accept_answer,   question.author, answer, true
      create_event :answer_accepted, answer.author,   answer, true
    end
  end

  private

  def question
    answer.question
  end
end
{% endraw %}
{% endhighlight %}


ひとつの論理的なまとまりであるはずのロジックが様々な場所に分散していてわかりにくいと感じるようなら、このようなアプローチを試してみるといいかもしれません。

## まとめ

Rails のレールがまだ及んでいない real world problem に対して、私たちがどのように立ち向かってきたかをご紹介しました。

本稿で挙げた解決案はまだまだ不十分なものですし、他にも問題はいくらでもあると思います。本稿が問題を考えるきっかけとなれば幸いです。

## 著者について

浦嶌 啓太 ([ursm](http://coderwall.com/ursm))

(株)永和システムマネジメント サービスプロバイディング事業部チーフプログラマ。好きな Linux ディストリビューションは [Funtoo Linux](http://www.funtoo.org/)。

----

[^1]: そもそもの発想には DCI (Data Context Interaction) アーキテクチャの影響を強く受けていますが、実装にあたり原型を留めないほどアレンジしているので、共通点はほぼないものと考えてください。
