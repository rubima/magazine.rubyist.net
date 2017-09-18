---
layout: post
title: Jeweler で作る Rails 用 RubyGems パッケージとそのテストについて
short_title: Jeweler で作る Rails 用 RubyGems パッケージとそのテストについて
tags: 0037 CreateRailsPlugin
---


* Table of content
{:toc}


書いた人 : 山本 和久

## はじめに

こんにちは。皆さん RubyGems 使ってますか？ RubyGems パッケージは使うだけではなく自分で作ったものを公開することができるプラットフォームです。
今回は Jeweler を使った RubyGems パッケージの作り方と、私が初めて作った Rails 用パッケージを題材にしたテストの書き方についてお話したいと思います。

## RubyGemsとは

RubyGems は Ruby のパッケージ管理システムです。RubyGems が構築された経緯や使い方についてはすでにるびまの記事としてまとめられています。

{% for post in site.tags.PackageManagement %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}

Ruby のライブラリは gem 形式のファイルとしてパッケージ化することができます。このパッケージを集約しているのが RubyGems というサイトで、簡単に検索やインストールを行うことができます。また、 Rails3 系から標準採用された Bundler[^1] という仕組みを利用すればバージョン間の依存を考慮したインストールおよびアップデートを行うことができます。

## Jeweler について

Jeweler とは、RubyGems 作成支援のツールであり RubyGems の作成を簡単にしてくれます。
下記のような機能があります。

* パッケージのひな形の作成
* github へのソースの登録
* RubyGems への公開
* 公開したパッケージの更新


ここでは順を追って操作を説明します。

### インストール

Jeweler をインストールします。Jeweler 自体も RubyGems で配布されています。

{% highlight text %}
{% raw %}
$ gem install jeweler
{% endraw %}
{% endhighlight %}


### パッケージのひな形作成

新しいパッケージのひな形を jeweler コマンドで作成します。

{% highlight text %}
{% raw %}
$ jeweler --rspec --create-repo hoge
{% endraw %}
{% endhighlight %}


hoge の部分がパッケージ名です。先に rubygems.org で自分が作ろうとしているパッケージ名[^2]が先に登録されていないか確認しておきましょう。

#### オプション

* --rspec


テストフレームワークに rspec を使用します。rspec は Ruby のプロダクトで最も多く使用されているテストツールです。上記のコマンドでは rspec を選択しています。

* --shoulda


テストフレームワークに shoulda を使用します。should は Test::Unit を拡張して rspec 的に書くことができるようにしたものです。他にもお好みで bacon , testspec , minitest , micronaut , riot , shind , cucumber などのテストフレームワークを使用することができます。

* --reek


reek をインストールします。reek は大きなクラスやふさわしく無い名前など「読みやすい」コードであるかチェックを行うことができます。

* --create-repo


github にリポジトリを作成します。 ~/.gitconfig に github の設定が行われている必要があります。

#### github の確認

今回のコマンドでは --create-repo を指定しているので、この時点で github にログインすると指定したパッケージ名でリポジトリが作成されていることを確認できます。

#### ひな形の確認

現時点で次の内容でファイルが作成されていることが確認できます。

{% highlight text %}
{% raw %}
hoge
├── Gemfile
├── LICENSE.txt
├── README.rdoc
├── Rakefile
├── lib
│   └── hoge.rb
└── spec
   ├── hoge_spec.rb
   └── spec_helper.rb
{% endraw %}
{% endhighlight %}


### プログラムの作成

lib/hoge.rb にプログラムを記述します。一つのファイルで収まらない場合は lib フォルダ以下にパッケージ名のディレクトリを作成して、その中に関連ファイルを置くと良いでしょう。

{% highlight text %}
{% raw %}
├── lib
│   ├── hoge
│   │   ├── lib1.rb
│   │   ├── lib2.rb
│   │   └── lib3.rb
│   └── hoge.rb
{% endraw %}
{% endhighlight %}


### 公開準備

まず VERSION ファイルを作成します。

{% highlight text %}
{% raw %}
$ rake version:write
{% endraw %}
{% endhighlight %}


公開前にマイナーバージョンを上げておきましょう。

{% highlight text %}
{% raw %}
$ rake version:bump:minor
{% endraw %}
{% endhighlight %}


Jeweler によって作成された Rakefile を使用してパッケージをビルドしてみます。

{% highlight text %}
{% raw %}
$ rake build
rake aborted!
"FIXME" or "TODO" is not a description
{% endraw %}
{% endhighlight %}


おや？エラーメッセージが表示されました。Rakefile に最低限必要な情報を記述しましょう。
次の TODO の箇所を修正します。

```ruby
  gem.summary = %Q{TODO: one-line summary of your gem}
  gem.description = %Q{TODO: longer description of your gem}

```

{% highlight text %}
{% raw %}
$ rake build
  Successfully built RubyGem
  Name: hoge
  Version: 0.1.0
  File: hoge-0.1.0.gem
{% endraw %}
{% endhighlight %}


今度は作成されました。

今の状態で一旦 commit して github に push しておきましょう。

{% highlight text %}
{% raw %}
$ git add .
$ git commit -m "create new library."
$ git push origin master
{% endraw %}
{% endhighlight %}


### 公開

ここまでできたら RubyGems に公開することができます。
次のコマンドで公開しましょう。[^3]

{% highlight text %}
{% raw %}
$ rake release
{% endraw %}
{% endhighlight %}


実際に rubygems.org に公開されるのはしばらく時間がかかるという人が多いですが、私の場合はすぐに公開されました。
リリースする時間帯にもよると思いますので、焦らずしばらく待ってみましょう。

### テスト

テストコードはプログラムの動作を保証すると共に、仕様を明確にする目的があります。RubyGems を公開する際にはテストコードを添付するべきです。
さて、小規模なライブラリの場合はテストコードの記述も容易です。

例：

```ruby
# jp_yen.rb
class Fixnum
  def yen
    "#{self.to_s}yen"
  end
end


```


```ruby
# jp_yen_spec.rb
require 'rspec'
require './jp_yen'

describe "JpYen" do
  it "Checks that a yen is displayed" do
    10.yen.should == "10yen"
  end
end


```

{% highlight text %}
{% raw %}
$ rspec jp_yen_spec
.

Finished in 0.46084 seconds
1 example, 0 failures
{% endraw %}
{% endhighlight %}


しかし、多くの RubyGems パッケージは他のライブラリ、もしくは Ruby on Rails のようなフレームワークに依存しています。
ここでは Ruby on Rails で使用するための RubyGems パッケージのテスト方法を、私が作成した need_label を例にとって説明してみたいと思います。

## need_label

私が作成した need_label は view のラベル項目に class 属性を出力する単純なものです。Ruby on Rails では Model の項目に必須入力のバリデーションを設定することができます。フォームで何も入力せずに登録しようとするとエラーが発生するのですが、登録してみるまでその項目が必須であるかどうかは分かりません。世の中の多くの入力フォームが実現しているような「必須入力マーク」は自分で View に設定する必要があります。need_label を導入することで自動的に必須入力項目にマークを表示させることができます。

### ソースのダウンロード

ソースは github からダウンロードすることができます。

[https://github.com/kazuhisa/need_label](https://github.com/kazuhisa/need_label)

### ライブラリの解説

```ruby
# lib/need_label/helpers.rb
# -*- coding: utf-8 -*-

module ActionView
  module Helpers
    module FormHelper
      def need_label(object_name, object, method, content_or_options = nil, options = nil, &block)
        need = true
        if content_or_options.class == Hash && content_or_options[:need_label] == false
          need = false
          content_or_options.delete(:need_label)
          content_or_options = nil if content_or_options == {}
        end
        need = false if options.class == Hash && options[:need_label] == false
        if need && object.present? && object.class.respond_to?(:validators)
          need_attributes = object.class.validators.
            select{|e| e.is_a? ActiveModel::Validations::PresenceValidator}.map{|e| e.attributes[0]}
          if need_attributes.index(method.to_sym)
            if content_or_options.present? && content_or_options.class == Hash && content_or_options[:class].present?
              content_or_options[:class] = content_or_options[:class] + " need-label"
            else
              options[:class] = "need-label"
            end
          end
        end
        label(object_name, method, content_or_options, options, &block)
      end
    end

    class FormBuilder
      def label(method, text = nil, options = {}, &block)
        if @object_name.class == Symbol
          @object = @template.instance_variable_get("@#{@object_name}")
        end
        @template.need_label(@object_name, @object, method, text, objectify_options(options), &block)
      end
    end
  end
end


```

まず ActionView::Helpers::FormBuilder#label に手を加えて、標準の label メソッドではなく need_label メソッドを呼び出すように変更しています。
ActionView::Helpers::FormHelper#need_label で関連する Model の項目が必須入力に設定されていれば need-label というクラスを追加する仕様です。
ただし、option に :need_label =&gt; false と設定されていればこの限りではありません。

### テストの手法

いざテストを書こうとして、どうやって環境を作るべきか非常に困りました。need_label は ActionView::Helpers::FormHelper をフックしています。そして Model 内で :presence =&gt; true と設定している項目のラベルに need-label というクラス属性を出力するという仕様です。View と Model が登場するためテストのために Rails を導入するのが手っ取り早いのですが、それではあまりにも大掛かりです。プロダクトコードに関係する最低限のコードで「Rails のようなもの」を構築するにはどうすればよいのでしょうか？

### 参考元を探して

困った私は似たような機能を持つ Gem のソースを片っ端からダウンロードしてテストコードを見てみました。しかしなかなかシンプルなものが見つかりません。Model と View が関係しそうな Gem といえば、取得したレコードに応じたページ数を表示するページネーションが思い当たりました。初めは will_pagenate[^4] を、そしてページネーションなら「amatsuda[^5] さんが作られた kaminari[^6] がいいよ」という知人からのアドバイスもあり、ソースを確認してみたところシンプルで良い感じなので参考にさせて頂きました。

### テストコードについて

kaminari のテストに習い spec/fake_app.rb に Rails で必要な機能を設定しています。テストフレームワークは rspec を使用してエンドツーエンドテストを行なっています。

```ruby
# spec/fake_app.rb

# -*- coding: utf-8 -*-
require 'active_record'
require 'action_controller/railtie'
require 'action_view/helpers'
require 'need_label'

# database
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'\}\}
ActiveRecord::Base.establish_connection('test')

# config
app = Class.new(Rails::Application)
app.config.secret_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
app.config.session_store :cookie_store, :key => "_myapp_session"
app.config.active_support.deprecation = :log
app.initialize!

# routes
app.routes.draw do
  resources :users
end

# models
class User < ActiveRecord::Base
  validates :name, :presence => true
end

# controllers
class ApplicationController < ActionController::Base; end

# helpers
Object.const_set(:ApplicationHelper, Module.new)

#migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:users) {|t| t.string :name; t.integer :age}
  end
end

```

テスト用に name と age という項目が設定された User モデルが作成されており、name が必須項目に設定されていることに注目してください。

テスト本体は spec/requests/need_label_spec.rb に記述されています。

```ruby
# spec/requests/need_label_spec.rb

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "output need-label class" do
  describe "instance variable type without options" do
    before do
      class UsersController < ApplicationController
        def new
          @user = User.new
          render :inline => <<-ERB
          <%= form_for @user do |f| %>
            <%= f.label :name %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit "/users/new"
    end
    it "It checks that need-label is outputted." do
      page.has_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
    end
    it "It checks that need-label is not outputted." do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

##(略)##

end


```

様々なパターンで View を定義してレンダリングすることで、name と age にどのような class が出力されているかを確認しています。

## まとめ

Jeweler を使用すると容易に RubyGems パッケージが作成できることが分かりました。しかし、テストの手法については作成するパッケージの種類よって多様です。
さらに RubyGems パッケージのテストについて記述されたドキュメントが少ないのもテストが書きづらい要因になっています。
困ったときは自分が作ろうとしているパッケージの機能に似ているものを探して、積極的にテスト手法を参考にするのが良いと思います。
そのためには Ruby をとりまくパッケージの情報にアンテナを張って積極的に情報収集していきましょう。

## 著者について

山本 和久([@kazuhisa1976](http://twitter.com/kazuhisa1976))

岡山 Ruby / Ruby on Rails 勉強会のスタッフの一人。仕事は Ruby on Rails を使用した Web サービスの作成。

35 歳にして最近バイクの免許を取りたいと思ってる。
----

[^1]: Jewelerを使用せずBundlerを使用してパッケージを作成し、gem pushコマンドでRubyGemsへパッケージを公開することもできます。
https://github.com/carlhuda/bundler
http://guides.rubygems.org/command-reference/#gem_push
[^2]: 特に命名規約は無いようですが単語の区切りは_(アンダーバー)で行い、◯◯の Ruby 版などの場合は最後に -ruby を付けるのが良いようです。http://kyow.cocolog-nifty.com/blog/2010/12/rubygems-d629.html
[^3]: 誤って公開してしまったgemはgemcutterを使用して削除しましょう。使い方は次のFAQに記述されています。http://help.rubygems.org/kb/gemcutter/removing-a-published-rubygem
$ gem update --system
$ gem install gemcutter
$ gem yank hoge -v 0.1.0 #必ずバージョンを指定すること
[^4]: Railsで古くから使用されているページネーション。https://github.com/mislav/will_paginate

[^5]: 今号のインタビュー記事 [[0037-Hotlinks]] に出ておられます
[^6]: Rails3.1やmongoidにも対応している最近話題のページネーション。https://github.com/amatsuda/kaminari
