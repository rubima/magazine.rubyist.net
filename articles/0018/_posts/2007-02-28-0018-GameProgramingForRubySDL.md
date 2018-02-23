---
layout: post
title: Ruby/SDLで始めるゲームプログラミング【前編】
short_title: Ruby/SDLで始めるゲームプログラミング【前編】
tags: 0018 GameProgramingForRubySDL
---
{% include base.html %}


## はじめに

本稿では Ruby/SDL を使って簡単なゲームを作ってみます。
Ruby on Rails など Web 系の用途で知名度を上げている Ruby ですが、
Ruby でこんなこともできるんだ！と思ってもらえれば幸いです。

## 準備

### テキストエディタ

Ruby スクリプトの編集用に何かひとつ[テキストエディタ](http://www.forest.impress.co.jp/lib/offc/document/txteditor/)を
用意しておいてください (Windows 付属の「メモ帳」でも良いですが、もう少し高機能なものを使ったほうが何かと便利です)。

### Ruby/SDL のインストール

あなたは……

* Linux や FreeBSD など、Unix 系 OS を使っている→ (A) へ
* Windows を使っていて、
  * Ruby は既にインストールしている→ (B) へ
  * Ruby はまだインストールしていない
    * インストールは面倒だから嫌いだ→ (C) へ
    * インストールは嫌いじゃない→ (D) へ
* Mac OS X を使っている→ (E) へ


### (A) Unix 系 OS へのインストール

ディストリビューションによってはパッケージが用意されているので、
それを利用するのが簡単です (例えば Debian GNU/Linux なら libsdl-ruby1.8)。

その他のディストリビューションでは
[Download Ruby/SDL](http://www.kmc.gr.jp/~ohai/rubysdl_download.html) から「source of Ruby/SDL 1.3.0」
をダウンロードし、[README.ja](http://www.kmc.gr.jp/~ohai/rubysdl/README.ja) に従ってインストールしてください。
SDL 関係のライブラリを一つずつインストールしなければならないので多少面倒ですが、とりあえずは
SDL、SDL_mixer、SDL_ttf、SDL_image があれば OK です。

### (B) Windows へのインストール

[Download Ruby/SDL](http://www.kmc.gr.jp/~ohai/rubysdl_download.html)
から「Win32's binary(ver 1.3.0) for Ruby 1.8」をダウンロードし、同梱の install_rubysdl.rb を実行してください。

### (C) Ruby/SDL スターターキットを使う

Windows 用に、インストールなしに Ruby/SDL を使ったゲーム開発ができるパッケージを公開しています。
[Ruby/SDL スターターキット](http://mono.kmc.gr.jp/~yhara/w/?RubySDLStarterKit)から zip ファイルをダウンロードし、好きなところに展開してください。

### (D) Windows に Ruby をインストールする

まず、[FirstStepRuby](https://github.com/rubima/rubima/blob/master/first_step_ruby/first-step-ruby-2.0.md)を参考に Ruby をインストールしてください。Windows 版の Ruby にはいろいろなパッケージが用意されていますが、
[ActiveScriptRuby](http://arton.hp.infoseek.co.jp/indexj.html) が人気があるようです。

インストールできたら (B) に進んでください。

### (E) Mac OS X について

MacPorts を利用するのが一番簡単なようです。以下の順にインストールを行ってください。

* XCodeTools (OS のインストールディスク等から入手可能)
* [MacPorts](http://svn.macosforge.org/repository/macports/downloads/)
* 各種ライブラリ


{% highlight text %}
{% raw %}
 % port install XFree86
 % port install libsdl
 % port install libsdl_image
 % port install libsdl_mixer
 % port install libsdl_ttf
 % port install rb-opengl
{% endraw %}
{% endhighlight %}


* [Ruby/SDL 本体](http://www.kmc.gr.jp/~ohai/rubysdl_download.html) (ソースからコンパイル)
* [rsdl](http://www.kumaryu.net/?(Ruby)+Ruby%2FSDL%CD%D1ruby)


### サンプルパック

インストールできたら、
ゲームに必要なデータが入った[サンプルパック](http://mono.kmc.gr.jp/~yhara/files/rubima_sdl_sample.zip)をダウンロードし、好きなところに解凍してください。
ただし (C) の Ruby/SDL スターターキットには同じデータが既に同梱されているのでダウンロードの必要はありません。

### Q&amp;A

本稿では Q&amp;A 形式で「ちょっとした疑問」に答えていきます。豆知識なので、お急ぎの方は読み飛ばしても構いません。

Q. SDL って何ですか？
: 

A. SDL は「クロスプラットフォームなマルチメディアアプリケーションを書くためのライブラリ」です。
: なんだか仰々しいですね (笑)。簡単に言うと、「いろんな OS で動くゲームが作れるライブラリ」だと思ってもらえれば良いと思います。[SDL の公式サイト](http://libsdl.org)に書かれているように、Windows や Linux、Mac OS X などいろいろな OS に対応しています。SDL 本体は C 言語のためのライブラリですが、有志の手によって Perl や Python など他のいろいろな言語から SDL を使うためのライブラリが公開されています。そのうちの、Ruby から SDL を使うためのライブラリが [Ruby/SDL](http://www.kmc.gr.jp/~ohai/rubysdl.html) であるというわけです。

## ウィンドウを出してみよう

では早速、初めての Ruby/SDL アプリケーションを書いてみましょう。

サンプルパックを展開した中に main.rb というファイルがあるので、これをテキストエディタで開き、以下のように
書き換えてください。

{% highlight text %}
{% raw %}
# ライブラリの読み込み
require "sdl"

# 定数の定義
SCREEN_W = 640
SCREEN_H = 480

# SDL の初期化
SDL.init(SDL::INIT_EVERYTHING)
SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

# 2 秒間待つ
sleep(2)
{% endraw %}
{% endhighlight %}


### 実行方法

このスクリプトを実行するには、以下のようにします。

Ruby/SDL スターターキットを使っている場合
: debug.exe をダブルクリック

それ以外の場合
: ターミナルや MS-DOS プロンプトを開いて

{% highlight text %}
{% raw %}
ruby main.rb
{% endraw %}
{% endhighlight %}


新しいウィンドウが開いて、2 秒後に閉じれば成功です。Ruby/SDL の世界へようこそ！
![00_.png]({{site.baseurl}}/images/0018-GameProgramingForRubySDL/00_.png)

### 初期化

Ruby/SDL では、一番最初に [SDL.init](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-7) を呼び出します。
引数には、SDL のさまざまな機能のうちどれを初期化するかを指定します。通常は INIT_EVERYTHING (全て初期化) で
問題ないでしょう。

次に、[SDL.set_video_mode](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-18)
で画面を初期化しています。
多くのゲームは VGA サイズで作られるので、ここでも幅 640 ピクセル、高さ 480 ピクセルを指定しています。
SCREEN_W、SCREEN_H の W、H はそれぞれ Width (幅)、Height (高さ) の略です。

## 何か描いてみよう

さて、真っ黒なウィンドウを出すだけでは寂しいので、何か描いてみましょうか。

main.rb を以下のように書き換えて保存してください。
(以下では、前のスクリプトから変更する部分にはコメントを付けてあります。
スクリプトを写すときにはまず「#」を探してみてください。)

{% highlight text %}
{% raw %}
require "sdl"

SCREEN_W = 640
SCREEN_H = 480
HOLIZON  = 400   #地平線の高さ (一番上が 0、一番下が 399)

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

# 塗りつぶし
screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
screen.update_rect(0, 0, 0, 0)

sleep(2)
{% endraw %}
{% endhighlight %}


空と大地が表示されましたか？:-)
![01_.png]({{site.baseurl}}/images/0018-GameProgramingForRubySDL/01_.png)

### 画面への描画

[SDL.set_video_mode](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-18) を実行すると、「画面」を表す
SDL::Screen クラスのオブジェクトが返ってきます。上では screen という変数に代入しています。
画面に何か表示するにはいつもこのオブジェクトを使います。

次に、[SDL::Surface#fill_rect](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-78) というメソッドを使って四角形の範囲を塗りつぶしています。
引数の意味はそれぞれ「左上の x 座標、y 座標、幅、高さ、色」です。
色は 0〜255 の間の 3 つの数字で指定します (それぞれ赤、緑、青の明るさです)。

ただし、fill_rect を呼び出しただけではまだ画面には何も表示されません。
画面の更新には時間がかかるので、SDL では
[SDL::Screen.update_rect](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-196)
を呼んだ時にまとめて更新されるという仕様になっています。引数には fill_rect と同じく
「左上の x 座標、y 座標、幅、高さ、色」を指定します。4 つとも 0 を指定すると画面全体が更新されます。

## 画像を表示してみよう

ゲームには主人公が必要ですよね。 次はビットマップ画像を表示してみましょう。
image というディレクトリにサンプル画像 (nos_front.png) が入っていることを確認してください。

main.rb を以下のように書き換えてください。

{% highlight text %}
{% raw %}
require "sdl"

SCREEN_W = 640
SCREEN_H = 480
HOLIZON  = 400

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

# 画像の読み込み
chara = SDL::Surface.load("image/nos_front.png")
chara.set_color_key(SDL::SRCCOLORKEY, [255, 255, 255])

screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
screen.put(chara, 240, HOLIZON-chara.h)  # 画像の表示
screen.update_rect(0, 0, 0, 0)

sleep(2)
{% endraw %}
{% endhighlight %}


実行すると、地面の上にキャラクターが表示されます。少しゲームらしくなってきました。
![02_.png]({{site.baseurl}}/images/0018-GameProgramingForRubySDL/02_.png)

### 画像の読み込み

[SDL::Surface.load](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-67)
というメソッドにファイル名を渡すことで画像ファイルを読み込むことができます。
読み込み可能なフォーマットは bmp, png, gif, jpg などです。
読み込んだ画像は [SDL::Surface](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-59) のインスタンス
になります。Ruby/SDL で画像を扱うときはいつもこの Surface クラスを使います。

[SDL::Surface#w](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-86) で画像の横幅が、
[SDL::Surface#h](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-85) で画像の縦幅が得られます。
上では、キャラクターが地面の上に立っている用に見せるために、「HOLIZON - chara.h」でキャラクターの
y 座標を計算しています。

### カラーキーの設定

その次の行では、読みこんだ画像に対し [SDL::Surface#set_color_key](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-76) でカラーキー (色抜き) を設定しています。
カラーキーを使うと、図のように画像のある色の部分だけ背景に溶け込ませることができます。
ここでは白 (255,255,255) をカラーキーに設定しています。

![colkey_off.png]({{site.baseurl}}/images/0018-GameProgramingForRubySDL/colkey_off.png)
![colkey_on.png]({{site.baseurl}}/images/0018-GameProgramingForRubySDL/colkey_on.png)

## 関数を使ってみよう

さて、画像の読み込みはよく使うので、関数にまとめておきましょう。

main.rb を以下のように書き換えてください。

{% highlight text %}
{% raw %}
require "sdl"

SCREEN_W = 640
SCREEN_H = 480
HOLIZON  = 400

# 関数を定義
def load_image(fname)
  image = SDL::Surface.load(fname)
  image.set_color_key(SDL::SRCCOLORKEY, [255, 255, 255])

  image      #生成した画像を返す
end

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

# 画像の読み込み
chara = load_image("image/nos_front.png")

screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
screen.put(chara, 240, HOLIZON-chara.h)
screen.update_rect(0, 0, 0, 0)

sleep(2)
{% endraw %}
{% endhighlight %}


実行結果は前と変わらないはずです。

### Q&amp;A

Q. あれ、値を返すのに return はいらないの？
: 

A. 付けても構いません。
: Ruby では関数の「最後に評価した値」が自動的に返り値になるので、「return image」のように return をつける必要はありません。

## 画像を動かしてみよう

次はビットマップ画像を動かしてみましょう。
キャラクターを少しずつ位置をずらしながら描画することで、パラパラマンガのように
絵を動かすことができます。

main.rb を以下のように書き換えてください。

{% highlight text %}
{% raw %}
require "sdl"

SCREEN_W = 640
SCREEN_H = 480
HOLIZON  = 400

def load_image(fname)
  image = SDL::Surface.load(fname)
  image.set_color_key(SDL::SRCCOLORKEY, [255, 255, 255])

  image
end

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

chara = load_image("image/nos_front.png")

# 変数の初期化
x = 0

# 右端に達するまで繰り返す
while x < SCREEN_W
  x += 8
  screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
  screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
  screen.put(chara, x, HOLIZON-chara.h)
  screen.update_rect(0, 0, 0, 0)
end
{% endraw %}
{% endhighlight %}


実行するとキャラクターが左から右まで動いて終了します。少しゲームらしくなってきました。

### ゲームの動く仕組み

このように、ゲームプログラミングでは

* キーボードやジョイパッドの入力を受け付ける (入力)
* キャラクターの座標を少し動かす (移動)
* キャラクターを描画する (描画)
* 画面を更新する (更新)


という手順を何度も繰り返すことでゲームを進めていきます。この「入力→移動→描画→更新」 1 回分を
1 フレームと呼びます。

しかし、このままだと 1 フレームにかかる時間はコンピュータのスペックによって異なります。
自分のコンピュータではゆっくり飛んでくる弾が友達のコンピュータではものすごい速さで飛んでくる……
なんてことでは困りますよね。
そこで、1 秒間のフレーム数を 60 回なら 60 回に固定してしまい

* 1 フレームにかかる時間が 1/60 秒より短いときは、適当にウェイトを入れて調整する
* 1 フレームにかかる時間が 1/60 秒より長いときは、描画や更新をスキップして調整する


という処理を行うことで、どの環境でも同じ速度でゲームを動かすことができます。

### fpstimer.rb

この処理を行うためのライブラリが、Ruby/SDL 公式サイトの
[チュートリアル](http://www.kmc.gr.jp/~ohai/rubysdl_intro.html)の最後で公開されています。
これをダウンロードしたものが lib/fpstimer.rb に入っています。

これを使った main.rb は以下のようになります。

{% highlight text %}
{% raw %}
require "sdl"
require "lib/fpstimer"  # fpstimer.rb を読み込む

SCREEN_W = 640
SCREEN_H = 480
HOLIZON  = 400

def load_image(fname)
  image = SDL::Surface.load(fname)
  image.set_color_key(SDL::SRCCOLORKEY, [255, 255, 255])

  image
end

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

chara = load_image("image/nos_front.png")
x = 0

#タイマーの生成
timer = FPSTimerLight.new
timer.reset

while x < SCREEN_W
  x += 8
  screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
  screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
  screen.put(chara, x, HOLIZON-chara.h)
  #タイマー処理
  timer.wait_frame do
    screen.update_rect(0, 0, 0, 0)
  end
end
{% endraw %}
{% endhighlight %}


最近のコンピュータは処理速度が速いので、実行すると大抵の環境ではさっきのバージョンよりもキャラクターがゆっくり動く
ようになったと思います。

### FPSTimerLight

fpstimer.rb では FPSTimerLight というクラスが定義されています。
このタイマーの wait_frame というメソッドにブロックを渡してやると、

* 時間に余裕があるときはブロックを実行し、定時まで待つ
* 時間に余裕がないときはブロックを実行しない


という風に時間を調整してくれます。

ゲームプログラミングにおいて一番時間がかかるのは画面の更新処理なので、上では update_rect のみを
wait_frame で囲んでいます。
処理速度の遅いコンピュータではときどき画面の更新をスキップすることで、
(見た目は多少カクカクしますが) 秒間 60 フレームを守ることができます。

### Q&amp;A

Q. どうして require "lib/fpstimer.rb"のように拡張子を付けないの？
: 

A. つけても構いません。
: Ruby のライブラリには C 言語で書かれたもの (*.so) と Ruby で書かれたもの (*.rb) の 2 種類があります。拡張子を省略した場合は*.rb の方が優先されます。

## キーボードから操作できるようにしよう

次はキーボードの矢印キーでキャラクターが左右に移動するようにしてみましょう。

{% highlight text %}
{% raw %}
require "sdl"
require "lib/fpstimer"

SCREEN_W = 640
SCREEN_H = 480
HOLIZON  = 400

def load_image(fname)
  image = SDL::Surface.load(fname)
  image.set_color_key(SDL::SRCCOLORKEY, [255, 255, 255])

  image
end

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

chara = load_image("image/nos_front.png")
x = 240 #初期位置の設定

timer = FPSTimerLight.new
timer.reset

# メインループ
loop do  
  #キーが「押されたかどうか」を調べる
  while event=SDL::Event2.poll
    case event
    when SDL::Event2::Quit #ウィンドウの×ボタンが押された
      exit
    when SDL::Event2::KeyDown
      exit if event.sym == SDL::Key::ESCAPE
    end
  end

  #キーが「押されているかどうか」を調べる
  SDL::Key.scan
  x -= 8 if SDL::Key.press?(SDL::Key::LEFT)  
  x += 8 if SDL::Key.press?(SDL::Key::RIGHT)

  #入力に応じてキャラクターを動かす
  x = 0 if x < 0
  x = SCREEN_W-chara.w if x >= SCREEN_W-chara.w

  screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
  screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
  screen.put(chara, x, HOLIZON-chara.h)
  timer.wait_frame do
    screen.update_rect(0, 0, 0, 0)
  end
end
{% endraw %}
{% endhighlight %}


### 入力の処理

SDL では、キーが「押されたかどうか」と「押されているかどうか」を区別して調べることができます。
これによって、例えばシューティングゲームで

* ショットはボタンが「押されている」間ずっと発射される
* ボムはボタンが「押された」瞬間に一度だけ発射される


というような仕様を簡単に実装することができます。

Ruby/SDL では、[SDL::Event2](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-248) というクラスで
「キーが押された」などのイベントを、
[SDL::Key.scan](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-329)
というメソッドで「キーが押されているか」という状態を取得することができます。
上では ESCAPE キーが「押されたら」ゲームを終了し、矢印キーが「押されていたら」キャラクターを
動かすようにしています。

### input.rb

上ではキーボードの入力のみを受け付けていますが、
ゲームの入力デバイスには他にもジョイパッドなどいろいろなものがあります。
これらに対応するコードをいちいち書くのは面倒なので、本稿では input.rb というライブラリを用意しました。

input.rb を使うと、上のスクリプトはこんな風に書けます。

{% highlight text %}
{% raw %}
require "sdl"
require "lib/fpstimer"
require "lib/input"  # input.rb を読み込む

SCREEN_W = 640
SCREEN_H = 480
HOLIZON  = 400

def load_image(fname)
  image = SDL::Surface.load(fname)
  image.set_color_key(SDL::SRCCOLORKEY, [255, 255, 255])

  image
end

# キー定義
class Input
  define_key SDL::Key::ESCAPE, :exit
  define_key SDL::Key::LEFT, :left
  define_key SDL::Key::RIGHT, :right
end

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

chara = load_image("image/nos_front.png")
x = 240

input = Input.new        # 入力用の変数を初期化
timer = FPSTimerLight.new
timer.reset
loop do  
  input.poll             # キーボードやジョイスティックを調べる
  break if input.exit

  x -= 8 if input.left
  x += 8 if input.right
  x = 0 if x < 0
  x = SCREEN_W-chara.w if x >= SCREEN_W-chara.w

  screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
  screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
  screen.put(chara, x, HOLIZON-chara.h)
  timer.wait_frame do
    screen.update_rect(0, 0, 0, 0)
  end
end
{% endraw %}
{% endhighlight %}


だいぶすっきりしました。
もしパソコンに繋げられるジョイパッドをお持ちなら、ぜひジョイパッドで操作してみてください。

input.rb は Ruby の高度な (マニアックな、とも言う) 機能をいろいろ使っているので、中身の解説は省略します。
興味のある人は lib/input.rb の解読に挑戦してみてください。

## クラスを定義してみよう

さて、主人公の次は敵キャラ出して、アイテム出して……と行きたいところですが、変数名に「x」を使っているのが
ちょっと気になります。
例えば敵キャラを出すなら、プレイヤーの座標は player_x、敵キャラの座標は teki_x のように改名しないといけないですよね。
さらにアイテムの座標も……と考えると、似たような変数がたくさんあって混乱してしまいそうです。

せっかく Ruby を使うのですから、ここはひとつ自分でクラスを定義してみましょう。

main.rb と同じディレクトリに player.rb というファイルを作って、以下のように書いてください。

{% highlight text %}
{% raw %}
class Player
  def initialize(x)
    @image = load_image("image/nos_front.png")
    @x = x
    @y = HOLIZON - @image.h
  end
  attr_reader :x, :y

  def center
    cx = @x + (@image.w / 2)
    cy = @y + (@image.h / 2)

    [cx, cy]
  end

  def act(input)
    @x -= 8 if input.left
    @x += 8 if input.right
    @x = 0 if @x < 0
    @x = SCREEN_W-@image.w if @x >= SCREEN_W-@image.w
  end

  def render(screen)
    screen.put(@image, @x, @y)
  end
end
{% endraw %}
{% endhighlight %}


initialize は Player.new でプレイヤーが生成されるときに自動的に呼ばれるメソッドです。
initialize ではキャラクターの座標や画像といった情報を「@」から始まる変数 (インスタンス変数) にセットしています。

インスタンス変数は基本的に外からアクセスすることができませんが、attr_reader :x のように書いておくと
player.x で @x の値を取得できるようになります。また書き込みを可能にする attr_writer や、
読み書き両方を可能にする attr_accessor もあります。

また center ではプレイヤーの画像の「中心の座標」を返しています (あとで使います)。

このクラスを使うと、main.rb はこんな風に書けます。

{% highlight text %}
{% raw %}
require "sdl"
require "lib/fpstimer"
require "lib/input"

SCREEN_W = 640
SCREEN_H = 480
HOLIZON  = 400

def load_image(fname)
  image = SDL::Surface.load(fname)
  image.set_color_key(SDL::SRCCOLORKEY, [255, 255, 255])

  image
end
require "player"               # player.rb を読み込む

class Input
  define_key SDL::Key::ESCAPE, :exit
  define_key SDL::Key::LEFT, :left
  define_key SDL::Key::RIGHT, :right
end

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

player = Player.new(240)   # プレイヤーをつくる

input = Input.new        
timer = FPSTimerLight.new
timer.reset
loop do  
  input.poll            
  break if input.exit

  player.act(input)            # プレイヤーを動かす

  screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
  screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
  player.render(screen)        # プレイヤーを描画する
  timer.wait_frame do
    screen.update_rect(0, 0, 0, 0)
  end
end
{% endraw %}
{% endhighlight %}


まず、require で player.rb を読み込んでいます。player.rb の中では関数 load_image や定数 SCREEN_W を使っているので、
それらの定義より後に読み込まないといけません。

また Player クラスには act (移動) と render (描画) という 2 つのメソッドが定義されていて、メインループの中で
これらのメソッドを 1 フレーム毎に呼び出しています。

### Q&amp;A

Q. クラスごとにファイルを分けないといけないの？
: 

A. 別に分けなくても構いません。
: Ruby では、Java のように 1 ファイル 1 クラスのような制限がありません。1 つのファイルで複数のクラスを定義しても良いし、逆に 1 つのクラスの定義を複数のファイルに分けて書くこともできます (Input クラスがそうですね)。

## アイテムを降らせてみよう

さて、主人公だけでは寂しいので、他の物も描画してみましょう。
手元にリンゴと爆弾の絵があるので、「爆弾を避けつつリンゴを集める」ゲームにしてみましょうか。
![11_.png]({{site.baseurl}}/images/0018-GameProgramingForRubySDL/11_.png)

main.rb と同じディレクトリに items.rb というファイルを作り、
以下のように書いてください。

{% highlight text %}
{% raw %}
class Item
  def initialize(x, y, v)
    @x, @y, @v = x, y, v
    @is_dead = false
  end
  attr_reader :v, :image
  attr_accessor :x, :y, :is_dead
end

class Apple < Item
  def initialize(x, y, v)
    super
    @image = load_image("image/ringo.bmp")
  end
end

class Bomb < Item
  def initialize(x, y, v)
    super
    @image = load_image("image/bomb.bmp")
  end
end

class Items
  def initialize
    @items = []
  end

  def act(player)
    #それぞれのアイテムを移動
    @items.each do |item|
      item.y += item.v
      item.is_dead = true if item.y > SCREEN_H
    end
      
    #画面外に出たものを消去
    @items.reject!{|item| item.is_dead}

    #新しいアイテムを補充 (つねに画面内に 5 個のアイテムがあるように)
    while @items.size < 5
      newx = rand(SCREEN_W) 
      newv = rand(9) + 4
      if rand(100) < 60
	@items << Bomb.new(newx, 0, newv)
      else
        @items << Apple.new(newx, 0, newv)
      end
    end
  end

  def render(screen)
    @items.each do |item|
      screen.put(item.image, item.x, item.y)
    end
  end
end
{% endraw %}
{% endhighlight %}


リンゴを表す Apple クラスと、爆弾を表す Bomb クラスを定義しています。
また Apple と Bomb はほとんど同じ実装になるので、「空から降ってくるもの」全体を現す Item クラスを作り、
Apple と Bomb は Item のサブクラスにしてみました。最後に、アイテムの管理を行う Items クラスを定義しています。
メインループから使うのはこの Items クラスのみです。

アイテムの処理を追加した main.rb は以下のようになります。前のバージョンとほとんど変わりませんね。

このようにプログラムをクラスに分割することで、表示するものを増やしてもメインループをシンプルに保つことができます。

{% highlight text %}
{% raw %}
require "sdl"
require "lib/fpstimer"
require "lib/input"

SCREEN_W = 640
SCREEN_H = 480
HOLIZON  = 400

def load_image(fname)
  image = SDL::Surface.load(fname)
  image.set_color_key(SDL::SRCCOLORKEY, [255, 255, 255])

  image
end
require "player"
require "items"                # items.rb を読み込む

class Input
  define_key SDL::Key::ESCAPE, :exit
  define_key SDL::Key::LEFT, :left
  define_key SDL::Key::RIGHT, :right
end

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

player = Player.new(240)
items = Items.new              # アイテムを初期化

input = Input.new        
timer = FPSTimerLight.new
timer.reset
loop do  
  input.poll            
  break if input.exit

  player.act(input)            
  items.act(player)            # アイテムを動かす

  screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
  screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
  player.render(screen)  
  items.render(screen)         # アイテムを描画する
  timer.wait_frame do
    screen.update_rect(0, 0, 0, 0)
  end
end
{% endraw %}
{% endhighlight %}


### Q&amp;A

Q. クラスをどういう風に分けたらいいのかよく分かりません。
: 

A. 僕にもよく分かりません。：-P
: クラスをどのように設計すべきか？という話はそれだけで本が書けてしまうくらいで、ここに書くにはちょっと余白が狭すぎます。基本的には「リンゴ」や「爆弾」などの「物」をひとつづつクラスにすれば良いと思いますが、Items のように物でないものをクラスにすることもあります。いろいろなパターンでプログラムを書いて、試行錯誤するのが良いと思います。

## 当たり判定を付けてみよう

上から落ちてきたものがすり抜けてしまうのではゲームになりませんね。ここでは、

* 爆弾に当たったらゲーム終了 (爆弾に当たってはいけない)
* リンゴに当たったらリンゴは消える (リンゴには当たっても良い)


という風にしてみましょう。

当たり判定を実装する方法にはいろいろありますが、ここでは単純に「中心どうしの距離が一定以下か」で
判定することにしましょう。この方法は当たり判定の範囲 (下図の青線) が円形になるので丸い画像に向いていますが、
Math.sqrt(平方根) を利用しているので物体が多いと重くなる可能性があります (その場合は四角形で判定するのが
良いでしょう)。
![distance.png]({{site.baseurl}}/images/0018-GameProgramingForRubySDL/distance.png)

items.rb を以下のように書き換えてください。

{% highlight text %}
{% raw %}
class Item
  def initialize(x, y, v)
    @x, @y, @v = x, y, v
    @is_dead = false
  end
  attr_reader :v, :image
  attr_accessor :x, :y, :is_dead

  # 2 点間の距離の計算
  def distance(x1, y1, x2, y2)
    Math.sqrt((x1-x2)**2 + (y1-y2)**2)  # n**2 は 「n の 2 乗」(=n*n)
  end
end

class Apple < Item
  def initialize(x, y, v)
    super
    @image = load_image("image/ringo.bmp")
  end

  # リンゴの当たり判定
  def collides?(player)
    px, py = player.center
    distance(@x+@image.w/2, @y+@image.h/2, px, py) < 56
  end
end

class Bomb < Item
  def initialize(x, y, v)
    super
    @image = load_image("image/bomb.bmp")
  end

  # 爆弾の当たり判定
  def collides?(player)
    px, py = player.center
    distance(@x+@image.w/2, @y+@image.h/2, px, py) < 42
  end
end

class Items

  def initialize
    @items = []
  end

  def act(player)
    crash = false

    @items.each do |item|
      item.y += item.v
      item.is_dead = true if item.y > SCREEN_H
    end
      
    # 当たり判定を行う
    @items.each do |item|
      case item
      when Apple
        item.is_dead = true if item.collides?(player)
      when Bomb
        crash = true if item.collides?(player)
      end
    end

    @items.reject!{|item| item.is_dead}

    while @items.size < 5
      newx = rand(SCREEN_W) 
      newv = rand(9) + 4
      if rand(100) < 60
	@items << Bomb.new(newx, 0, newv)
      else
        @items << Apple.new(newx, 0, newv)
      end
    end

    # 爆弾に当たったかどうかを返す
    crash
  end

  def render(screen)
    @items.each do |item|
      screen.put(item.image, item.x, item.y)
    end
  end
end
{% endraw %}
{% endhighlight %}


collides?というメソッドで、アイテムとプレイヤーが接触しているかどうかを判定しています。
判定には、中心間の距離と半径の和を比べればよい……のですが、どの画像も完全な円ではないので、
プレイしてみて違和感がないように数値を手で調整しています。できれば、リンゴの当たり判定は大きめに、
爆弾の当たり判定は小さめにするとより楽しいゲームになると思います。

また、爆弾に当たったときは act が true を返すようにしました。

これに対応した main.rb は以下のようになります。item.act が true を返したらゲームを終了するように変更しました。

{% highlight text %}
{% raw %}
require "sdl"
require "lib/fpstimer"
require "lib/input"

SCREEN_W = 640
SCREEN_H = 480
HOLIZON  = 400

def load_image(fname)
  image = SDL::Surface.load(fname)
  image.set_color_key(SDL::SRCCOLORKEY, [255, 255, 255])

  image
end
require "player"
require "items"

class Input
  define_key SDL::Key::ESCAPE, :exit
  define_key SDL::Key::LEFT, :left
  define_key SDL::Key::RIGHT, :right
end

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

player = Player.new(240)
items = Items.new

input = Input.new        
timer = FPSTimerLight.new
timer.reset
loop do  
  input.poll            
  break if input.exit

  player.act(input)            
  is_crashed = items.act(player)    # 爆弾に当たったか？
  break if is_crashed               # 当たったらゲーム終了

  screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
  screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
  player.render(screen)  
  items.render(screen) 
  timer.wait_frame do
    screen.update_rect(0, 0, 0, 0)
  end
end
{% endraw %}
{% endhighlight %}


## おわりに

何となくゲームらしくなってきたところで、今回はお別れです。

次回は点数表示や効果音など、ゲームとしての完成度をより高めていきたいと思います。お楽しみに！

## 補足：フルスクリーンについて

本文では説明しませんでしたが、

{% highlight text %}
{% raw %}
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE|SDL::FULLSCREEN)
{% endraw %}
{% endhighlight %}


のように SDL::FULLSCREEN というフラグを指定することで、アプリケーションを全画面で動かすことができます。

ゲームをフルスクリーンで動かすと迫力がある反面、起動に時間がかかるのでデバッグが少し面倒になります。
開発中はウィンドウモードにしておき、リリースするときにフルスクリーンで動くように変更するのが良いと思います。

### Ruby/SDL スターターキットの場合

Ruby/SDL スターターキットでは、main.rb を実行するための exe を debug.exe と game.exe という 2 種類用意しています。
main.rb の中では「SDL::RELEASE_MODE という変数が定義されているかどうか」を調べることで
どちらの exe から起動されたかを判別することができるので、例えば以下のようにすると game.exe から起動されたときだけフルスクリーンにすることができます。

{% highlight text %}
{% raw %}
if defined?(SDL::RELEASE_MODE)
  video_mode = SDL::SWSURFACE|SDL::FULLSCREEN
else
  video_mode = SDL::SWSURFACE
end
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, video_mode)
{% endraw %}
{% endhighlight %}


なお、フルスクリーン/ウィンドウモードを選択できるのは set_video_mode で画面を初期化するときのみで、
ゲームの実行中に切り替えることはできません。

## 関連リンク

[Ruby/SDL](http://www.kmc.gr.jp/~ohai/rubysdl.html)
: Ruby/SDL の公式サイトです。

[Ruby/SDL Reference](http://www.kmc.gr.jp/~ohai/rubysdl.html)
: Ruby/SDL の日本語リファレンスです。

[Ruby/SDL Users](http://mono.kmc.gr.jp/proj/rubysdl/)
: Ruby/SDL の関連情報についてまとめたページです。まだ出来立てですが、[Ruby/SDL を利用した作品へのリンク集](http://mono.kmc.gr.jp/proj/rubysdl/?Works)などがあります。

## 筆者について

yhara
:  [京大マイコンクラブ](http://www.kmc.gr.jp/)に所属する大学院生。好きなゲームのジャンルは音ゲーと落ちゲー。


