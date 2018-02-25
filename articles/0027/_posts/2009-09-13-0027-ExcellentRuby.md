---
layout: post
title: VBA より便利で手軽 Excel 操作スクリプト言語「Ruby」へのお誘い (前編)
short_title: VBA より便利で手軽 Excel 操作スクリプト言語「Ruby」へのお誘い (前編)
tags: 0027 ExcellentRuby
---
{% include base.html %}


著者：こしば としあき

## はじめに

主に業務の分野で頻繁に使われる、「Microsoft Excel」(以下、Excel)。それを操作するためのスクリプト言語として Ruby を活用する事ができます。

今回は、Ruby を使って Excel を扱う為の基本的な部分を、細かい実装の理屈を抜きにして即物的に解説します。

## 必要となる環境

この記事で解説する事を行うには、Windows 上で、Microsoft Excel と Ruby が動く環境が必要です。Ruby の入手とインストールについては、[FirstStepRuby](https://github.com/rubima/rubima/blob/master/first_step_ruby/first-step-ruby-2.0.md) を参照してください。

サンプルコードの動作は下記環境で確認しております。

* Windows XP Home Edition SP3
* ruby 1.9.1p0  [i386-mswin32]
* Microsft Excel 2007 SP1


なお、コードのエンコーディングはシフト JIS を用いて動作確認を行いました。同じくシフト JIS でサンプルコードを試す場合は、ソースファイルの先頭で下記ようにエンコーディング指定を行ってください。使っている Ruby が 1.8 系でも 1.9 系でもこれで動作します。

{% highlight text %}
{% raw %}
#! ruby -Ks
# -*- coding: sjis -*-
{% endraw %}
{% endhighlight %}


## クイックスタート：これをコピペで Excel を Ruby で操作できる

能書きはいいから Excel を楽に操作する方法を知りたいあなた！

最低限下記のコードがあれば、Excel を開いてシート上のデータを取り出すことができます。

{% highlight text %}
{% raw %}
require 'win32ole'

app = WIN32OLE.new('Excel.Application')
book = app.Workbooks.Open(app.GetOpenFilename)

#使っているワークシート範囲を一行ずつ取り出す
for row in book.ActiveSheet.UsedRange.Rows do
  #取り出した行から、セルを一つづつ取り出す
  for cell in row.Columns do
    p cell.Address
    p cell.Value
    p '-------'
  end
end

book.close(false)
app.quit
{% endraw %}
{% endhighlight %}


このコードでは、以下の事を行っています。

1. Excel のインスタンスを生成
1. ファイルを開くダイアログを使って処理対象のワークブックを開く
1. 開いたワークブックのアクティブなシートで、値が入っているワークシート範囲から 1 つずつ行を取り出す
1. 取り出した行をセル単位に取り出す
1. 取り出したのセルのアドレスと値と区切りの線を出力


動作サンプルは以下の通りです。

#### ワークブック上のアクティブなシートの内容

| Elysion| Roman| Moira|
| 2004,2005| 2006| 2008|


#### 出力結果

{% highlight text %}
{% raw %}
"$A$1"
"Elysion"
"-------"
"$B$1"
"Roman"
"-------"
"$C$1"
"Moira"
"-------"
"$A$2"
20042005.0
"-------"
"$B$2"
2006.0
"-------"
"$C$2"
2008.0
"-------"
{% endraw %}
{% endhighlight %}


## 解説：VBA で書くとどうなるか

結構 VBA と似たような単語が使われているなと思われたかもしれませんが、まさにそのとおりです。

何故なら多くが Excel のオブジェクトであるからです。同様の事を行う VBA のコードと見比べてみましょう。

{% highlight text %}
{% raw %}
Set book = Workbooks.Open(Application.GetOpenFilename)

'使っているワークシート範囲を一行ずつ取り出す
For Each row In book.ActiveSheet.UsedRange.Rows
  '取り出した行から、セルを一つづつ取り出す
  For Each cell In row.Columns
     Debug.Print cell.Address
     Debug.Print cell.Value
     Debug.Print "-------"
  Next cell
Next row

book.Close False
{% endraw %}
{% endhighlight %}


気付きましたでしょうか、Excel を操作する部分は全く同じなのです。

ただ、異なる点としては、下記 3 点があります。

#### 1. プリミティブとオブジェクトの区別が不要

Ruby は VBA のようにプリミティブとオブジェクトを区別せず、すべてオブジェクトとして扱います。よって、オブジェクトだから set ステートメントを使う、プリミティブだからそのまま代入するといった面倒な使い分けが必要ありません。

#### 2. Excel のインスタンス生成

本来 Excel の VBA では、Excel のインスタンスは Application オブジェクトとして生成済みです。Ruby では標準添付ライブラリの Win32OLE クラスを用いた下記のコードで Excel のインスタンスを生成する必要があります。

{% highlight text %}
{% raw %}
app = WIN32OLE.new('Excel.Application')
{% endraw %}
{% endhighlight %}


なお上記コードは、VBS で利用する下記のコードと同じ意味です。

{% highlight text %}
{% raw %}
Set app = CreateObject("Excel.Application")
{% endraw %}
{% endhighlight %}


#### 3. 省略不可

本来 Excel の VBA では、Applicaion オブジェクトや ActiveWorkbook オブジェクトなど、いくつかのオブジェクトの名前を省略できます。Ruby では省略できないので、必ずどのオブジェクトを用いるのかを明示する必要があります。

## そもそも何故 Excel なのか？　何故 Ruby を使って Excel を扱うのか？

最近は様々な業務を Web サーバと Web ブラウザによって行えるようになっています。ソフトウェア開発現場でもその例に洩れず、BTS、Wiki など Web アプリケーションが、広く普及しています。

しかし、現在もなお業務に関する多くのデータは、オフィススイートによって作成・編集され、人々の間を飛び回っています。

オフィススイートはいくつものアプリケーションで構成されていますが、日本では表計算ツールの Excel が一番汎用的に使われています。例えば、一覧表、報告書、処理設計書、画面イメージ設計、チラシ、さまざまなものが Excel で作られています。

そんな Excel の操作や処理を簡便にするためには、ご存じの通り VBA (Visual Basic for Applications) を用います。ユーザ数も多く利用頻度も高い、一番使われているプログラム言語＆開発環境ではないでしょうか。そんな VBA は、長い期間使われ続けているので様々なノウハウがたまっている反面、不満やイライラも多くたまってきていると思います。

そこで、VBA の代わりに Ruby を使うことで、不満やイライラを解消しつつ、Excel を扱う上でのノウハウはそのままに、さらに便利かつ強力に Excel を処理できます。

また、一応 Ruby 勉強してるけど・Ruby に興味があるけど、いまいち何に使えばいいか分からないと悩みを抱えている VBA 使いのあなたにとって、これを機会に Ruby を使えるようになると、Excel の仕事を楽に片付けつつ Ruby を使えるようになり、一石二鳥の効果があります。

## VBA での文字列操作の不満やイライラを Ruby で解消する

さて、VBA ではこのようなコードがよく出てきます。

{% highlight text %}
{% raw %}
buf = Cells(i, 1).Value & _
      "や" & _
      Cells(i, 2).Value & _
      "は、我々の業界ではご褒美です。"
{% endraw %}
{% endhighlight %}


このようなコードによって下記のような問題が引き起こされます。

1. 結合結果を把握しにくい
1. 誤った位置に要素を挿入してしまう
1. ミスタイプしたままに別の行にフォーカスを移動すると、文法エラーのメッセージボックスが表示される


これらの問題のせいで、腹立たしい思いをした人は多いと思います。勿論、筆者もその一人です。

実は Ruby では、同じ意図のコードを[リテラルの式展開](http://www.ruby-lang.org/ja/man/html/_A5EAA5C6A5E9A5EB.html#a.bc.b0.c5.b8.b3.ab)を使ってシンプルに記述できます。

{% highlight text %}
{% raw %}
buf = "#{app.Cells(i, 1).Value}や#{app.Cells(i, 2).Value}は、我々の業界ではご褒美です。"
{% endraw %}
{% endhighlight %}


また、ソースコードの自動生成など、複数行にわたる文字列を出力する場合、VBA で実現しようとするととんでもないコードになってしまいます。

例えば、Excel 上のデータを用いて、下記のようなクラスのスケルトンを作りたい場合を考えます。

{% highlight text %}
{% raw %}
package AAAAA;

class BBBBB {
    public CCCCC DDDDD() {
        //TODO: method implement
        ;
        ;
        ;
    }
}
{% endraw %}
{% endhighlight %}


VBA では下記のようなコードになります。

{% highlight text %}
{% raw %}
package = Cells(i, 1).Value
class_name = Cells(i, 2).Value
method_name = Cells(i, 3).Value
return_type = Cells(i, 4).Value

buf = "package " & package & ";" & vbCrLf
buf = buf & vbCrLf
buf = buf & "class " & class_name & " {" & vbCrLf
buf = buf & "    public " & return_type & " " & method_name & "() {" & vbCrLf
buf = buf & "        //TODO: method implement" & vbCrLf
buf = buf & "        ;" & vbCrLf
buf = buf & "        ;" & vbCrLf
buf = buf & "        ;" & vbCrLf
buf = buf & "    }" & vbCrLf
buf = buf & "}"
{% endraw %}
{% endhighlight %}


体験した事のある人もきっと多いでしょうが、正直うんざりします。やってられません。それなので、プログラマの美徳の一つ「怠惰」を発揮して、Ruby でもっと楽にやりましょう。

実は Ruby では、標準添付ライブラリにある ERB を用いることで、同じ結果を下記のコードで得ることができます。

{% highlight text %}
{% raw %}
##Excel ファイルを開くあたりは省略しています。

require 'erb'
TEMPLATE = <<EOT
#テンプレート部分 (レイアウト) 
package <%= package %>;

class <%= class_name %> {
    public <%= return_type %> <%= method_name %>() {
        //TODO: method implement
        ;
        ;
        ;
    }
}
EOT

#処理部分
package = app.Cells(i, 1).Value
class_name = app.Cells(i, 2).Value
method_name = app.Cells(i, 3).Value
return_type = app.Cells(i, 4).Value

puts  ERB.new(TEMPLATE).result
{% endraw %}
{% endhighlight %}


ERB のような機能をテンプレートエンジンといいます。他言語では JSP や Velocity などが有名です。

テンプレートエンジンを用いると、レイアウトと処理とを明快に分離できるので、処理を変えずにレイアウトを自在に変えることができ大変便利です。Web の画面でよく使われる技術ですが、差し込み印刷系の処理や定型文の自動生成などにも力を発揮します。

テンプレートエンジンの種類によっては、特別な環境が必要であったり、専用の制御言語が必要となることもありますが、ERB では、ERB 用のタグを付けて Ruby のコードを入れるだけで使えるため、とても気軽に使う事ができます。

## まとめ

要約すると説明した事柄は以下の通りです。

* Excel を操作する部分は、Ruby であっても VBA を使う場合と同じである。その為 VBA で蓄積したノウハウを活用できる。
* Ruby から Excel のインスタンスを生成する必要はあるが、プリミティブだのオブジェクトだの意識しないので、楽である。
* Ruby ではリテラルの式展開によって、VBA で面倒臭かった文字列結合が楽になる。
* Ruby ではテンプレートエンジンの ERB を利用することで、VBA ではうんざりしてしまうやってられない苦労を解決できる。


## 次回予告

今回は、Ruby を使って Excel を扱う為の基礎的なテクニックを紹介しました。今回のテクニックで、ちゃっかり手早く Excel を処理するスクリプトを組む喜びを得ることができます。
次回は、じっくり作って長く運用する Excel 利用システムを作りたい場合に活用できるテクニックをご紹介します。

まずは実際に使ってみて、楽しい Ruby を使ったオフィスライフをスタートして下さい。
Enjoy Your Excel'ent Ruby Life!

## 著者について

### こしば としあき

* 仕事の企画・設計や工程管理が好物なソフトウェア技術者。


* 個人的に、ユースケース図と DFD のブームが到来中。


* [株式会社アイ・プライド](http://www.ipride.co.jp/) チーフシステムエンジニア


* ブログ：[http://d.hatena.ne.jp/bash0C7/](http://d.hatena.ne.jp/bash0C7/)
* twitter：[http://twitter.com/bash0C7](http://twitter.com/bash0C7)


## 参考

* [リテラル - Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/html/_A5EAA5C6A5E9A5EB.html#a.bc.b0.c5.b8.b3.ab)
* [Win32OLE 活用法 【第 1 回】 Win32OLE ことはじめ](http://jp.rubyist.net/magazine/?0003-Win32OLE)
* [Win32OLE 活用法 【第 2 回】 Excel](http://jp.rubyist.net/magazine/?0004-Win32OLE)
* [標準添付ライブラリ紹介 【第 10 回】 ERB](http://jp.rubyist.net/magazine/?0017-BundledLibraries)
* [『Ruby を 256 倍使うための本 邪道編』](http://ascii.asciimw.jp/books/books/detail/4-7561-3603-6.shtml)
* [Microsoft Visual C# .NET を使用して Microsoft Excel を自動化する方法](http://support.microsoft.com/kb/302084/ja)



