---
layout: post
title: 標準添付ライブラリ紹介 【第 3 回】 Kconv/NKF/Iconv
short_title: 標準添付ライブラリ紹介 【第 3 回】 Kconv/NKF/Iconv
tags: 0009 BundledLibraries
---
{% include base.html %}


* Table of content
{:toc}


書いた人: 成瀬

## はじめに

### この連載について

Ruby 1.8 になって標準添付ライブラリが増えました。そんなライブラリをどんどん紹介していこうという連載です。

### 今回の記事について

今回は Kconv, NKF, Iconv といった、文字コード変換のためのライブラリを紹介します。

## 文字コード

### 文字コードとは

文章を読もうとしたら文字化けしてしまっていて困った、という経験は誰しもあるでしょう。しょうがないので調べると、文字コードを変換すれば読めるようになる、などとの説明を見つけることが出来るでしょう。多くの方の「文字コードとの出会い」は、おそらくこのあたりなのではないでしょうか。さて、そんな文字コードですが、そもそもいったい何者なのでしょうか。

文章をコンピュータで扱おう思うと、文字をコンピュータで扱わなければなりません。しかし、ご存知のとおり、基本的にコンピュータは 0 と 1 しか扱えないため、文字をコンピュータが扱える形に変換する (符号化する) 仕組みが必要となります。この仕組みが文字符号化であり、符号化の仕方の一つ一つが文字コードです。

コンピュータの扱う情報量の最小単位は 0 か 1 によって表される情報量であり、これを bit と呼びます。通常は 8bit (1octet) を一組にして 1byte とし、これを基本にしてコンピュータは情報をやりとりします。文字も同様に byte を一単位としてやりとりすることになります。つまり、文字コード[^1]とは、文字を byte の列に変換する体系のことと言えるのです。

### 文字コードの種類

文字コードは一つではありません。例えば日本語を表すのに用いられる文字コードには、主に以下のようなものがあります。

* ISO-2022-JP (JIS)
* Shift_JIS (亜種として CP932)
* EUC-JP
* UTF-8
* UTF-16


異なる文字コードで表された文章は、一般に異なるバイト列に変換されます。そのため、例えば Shift_JIS で表された文書を、 EUC-JP として表示しようとすると、正しくその文書を見ることが出来ません。これが文字化けです。

文字化けの解決方法は二つあります。

一つはその文書を正しい文字コードで表示することです。多くのプログラムはいくつかの文字コードに対応しているので、正しい文字コードで表示しなおせば、文書を見ることが出来ます。この例の場合では、 Shift_JIS として文書を開きなおせば文字化けせずに読めます。

もう一つはその文書を都合のいい文字コードに変換する事です。文字コード変換プログラムによって、自分の扱いやすい文字コードに変換してしまえば、後は気楽にその文書を扱う事が出来ます。この例の場合では、 Shift_JIS から EUC-JP に文書の文字コードを変換してしまえばいいのです。

## Ruby の文字コード変換ライブラリ

さて、では実際に Ruby で文字コードを変換してみましょう。Ruby では主に以下のような文字コード変換ライブラリが用いられており、このうち最初の三つの文字コード変換ライブラリは ruby に標準で添付されています。

* Kconv
* NKF
* Iconv
* Uconv


なお、紛らわしい名称のライブラリとして、 [jcode.rb](ruby-man:jcode.rb) が存在しますが、これは Perl の [jcode.pl](http://srekcah.org/jcode/) とは役割が異なり、Ruby に文字志向の処理を行わせるためのモジュールです。

## Kconv

Ruby 1.8.2以降においては、日本語の文字コード変換は Kconv を使えば、たいていの場合は事足りるでしょう。それ以前の Kconv でも、 Unicode 系の変換は出来ませんが、Shift_JIS, EUC-JP, ISO-2022-JP の相互変換が可能です。

なお、 Kconv は自動的に、 MIME をデコードしたり、半角カタカナを全角カタカナに変換したりしてしまいますが、このような動作を好まない場合は、後述のとおり、 NKF モジュールを直接用いる必要があります。

### 基本的な変換

最も容易なのは Kconv#to* を用いる事でしょう。これでは変換元の文字列の文字コードを推測し、文字コードを変換します。以下に例を示します。

{% highlight text %}
{% raw %}
require 'kconv'

str = 'Hello, るびま！'     # 何かしらの文字コードの文字列

str_eucjp     = str.toeuc   # 文字コードを自動判定し、 EUC-JP に変換

str_shiftjis  = str.tosjis  # Shift_JIS に変換

str_iso2022jp = str.tojis   # ISO-2022-JP (JIS) に変換

str_utf8      = str.toutf8  # UTF-8 に変換

str_utf16     = str.toutf16 # BOM 無し UTF-16BE に変換
{% endraw %}
{% endhighlight %}


### 文字コードを明示した変換

先述の Kconv#to* では変換元の文字コードを推測しているため、推測が外れていた場合は変換結果が文字化けしてしまいます。このような危険性を避けるため、変換元の文字コードが分かっている場合は、なるべく文字コードを明示的に指定するようにしましょう。

Kconv では文字コードは定数で指定します。

| 定数	| 値	| 文字コード|
| JIS	| 1	| ISO-2022-JP|
| EUC	| 2	| EUC-JP|
| SJIS	| 3	| Shift_JIS|
| BINARY| 4	| バイナリ|
| ASCII	| 5	| ASCII|
| UTF8	| 6	| UTF-8|
| UTF16	| 8	| UTF-16|


これらの定数を用いて、例えば以下のように変換を行います。

{% highlight text %}
{% raw %}
# EUC-JP で表された 'Hello, るびま！'
str_eucjp     = "\x48\x65\x6c\x6c\x6f\x2c\x20\xa4\xeb\xa4\xd3\xa4\xde\xa1\xaa"

str_shiftjis  = str.kconv(Kconv::SJIS,  Kconv::EUC) # EUC-JP から Shift_JIS に変換

str_iso2022jp = str.kconv(Kconv::JIS,   Kconv::EUC) # EUC-JP から ISO-2022-JP (JIS) に変換

str_utf8      = str.kconv(Kconv::UTF8,  Kconv::EUC) # EUC-JP から UTF-8 に変換

str_utf16     = str.kconv(Kconv::UTF16, Kconv::EUC) # EUC-JP から BOM 無し UTF-16BE に変換
{% endraw %}
{% endhighlight %}


### 文字コードの推測

Kconv.guess によって与えられた文字列の文字コードを推測することができます。

{% highlight text %}
{% raw %}
# ISO-2022-JP で表された 'Hello, るびま！'
str_iso2022jp = "\x48\x65\x6c\x6c\x6f\x2c\x20\x1b\x24\x42\x24\x6b\x24\x53\x24\x5e\x21\x2a\x1b\x28\x42"

Kconv.guess(str_iso2022jp) # => 1 == Kconv::JIS

# EUC-JP で表された 'Hello, るびま！'
str_eucjp     = "\x48\x65\x6c\x6c\x6f\x2c\x20\xa4\xeb\xa4\xd3\xa4\xde\xa1\xaa"

Kconv.guess(str_eucjp)     # => 2 == Kconv::EUC

# Shift_JIS で表された 'Hello, るびま！'
str_shiftjis  = "\x48\x65\x6c\x6c\x6f\x2c\x20\x82\xe9\x82\xd1\x82\xdc\x81\x49"

Kconv.guess(str_shiftjis)  # => 3 == Kconv::SJIS

# UTF-8 で表された 'Hello, るびま！'
str_utf8 = "\x48\x65\x6c\x6c\x6f\x2c\x20\xe3\x82\x8b\xe3\x81\xb3\xe3\x81\xbe\xef\xbc\x81"

Kconv.guess(str_utf8)      # => 6 == Kconv::UTF8

# UTF-16BE (BOM 付き) で表された 'Hello, るびま！'
str_utf16be = "\xfe\xff\x0\x48\x0\x65\x0\x6c\x0\x6c\x0\x6f\x0\x2c\x0\x20\x30\x8b\x30\x73\x30\x7e\xff\x1"

Kconv.guess(str_utf16be)   # => 8 == Kconv::UTF16

# UTF-16LE (BOM 付き) で表された 'Hello, るびま！'
str_utf16le = "\xff\xfe\x48\x0\x65\x0\x6c\x0\x6c\x0\x6f\x0\x2c\x0\x20\x0\x8b\x30\x73\x30\x7e\x30\x1\xff"

Kconv.guess(str_utf16le)   # => 8 == Kconv::UTF16
{% endraw %}
{% endhighlight %}


なお、Kconv.guess による文字コードの推測は、 UTF-16 については BOM 付きにのみ対応しています。

### BUGS

ruby 1.8.2 の Kconv には以下のようなバグが存在します。

#### 文字コードの自動判定の精度が低い

NKF モジュール由来のバグで、文字コードの自動判定精度が下がっています。変換元の文字コードが分かっている場合は、to* 系のメソッドを用いず、 String#kconv や Kconv.kconv 、 NKF.nkf を用いて、変換元の文字コードを明示的に指定するようにしましょう。

なお、この問題は ruby 1.9 及び ruby 1.8 系の最新版では既に修正されており、 ruby 1.8.3 では修正された版が添付されます。

ruby 1.8.2 でこの問題を回避したい場合は以下のような方法が挙げられます。

* Kconv.guess の代わりに Kconv.guess_old を用いる
* ruby 1.9 や ruby 1.8 の最新の NKF モジュールを用いる


i386-freebsd4 ならば、 [2.0.5-i386-freebsd4](https://sourceforge.jp/projects/nkf/files/?release_id=15690#15690) を用いることもできます。一応さくらインターネットのレンタルサーバでの動作を確認はしています、保障は出来ませんが。

#### String#kconv 及び Kconv.kconv で Unicode 系の文字コードが指定できない

ruby 1.8.2 に添付されている kconv.rb では String#kconv 及び Kconv.kconv において、 Unicode系の文字コードの指定ができないバグが存在します。

なお、この問題は ruby 1.9 及び ruby 1.8 系の最新版では既に修正されており、 ruby 1.8.3 では修正された版が添付されます。

ruby 1.8.2 でこの問題を回避したい場合は以下のような方法が挙げられます。

* NKF.nkf を直接用いる
* [ruby 1.8 の kconv.rb](http://www.ruby-lang.org/cgi-bin/cvsweb.cgi/ruby/ext/nkf/lib/kconv.rb?only_with_tag=ruby_1_8) を用いる
* [ruby 1.9 の kconv.rb](http://www.ruby-lang.org/cgi-bin/cvsweb.cgi/ruby/ext/nkf/lib/kconv.rb?only_with_tag=HEAD) を用いる


### 関連リンク

[ruby-man:Kconv](ruby-man:Kconv)
: Kconv クラスについてのマニュアル。

[ruby-man:kconv.rb](ruby-man:kconv.rb)
: Kconv が String クラスに追加するメソッドについてのマニュアル。

[ruby-man:trap::Kconv](ruby-man:trap::Kconv)
: Kconv で陥りやすい罠

## NKF

ものすごく古い漢字コード変換プログラムである nkf を Ruby から用いるためのライブラリです。1.8.2 から nkf 2.0 ベースになったため、 Unicode 系の変換に対応しました。上記の Kconv は、内部では NKF を用いて変換を行っています。

### 基本的な変換

NKF は変換を converted = NKF.nkf( option_string, string ) といった文法で行います。オプションを文字列として与える方法は複雑で覚えづらいものではありますが、その一方で Kconv を使う場合に比べてはるかに複雑な処理を行うことが可能となります。なお、オプションは NKF モジュールのベースとなっている nkf のオプションをほぼ全て使うことが出来ます。

{% highlight text %}
{% raw %}
require 'nkf'

str = 'Hello, るびま！'            # 何かしらの文字コードの文字列

str_eucjp     = NKF.nkf('-e', str) # 文字コードを自動判定し、 EUC-JP に変換

str_shiftjis  = NKF.nkf('-s', str) # Shift_JIS に変換

str_iso2022jp = NKF.nkf('-j', str) # ISO-2022-JP (JIS) に変換

str_utf8      = NKF.nkf('-w', str) # UTF-8 に変換
{% endraw %}
{% endhighlight %}


### 主なオプション

#### -e, -s, -j -w, -w16

出力する文字コードを指定します。

| 文字コード	| オプション	| ロングオプション|
| EUC-JP	| -e		| --euc|
| Shift_JIS	| -s		| --sjis|
| ISO-2022-JP	| -j		| --jis|
| UTF-8N	| -w		| --utf8|
| UTF-8 BOM	| -w8		|
| UTF-8N	| -w80		|
| UTF-16BE N	| -w16		| --utf16|
| UTF-16BE BOM	| -w16B		|
| UTF-16BE N	| -w16B0	|
| UTF-16LE BOM	| -w16L		|
| UTF-16LE N	| -w16L0	|


#### -E, -S, -J -W, -W16

入力する文字コードを指定します。指定しなくても自動判定が効きますが、誤判定のリスクを避ける意味でも、入力する文字コードが分かっている場合は明示的に指定するべきです。

| 文字コード	| オプション	| ロングオプション|
| EUC-JP	| -E		| --euc-input|
| Shift_JIS	| -S		| --sjis-input|
| ISO-2022-JP	| -J		| --jis-input|
| UTF-8N	| -W		| --utf8-input|
| UTF-8 BOM	| -W8		|
| UTF-8N	| -W80		|
| UTF-16BE N	| -W16		| --utf16-input|
| UTF-16BE BOM	| -W16B		|
| UTF-16BE N	| -W16B0	|
| UTF-16LE BOM	| -W16L		|
| UTF-16LE N	| -W16L0	|


#### -L, -c, -d

改行コードを変換します。

| 改行	| オプション	| 使われるシステム|
| LF	| -Lu, -d	| Unix系|
| CRLF	| -Lw, -c	| Windows|
| CR	| -Lm		| Macintosh|


#### -m, -M

MIME decode/encode のためのオプションです。 nkf はデフォルトで MIME encoded-word のデコードを試みるため、この動作を望まない場合は -m0 を指定してください。

#### -x, -X

-X を指定すると、 nkf は半角カタカナを自動的に全角カタカナに変換します。 -X はデフォルトで指定されているため、この動作を望まない場合は -x を指定してください。

### その他の便利なオプション

#### --cp932

Windows 互換の文字コード変換、つまり  CP932 や eucJP-ms 互換の変換を行います。具体的には、「??????｜」のような文字を Unicode へと変換した時に化ける問題や、 Windows の機種依存文字が変換できない問題は、このオプションを指定する事によって回避することができます。

#### --hiragana, --katakana

ひらがなやカタカナを相互に変換します。

| オプション	| ロングオプション	| 機能|
| -h1		| --hiragana		| カタカナをひらがなに変換|
| -h2		| --katakana		| ひらがなをカタカナに変換|
| -h3		| --katakana-hiragana	| カタカナとひらがなを交換|


#### -f, -F

禁則を考慮した折り返しを行います。禁則は通常半角 60 文字で行われますが、明示的に -f40 と指定すると半角 40 文字で、 -f80 と指定すると半角 80 文字で折り返します。

通常、禁則は半角 10 文字までの範囲で禁則文字をぶら下げ、それ以上は強制的に改行しますが、明示的に -f40-5 と指定すると強制改行の余地 (fold-margin) を半角 5 文字に指定できます。禁則処理を行わない場合は -f40-0 などと指定します。

-f では改行が全て半角空白に置き換えられてしまいますが、 -F では改行が保存されます。

### BUGS

ruby 1.8.2 の NKF には以下のようなバグが存在します。

#### 文字コードの自動判定の精度が低い

NKF モジュール由来のバグで、文字コードの自動判定精度が下がっています。変換元の文字コードが分かっている場合は、 NKF.nkf を用いて、変換元の文字コードを明示的に指定するようにしましょう。

なお、この問題は ruby 1.9 及び ruby 1.8 系の最新版では既に修正されており、ruby 1.8.3 では修正された版が添付されます。

ruby 1.8.2 でこの問題を回避したい場合は以下のような方法が挙げられます。

* NKF.guess の代わりに NKF.guess1 を用いる
* ruby 1.9 や ruby 1.8 の最新の NKF モジュールを用いる


i386-freebsd4 ならば、 [2.0.5-i386-freebsd4](https://sourceforge.jp/projects/nkf/files/?release_id=15690#15690) を用いることもできます。一応さくらインターネットのレンタルサーバでの動作を確認はしています、保障は出来ませんが。

### 関連リンク

[ruby-man:NKF](ruby-man:NKF)
: NKF クラスについてのマニュアル。

[ruby-man:trap::NKF](ruby-man:trap::NKF)
: NKF で陥りやすい罠

[プロジェクト: nkf Network Kanji Filter](https://sourceforge.jp/projects/nkf/)
: nkf の配布サイト

## Iconv

UNIX 系で主に使われる iconv を Ruby から利用するためのライブラリです。そのシステムに存在する iconv を利用するため、実際にどのような文字コードを利用できるかはプラットフォームに依存します。

### 基本的な変換

Iconv クラスには様々なメソッドがありますが、通常は Iconv.conv を用いればいいでしょう。

Iconv.conv は

{% highlight text %}
{% raw %}
result = Iconv.conv(to, from, str)
{% endraw %}
{% endhighlight %}


のように用います。

それぞれの引数の意味は以下の通りです。

result
: 変換された文字列

to
: 変換先の文字コード

from
: 変換元の文字コード

str
: 変換元の文字列

{% highlight text %}
{% raw %}
require 'iconv'

# EUC-JP で表された 'Hello, るびま！'
str_eucjp     = "\x48\x65\x6c\x6c\x6f\x2c\x20\xa4\xeb\xa4\xd3\xa4\xde\xa1\xaa"

str_shiftjis  = Iconv.conv('Shift_JIS', 'EUC-JP', str_eucjp)   # EUC-JP から Shift_JIS に変換

str_utf8      = Iconv.conv('UTF-8', 'Shift_JIS', str_shiftjis) # Shift_JIS から UTF-8 に変換
{% endraw %}
{% endhighlight %}


なお、変換先・変換元の文字コードを指定する文字列も、プラットフォームに依存します。しかし、この問題は charset_alias.rb という仕組みによって解決が図られており、日本語では 'Shift_JIS', 'cp932', 'EUC-JP', 'UTF-8' は、実装されていれば、それぞれの文字列で指定できるようになっています。

### CP932 や eucJP-ms の変換

Windows 機種依存文字等の日本語関係の文字コード変換を Iconv モジュールで行うには、対策を施してある iconv ライブラリを用いる必要があります。具体的には以下のライブラリを使う事になるでしょう。

* [glibc-2.3.3](http://www.gnu.org/software/libc/libc.html) 以降
* glibc-2.2.5/2.3.1/2.3.2 に[パッチ](http://www2d.biglobe.ne.jp/~msyk/software/glibc/)を適用したもの
* [libiconv](http://www.gnu.org/software/libiconv/) に[パッチ](http://www2d.biglobe.ne.jp/~msyk/software/libiconv-patch.html)を適用したもの


その他の iconv 、例えば NetBSD Iconv (Citrus Iconv) では、いくつか[^2]の機種依存文字が変換できないため、 pkgsrc 等から libiconv を別途インストールして用いる必要があります。

また、 Windows の機種依存文字を含んだ Shift_JIS は cp932 を、 EUC-JP は eucJP-ms を指定する必要があります。

{% highlight text %}
{% raw %}
roman_one = "\x87\x54" # cp932 での ローマ数字の I

str_eucjpms = Iconv.conv('eucJP-ms', 'cp932', roman_one) # cp932 から eucJP-ms に変換
{% endraw %}
{% endhighlight %}


### Iconv がインストールされない

FreeBSD 等のように標準で、 iconv 等が /usr/local 下にインストールされる OS の場合、ruby を自分で make すると Iconv 等がインストールされない場合があります。このような場合には、 configure する際に iconv 等の位置を指定しましょう。

{% highlight text %}
{% raw %}
./configure --with-opt-dir=/usr/local
{% endraw %}
{% endhighlight %}


### 関連リンク

[ruby-man:Iconv](ruby-man:Iconv)
: Iconv クラスについてのマニュアル。

[GNU libiconv](http://www.gnu.org/software/libiconv/)
: GNU libiconv の配布サイト

[Citrus Project](http://citrus.bsdclub.org/)
: NetBSD の iconv 実装を行った、 Citrus Project のサイト

[ミラクルリナックス:Samba 国際化プロジェクト &gt; iconvについて](http://www.miraclelinux.com/technet/samba30/iconv_issues.html)
: iconv における CP932 と eucJP-ms への対応について

## Uconv

Uconv は Unicode 系と CP932 および EUC-JP との相互変換を行います。また、その他 UTF のバイトオーダーに関する処理等も行う事が出来ます。なお、レンタルサーバーを使っている等の事情で C 言語版の Uconv を用いる事が出来ない場合は、 PureRuby 版である [rbuconv](http://www.yoshidam.net/Ruby_ja.html#rbuconv) を用いるとよいでしょう。

### Unicode 系と CP932 および EUC-JP との相互変換

ここにおいては、基本的に UTF-16 および UTF-32 は常にリトルエンディアンです。ビッグエンディアンでの文字列が欲しい場合は後述の u16swap または u4swap によって、エンディアンを変更する必要があります。

| 変換元?変換先| EUC-JP	| CP932		| UTF-8		| UTF-16LE	| UTF-32LE|
| EUC-JP	| ?		| -		| euctou8	| euctou16	| -|
| CP932		| -		| ?		| sjistou8	| sjistou16	| -|
| UTF-8		| u8toeuc	| u8tosjis	| ?		| u8tou16	| u8tou4|
| UTF-16LE	| u16toeuc	| u16tosjis	| u16tou8	| ?		| u16tou4|
| UTF-32LE	| -		| -		| u4tou8	| u4tou16	| ?|


{% highlight text %}
{% raw %}
require 'uconv'

# EUC-JP で表された 'Hello, るびま！'
str_eucjp   = "\x48\x65\x6c\x6c\x6f\x2c\x20\xa4\xeb\xa4\xd3\xa4\xde\xa1\xaa"
str_utf8    = Uconv.euctou8(str_eucjp)     # UTF-8 に変換
str_utf16le = Uconv.euctou16(str_eucjp)    # UTF-16LE に変換

# CP932 で表された 'Hello, るびま！'
str_cp932   = "\x48\x65\x6c\x6c\x6f\x2c\x20\x82\xe9\x82\xd1\x82\xdc\x81\x49"
str_utf8    = Uconv.sjistou8(str_cp932)    # UTF-8 に変換
str_utf16le = Uconv.sjistou16(str_cp932)   # UTF-16LE に変換

# UTF-8 で表された 'Hello, るびま！'
str_utf8    = "\x48\x65\x6c\x6c\x6f\x2c\x20\xe3\x82\x8b\xe3\x81\xb3\xe3\x81\xbe\xef\xbc\x81"
str_euc     = Uconv.u8toeuc(str_utf8)      # EUC-JP に変換
str_cp932   = Uconv.u8tosjis(str_utf8)     # CP932 に変換
str_utf16le = Uconv.u8tou16(str_utf8)      # UTF-16LE に変換
str_utf32le = Uconv.u8tou4(str_utf8)       # UTF-32LE に変換

# UTF-16LE (BOM 付き) で表された 'Hello, るびま！'
str_utf16le = "\xff\xfe\x48\x0\x65\x0\x6c\x0\x6c\x0\x6f\x0\x2c\x0\x20\x0\x8b\x30\x73\x30\x7e\x30\x1\xff"
str_euc     = Uconv.u16toeuc(str_utf16le)  # EUC-JP に変換
str_cp932   = Uconv.u16tosjis(str_utf16le) # CP932 に変換
str_utf8    = Uconv.u16tou8(str_utf16le)   # UTF-8 に変換
str_utf32le = Uconv.u16tou4(str_utf16le)   # UTF-32LE に変換

# UTF-32LE (BOM 付き) で表された 'Hello, るびま！'
str_utf32le = "\xff\xfe\x00\x00\x48\x00\x00\x00\x65\x00\x00\x00\x6c\x00\x00\x00" \
  + "\x6c\x00\x00\x00\x6f\x00\x00\x00\x2c\x00\x00\x00\x20\x00\x00\x00" \
  + "\x8b\x30\x00\x00\x73\x30\x00\x00\x7e\x30\x00\x00\x01\xff\x00\x00"
str_utf8    = Uconv.u4tou8(str_utf32le)    # UTF-8 に変換
str_utf16le = Uconv.u4tou16(str_utf32le)   # UTF-16LE に変換
{% endraw %}
{% endhighlight %}


### Unicode 系でのバイトスワップ

Unicode でのバイトオーダー変更、つまりビッグエンディアンとリトルエンディアンを相互変換します。

| エンコーディング	| メソッド名|
| UTF-16		| u16swap|
| UTF-32		| u4swap|


{% highlight text %}
{% raw %}
# UTF-16 のバイトスワップ
str_utf16be  = Uconv.u16swap(str_utf16le) # UTF-16BE に変換
str_utf16le  = Uconv.u16swap(str_utf16be) # UTF-16LE に変換

# UTF-32 のバイトスワップ
str_utf32be  = Uconv.u4swap(str_utf32le)  # UTF-32BE に変換
str_utf32le  = Uconv.u4swap(str_utf32be)  # UTF-32LE に変換
{% endraw %}
{% endhighlight %}


### 関連リンク

[Uconv/rbuconv](http://www.yoshidam.net/Ruby_ja.html)
: よしだむさんによる Uconv と rbuconv の配布サイト

## その他の関連リンク

[Unicode Technical Report #17: Character Encoding Model](http://www.unicode.org/reports/tr17/)
: Unicode Consortium による文字コードについての説明

[Windows-31J 情報](http://www2d.biglobe.ne.jp/~msyk/charcode/cp932/index.html)
: Windows-31J (CP932) と eucJP-ms についての情報

## 著者について

[成瀬ゆい](http://airemix.com/)

様々な界隈に首を突っ込む多趣味な子。最近は文字コード関連に興味を持っているが、なんとも難しくて、わからないことだらけ。

## 標準添付ライブラリ紹介 連載一覧

{% for post in site.tags.BundledLibraries %}
  - [{{ post.title }}]({{base}}{{ post.url }})
{% endfor %}

----

[^1]: ここで言う文字コード (charset, codeset) は符号化文字集合 (CCS) と符号化方式 (CES) をあわせたもの
[^2]: NetBSD 2.0.2 付属の iconv で試したところ、 CP932 から UTF-8 では 74 文字
