---
layout: post
title: 0049 号 アクセスランキング
short_title: 0049 号 アクセスランキング
tags: 0049 RubyistMagazineRanking
---
{% include base.html %}


書いた人: takkanm

## Rubyist Magazine アクセスランキング

こんにちは、takkanm です。2014/09/19-2014/12/12 のアクセスランキングをお送りします。

6 号連続で "プログラマーのための YAML 入門 (初級編)" がトップでした。
今回はあまり順位変動が見られない結果となりました。
今回のランキングを見るとテストやメタプログラミング、ERB 等、仕事によく使われてそうな内容がランクインしていますね。

| 順位| 前回| タイトル|
|---|---|---|
| 1| 1| [プログラマーのための YAML 入門 (初級編)]({{base}}{% post_url articles/0009/2005-09-06-0009-YAML %})|
| 2| 2| [スはスペックのス 【第 1 回】 RSpec の概要と、RSpec on Rails (モデル編)]({{base}}{% post_url articles/0021/2007-09-29-0021-Rspec %})|
| 3| 3| [Ruby ではじめるプログラミング 【第 1 回】]({{base}}{% post_url articles/0002/2004-10-16-0002-FirstProgramming %})|
| 4| 5| [エンドツーエンドテストの自動化は Cucumber から Turnip へ]({{base}}{% post_url articles/0042/2013-05-29-0042-FromCucumberToTurnip %})|
| 5| 4| [値渡しと参照渡しの違いを理解する]({{base}}{% post_url articles/0032/2011-01-31-0032-CallByValueAndCallByReference %})|
| 6| 7| [Ruby ではじめるプログラミング 【第 2 回】]({{base}}{% post_url articles/0003/2004-11-15-0003-FirstProgramming %})|
| 7| 8| [標準添付ライブラリ紹介 【第 10 回】 ERB]({{base}}{% post_url articles/0017/2006-11-26-0017-BundledLibraries %})|
| 8| 9| [Ruby 初級者のための class << self の話 (または特異クラスとメタクラス)]({{base}}{% post_url articles/0046/2014-04-05-0046-SingletonClassForBeginners %})|
| 9| 10| [Ruby ビギナーのための CGI 入門 【第 1 回】 初めての CGI プログラム]({{base}}{% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners %})|
| 10| -| [Ruby ビギナーのための CGI 入門 【第 1 回】 2 ページ]({{base}}{% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-2 %})|


## Rubyist Magazine アクセスランキング 連載一覧

{% for post in site.tags.RubyistMagazineRanking %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}


