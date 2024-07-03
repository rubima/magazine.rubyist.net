---
layout: post
title: Ruby ビギナーのための CGI 入門 【第 1 回】 2 ページ
short_title: Ruby ビギナーのための CGI 入門 【第 1 回】 2 ページ
created_on: 2005-11-16
tags: 0011 CGIProgrammingForRubyBeginners
---
{% include base.html %}


[目次ページへ]({{base}}{% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners %})
[前ページへ]({{base}}{% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-1 %})
[次ページへ]({{base}}{% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-3 %})

* Table of content
{:toc}


## CGI プログラムに必要なもの

次に CGI プログラムに何が必要か考えてみましょう。
例えば、材料や道具も揃えずに料理を始めてもなかなか上手くいきません。
それと同じでプログラムを作る時もあらかじめ必要な物を予想して、
準備しておいた方が失敗が少なくなります。

これから皆さんが作るのは CGI プログラム ですから、
先ほどの例えの「料理」に相当するものは CGI プログラムです。
CGI プログラムはプログラムですから、
プログラム作成に必要な道具や材料を用意しなければなりません。
ここで (翻訳機としての) Ruby が出てきます。

次に CGI プログラムに固有なものについても考えてみましょう。
最初はブラウザです。
「るびま」 を読んでいる皆さんは   
[Internet Explorer](http://www.microsoft.com/windows/ie_intl/ja/default.mspx)
や
[Firefox](http://www.mozilla.org/)
などを使ってこの記事までたどり着いたと思います。
ブラウザというのは「るびま」のような Web ページを表示させる時に使います。
CGI プログラムの実行結果を見る時にもブラウザを利用するので、
ブラウザが無いと CGI プログラムの実行結果を見れません。
自分が作った CGI プログラムの動くところを見れないのは
面白くないですよね。

ブラウザに加えてもう一つ必要なものがあります。
それはサーバーです。
皆さんの中には自分のサイト (ホームページ) に HTML や画像などをアップロードして
Web ページを公開している人もいると思います。
公開された Webページ はブラウザを使って世界中から見ることが出来ます。
実はその裏ではサーバーと呼ばれるものが働いています。
ブラウザで Web ページにアクセスすると、
サーバーはその Web ページのデータをブラウザに渡します。
この時、サーバーはブラウザへのデータの運び役をしています。

データ運びだけがサーバーの役割ではありません。
サーバーは CGI でも大きな役割を果たします。
ブラウザで掲示板などの CGI プログラムにアクセスすると、
サーバーによって CGI プログラムが実行されて
その結果がブラウザに渡ります。
この場合、サーバーは CGI プログラムの実行役になります。
サーバーが無いと、CGI プログラムを作っても
その CGI プログラムを実行させることが出来ません。

以上をまとめると CGI プログラムに最低限必要な物は以下のようになります。

* プログラミング言語の翻訳機 (この連載では Ruby を用います)
* ブラウザ
* サーバー


## CGI プログラムに必要なものを準備しよう

CGI プログラムに何が必要か分かったところで
実際に必要なものを準備しましょう。
ブラウザの準備は済んでいるはずなので、
ここで用意するのは下の二つです。

* Ruby (の翻訳機)
* サーバー


Ruby でプログラムを書く時は
Ruby (の翻訳機) の他に
テキストエディタがあれば十分です。
例えば、Windows のメモ帳でも Ruby のプログラムを書くことが出来ます。

メモ帳でプログラムを書いても良いのですが、
Windows には Ruby プログラムを書くための
便利な道具があるので、それを使って楽をしましょう。
道具の名前は [RDE](http://homepage2.nifty.com/sakazuki/rde.html) と言います。
RDE は Ruby のプログラムの開発を色々と助けてくれるので、
メモ帳で開発していると面倒なことも RDE だと簡単に出来たりします。

準備は面倒ですが、一回限りです。頑張りましょう。

### Ruby の準備

まずは Ruby (の翻訳機) を用意しましょう。
One-Click Ruby Installer を使って Ruby をインストール (準備) します。

One-Click Ruby Installer を使用しない場合、
自分で設定しなければならない事がありちょっと面倒です。
One-Click Ruby Installer を使うことをお勧めします。

なお、ここで Ruby と書いた場合は
すべて Ruby の翻訳機のことを指します。

#### ダウンロード

__その1__

最初に [http://rubyforge.org/projects/rubyinstaller/](http://rubyforge.org/projects/rubyinstaller/) に行きます。
ページを下の方へスクロールさせると
下図のような「最新ファイルリリース」というところがあるので、
そこの 「ダウンロード」のリンクをクリックします。
![rubyforge_installer.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rubyforge_installer.jpg)

__その2__

表示されたページの上の方に
One-Click Installer - Windows と書かれた項目があります。
そこにダウンロード可能なインストーラーが一覧で表示されています。
インストーラーは rubyXXX-YY.exe (XXXとYYは数字) で示されています。
これをクリックしてダウンロードします。
筆者がダウンロードした時には ruby182-15.exe が最新版でした。
![rubyforge_download.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rubyforge_download.jpg)

__その3__

ダウンロードが完了すると、下のようなファイルが作成
されていると思います。
![installer_donwloaded.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/installer_donwloaded.jpg)

#### インストール

ダウンロードしたファイル (ここでは ruby182-15.exe) を
ダブルクリックして実行します。
可能であれば、実行する前に、自分に Windows の管理者権限があるかどうか
確認しておいて下さい。 

__その1__

インストーラーを実行すると、
下のようなダイアログが表示されるはずです。
「Next」 を選択するとインストールが開始されます。
![installer_startup.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/installer_startup.jpg)

__その2__

次の画面にはインストーラーと 
Ruby ライセンスの説明が書かれています。
Ruby のライセンスが英語で書かれていて
読めないという方は
[http://www.ruby-lang.org/ja/LICENSE.txt](http://www.ruby-lang.org/ja/LICENSE.txt) に
Ruby ライセンスの日本語の説明がありますので、
そちらを参照して下さい。
納得出来たら「I Agree」を押して下さい。
![installer_argeed.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/installer_argeed.jpg)

__その3__

インストールされる内容を選択します。
ここも「Next」 で結構です。
皆さんの中にはインストールの内容を取捨したい方もいるでしょう。
最低でも RubyGems と OpenSSL と Tcl/Tk GUI Libraries の 3 つを
選択することをお勧めします。
その他はお好みで選択して良いと思います。
![installer_content.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/installer_content.jpg)

__その4__

Ruby のインストール場所を指定します。
インストール場所を変更したい場合は
「Destination Folder」に指定します。
インストール場所はデフォルトの C:\ruby でも良いですし、
下図のように D:\app\ruby に変更しても良いです。
スペースが入る C:\Program Files\ruby は止めておきましょう。
トラブルの原因になります。

「Install」を押すとファイルがインストールされます。
![installer_path.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/installer_path.jpg)

__その5__

これでインストールは終了です。「Finish」を押してインストーラーを終了させます。
![installer_done.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/installer_done.jpg)

#### インストールの確認

インストールが完了したかどうかを確認します。
方法その 1 が一番簡単ですが、
この方法は One-Click Ruby Installer に Tcl/TK
が含まれていなければなりません。
もし、含まれていない場合は
方法その 2 を試して下さい。

__方法その1__

インストールのその 3 で Tcl/Tk をインストールした人は

{% highlight text %}
{% raw %}
(Rubyのインストール先)\samples\tk\
{% endraw %}
{% endhighlight %}


にある

{% highlight text %}
{% raw %}
tkline.rb
{% endraw %}
{% endhighlight %}


というファイルをダブルクリックして実行してみて下さい。
黒い画面 (コマンドプロンプト) と何かウィンドウが現れるはずです。
これが出てきたらインストールは完了しています。
![confirm_installation_tk.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/confirm_installation_tk.jpg)

__方法その2__

コマンドプロンプト が必要になります。
Windows XP なら次の手順で起動することが出来ます。

1. スタートボタンをクリック
1. すべてのプログラム をクリック
1. アクセサリ をクリック
1. コマンドプロンプト をクリック


起動したコマンドプロンプトに 

{% highlight text %}
{% raw %}
ruby -v
{% endraw %}
{% endhighlight %}


と入力して、「Enter」キーを押します。下図のように 
Ruby のバージョン・リリースの日付・プラットフォームが
表示されれば OK です。
![confirm_installation.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/confirm_installation.jpg)

### サーバーの準備

サーバーには 
[Apache](http://www.apache.org/) や 
[AN HTTPD](http://www.st.rim.or.jp/~nakata/) などのプログラムがありますが、
これらのプログラムでは CGI を使うために設定が必要となり、多少煩雑です。
そこで、この連載では Ruby で書かれたサーバーを用意しました。
設定をせずに CGI プログラムを試すことが出来ます。

* [rubima011-cgi.zip]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rubima011-cgi.zip)


上のリンクをクリックして
rubima011-cgi.zip をダウンロードし自分のマシンに保存して下さい。
Windows XP を使っている場合は
zip ファイルをダブルクリックしてその中身を C:\ にコピーします。
こうする事で zip ファイルを展開することが出来ます。
今号では __zip ファイルを C:\ に展開した__ という前提で話を進めていきます。

Windows XP 以外の Windows をお使いの方は zip ファイルを
展開するプログラムが必要となります。
zip ファイルを展開するプログラムは多数あるので、
個々のプログラムの説明は出来ません。
ご自分で調べて下さい。
下に zip を展開するプログラムを 1 つだけ紹介します。

* [Lhaz](http://www.chitora.jp/lhaz.html)


### RDE の準備

ここでは RDE のインストールやその設定について説明を行います。 
まずはインストールからです。

#### ダウンロード

__その1__

[http://homepage2.nifty.com/sakazuki/rde.html](http://homepage2.nifty.com/sakazuki/rde.html) に行き、
RDE を ダウンロードします。

ページの上の方に「ダウンロード」という項目があります。
それをクリックすると、
新しく表示されたページの中に ver. 1.x.x (x は数字) というリンクがあるので、
もう一度そこをクリックします。
筆者がこれを書いた時には ver. 1.0.0 でした。
ver 1.0.0 よりも新しいものがあればそれをクリックして下さい。

__その2__

Sourceforge の RDE のページに移動します。
ページの中ほどやや上に RDE binary と書かれたところがあり、
そこから RDE をダウンロードすることが出来ます。
Download RDE1.x.x_setup.exe (x は数字) と書かれたリンクを
クリックします。
![rde_sourceforge1.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_sourceforge1.jpg)

__その3__

RDE をダウンロードするところを選択します。
「Download」 の下の 「xxxx kb」 (x は数字) の
左隣のアイコンをどれでもいいので、クリックして下さい。
![rde_sourceforge2.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_sourceforge2.jpg)

__その4__

しばらく待つとダウンロードが開始されます。
開始されない場合は

{% highlight text %}
{% raw %}
http://.../RDE1.x.x_setup.exe (x は数字)
{% endraw %}
{% endhighlight %}


というリンクをクリックして下さい。
![rde_sourceforge3.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_sourceforge3.jpg)

#### インストール

ダウンロードが終了したら、 RDE1.x.x_setup.exe (x は数字) を
ダブルクリックしてインストールを開始します。
基本的に画面の指示に従っていけば良いだけです。

__その1__

インストーラーが使用する言語を指定します。
通常は「Japanese」のままで良いです。
![rde_installer_startup.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_installer_startup.jpg)

__その2__

そのまま「次へ」を選びます。
![rde_installer_startup2.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_installer_startup2.jpg)

__その3__

ここでは使用する ruby.exe がインストールされている場所を指定します。
通常は「次へ」を選べば良いはずです。

ここで指定する場所は
One-Click Ruby Installer で Ruby (の翻訳機) のインストール時に
指定した場所が基準になります。
もし D:\app\ruby に Ruby をインストールしたならば
D:\app\ruby\bin\ruby.exe になりますし、
C:\ruby に Ruby をインストールしたら
C:\ruby\bin\ruby.exe になります。
![rde_installer_ruby.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_installer_ruby.jpg)

__その4__

RDE をインストールする場所を指定します。
これも「次へ」を押します。
![rde_installer_path.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_installer_path.jpg)

__その5__

インストールする内容を選びます。
内容を選ぶのが面倒なら「次へ」を選んで下さい。
![rde_installer_content.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_installer_content.jpg)

__その6__

これも「次へ」を選べば良いです。
![rde_installer_rde.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_installer_rde.jpg)

__その7__

今までの設定で問題なければ「インストール」を選びます。
![rde_installer_install.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_installer_install.jpg)

__その8__

インストール終了です。「終了」を押して下さい。
![rde_installer_finish.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_installer_finish.jpg)

#### RDEの設定

最初に起動すると、下の図のようなダイアログが出ます。
後で設定出来るので、「Submit」ボタンを押しましょう。
![rde_startup.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_startup.jpg)

「Submit」ボタンを押すと、下のようなウィンドウが
表示されるはずです。
もしかするとツールバーが 4 種類見えないかもしれません。
その場合は各ツールバーの左端の縦線をドラッグして
ツールバーを動かしてみて下さい。
![rde_main_window.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_main_window.jpg)

#### メニューの日本語表示

ここではメニューの表示を日本語にします。

メニューの Tool → Options で起動時に表示されたダイアログが表示されます。
表示されたダイアログの左側の列の「Config File」を選択すると、
下図のように各種設定ファイルを指定する画面が表示されます。
その中の一番上の TranslationFile に 
RDE がインストールされた場所の
「Translations\Japanese_XXXX.xml」(Xは数字) を翻訳ファイルとして指定します。
![rde_translation.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_translation.jpg)

上の図は RDE を C:\Program Files\RDE にインストールした場合です。
他の場所に RDE をインストールした場合は適宜変更する必要があります。

適切な翻訳ファイルを指定してダイアログの「Submit」ボタンを押して
RDE を再起動すればメニューが日本語表示になります。

#### エディタの日本語表示

最初はエディタ部分に日本語を表示することが出来ないかもしれません。

その場合はメニューの ツール → エディタ設定 を選び、
タブの一番上にあるフォントと書かれたボタンを押します。
こうすることで下図のようなフォント選択のダイアログが出ます。
![rde_editor_font.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_editor_font.jpg)

好みのフォントが無ければ下記のようにすれば良いでしょう。

|  フォント名 |  MS ゴシック|
|  スタイル   |  標準|
|  サイズ     |  10|
|  書体の種類 |  日本語|


#### ファイル保存時の文字コード

細かいことを考えたくない場合は下記のようにして下さい。

* メニュー の ツール → 設定 を選ぶ
* コードウィンドウ → 文字コード変換 を選ぶ

![rde_charcode.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_charcode.jpg)

* 「追加」 のボタンを押す
* RDE のインストール先の japanese.dll を選択

![rde_japanese_dll.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_japanese_dll.jpg)

* コードウィンドウ → 文字コード を選ぶ
* 標準文字コードを デフォルト から SJIS に変更

![rde_default_charcode.jpg]({{base}}{{site.baseurl}}/images/0011-CGIProgrammingForRubyBeginners-2/rde_default_charcode.jpg)

#### Ruby の Help との連動

RDE から Ruby の Windows HTML Help を使うことが出来ます。
設定しなくても問題は起きませんが、
しておくと便利です。

[http://elbereth-hp.hp.infoseek.co.jp/ruby.html](http://elbereth-hp.hp.infoseek.co.jp/ruby.html)

から [ruby-refm-rdp-1.8.1-ja-htmlhelp.zip ](http://elbereth-hp.hp.infoseek.co.jp/files/ruby/refm/ruby-refm-rdp-1.8.1-ja-htmlhelp.zip)
をダウンロードします。ダウンロードしたファイルを解凍して、
中の rubymanjp.chm を RDE のインストール先にコピーします。
これでメニューの ヘルプ → Rubyヘルプ から Ruby の HTML Help を使うことが出来るようになります。

[目次ページへ]({{base}}{% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners %})
[前ページへ]({{base}}{% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-1 %})
[次ページへ]({{base}}{% post_url articles/0011/2005-11-16-0011-CGIProgrammingForRubyBeginners-3 %})


