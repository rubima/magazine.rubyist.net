---
layout: post
title: 0048 号 アクセスランキング
short_title: 0048 号 アクセスランキング
created_on: 2014-09-19
tags: 0048 RubyistMagazineRanking
---
{% include base.html %}


書いた人: hsbt

## Rubyist Magazine アクセスランキング

こんにちは、hsbt です。2014/06/28-2014/09/18 のアクセスランキングをお送りします。

今回も引き続き "プログラマーのための YAML 入門 (初級編)" がトップとなりました。0044 号、0045 号、0046 号、0047 号と続いて 5 号連続のトップです。いったい YAML はどういう用途に使われているんですかねえ。新しくランクインした記事としては[8-bit風ゲームをつくるフレームワークburnの紹介]({{base}}{% post_url articles/0047/2014-06-30-0047-IntroductionToBurn %})や[標準添付ライブラリ紹介 【第 10 回】 ERB]({{base}}{% post_url articles/0017/2006-11-26-0017-BundledLibraries %})、[Ruby 初級者のための class << self の話 (または特異クラスとメタクラス)]({{base}}{% post_url articles/0046/2014-04-05-0046-SingletonClassForBeginners %})などがあります。

| 順位| 前回| タイトル|
|---|---|---|
| 1| 1| [プログラマーのための YAML 入門 (初級編)]({{base}}{% post_url articles/0009/2005-09-06-0009-YAML %})|
| 2| 2| [スはスペックのス 【第 1 回】 RSpec の概要と、RSpec on Rails (モデル編)]({{base}}{% post_url articles/0021/2007-09-29-0021-Rspec %})|
| 3| 3| [Ruby ではじめるプログラミング 【第 1 回】]({{base}}{% post_url articles/0002/2004-10-16-0002-FirstProgramming %})|
| 4| 7| [値渡しと参照渡しの違いを理解する]({{base}}{% post_url articles/0032/2011-01-31-0032-CallByValueAndCallByReference %})|
| 5| 6| [エンドツーエンドテストの自動化は Cucumber から Turnip へ]({{base}}{% post_url articles/0042/2013-05-29-0042-FromCucumberToTurnip %})|
| 6| -| [8-bit風ゲームをつくるフレームワークburnの紹介]({{base}}{% post_url articles/0047/2014-06-30-0047-IntroductionToBurn %})|
| 7| 9| [Ruby ではじめるプログラミング 【第 2 回】]({{base}}{% post_url articles/0003/2004-11-15-0003-FirstProgramming %})|
| 8| -| [標準添付ライブラリ紹介 【第 10 回】 ERB]({{base}}{% post_url articles/0017/2006-11-26-0017-BundledLibraries %})|
| 9| -| [Ruby 初級者のための class << self の話 (または特異クラスとメタクラス)]({{base}}{% post_url articles/0046/2014-04-05-0046-SingletonClassForBeginners %})|
| 10| 8| [Ruby ビギナーのための CGI 入門 【第 1 回】 初めての CGI プログラム]({{base}}{% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners %})|


## Rubyist Magazine アクセスランキング 連載一覧

{% for post in site.tags.RubyistMagazineRanking %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}


