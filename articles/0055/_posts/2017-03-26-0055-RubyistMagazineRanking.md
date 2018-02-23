---
layout: post
title: 0055号 アクセスランキング
short_title: 0055号 アクセスランキング
tags: 0055 RubyistMagazineRanking
---
{% include base.html %}


書いた人: みよひで

## Rubyist Magazine アクセスランキング

こんにちは、るびま編集部の みよひで です。前号発行日の 2016/08/21 から今号発行日の前日である 2017/03/25 までのアクセスランキングをお送りします。

今回も 0044 号以来のトップである [プログラマーのための YAML 入門 (初級編)]({% post_url articles/0009/2005-09-06-0009-YAML %}) が 1 位となりました。4 位までは順位は変わりませんでしたが、9 位に 0054 号の記事である[]({% post_url articles/0054/2016-08-21-0054-typestruct %})が出てきています。公開直後からアクセス数が高い記事で今回のトップ10入りとなりました。

| 順位| 前回| タイトル|
|---|---|---|
| 1| 1| [プログラマーのための YAML 入門 (初級編)]({% post_url articles/0009/2005-09-06-0009-YAML %})|
| 2| 2| [Ruby ではじめるプログラミング 【第 1 回】]({% post_url articles/0002/2004-10-16-0002-FirstProgramming %})|
| 3| 3| [値渡しと参照渡しの違いを理解する]({% post_url articles/0032/2011-01-31-0032-CallByValueAndCallByReference %})|
| 4| 4| [Ruby ではじめるプログラミング 【第 2 回】]({% post_url articles/0003/2004-11-15-0003-FirstProgramming %})|
| 5| 6| [エンドツーエンドテストの自動化は Cucumber から Turnip へ]({% post_url articles/0042/2013-05-29-0042-FromCucumberToTurnip %})|
| 6| 5| [スはスペックのス 【第 1 回】 RSpec の概要と、RSpec on Rails (モデル編)]({% post_url articles/0021/2007-09-29-0021-Rspec %})|
| 7| 8| [標準添付ライブラリ紹介 【第 10 回】 ERB]({% post_url articles/0017/2006-11-26-0017-BundledLibraries %})|
| 8| 9| [Ruby ビギナーのための CGI 入門 【第 3 回】 ページ 2]({% post_url articles/0014/2006-05-15-0014-CGIProgrammingForRubyBeginners-2 %})|
| 9| -| []({% post_url articles/0054/2016-08-21-0054-typestruct %})|
| 10| -| [Ruby 初級者のための class << self の話 (または特異クラスとメタクラス)]({% post_url articles/0046/2014-04-05-0046-SingletonClassForBeginners %})|


るびまにアクセスしているOSも見てみました。

| 順位| 前回| OS| 割合|
|---|---|---|---|
| 1| -| Windows| 55.42%|
| 2| -| Macintosh| 27.50%|
| 3| -| iOS| 7.97%|
| 4| -| Android| 4.86%|
| 5| -| Linux| 4.01%|


Windows のアクセス数が多いですね。カンファレンスなどに行くと Mac ユーザが多いのでちょっと意外でした。

## Rubyist Magazine アクセスランキング 連載一覧

{% for post in site.tags.RubyistMagazineRanking %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}


