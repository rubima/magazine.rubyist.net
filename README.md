[![Build Status](https://travis-ci.org/rubima/magazine.rubyist.net.svg?branch=master)](https://travis-ci.org/rubima/magazine.rubyist.net)

# Rubima on Jekyll

るびま本体のサイトです。

# 記事について

- 記事は、`articles/号数/_posts/yyyy-mm-dd-号数-記事名.md`として作成してください。
- 画像ファイルなどは`images/号数-記事名`以下に配置してください。
- ファイル名にある`yyyymmdd`の部分は、号数のリリース予定日です。これはるびま編集部が決めます。
- 記事名は、以下の要領で命名してください。
  - 表紙は`index`
  - 巻頭言は`ForeWord`
  - 編集後記は`EditorsNote`
  - 地域Ruby会議レポートは`hogehogeRubyKaigiXXReport`
  - その他の記事は適当な英語名で
- 記事を https://github.com/rubima/magazine.rubyist.net に対してPull Requestで出してください。
- 記事はMarkdownで書きます。後述する書式とローカル環境の構築の方法を参照して、ご自身の環境でレイアウトなどを確認されてからPull Requestを出していただけると助かります。

# 書式

記事はMarkdownで記します。具体的には、[kramdown](https://kramdown.gettalong.org/)を使っています。詳細な文法は[kramdownのSyntaxページ](https://kramdown.gettalong.org/syntax.html)を参照してください。

書き方について、いくつか注意点があります。

- 記事の先頭には以下のテンプレートを記してください。

```
---
layout: post
title: タイトル名
short_title: 短いタイトル名
tags: 後述
post_author: 書いた人の名前
created_on: リリース予定日
---
{% include base.html %}
```

- tagsについては、`号数`の他に種別を記してください。
  - 種別は、記事名と同じですが、地域Ruby会議の場合は`regionalRubyKaigi`も指定してください。
  - このtagで指定した内容に応じてバックナンバーの記事一覧を生成しています。このため、大文字小文字も厳密に区別します。
- 過去記事へのリンクは`{{base}}{% post_url articles/号数/日付-記事名 %}`をURLとして指定してください。
- 画像へのリンクは`{{base}}{{site.baseurl}}/images/号数-記事名/ファイル名`をURLとして指定してください。
- 見出し（HTMLでいうと`H1`や`H2`など、Makrdownでいうと`#`や`##`など）は、第一レベル（HTMLでいうと`H1`タグ、Markdownでは`#`）は使わず、第二レベル（HTMLでいうと`H2`タグ以降、Markdownでは`##`以降）を使ってください。
  - 上記のヘッダに書いた`title`を第一レベルの見出しにしているためです。
- URLだけを記述しても自動リンクにはならないので、`<URL>`のようにURLを`<`と`>`で挟むようにしてください。
- 記事の最後には`著者について`の見出しを作成して、書いた人がわかるようにしてください。
- GitHubのリンクを乗せる場合は`master`ではなく、該当バージョンへのリンクにするようにしてください。
  - `master`へのリンクは将来的に変更される可能性があるためです。

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
1. buildした結果（`docs`の中身）を https://github.com/rubima/rubima.github.io に対して反映させます

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
