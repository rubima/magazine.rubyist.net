---
layout: post
title: AWS Lambdaで作るサーバーレス Mastodon Bot
short_title: AWS Lambdaで作るサーバーレス Mastodon Bot
tags: 0060
post_author: S.H.
created_on: 2019年8月18日
---
{% include base.html %}

## はじめに

みなさん、こんにちは。
普段は[Creatodon](https://gamelinks007.net)というMastodonサーバーの管理人をしています、S.H.と申します。

今回は、下記のイベントで寄稿した記事に加筆したものをるびまにも寄稿させて頂きました。

[分散SNS萬本執筆・販売　執筆者募集中です（公募型アンソロジー）](https://connpass.com/event/115011/)

今回書くものは、以前「#顔面工事」というハッシュタグを拡散するBotを作った際に得たノウハウをまとめたものになります。
下記のリポジトリを見つつ、読み進めるとより楽しめると思います。

[S-H-GAMELINKS/face_under_construction](https://github.com/S-H-GAMELINKS/face_under_construction)

## 環境

本記事では、以下の環境にてBotを作成しました。

* OS : Windows 10 Pro(WSL/Ubuntu 18.04)
* Ruby : 2.5.5
* エディタ : VSCode 1.36.0

AWS Lambda のRubyランタイムのバージョンが2.5なので、Rubyの2.5系列がインストールされていれば問題ありません。

## Mastodonとは？

[Mastodon](https://github.com/tootsuite/mastodon)とは分散SNSと呼ばれるものの一つになります。
数年前に日本でもMastodonブームが来たこともあり、ご存知の方もおられるかと思います。

実装としてはバックエンドにRails、フロントエンドにReactが使用されています。
Dockerイメージも公開されており手軽にサーバーを構築できます。

Mastodonなどの分散SNSの魅力は自分でTwitterのようなSNSサービスを立ち上げ、運営することができる点です。
自分のサーバーを構築すればアカウントの凍結などを気にする必要もないですし、

MastodonではActivityPubというプロトコルを使い、他なサーバーとやり取りをすることができます。
その為、別のサーバーのアカウントをフォローできますし、つぶやきなどを見ることもできます。

また他な分散SNSともやり取りをすることができます。
他な分散SNSには[Pleroma](https://git.pleroma.social/pleroma/pleroma)や[Misskey](https://github.com/syuilo/misskey)といったものがあります。それらの分散SNSもActivityPubを使用しています。
その為、それらと相互にフォローしたり、つぶやきをお気に入りしたりということができます。
分かりやすく言えば、TwitterとFacebookで互いにやり取りができるという状態ですね。

ちなみに、海外のRubyistが[ruby.social](https://ruby.social)というRubyistのためのサーバーを公開しています。
興味のある方はアカウントを作成してみてはいかがでしょうか？

## AWS Lambdaとは？

ご存知の方も多いとは思いますが、念のため[AWS Lambda](https://aws.amazon.com/jp/lambda/)について少し解説します。

AWS LambdaとはAmazonが提供しているサービスの一つで、サーバーを意識しなくてもコードを実行する環境を提供するサービスです。
そのためコードを書くことに集中できますし、コードを気軽に本番環境で動かすことができます。

また、AWS Lambdaはコードを実行した分だけの課金となっています。その為、Botなどで定期的にコードを実行するものを作成する際には非常に低コストで済みます。

## BotをRubyで作成

それでは、AWS LaambdaでMastodonのハッシュタグをブーストするBotを作っていきます。

なお、AWSへのアカウント作成などは省略させていただきます。

### まずは AWS LambdaでHello World!

まず、AWS にログインし、サービスの検索欄から Lambdaを検索します。

![lambdaの検索]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_00.png)


Lambdaの管理画面に移動して、**関数の作成**と書かれているボタンを選択します。


![lambdaの管理画面]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_01.png)

その後、関数作成のフロー画面に移動します。


![関数作成画面]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_02.png)

**関数名**などを以下のように入力してください。

* 関数名：bot
* ランタイム： Ruby 2.5

入力後、**関数の作成**をクリックして、関数を作成します。これでAWS Lambdaに関数が作成されます。


![関数作成後の画面]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_03.png)

関数が作成されると画面が遷移します。遷移後の画面をスクロールすると、**関数コード**という項目でエディタ画面が見つかります。


![関数コードの画面]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_04.png)

そこには既に以下のようなコードが作成されています。



```ruby
require 'json'

def lambda_handler(event:, context:)
    # TODO implement
    { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
```

**Hello from Lambda!**の部分を**Hello World!**に修正してください。その後、画面上部にある**テスト**をクリックします。

新しいテストの作成画面が表示されますので、**イベント名**に**helloworld**と入力します。あとは**作成**をクリックし、テストを作成します。


![テスト作成画面]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_05.png)

最後に、再び画面上部にある**テスト**をクリックします。すると、先ほど作成したテストが実行され、実行結果がログとして表示されます。


![テスト実行時のログ]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_06.png)

### MastodonインスタンスでBotのアカウントを作成

Botを作成したいMastodonインスタンスにてBot用のアカウントを作成しましょう。

作成後、**ユーザー設定**を開きます。


![ユーザー設定を選択]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_07.png)

**開発**タブをクリックします。

![開発を選択]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_08.png)

**新規アプリ**を作成します

![新規アプリを選択]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_09.png)

新規で作成するアプリの情報などを記入していきます。

![アプリの情報入力]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_10.png)

入力後、**送信**をクリックします。

![送信を押してアプリを作成]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_11.png)

これで新しいアプリが作成されます。

新しく作成した**アプリ**をクリックします。

![作成したアプリへのリンクをクリック]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_12.png)

**アクセストークン**を取得します。

![アクセストークンを取得]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_13.png)

以上でMastodon側での設定は完了です。

### RubyでBotのコーディング

それでは、Botのコードを書いていきます。

まずは、以下のように**Gemfile**を作成します。


```ruby

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Using Mastodon API
gem 'mastodon-api', '1.1.0'

```

次に、以下のように**bot.rb**を作成します。

```ruby
load_paths = Dir["/vendor/bundle/ruby/2.5.0/gems/2.5.0/**/lib"]
$LOAD_PATH.unshift(*load_paths)

require "mastodon"

def lambda_handler(event:, context:)

  client = Mastodon::REST::Client.new(base_url: URL, bearer_token: ACCESS_TOKEN)

    client.hashtag_timeline(HASH_TAG).each do |toot|
        if !toot.reblogged? then
          response = client.reblog(toot.id)
          response = client.favourite(toot.id)
        end
    end
end
```

実は、ハッシュタグをブーストするBotはたったこれだけのコードで実装できます。それではコードの内容を解説していきましょう。

まず、最初の二行で外部ライブラリを読み込むためのパスを設定しています。

```ruby
load_paths = Dir["/vendor/bundle/ruby/2.5.0/gems/2.5.0/**/lib"]
$LOAD_PATH.unshift(*load_paths)
```

AWS Lambdaではbundlerを使っての外部ライブラリ使用ができません。そのため、ローカルのディレクトリ内にライブラリのファイルを配置する必要があり、上記のコードで読込先を指定しています。

次に、requireを使ってライブラリを読み込みます。

```ruby
require 'mastodon'
```

その後、以下のように lambda_handlerというメソッドを定義します。

```ruby
def lambda_handler(event:, context:)

  client = Mastodon::REST::Client.new(base_url: URL, bearer_token: ACCESS_TOKEN)

    client.hashtag_timeline(HASH_TAG).each do |toot|
        if !toot.reblogged? then
          response = client.reblog(toot.id)
          response = client.favourite(toot.id)
        end
    end
end
```

アクセストークンとインスタンスのURLを使い、Botへのアクセスができるようにします。その後、hashtag_timelineというメソッドにブーストしたいハッシュタグを引数として渡します(ex: "顔面工事")

すると、指定のハッシュタグをもつ投稿を取得できます。それをeachメソッドで一つずつ繰り返し、既にブースト済みかを判定してからブーストします。


### AWS lambdaへデプロイ

それでは作成したBotを AWS Lambdaへとデプロイしていきます。

まず、ターミナルで bundle install --deployment を実行します。

```shell
bundle install --path vendor/bundle
```

実行すると、vendorディレクトリが作成されます。そこに、使用するライブラリのファイルが配置されています。

あとは、bot.rb、vendorディレクトリをzip形式で圧縮します。

AWS Lamndaの先ほど作成したbot関数の画面を開きます。**関数コード**の項目内に、**コードエントリタイプ**というものがあります。


![コードエントリ]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_14.png)

**コードエントリタイプ**で**zipファイルをアップロード**を選択します。**アップロード**をクリックし、先ほど作成したzipファイルをアップロードします。


![ZIPファイルのアップロード]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_15.png)

その後、ハンドラを bot.lambda_handlerに書き換えて保存します。


![ハンドラの書き換え]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_16.png)

次に、**トリガーを追加**という項目がありますので、それを選択します。トリガーの追加画面に切り替わります。


![トリガーを追加をクリック]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_17.png)

トリガーには**Cloud Watch Events**を使用します。

![トリガーの検索画面]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_18.png)

**Cloud Watch**と入力すると以下のように検索結果に表示されます。

![Cloud Watch Eventsを選択]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_19.png)

**Cloud Watch**を選択し、**ルール**の部分をクリックして新しいルールを作成します。

![新規ルールの作成]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_20.png)

新しいルールは以下のようにします。

* ルール名：bot
* ルールの説明：Mastodon Bot用の定期スケジュール
* ルールタイプ：スケジュール式
* スケジュール式下の空欄：rate(1 hour)

![新規ルールを入力していく]({{base}}{{site.baseurl}}/images/0060-AWS-Lambda-Mastodon-Bot/lambda_21.png)

各項目を入力後、**追加**をクリックします。

これで AWS LambdaへBoをデプロイできました！


## おわりに

本記事では AWS Lambda を使ったMastodon Botの作成について解説を行いました。

意外と簡単に定期実行のBotは作成できますので、皆さんも是非Botを作成してみてください。

## 著者について

S.H. (平岡 瞬) Mastodon: [@S_H_](https://gamelinks007.net/@S_H_) blog: [ゲームリンクスの徒然なる日常](https://gamelinks007.hatenablog.com/) GitHub: [S-H-GAMELINKS](https://github.com/S-H-GAMELINKS)

RubyとC++が好きな人。株式会社侍にてRailsとか教えています。
趣味でMastodonの周辺サービスとか色々やってます。