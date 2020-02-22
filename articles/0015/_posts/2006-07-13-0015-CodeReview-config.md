---
layout: post
title: 0015-CodeReview-config
short_title: 0015-CodeReview-config
created_on: 2006-07-13
tags: 0015 CodeReview
---
{% include base.html %}


[あなたの Ruby コードを添削します 【第 4 回】 Tropy]({{base}}{% post_url articles/0015/2006-07-13-0015-CodeReview %}) で解説した、添削後の設定ファイル config です。

```ruby
$LOAD_PATH.unshift './lib'
require 'tropy'

def tropy_context
  db = Tropy::Database.new("db.pstore", "shift_jis")
  screen = Tropy::ScreenManager.new(
    :baseurl     => "http://www.example.com/tropy/sample.cgi",
    :theme       => "default",
    :templatedir => "template")
  Tropy::Application.new(db, screen)
end

```


