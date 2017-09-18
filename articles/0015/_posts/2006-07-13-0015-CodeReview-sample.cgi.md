---
layout: post
title: 0015-CodeReview-sample.cgi
short_title: 0015-CodeReview-sample.cgi
tags: 0015 CodeReview
---


[あなたの Ruby コードを添削します 【第 4 回】 Tropy]({% post_url articles/0015/2006-07-13-0015-CodeReview %}) で添削した sample.cgi のソースコード (添削前) です。

```ruby
#!/usr/bin/ruby
require "tropy"

ABSOLUTE_URL = "http://www.example.com/tropy/sample.cgi"
DATA_FILENAME = "/home/example/www/tropy/data/data.pstore"
MAX_COLS = 80
MAX_ROWS = 20
TITLE = "Tropy"

Tropy::Tropy.new(CGI.new, Tropy::Database.new(DATA_FILENAME))

```


