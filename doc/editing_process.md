# 主に進行役のためのチートシート

- issue つくる
- 執筆者へ日程確認
- 記事申込・概要締切
- 記事目次・アウトライン締切
- 記事締切
- 執筆者の確認
- レビュー (詳細は下記)
- リリース (詳細は下記)
- 執筆者へ案内と御礼のメール
- リリースの案内
  - [ruby-list メーリングリスト](https://ml.ruby-lang.org/archives/list/ruby-list@ml.ruby-lang.org/)
  - [ruby-jp Slack](https://ruby-jp.github.io) の #general チャンネル
  - [@ruby-no-kai](https://x.com/rubynokai)
- 読者プレゼント抽選タスク
  - 抽選
  - 当選案内
  - 抽選結果の更新
  - 出版社さんへの発送のお願い

# レビュー

執筆者からレビュー可能な状態になったと知らせがあれば、レビューを始めます。変更の必要な点があれば、執筆者に変更を依頼するか、軽微な変更で編集者がプルリクエスト元のレポジトリへの書き込み権限を持っている場合は直接変更します。

下記のような手順で、ビルドされた状態の記事を手元のブラウザで確認することができます。

## 新しい記事のブランチを取得してそこに移動する

初めての場合は、るびまのレポジトリを取得します。

```
$ git clone git@github.com:rubima/magazine.rubyist.net.git
$ cd magazine.rubyist.net
```

2度目以降の場合は、手元のレポジトリを更新します。

```
$ cd magazine.rubyist.net
$ git switch master
$ git pull
```

プルリクエスト元のブランチを取得します。下記では、GitHubの`example`アカウントの`newarticle`ブランチからプルリクエストが来ていると仮定しています。実際の作業時には適宜読み替えてください。

```
$ git remote add example https://github.com/example/magazine.rubyist.net.git
$ git fetch example newarticle
$ git switch newarticle
```

## 新しい記事のパスを推定する

新しい記事 (手元のブランチにはあるけれど公開されていない記事) を手元で閲覧する時のURLを、上記の作業をしたディレクトリで下記のように推定することができます。

```
$ bundle install
$ bundle exec jekyll build --future
$ ruby script/show_new_pages.rb --base http://localhost:4000
New pages:
http://localhost:4000/articles/1234/1234-NewArticle.html
```

## るびまlintをかける

原稿がるびまの[編集方針](https://github.com/rubima/magazine.rubyist.net/blob/master/doc/editing_policy.md)に従っているか、基本的な確認やオートコレクトをすることができます。新しい記事について、下記のように懸念のある項目を指摘してもらったり、

```
$ ./editing_tools/rubima-lint.rb articles/1234/_posts/2026-04-15-1234-NewArticle.md
```

下記のように自動的に修正可能な項目を修正しもらったりできます。

```
$ ./editing_tools/rubima-lint.rb -a articles/1234/_posts/2026-04-15-1234-NewArticle.md
```

## 原稿を編集しながら新しい記事を閲覧する

上記の作業をしたディレクトリで下記のコマンドを実行することで、上記で得られたURLから記事を閲覧できます。コマンドはCtrl-Cなどで停止します。

```
$ bundle install
$ bundle exec jekyll serve -I --future
```

# リリース

個別の記事や新しい号数で公開する記事が公開可能になったらリリースします。下記の手順で `master` ブランチに merge/push された記事は、GitHub Actions が[ワークフロー](/.github/workflows/jekyll.yml)を実行することでビルド・デプロイされ、GitHub Pages として https://magazine.rubyist.net/ 以下に公開されます。

## 個別の記事としてリリースする場合

1. 受け付けたリリース対象の記事の Pull Request を merge します
1. 下記の「リリース時に新しい記事のURLを確認する」手順で対象の記事の URL を取得して表示内容を確認します

## 新しい号数としてリリースする場合
### 表紙と編集後記の準備

1. 編集に参加した人から編集後記を集めておきます

TODO: 編集後記を集める方法を考える。Git に慣れている人が多ければ早めに新規号数用のブランチと Pull Request を作っておいて、記事の公開後に `master` ブランチから merge しなおすのが良いかもしれない。

### 記事のリリース

1. リリース対象の記事のうち個別の記事としてリリースされていないものの Pull Request を merge します
1. 下記の「リリース時に新しい記事のURLを確認する」手順で対象の記事の URL を取得して表示内容を確認します

### 表紙と編集後記のリリース

1. 上記の記事の公開作業を反映した最新の `master` ブランチから号数に対応したブランチ (0066 号なら `0066`) を作成します。ブランチ内で:
1. 表紙を作成します
1. 編集後記を作成します
1. 「0066号の表紙・編集後記」として Pull Request を作成します
1. Pull Request を merge します
1. 下記の「リリース時に新しい記事のURLを確認する」手順で表紙と編集後記の URL を取得して表示内容を確認します

## リリース時に新しい記事のURLを確認する

リリース対象の記事の Pull Request を merge して GitHub Actions によるページのビルトとデプロイが終わると、下記の手順でリリース対象の記事の URL を確認できます。

1. [`master`ブランチへの push をきっかけとして実行されたワークフローの一覧](https://github.com/rubima/magazine.rubyist.net/actions?query=branch%3Amaster+event%3Apush)から記事を公開した Pull Request に対応したものを見つける
1. 対象の「Merge pull request …」という表題をクリックする
1. 「build」ジョブと「deploy」ジョブのうち「build」をクリックする
1. 「Show new pages since previous deploy」ステップをクリックする

この手順で、下記のような情報が表示されます。表示された URL をクリックすることでデプロイされた記事を閲覧することもできます。

```
Show new pages since previous deploy
1 ▸ Run bundle exec ruby script/show_new_pages.rb
6 New pages:
7 https://magazine.rubyist.net/articles/ ...
```

このワークフローの現状の詳細は[`/.github/workflows/jekyll.yml`](/.github/workflows/jekyll.yml)で、実行されるスクリプトは[`script/show_new_pages.rb`](/script/show_new_pages.rb)で確認できます。

# 現状

## リリース後

- 次号のリリーススケジュールをだいたい決める。下記を考慮する
  - RubyKaigi などの日程
  - 編集者の忙しさ
- 締切の日程を決める
  - 概要の締切はだいたいリリース 3 週間前
  - 目次の締切はだいたいリリース 2 週間前
  - 記事の締切はだいたいリリース 1 週間前

## 記事集め

- お願いして記事を書いてもらったりしている。
- 投稿されることもある
- 担当編集を決める
- 担当が付かなかった記事は載せられない

## 4 週間前

- 上記の日程をリマインドする

## 3 週間前

- 概要の締切をリマインドする

## 2 週間前

- 目次の締切をリマインドする

## 1 週間前

- 記事をいただいてなければお願いする
- 記事をいただいたら下記の作業などをする
  - 内容とか構成の確認
  - サンプルコードの確認
  - [編集指針](editing_policy.md) との照合
  - 著者との編集内容の確認

## リリース

- 編集者に記事がリリースできる状態になってるか確認
- 編集者は自分の担当記事以外もチェックする
- リリース作業者が作業できるか確認
- リリース!
- リリースのアナウンス
- お疲れ様でした
- お礼の手紙を書きませう
  - 執筆者のかた
  - 編集者のみなさん

# インタビューの現状(8 号のケース)

## 4 週間前

- テープを聞いておおまかな目次を作る
- テープ起こし参加者を募る
- 参加者に適当にテープの部分を割り当てて、テープ起こし開始

## 3 週間前

- ひたすらテープ起こし

## 2 週間前

- テープ起こしの締め切り
- 締め切りに間に合わなかった部分の再割り当て
- 編集構成開始

## 1 週間前

- 終わってない部分のテープ起こし
- ひたすら校正
- ひたすら脚注の補完

## 3 日前

- インタビュイーに原稿チェックの依頼
- ひたすら校正

## 当日

- コードフリーズ
- まだ修正する
- リリース作業

## リリース後

- お礼のメール発射

# リリース後の記事の修正

[RubiMa-editors:2663]

- Pull Request を作成し、merge する。ただし、変更が大きかった場合（自明ではない変更）は Pull Request などで相談する
