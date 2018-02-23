---
layout: post
title: 標準添付ライブラリ紹介 【第 15 回】 tmpdir, tempfile
short_title: 標準添付ライブラリ紹介 【第 15 回】 tmpdir, tempfile
tags: 0029 BundledLibraries
---
{% include base.html %}


書いた人：西山

## はじめに

Ruby には便利な標準添付ライブラリがたくさんありますが、なかなか知られていないのが現状です。そこで、この連載では Ruby の標準添付ライブラリを紹介していきます。

今回は tmpdir と tempfile についてです。
名前が似ていますが、歴史的理由により tmpdir は e なしの tmp で tempfile は e ありの temp になっています。
tmpdir は dir が 3 文字なので tmp も 3 文字、tempfile は file が 4 文字なので temp も 4 文字と覚えると良いかもしれません。

詳細は後述しますが、安全に一時ファイルを作成するのは素人には難しいので、一時ファイルなどを使うときは、自分で独自実装をせず既存のライブラリを使うことをおすすめします。

## tmpdir ライブラリ

テンポラリディレクトリ (一時ディレクトリ) を扱うためのライブラリです。

一般的には、何か一時的な作業をするディレクトリとして "/tmp" などを使うべきではありません。
OS によっては存在しなかったり、使い方を間違えるとセキュリティホールの原因になったりします。

そういう場合に ruby では tmpdir ライブラリを使います。

### Dir.tmpdir

Dir.tmpdir を使うと OS や環境変数や $SAFE に応じて、テンポラリディレクトリとして使うのに適切な絶対パスを取得できます。

Linux での実行例:

{% highlight text %}
{% raw %}
 % env - ruby1.8 -v -r tmpdir -e 'p Dir.tmpdir'
 ruby 1.8.7 (2009-06-12 patchlevel 174) [i486-linux]
 "/tmp"
 %
{% endraw %}
{% endhighlight %}


Windows での実行例:

{% highlight text %}
{% raw %}
 C:\ruby\bin>ruby -v -r tmpdir -e "p Dir.tmpdir"
 ruby 1.8.7 (2008-08-11 patchlevel 72) [i386-mswin32]
 "c:/DOCUME~1/kazu/LOCALS~1/Temp"

 C:\ruby\bin>
{% endraw %}
{% endhighlight %}


ユーザが環境変数を設定している場合:

{% highlight text %}
{% raw %}
 % env - TMPDIR=$HOME/tmp ruby1.8 -v -r tmpdir -e 'p Dir.tmpdir'
 ruby 1.8.7 (2009-06-12 patchlevel 174) [i486-linux]
 "/home/kazu/tmp"
 %
{% endraw %}
{% endhighlight %}


さらに safe level が 1 以上の場合:

{% highlight text %}
{% raw %}
 % env - TMPDIR=$HOME/tmp ruby1.8 -v -r tmpdir -e '$SAFE=1; p Dir.tmpdir'
 ruby 1.8.7 (2009-06-12 patchlevel 174) [i486-linux]
 "/tmp"
 %
{% endraw %}
{% endhighlight %}


セキュリティを考慮するなら symlink attack などの可能性があるため、Dir.tmpdir の直下に直接ファイルを作ったりせず、次の Dir.mktmpdir を使ったり、後述の tempfile を使う方がおすすめです。

詳しくは後述のセキュリティのところで紹介しているリンク先を参照してください。

### Dir.mktmpdir

ruby 1.8.7 以降の tmpdir には Dir.mktmpdir が追加されています。

Dir.mktmpdir を使うと一時ディレクトリを作成できます。
作られるディレクトリのパーミッションは 0700 になっています。

ブロック付きで Dir.mktmpdir を使うと、ブロックの引数に作成された一時ディレクトリのパスが渡されて、作成された一時ディレクトリやその中のファイルが Dir.mktmpdir から返るときに FileUtils.remove_entry_secure で削除されます。
カレントディレクトリは変わらないので、必要ならブロック付きの Dir.chdir と組み合わせると便利でしょう。

例:

{% highlight text %}
{% raw %}
 require "tmpdir"
 Dir.mktmpdir do |dir|
   p dir #=>
   # dir を使って何かする。
   open("#{dir}/foo", "w") {|f| f.puts "..." }
   system("ls", "-al", dir) #=>
 end
{% endraw %}
{% endhighlight %}


第一引数に文字列を渡すと作成するディレクトリの prefix を指定できます。(指定しなかった場合は "d" になります。)

例:

{% highlight text %}
{% raw %}
 require "tmpdir"
 Dir.mktmpdir("foo") do |dir|
   p dir #=>
 end
{% endraw %}
{% endhighlight %}


第一引数に 2 要素の配列を渡すと作成するディレクトリの prefix と suffix を指定できます。

例:

{% highlight text %}
{% raw %}
 require "tmpdir"
 Dir.mktmpdir(["foo", "bar"]) do |dir|
   p dir #=>
 end
{% endraw %}
{% endhighlight %}


第二引数にパスを指定すると、そのディレクトリの中に一時ディレクトリを作成します。
指定しなかった場合には Dir.tmpdir の中に作成されます。

第二引数だけ指定したい場合は第一引数に nil を渡します。

例:

{% highlight text %}
{% raw %}
 require "tmpdir"
 Dir.mktmpdir(["foo", "bar"], "/var/tmp") do |dir|
   p dir #=>
 end
 require "tmpdir"
 Dir.mktmpdir(nil, "/var/tmp") do |dir|
   p dir #=>
 end
{% endraw %}
{% endhighlight %}


ブロックなしで Dir.mktmpdir を呼びだすと、作成されたディレクトリを返します。
このとき、 Dir.mktmpdir はディレクトリを消さないので、自分でどうにかする必要があります。

例:

{% highlight text %}
{% raw %}
 dir = Dir.mktmpdir
 begin
   open("#{dir}/foo", "w") {|f| f.puts "..." }
 ensure
   # ディレクトリを消す
   FileUtils.remove_entry_secure dir
 end
{% endraw %}
{% endhighlight %}


## tempfile ライブラリ

tempfile ライブラリはテンポラリファイル (一時ファイル) を扱うためのライブラリです。

### 使用例

Tempfile は Dir.mktmpdir と違って finalizer でファイルの削除をするようになっているため、 GC や ruby の終了時に自動でファイルが削除されます。
しかし、開いたファイルは閉じるのが行儀が良いように、Tempfile も使い終わったらちゃんと消すのがおすすめです。

例:

{% highlight text %}
{% raw %}
 require "tempfile"
 file = Tempfile.new('foo')
 begin
   # file を使って何かする。
   file.puts "..."
 ensure
   file.close
   file.unlink # 一時ファイルを削除
end
{% endraw %}
{% endhighlight %}


### Tempfile.new(basename, tempdir=Dir.tmpdir)

ruby 1.8.7 以降の tempfile では Dir.mktmpdir と同様に第一引数に 2 要素の配列を渡すと prefix と suffix を指定できます。
拡張子によって処理内容が決まるコマンドの引数に使うなど、一時ファイルの拡張子を指定する必要があるときに使います。

### Tempfile.open

ブロックなしで呼び出した場合は Tempfile.new と同じです。

ブロック付きで呼び出した場合は File.open と同じように Tempfile オブジェクトを引数としてブロックが呼ばれ、
ブロックから抜けるときにファイルは自動的に閉じて削除されます。

### Tempfile#close(unlink_now=false)

一時ファイルを閉じます。
引数に true を指定すると、一時ファイルの削除もします。

### Tempfile#close!

Tempfile#close(true) と同じです。

### Tempfile#open

close した後、再度開くのに使います。

### Tempfile#unlink, Tempfile#delete

一時ファイルを削除します。

Unix 系の OS では open したまま unlink することにより、

* ファイルは存在し続ける
* ファイル名がなくなり open できなくなる
* プロセス異常終了時にも残らない


という状態になります。

詳しくは
[http://www.ipa.go.jp/security/awareness/vendor/programmingv2/contents/c603.html](http://www.ipa.go.jp/security/awareness/vendor/programmingv2/contents/c603.html)
の「ファイルを作成したら unlink する」を参照してください。

Windows では開いているファイルを削除することが出来ないので、
いろいろな環境で動かしたいプログラムを作成する場合には注意してください。

### Tempfile#path

一時ファイルのパスを返します。

一時ファイルを別プログラムとの連携に使う場合などに使います。

## 使用例

一時ファイルの主な用途としては、

* 他のプログラムを起動するときの引数
* ユニットテストなどのテストの中で扱うファイルを作成


などがあるようです。

### 子プロセスのリダイレクト

* 終了ステータスも子プロセスの標準出力も標準エラー出力もほしい
* 子プロセスの標準出力と標準エラー出力は別々にほしい
* 出力はコマンドの実行後にまとめて取得できるだけで良い
* fork のない環境は対応しなくても良い
* ruby 1.8 対応


という条件で子プロセスを起動したいことがありました。

そのとき、いくつか方法を考えてみたところ、

* 「`#{cmd} 2&gt;&amp;1`」だと標準出力と標準エラー出力が混ざる
* 「open3」ライブラリの「Open3.popen3(cmd)」だと終了ステータスが取れない
* IO.pipe と fork の組み合わせだと読み込まないとコマンドが止まる可能性があるのが面倒
* Process.spawn は ruby 1.8 では使えない


という問題がありました。

そこで Tempfile で作成したファイルにリダイレクトするという方法を使いました。
そのときのプログラムの tempfile を使用した部分を再現したものが以下のプログラムです。

{% highlight text %}
{% raw %}
#!/usr/bin/ruby
require 'tempfile'
make_out = Tempfile.open("make")
make_err = Tempfile.open("make")
make_out.close
make_err.close
pid = fork do
  STDOUT.reopen(make_out.path)
  STDERR.reopen(make_err.path)
  exec("make", "all")
  abort("exec failed")
end
pid, status = Process.waitpid2(pid)
p status
make_out.open
p make_out.read
make_out.close(true)
make_err.open
p make_err.read
make_err.close(true)
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
実行結果の例:
#<Process::Status: pid=12023,exited(2)>
""
"make: *** ターゲット `all' を make するルールがありません.  中止.\n"
{% endraw %}
{% endhighlight %}


## セキュリティ

安全に一時ファイルを作成するのは素人には難しく、[http://www.ipa.go.jp/security/awareness/vendor/programmingv2/contents/c603.html](http://www.ipa.go.jp/security/awareness/vendor/programmingv2/contents/c603.html) の「使用を避けた方がよい関数」にあるように問題がある実装になりがちなので、普通はライブラリを使いましょう。
ライブラリを使っていれば、問題がある可能性は自分で実装するより低く、問題がみつかった場合もきちんと修正されることが期待できます。

また、どのような問題があり、どう対処すれば良いのかは [http://www.ipa.go.jp/security/fy20/reports/tech1-tg/2_05.html](http://www.ipa.go.jp/security/fy20/reports/tech1-tg/2_05.html) も参考になります。

## まとめ

今回は tmpdir と tempfile を紹介しました。
一時ファイルなどを使うときは、自分で独自実装をせず既存のライブラリを使い、セキュリティや削除されずにゴミファイルが残る可能性を考慮した使い方をすると良いと思います。

## 著者について

西山和広。
最近は文字コード関連やフォント関連も勉強中。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}


