[![Build Status](https://travis-ci.org/rubima/magazine.rubyist.net.svg?branch=master)](https://travis-ci.org/rubima/magazine.rubyist.net)

# Rubima on Jekyll

次期るびま本体のサイトです。

# 記事について

記事は、`articles/号数/_posts/日付-記事名.md`として作成してください。画像ファイルなどは`images/号数-記事名`以下に配置してください。
記事はPull Requestで受け付け、リリースのタイミングでmergeします。

# 書式

Markdownです。具体的には、[kramdown](https://kramdown.gettalong.org/)を使っています。
詳細な文法は[kramdownのSyntaxページ](https://kramdown.gettalong.org/syntax.html)を参照してください。

# ローカル環境構築

```
$ git clone git@github.com:rubima/magazine.rubyist.net.git
$ cd magazine.rubyist.net
$ bundle install
$ bundle exec jekyll serve -I --future
```

http://127.0.0.1:4000/ にローカル開発サーバーが起動し、Markdownから生成されたHTMLページを確認することができます。

# リリース作業について

次の手順で行います。

1. 受け付けたリリース対象の記事のPull Requestをmergeします。
1. 次のことがTravisでできそうなので、実装すれば良さそう。
- `JEKYLL_ENV=production bundle exec jekyll build`を実行します。
- `docs`にサイトが生成されるので`git commit`して`gh-page`ブランチにcommit、`git push`します。

上記のようにしているのは、amazonの書影をとるためにpluginを使用しているため。これを解決できれば、特にcloneしなくても動かせるものと考えています。

## rubima.github.io へのリリース
　
`../rubima.github.io/` に `rubima/rubima.github.io` が chekout されている場合は下記のような操作をします。

```
$ git checkout master
$ git pull
$ \cp -r docs/* ../rubima.github.io/
$ cd ../rubima.github.io/
$ git checkout -b (ブランチ名)
$ git add .
$ git commit
$ git push -u origin (ブランチ名)
```

https://github.com/rubima/rubima.github.io からプルリクエストを作成し`master`ブランチにマージします。
