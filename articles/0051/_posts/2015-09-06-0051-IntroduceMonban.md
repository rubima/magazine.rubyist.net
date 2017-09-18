---
layout: post
title: Monban どうでしょう
short_title: Monban どうでしょう
tags: 0051 IntroduceMonban
---


* Table of content
{:toc}


書いた人 : kbaba1001 さん

## はじめに

はじめまして。 kbaba1001 と申します。
Ruby on Rails を用いた受託開発を主な仕事としています。

今回は [Monban](https://github.com/halogenandtoast/monban) という gem を紹介したいと思います。

Monban は Ruby on Rails で認証機能を作るための gem です。
同系統の gem として [Devise](https://github.com/plataformatec/devise) や [Sorcery](https://github.com/NoamB/sorcery) があります。
Monban の README では次の 3 点の特徴を挙げています。

* 依存性の注入を利用することでテストしやすくする
* 便利な Controller Helpers を提供する
* カスタマイズしやすい


一方で次の 3 点は行わないことになっています。

* routes を自動的に追加しない
* Rails Engine ベースの Controller や View を強制しない
* User Model の変更を強制しない


Devise は Rails Engine を利用しているため導入するだけで多くの機能を使えるようになりますが、カスタマイズを行うとコードが汚くなりやすいというデメリットがあります。

Monban では少数の public メソッドを Controller Helpers として提供し、これらのメソッドの実装をサービス層で行うことでカスタマイズしやすくなっています。
セッションの操作には Devise と同様に [Warden](https://github.com/hassox/warden) を利用しているため、
Devise をカスタマイズしたことがある人であれば Warden の知識を使うことができます。

また、[Monban::Generators](https://github.com/halogenandtoast/monban-generators) という gem を使うことで
Monban を利用した認証機能を Scaffold により作成することができるため、 Sorcery と比べて導入しやすくなっています。

## Monban を導入する

実際に Rails アプリケーションを作りながら Monban による基本的な認証機能を実装する方法について説明します。
まず _rails new_ します。

```
$ rails new sample

```

_Gemfile_ に次の行を追加します。

```ruby
gem 'monban'
gem 'monban-generators'

```

_monban-generators_ は必須ではありませんが、 Monban を利用した認証機能を Scaffold で作成するための gem なので、 Monban の導入が楽になります。

### 簡単な認証機能の実装

次のコマンドを実行して認証機能を生成します。

```
$ rails g monban:scaffold
       route  resources :users, only: [:new, :create]
       route  resource :session, only: [:new, :create, :destroy]
      create  app/views/users/new.html.erb
      create  app/views/sessions/new.html.erb
      create  app/controllers/sessions_controller.rb
      create  app/controllers/users_controller.rb
      insert  app/controllers/application_controller.rb
      create  app/models/user.rb
      create  db/migrate/20150720120736_create_users.rb
      create  config/locales/monban.en.yml

    Final Steps
    run:
      rake db:migrate

```

生成されたファイルについて説明します。

まず、_app/controllers/application_controller.rb_ を開くと、次のように _include Monban::ControllerHelpers_ が追加されています。

```
class ApplicationController < ActionController::Base
+  include Monban::ControllerHelpers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end

```

_Monban::ControllerHelpers_ には次のメソッドが定義されています。

* Controller メソッド
  * sign_in(user)
  * sign_out
  * sign_up(user_params)
  * authenticate(user, password)
  * authenticate_session(session_params)
  * reset_password(user, password)
* Helper メソッド
  * current_user
  * signed_in?
* filter メソッド
  * require_login


他のコントローラではこれらのメソッドを使って認証機能を実装します。
例えば _app/controllers/users_controller.rb_ では次のようにサインアップ機能を実装しています。

```ruby
class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params)

    if @user.valid?
      sign_in(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

```

_create_ メソッド内では _Monban::ControllerHelpers_ が提供する _sign_up_ と _sign_in_ メソッドに認証関係の処理を任せています。
これにより _create_ メソッドでは HTTP リクエストを受け取ってレスポンスを返すことに集中しています。
コントローラとビジネスロジックが切り離されているのでメンテナンスしやすくなっています。

### 拡張の方法

_Monban::ControllerHelpers_ が提供しているメソッドはビジネスロジックと切り離されています。
例えば _Monban::ControllerHelpers#sign_up_ は次のように実装されています。

```ruby
module Monban
  module ControllerHelpers
    # Sign up a user
    #
    # @note Uses the {Monban::Services::SignUp} service to create a user
    #
    # @param user_params [Hash] params containing lookup and token fields
    # @yield Yields to the block if the user is signed up successfully
    # @return [Object] returns the value from calling perform on the {Monban::Services::SignUp} service
    def sign_up user_params
      Monban.config.sign_up_service.new(user_params).perform.tap do |status|
        if status && block_given?
          yield
        end
      end
    end

# 後略

```

_Monban::ControllerHelpers#sign_up_ では _Monban.config.sign_up_service_ が返すクラスを _new_ して _perform_ メソッドを呼び出しています。
_perform_ の戻り値についてはコメントで _Object_ を返すように指示されています。

つまり、_Monban.config.sign_up_service_ は次の条件を満たせばどのように実装しても良いということになります。

* _initialize_ の引数として _user_params_ をとること
* _perform_ メソッドを実装していること
* _perform_ メソッドは何かしらの _Object_ を返すこと


_Monban.config.sign_up_service_ はデフォルトでは _Monban::Services::SignUp_ が設定されています。
_Monban::Services::SignUp_ は monban 中の _/lib/monban/services/sign_up.rb_ で次のように定義されています。

```ruby
module Monban
  module Services
    # Sign up service. Signs the user up
    # @since 0.0.15
    class SignUp
      # Initialize service
      #
      # @param user_params [Hash] A hash of user credentials. Should contain the lookup and token fields
      def initialize user_params
        digested_token = token_digest(user_params)
        @user_params = user_params.
          except(token_field).
          merge(token_store_field.to_sym => digested_token)
      end

      # Performs the service
      # @see Monban::Configuration.default_creation_method
      def perform
        Monban.config.creation_method.call(@user_params.to_hash)
      end

      private

      def token_digest(user_params)
        undigested_token = user_params[token_field]
        unless undigested_token.blank?
          Monban.hash_token(undigested_token)
        end
      end

      def token_store_field
        Monban.config.user_token_store_field
      end

      def token_field
        Monban.config.user_token_field
      end
    end
  end
end

```

_initialize_ では引数に _user_params_ を受け取って、 _password_ をハッシュ化して _@user_params_ に代入します。
_perform_ メソッドでは _@user_params_ から _User_ を create してオブジェクトを返します。
これにより _Monban::ControllerHelpers#sign_up_ が _Monban.config.sign_up_service_ に期待する振る舞いを満たしていることがわかります。

もし _Monban.config.sign_up_service_ を _Monban::Services::SignUp_ 以外にしたい場合、 _config/initializers/monban.rb_ を作成して、次のように設定します。

```ruby
Monban.configure do |config|
  config.sign_up_service = MySignUp
end

```

_MySignUp_ クラスを独自に作成すれば、 _Monban::ControllerHelpers#sign_up_ を実行した際に呼び出されます。
これにより _app/controllers/users_controller.rb_ を変更することなくサインアップに関する機能を変更することができます。

### 拡張の例

拡張の例として、サインアップ時に「パスワードの確認」を入力できるようにしてみましょう。
_rails g monban:scaffold_ で作成されたサインアップ機能では、email アドレスとパスワードを 1 度入力するだけなので、 2 度入力できるようにします。

まず View を変更します。 _app/views/users/new.html.haml_ に _password_confirmation_ を入力するフォームを追加します。

```
= form_for @user do |form|
  - if @user.errors.any?
    = pluralize(@user.errors.count, "error")
    prevented your account from being created:
    %ul
      - @user.errors.full_messages.each do |error_message|
        %li= error_message
  %div
    = form.label :email
    = form.email_field :email
  %div
    = form.label :password
    = form.password_field :password
+  %div
+    = form.label :password_confirmation
+    = form.password_field :password_confirmation
  %div
    = form.submit "Sign up"

```

次に、モデルを拡張します。現在、 _users_ テーブルのスキーマは下記のようになっています。

```ruby
create_table "users", force: :cascade do |t|
  t.string   "email",           null: false
  t.string   "password_digest", null: false
  t.datetime "created_at",      null: false
  t.datetime "updated_at",      null: false
end

```

データベースには _password_digest_ を書き込めれば良いので、スキーマは変更せずに _app/models/user.rb_ を下記のように書き換えます。

```
class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

+  attr_accessor :password, :password_confirmation
+  validates_presence_of :password, :password_confirmation
+  validates_confirmation_of :password
end

```

_app/controllers/users/users_controller.rb_ の Strong Parameters で _password_confirmation_ を受け入れるようにします。

```
class Users::UsersController < Users::ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params)

    if @user.valid?
      sign_in(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
-    params.require(:user).permit(:email, :password)
+    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

```

上記のコントローラの _create_ 部分からわかるように、サインアップに関するビジネスロジックは _sign_up_ メソッドに切り出されています。
これは前節で説明したとおり _Monban.config.sign_up_service_ に設定したクラスに処理を委譲します。
_/config/initializers/monban.rb_ で独自のクラスを使うように設定します。

```ruby
require Rails.root.join('app/services/sign_up')

Monban.configure do |config|
  config.sign_up_service = Services::SignUp
end

```

_app/services/sign_up.rb_ というファイルを次の内容で作成します。

```ruby
# app/services/sign_up.rb
module Services
  class SignUp
    def initialize(user_params)
      @user_params = user_params
    end

    def perform
      User.new(@user_params) {|user|
        user.update(password_digest: Monban.hash_token(@user_params[:password])) if user.valid?
      }
    end
  end
end

```

_perform_ メソッドでは _User_ モデルでパラメータの妥当性を検証した後、
_params_ の _password_ の値を _Monban.hash_token_ によりハッシュ化して
_password_digest_ カラムに書き込みます。

これは _Monban.config.sign_up_service_ として求められるインタフェースを満たしています。
そのため、 _UsersController#create_ を変更する必要はありません。

以上により、パスワードの確認機能が使えるようになりました。
サインアップ機能がコントローラから切り離されているため、コントローラをほぼ変更する必要がありませんでした。
また、 Monban の機能を上書きするのではなく置き換えることで拡張しているので、無理のない実装となりました。

## おわりに

さて、簡単ではありますが Monban を用いた認証機能の導入と拡張方法について説明しました。
私の経験上、認証機能はサービスによって独自の仕様が必要となるケースが多く、拡張しやすい gem の方がメンテナンス性が良いと考えています。
Monban は手軽さと拡張性のバランスが取れた軽量の gem として使いやすいと感じています。
また、 Monban の拡張は上書きではなく置き換えにより行うことが多いので、 Monban の想定を超える拡張が必要な場合には Monban を捨てて独自に実装するという手段もあります。

もし、認証関係の gem を選定する機会があれば Monban を候補として検討してみてはいかがでしょうか。


