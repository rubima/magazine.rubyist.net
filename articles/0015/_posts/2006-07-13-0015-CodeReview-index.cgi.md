---
layout: post
title: 0015-CodeReview-index.cgi
short_title: 0015-CodeReview-index.cgi
tags: 0015 CodeReview
---
{% include base.html %}


[あなたの Ruby コードを添削します 【第 4 回】 Tropy]({{base}}{% post_url articles/0015/2006-07-13-0015-CodeReview %}) で解説した、添削後のソースコード index.cgi です。

```ruby
#!/usr/local/bin/ruby

load './config'
tropy_context().cgi_main

```


