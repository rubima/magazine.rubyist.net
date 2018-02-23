---
layout: post
title: 書籍紹介『Ruby on Windows -- Rubyist Magazine 出張版』
short_title: 書籍紹介『Ruby on Windows -- Rubyist Magazine 出張版』
tags: 0023 Book
---
{% include base.html %}


編集：くげ

## 書籍紹介 『Ruby on Windows -- Rubyist Magazine 出張版』
{% isbn_image('4839926689', '') %}

書名
: 「Ruby on Windows -- Rubyist Magazine 出張版」

著者
: cuzic

発売日
: 2007 年 12 月 19 日

体裁
: B5 版 296 ページ

定価
: 2730 円 (税込)

ISBN
: ISBN978-4-8399-2668-7

サポートページ
: [http://book.mycom.co.jp/support/e1/ruby_windows/](http://book.mycom.co.jp/support/e1/ruby_windows/)

## 内容紹介

> 本書は Web 上の Rubyist Magazine で連載され好評を博していた「Win32OLE 活用法」の記事を大幅に加筆・修正したのに加えて多数の書き下ろしを追加し、Ruby による Windows アプリケーションの操作法から Java や .NET CLR などの膨大なソフトウエア資産を活用する方法まで、Ruby のノウハウを最大限に活かしてより実用性・生産性を高めるためのテクニックを幅広く解説しています。
> 
> また、インストール方法や開発環境などについての記事も掲載していますので、Ruby 初心者の方にもオススメです。
> 
> [[MYCOM BOOKS - 「Rubyist Magazine出張版 Ruby on Windows」より|http://book.mycom.co.jp/book/978-4-8399-2668-7/978-4-8399-2668-7.shtml]]


## 執筆者より

cuzic です。

Rubyist Magazine の初期の頃に連載を行っていた Win32OLE 活用法が、本になりました。

タイトルは「Ruby on Windows -- Rubyist Magazine 出張版」です。青木さんの「Rubyist Magazine 出張版」の続編にあたります。つまり、Rubyist Magazine から出版された本の第二弾です。

この本のサブタイトルは「Ruby で丸投げ！ルーチンワーク」。「Ruby で丸投げ」というフレーズには２つの意味が込められています。

会社で仕事をしていると、いろいろと誰にでもできるような単純な作業が回ってくることはよくあるものです。そして、なぜか世の中には Windows と Excel が仕事をする上での前提になっています。上司や客先がそれが好きなんだし、世の中がそういう仕組みなんですから、仕方がありません。

このような面倒な仕事上のルーチンワークを Ruby のスクリプトに自動的にやってもらおうというのが、「Ruby で丸投げ！」の１つ目の意味です。

そして、「Ruby で丸投げ！」のもう１つの意味は、そのような面倒な仕事を自動的にやってくれるスクリプトを作る上で、すでに作られているコンポーネントに「丸投げ」する、という意味です。

実は Excel、Access や Internet Explorer といった Windows アプリケーションは、OLE/COM/ActiveX といった技術を使って、自動的にプログラマが思ったとおりの動作を行わせる機能があります。

この機能を使えばプログラマが行いたいさまざまな作業を Excel に丸投げさせることができます。

また、「Ruby on Windows」の本の中では OLE/COM/ActiveX だけでなく、Java と連携するための Rjb、.NET ライブラリと連携するための RubyCLR などについても使い方を紹介しています。これらのライブラリを使えば、既存のJava や .NET で作られたソフトウエア資産を活用した Ruby スクリプトを作成できます。つまり、Java や .NET に「丸投げ！」できるのです。

この方法は Java や .NET で作成している途中のシステムのテストを Ruby で行うときなどに役に立ちます。

この「Ruby on Windows」は 「実用的な本」として書かれました。

この本の中ではちょっと見慣れていないような Ruby の文法などについては出てくるたびに説明するようにしていますので、Ruby にあまり慣れていないような方にとっても読み進めやすくなっています。

Windows を使っている Rubyist は一冊、ぜひ手元においてもらえるとうれしいです。

## 目次

{% highlight text %}
{% raw %}
第  1 回 Win32OLE ことはじめ
第  2 回 Excel
第  3 回 ADODB
第  4 回 Outlook
第  5 回 Web 自動巡回
第  6 回 Windows アプリケーションの自動操作
第  7 回 他の言語での COM
第  8 回 WMI
第  9 回 iTunes
第 10 回 Exerb
第 11 回 RubyCLR
第 12 回 Rjb と Apache POI
第 13 回 JRuby

付録 A Windows での Ruby 実行環境のインストール
付録 B Ruby 統合開発環境

コラム
{% endraw %}
{% endhighlight %}



