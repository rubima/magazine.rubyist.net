---
layout: post
title: 標準添付ライブラリ紹介 【第 9 回】 PStore
short_title: 標準添付ライブラリ紹介 【第 9 回】 PStore
tags: 0016 BundledLibraries
---
{% include base.html %}


書いた人：西山

## はじめに

Ruby には便利な標準添付ライブラリがたくさんありますが、なかなか知られていないのが現状です。そこで、この連載では Ruby の標準添付ライブラリを紹介していきます。

今回は、データを外部ファイルに保存するためのクラス PStore と PStore を継承したクラスについて紹介します。

## PStore

PStore を使うと Ruby のオブジェクトを手軽に外部ファイルに保存することが出来ます。
保存されるデータファイルの内容は Marshal されたバイナリになります。

### 基本的な使い方

使い方は基本的には Hash のように PStore#[]= を使って値を保存して、PStore#[] を使って値を取り出します。
PStore#roots は Hash#keys に、PStore#root? は Hash#key に相当します。

ただし、transaction 中でしかデータを操作することは出来ません。
データを参照するだけの transaction の場合は引数に true を指定することで、読み込み専用の transaction にすることが出来ます。

{% highlight text %}
{% raw %}
require 'pstore'
db = PStore.new('/tmp/foo')
db.transaction do
  p db.roots
  ary = db['root'] = [1,2,3,4] # 配列を db に設定
  ary[0] = [1,1.5]             # 破壊的に変更
end # 保存は transaction を抜けるときなので変更された結果が保存される

db.transaction(true) do
  p db.root?('root')
  p db['root']
end

begin
  db.transaction(true) do
    db['root'] = 'hoge' # 書き込もうとすると PStore::Error
  end
rescue PStore::Error
  p $!
end
{% endraw %}
{% endhighlight %}


実行例 (1 回目):

{% highlight text %}
{% raw %}
[]
true
[[1, 1.5], 2, 3, 4]
#<PStore::Error: in read-only transaction>
{% endraw %}
{% endhighlight %}


実行例 (2 回目以降):

{% highlight text %}
{% raw %}
["root"]
true
[[1, 1.5], 2, 3, 4]
#<PStore::Error: in read-only transaction>
{% endraw %}
{% endhighlight %}


他に PStore#fetch と PStore#delete が Hash の同名のメソッドと同じ機能を持っています。

{% highlight text %}
{% raw %}
require 'pstore'
db = PStore.new('/tmp/foo')
db.transaction do
  ary = db.fetch(:ary, [])
  p ary
  ary.push(0, 1, 2)
  db[:ary] = ary
end

db.transaction do
  ary = db.fetch(:ary, [])
  p ary
  db.delete(:ary)
end
{% endraw %}
{% endhighlight %}


実行例:

{% highlight text %}
{% raw %}
[]
[0, 1, 2]
{% endraw %}
{% endhighlight %}


PStore#abort と PStore#commit で、その transaction での PStore への変更を破棄したり、即座に変更を反映して transaction を抜けたり出来ます。
transaction の中で例外が発生した場合も abort と同様に変更は保存されずに transaction を抜けます。

PStore#path は、PStore のデータファイルのパスを返します。

{% highlight text %}
{% raw %}
require 'pstore'
db = PStore.new('/tmp/foo')
db.transaction do
  db['foo'] = 'bar'
  p [1, db['foo']]
  db.abort
  p [2, db['foo']] # abort したので実行されない
end
db.transaction do
  db.delete('foo')
  p [3, db['foo']]
  db.commit
  p [4, db['foo']] # commit したので実行されない
  db['foo'] = 'bar' # 実行されないので delete されたまま
end
db.transaction(true) do
  p [5, db['foo']]
end
p db.path
{% endraw %}
{% endhighlight %}


実行例:

{% highlight text %}
{% raw %}
[1, "bar"]
[3, nil]
[5, nil]
"/tmp/foo"
{% endraw %}
{% endhighlight %}


### PStore の特徴

内部で Marshal を使っているため、以下の特徴があります。

* データファイルの内容はバイナリになるため、エディタなどでデータファイルの内容を直接編集することは出来ません。
* データファイルが壊れてしまった場合は、バックアップファイルがある場合はそのファイルを試すことが出来ますが、それも壊れていた場合は復旧はほぼ不可能です。
* IO や Proc などの Marshal.dump が出来ないオブジェクトは保存することが出来ませんが、Marshal.dump 出来るオブジェクトなら何でも保存できて、Marshal.load 出来るものは何でも読み込めます。
* Marshal::MAJOR_VERSION が違う Ruby で保存された PStore のデータファイルは扱えません。現在の Marshal::MAJOR_VERSION は 4 で Ruby 1.0 の頃から変わっていないため、将来 Marshal::MAJOR_VERSION があがるまで気にする必要はないでしょう。
* Marshal::MINOR_VERSION が小さいバージョンの Ruby で保存された PStore のデータファイルを Marshal::MINOR_VERSION が大きいバージョンの Ruby で読み込むことは出来ますが、逆に大きい Marshal::MINOR_VERSION のデータファイルは読み込めません。Ruby インタープリタをバージョンダウンしたり、他の環境へ PStore のデータファイルを持って行ったりすることがない限り、気にする必要はないでしょう。


### Windows 上での注意事項

ruby 1.8.5 以前の pstore.rb には[バイナリモードに関するバグ](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/29518)があるため、以下のスクリプトを実行して「found pstore.rb bug!」と表示された場合は[修正済みの pstore.rb をダウンロード](http://www.ruby-lang.org/cgi-bin/cvsweb.cgi/~checkout~/ruby/lib/pstore.rb?rev=1.17.2.7;content-type=application%2Fx-ruby)して使ってください。

{% highlight text %}
{% raw %}
require 'pstore'
db = PStore.new('bugcheck')
begin
  db.transaction do
    db['bugcheck'] = "\x1a"
  end
  db.transaction do
    if db['bugcheck'] == "\x1a"
      puts "OK"
    end
  end
rescue ArgumentError
  puts "found pstore.rb bug!"
end
{% endraw %}
{% endhighlight %}


## YAML::Store

YAML::Store は PStore と同じように Ruby のオブジェクトを YAML 形式で外部ファイルに保存します。
保存されるデータファイルの内容は YAML 形式のテキストで基本的に UTF-8N (BOM なしの UTF-8) になります。

### 基本的な使い方

YAML::Store の使い方は基本的に PStore と全く同じです。
[プログラマーのための YAML 入門 (中級編)]({% post_url articles/0010/2005-10-10-0010-YAML %}) も参考にしてください。

{% highlight text %}
{% raw %}
require 'yaml/store'
db = YAML::Store.new('/tmp/foo.yaml')
db.transaction do
  db['foo'] = 'bar'
end
db.transaction(true) do
  p db['foo']
end
{% endraw %}
{% endhighlight %}


実行例:

{% highlight text %}
{% raw %}
"bar"
{% endraw %}
{% endhighlight %}


実行後の /tmp/foo.yaml の例:

{% highlight text %}
{% raw %}
---
foo: bar
{% endraw %}
{% endhighlight %}


YAML::Store には Hash でオプションを指定することも出来ます。

オプションの詳細は
[http://yaml4r.sourceforge.net/doc/page/the_options_hash.htm](http://yaml4r.sourceforge.net/doc/page/the_options_hash.htm)
を参照してください。

{% highlight text %}
{% raw %}
require 'yaml/store'
db = YAML::Store.new('/tmp/foo.yaml', :SortKeys => true)
db.transaction do
  db['foo'] = 'bar'
  db['hoge'] = 'fuga'
end
db.transaction(true) do
  p db.roots
end
{% endraw %}
{% endhighlight %}


実行例:

{% highlight text %}
{% raw %}
["hoge", "foo"]
{% endraw %}
{% endhighlight %}


実行後の /tmp/foo.yaml の例:

{% highlight text %}
{% raw %}
---
hoge: fuga
foo: bar
{% endraw %}
{% endhighlight %}


### YAML::Store の特徴

内部で YAML を使っているため、以下の特徴があります。

* YAML はテキスト形式のため、データファイルをテキストエディタで直接編集できます。
* YAML は UTF-8 のテキスト形式のため、UTF-8 ではない String を YAML.dump すると、バイナリ扱いされて base64 などで格納される可能性があります。([[ruby-list:42204]](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/42204) あたりの話によると、Ruby 1.8.3 からの仕様変更のようです。)
* YAML.dump が出来るのに YAML.load が出来ないオブジェクトを格納してしまうとデータファイルを読み込めなくなります。そういう状態になってしまった場合は、テキストエディタでデータファイルを直接編集して原因となるオブジェクトを表す部分を削除するなどの対処が必要になります。


#### 読み込めなくなる例

Proc のように YAML.dump が出来るのに YAML.load が出来ないオブジェクトを格納してしまうと、以下の例のように transaction に入ることが出来なくなるので注意しましょう。

{% highlight text %}
{% raw %}
require 'yaml/store'
db = YAML::Store.new('/tmp/proc.yaml')
begin
  db.transaction do
    db["proc"] = proc{}
  end
  db.transaction(true) {}
rescue TypeError
  p $!
end
{% endraw %}
{% endhighlight %}


実行例:

{% highlight text %}
{% raw %}
#<TypeError: allocator undefined for Proc>
{% endraw %}
{% endhighlight %}


実行後の /tmp/proc.yaml の例:

{% highlight text %}
{% raw %}
---
proc: !ruby/object:Proc {}
{% endraw %}
{% endhighlight %}


## 独自形式の Store の作成

Marshal や YAML のように dump と load が出来る機能があれば、PStore を継承して他の形式の Store を簡単に作成することが出来ます。

### オーバーライドすべきメソッド

最低限以下のメソッドをオーバーライドすれば独自形式の Store を作ることが出来ます。
継承により transaction の処理などは PStore の機能をそのまま使うことが出来ます。

initialize(filename)
:  initialize は YAML::Store のように別途オプションを受け取るなど、ファイル名以外を受け取る必要がなければ定義する必要はありません。

dump(table)
:  dump は Marshal.dump に相当するメソッドを定義します。

load(content)
:  load は文字列を引数とする Marshal.load に相当するメソッドを定義します。

load_file(file)
:  load_file は File オブジェクトを引数とする Marshal.load に相当するメソッドを定義します。(が実際には使われていないので不要です。)

### XMLStore

ここでは例として、SOAP::Marshal を使って作った XMLStore を紹介します。

内容は短いのでここに全文を載せます。

[xmlstore.rb]({{site.baseurl}}/images/0016-BundledLibraries/xmlstore.rb)

```ruby
#
# XMLStore
#
# Copyright (c) 2005 Kazuhiro NISHIYAMA.
# You can redistribute it and/or modify it under the same terms as Ruby.
#
# $Id: xmlstore.rb,v 1.1 2005/03/09 13:58:25 znz Exp $

require 'pstore'
require 'soap/marshal'

class XMLStore < PStore
  def initialize(filename)
    super(filename)
  end

  def dump(table)
    SOAP::Marshal.dump(table)
  end

  def load(content)
    SOAP::Marshal.load(content)
  end

  def load_file(file)
    SOAP::Marshal.load(File.open(file, "rb"){|f| f.read})
  end
end

```

使い方は PStore や YAML::Store と同じです。

{% highlight text %}
{% raw %}
require 'xmlstore'
db = XMLStore.new('/tmp/foo.xml')
db.transaction do
  db['foo'] = 'bar'
  db['hoge'] = 'fuga'
end
db.transaction(true) do
  p db.roots
end
{% endraw %}
{% endhighlight %}


実行例:

{% highlight text %}
{% raw %}
["hoge", "foo"]
{% endraw %}
{% endhighlight %}


実行後の /tmp/foo.xml の例:

{% highlight text %}
{% raw %}
<?xml version="1.0" encoding="utf-8" ?>
<env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <env:Body>
    <Hash xmlns:n1="http://xml.apache.org/xml-soap"
        xsi:type="n1:Map"
        env:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
      <item>
        <key xsi:type="xsd:string">hoge</key>
        <value xsi:type="xsd:string">fuga</value>
      </item>
      <item>
        <key xsi:type="xsd:string">foo</key>
        <value xsi:type="xsd:string">bar</value>
      </item>
    </Hash>
  </env:Body>
</env:Envelope>
{% endraw %}
{% endhighlight %}


### JsonStore

もう一つの例として、ActiveSupport の to_json を使って作ってみた JsonStore を紹介します。
これも短いので全体を載せておきます。rubygems で ActiveSupport がインストールされていることを想定しています。
[YAML is JSON](http://redhanded.hobix.com/inspect/yamlIsJson.html) に書いてあるように、JSON は YAML の制限をきつくしたものと見なせるので、load には YAML.load を使っています。

{% highlight text %}
{% raw %}
require 'pstore'
require 'yaml'
require 'rubygems'
require 'active_support'

class JsonStore < PStore
  def initialize(filename)
    super(filename)
  end

  def dump(table)
    table.to_json
  end

  def load(content)
    YAML.load(content)
  end
end
{% endraw %}
{% endhighlight %}


to_json は Symbol が文字列になるなど、JavaScript の仕様にあわせているため、load しても元通りにならないので、JsonStore は実用には向かないと思いますが、このように簡単に独自形式の Store が作れるという例として参考にしてください。

## おわりに

今回は PStore を中心に PStore を継承して独自形式の Store を作成する方法までを紹介しました。
自作のアプリケーションでの手軽なデータ保存に活用していただければ幸いです。

## 関連リンク

* [ruby-man:PStore](ruby-man:PStore)
* [ruby-man:Marshal](ruby-man:Marshal)
* [ruby-man:YAML::Store](ruby-man:YAML::Store)
* [プログラマーのための YAML 入門 (中級編)]({% post_url articles/0010/2005-10-10-0010-YAML %})
* [http://yaml4r.sourceforge.net/doc/](http://yaml4r.sourceforge.net/doc/)
* [http://yaml4r.sourceforge.net/doc/page/the_options_hash.htm](http://yaml4r.sourceforge.net/doc/page/the_options_hash.htm)
* [http://cvs.sourceforge.jp/cgi-bin/viewcvs.cgi/ruexli/ruexli/lib/xmlstore.rb](http://cvs.sourceforge.jp/cgi-bin/viewcvs.cgi/ruexli/ruexli/lib/xmlstore.rb)
* [YAML is JSON](http://redhanded.hobix.com/inspect/yamlIsJson.html)


## 著者について

西山和広。
[Ruby hotlinks 五月雨版](http://www.rubyist.net/~kazu/samidare/)や
現在の [Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)のメンテナをやっています。
[Ruby リファレンスマニュアル](http://www.ruby-lang.org/ja/man/)はいつでも[執筆者募集中](ruby-man:執筆者募集)です。
何かあれば、マニュアル執筆編集に関する議論をするためのメーリングリスト rubyist@freeml.com ([参加方法](http://www.freeml.com/ctrl/html/MLInfoForm/rubyist)) へどうぞ。

Ruby リファレンスマニュアルは現在青木さんによる新システムに移行準備中です。
手伝っていただける方は [ruby-reference-manual ML](http://www.loveruby.net/d/20060904.html#p01) に入ってください。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{ post.url }})
{% endfor %}


