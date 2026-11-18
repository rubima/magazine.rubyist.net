---
layout: post
title: 記事を書いてみようと思ったあなたへ　るびまは OSS です！
short_title: るびまに記事を書きたい方へ
post_author: shokola
created_on: 2026-11-18
---
{% include base.html %}

## はじめに

「るびまに記事を書いてみたいけれど、何から始めればいいんだろう？」と思ったことはありませんか。

この記事では、るびまに記事を書いてみたい方や、記事を書くことになった方に向けて、最初の一歩から記事が公開されるまでの流れを紹介します。

なお、執筆の細かいルールや手順は今後も更新されていくため、この記事では内容を直接書かずに、それぞれの最新のドキュメントへのリンクを載せています。

## るびまは GitHub で作られている OSS です

るびまの記事はすべて、GitHub の [rubima/magazine.rubyist.net](https://github.com/rubima/magazine.rubyist.net) リポジトリで管理されています。

- 記事は Markdown で書きます
- 書いた記事は Pull Request として出し、レビューを経て公開されます
- 記事の企画や相談は、リポジトリの [Discussions](https://github.com/rubima/magazine.rubyist.net/discussions) で行います

つまり、ふだんの開発と同じように、Pull Request を作れば記事を寄稿できます。

はじめてコントリビュートされる方は、まず [CODE OF CONDUCT](https://github.com/rubima/magazine.rubyist.net/blob/master/CODE_OF_CONDUCT.md) をご一読ください。

## 書く記事を決める

### 書きたいネタがある場合

[Discussions の「記事を書きたい」カテゴリ](https://github.com/rubima/magazine.rubyist.net/discussions/categories/%E8%A8%98%E4%BA%8B%E3%82%92%E6%9B%B8%E3%81%8D%E3%81%9F%E3%81%84) に、新しく Discussion を作成して、書きたい記事の内容をお知らせください。

編集部で記事にするかどうかを確認します。採用となったら、記事を書き進めるための Issue を作成します。

### ネタはないけれど書いてみたい場合

[Discussions](https://github.com/rubima/magazine.rubyist.net/discussions) や [Issues](https://github.com/rubima/magazine.rubyist.net/issues) をのぞいて、まだ担当が決まっていない記事に「書きます！」とコメントしてみてください。きっと編集部から反応があるはずです。

## 記事を書く

担当する記事が決まったら、以下のドキュメントを参考に記事を作成します。

- [るびまに記事を追加する方法 (writing_process.md)](https://github.com/rubima/magazine.rubyist.net/blob/master/doc/writing_process.md)
  - ファイルの置き場所や名前の付け方、記事の先頭に書くテンプレート、手元で記事の見た目を確認する方法などがまとまっています

### 書く前に読んでおきたいもの

るびま全体で文章の表記をそろえるため、書きはじめる前に以下の指針に目を通しておいてください。

- [表記統一のための指針 (editing_policy.md)](https://github.com/rubima/magazine.rubyist.net/blob/master/doc/editing_policy.md)

## Pull Request を出してレビューを受ける

記事が書けたら、`master` ブランチに対して Pull Request を作成します。Pull Request の説明欄には、対応する Issue へのリンクを書いておくと、編集部が経緯を追いやすくなります。

[Pull Request の一覧](https://github.com/rubima/magazine.rubyist.net/pulls) には、ほかの方の記事の Pull Request も並んでいるので、書き方やレビューのやりとりの参考になります。

レビューで指摘をもらったら修正し、編集部の確認が済んだら編集部が Pull Request をマージして、記事が公開されます。

## 困ったときは

わからないことや相談したいことがあれば、気軽に聞いてください。

- [Discussions](https://github.com/rubima/magazine.rubyist.net/discussions) に質問を書く
- [日本 Ruby の会の Discord サーバー](https://scrapbox.io/ruby-no-kai/Discord%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC) の `#rubima` チャンネル (`PROJECTS` カテゴリ) で相談する

るびまへのそのほかの関わり方については、[CONTRIBUTING.md](https://github.com/rubima/magazine.rubyist.net/blob/master/CONTRIBUTING.md) にまとまっています。

あなたの記事をお待ちしています！

## 著者について

寺嶋 章子 ([@shokolateday](https://x.com/shokolateday)) プロダクトデザイナ。
