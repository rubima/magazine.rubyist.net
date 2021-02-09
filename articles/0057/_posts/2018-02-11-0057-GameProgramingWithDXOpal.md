---
layout: post
title: Rubyで始めるゲームプログラミング - DXOpal編 -
short_title: Rubyでゲーム
created_on: 2018-02-11
tags: 0057 GameProgramingWithDXOpal
---
{% include base.html %}

## はじめに

本稿ではDXOpalを使ってブラウザで動くゲームを作ってみます。Rubyでこんなこともできるんだ！と思ってもらえれば幸いです。

### DXOpalとは

DXOpalは筆者が作っている、Rubyでブラウザ用ゲームを作るためのライブラリです。

* [http://yhara.github.io/dxopal/](http://yhara.github.io/dxopal/)


DXOpalの「DX」は[DXRuby](http://dxruby.osdn.jp/)から来ています。DXRubyはRubyでWindows用ゲームを作るためのライブラリです(このRubyist Magazineにも[記事がありましたね](http://magazine.rubyist.net/?0027-DXRuby))。

DXOpalの「Opal」は[RubyのコードをJavaScriptに変換してくれるソフトウェア](http://opalrb.com/)です。DXOpalは内部でOpalを利用しています。

DXOpalは、DXRubyの命令を「だいたいそのまま」ブラウザに移植したものです。そのため、DXRubyのリファレンスを見れば使い方はだいたい同じです。もしDXRubyの命令でDXOpalで動かないものがあったら、[github](https://github.com/yhara/dxopal/issues)か[twitter](https://twitter.com/yhara)で教えてください。

* [DXRubyリファレンス](http://mirichi.github.io/dxruby-doc/index.html)


### 準備

#### DXOpalのインストール

Rubyをインストール後、RubyGemsからDXOpalをインストールできます。

{% highlight text %}
{% raw %}
$ gem install dxopal
{% endraw %}
{% endhighlight %}


インストールするとdxopalコマンドが使えるようになります。dxopal initで、カレントディレクトリにファイルの雛形ができます。

{% highlight text %}
{% raw %}
$ mkdir mygame
$ cd mygame
$ dxopal init
{% endraw %}
{% endhighlight %}


initしたあと、dxopal serverコマンドを実行するとWebサーバが起動します。

{% highlight text %}
{% raw %}
$ dxopal server
DXOpal v1.1.0
Starting DXOpal Server
(Open http://localhost:7521/index.html in browser)
---
Puma starting in single mode...
* Version 3.11.0 (ruby 2.4.2-p198), codename: Love Song
* Min threads: 0, max threads: 16
* Environment: development
* Listening on tcp://0.0.0.0:7521
Use Ctrl-C to stop
{% endraw %}
{% endhighlight %}


ブラウザで [http://localhost:7521/index.html](http://localhost:7521/index.html) を開くと、以下のように表示されるはずです。
![18.50.07.png]({{base}}{{site.baseurl}}/images/0057-GameProgramingWithDXOpal/18.50.07.png)

##### サンプルパックのダウンロード

本稿で使う画像と効果音をまとめたものを [http://route477.net/files/rubima_dxopal.zip](http://route477.net/files/rubima_dxopal.zip) に置きました。これを展開するとimagesとsoundsというディレクトリができるので、index.htmlと同じところに移動させてください。以下のような感じです。

{% highlight text %}
{% raw %}
index.html
main.rb
dxopal.min.js
images/
  apple.png
  bomb.png
  player.png
sounds/
  explosion.wav
  get.wav
{% endraw %}
{% endhighlight %}

### 画面を出してみよう

では早速、初めてのDXOpalアプリケーションを書いてみましょう。

main.rb というファイルがあるので、これをテキストエディタで開き、中身をいったん全部消して、以下のように書き換えてください。

{% highlight text %}
{% raw %}
require "dxopal"
include DXOpal

Window.load_resources do
  Window.loop do
  end
end
{% endraw %}
{% endhighlight %}


ブラウザをリロードすると、真っ黒な四角だけの画面に変わったはずです。

変わらなかった場合は、ブラウザが古いデータをキャッシュしているかもしれません。以下の手順で、一時的にキャッシュさせないようにしましょう。

* Chromeの場合


{% highlight text %}
{% raw %}
 1. 「表示」→「開発/管理」→「デベロッパー ツール」で開発者コンソールを起動
 2. 「Network」タブの「Disable cache」にチェック
 3. これで、開発者コンソール起動中はキャッシュがオフになります
{% endraw %}
{% endhighlight %}


* Firefoxの場合


{% highlight text %}
{% raw %}
 1. 「ツール」→「ウェブ開発」→「開発ツールを表示」で開発者コンソールを起動
 2. 「ネットワーク」タブの「キャッシュを無効化」にチェック
 3. これで、開発者コンソール起動中はキャッシュがオフになります
{% endraw %}
{% endhighlight %}


### 何か描いてみよう

真っ黒なウィンドウを出すだけでは寂しいので、何か描いてみましょうか。

main.rb を以下のように書き換えて保存してください。 (以下では、前のスクリプトから変更する部分にはコメントを付けてあります。 スクリプトを写すときにはまず「#」を探してみてください。)

{% highlight text %}
{% raw %}
require "dxopal"
include DXOpal

# 地面のY座標
GROUND_Y = 400

Window.load_resources do
  Window.loop do
    # 背景を描画
    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
  end
end
{% endraw %}
{% endhighlight %}


空と大地が表示されましたか？:-)

### 画像を表示してみよう

ゲームには主人公が必要ですよね。画像を表示してみましょう。imagesというディレクトリにサンプル画像 (player.png) が入っていることを確認してください。

{% highlight text %}
{% raw %}
require "dxopal"
include DXOpal

GROUND_Y = 400
# 使いたい画像を宣言する
Image.register(:player, 'images/player.png')

Window.load_resources do
  Window.loop do
    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])

    # プレイヤーキャラを描画
    Window.draw(240, GROUND_Y - Image[:player].height, Image[:player])
  end
end
{% endraw %}
{% endhighlight %}


実行すると、地面の上にキャラクターが表示されます。少しゲームらしくなってきました。
![22.43.11.png]({{base}}{{site.baseurl}}/images/0057-GameProgramingWithDXOpal/22.43.11.png)

### 画像を動かしてみよう

次はビットマップ画像を動かしてみましょう。 キャラクターを少しずつ位置をずらしながら描画することで、パラパラマンガのように絵を動かすことができます。

{% highlight text %}
{% raw %}
require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:player, 'images/player.png')

Window.load_resources do
  # 変数の初期化
  x = 0

  Window.loop do
    # 毎フレーム8ピクセルずつ進む
    x += 8

    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    # x座標を変数にした
    Window.draw(x, GROUND_Y - Image[:player].height, Image[:player])
  end
end
{% endraw %}
{% endhighlight %}


このように、ゲームプログラミングでは

* キーボードやジョイパッドの入力を受け付ける (入力)
* キャラクターの座標を少し動かす (移動)
* キャラクターを描画する (描画)


という手順を何度も繰り返すことでゲームを進めていきます。この「入力→移動→描画」1回分を1フレームと呼びます。

DXOpalでは基本的に1秒60フレームです。([参考](https://developer.mozilla.org/ja/docs/Web/API/Window/requestAnimationFrame))

### キーボードから操作できるようにしよう

次はキーボードの矢印キーでキャラクターが左右に移動するようにしてみましょう。

{% highlight text %}
{% raw %}
require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:player, 'images/player.png')

Window.load_resources do
  # 最初は真ん中にする
  x = Window.width / 2

  Window.loop do
    # キー入力をチェック
    if Input.key_down?(K_LEFT)
      x -= 8
    elsif Input.key_down?(K_RIGHT)
      x += 8
    end

    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    Window.draw(x, GROUND_Y - Image[:player].height, Image[:player])
  end
end
{% endraw %}
{% endhighlight %}


ブラウザをリロードして、カーソルキーの左右を押すとキャラクターが動くはずです。(カーソルがアドレスバーにあったりすると動かないかもしれません。ページ内を一度マウスでクリックしてみてください。)

ところで、上のプログラムだと画面の端にたどりついてもキャラクターが止まらず、画面外に隠れてしまうはずです。if式の条件を以下のようにすると、左右に行きすぎないようになります。

{% highlight text %}
{% raw %}
    # キー入力をチェック
    if Input.key_down?(K_LEFT) && x > 0
      x -= 8
    elsif Input.key_down?(K_RIGHT) && x < (Window.width - Image[:player].width)
      x += 8
    end
{% endraw %}
{% endhighlight %}


### Spriteクラスを使ってみよう

さて、主人公の次は敵キャラ出して、アイテム出して……と行きたいところですが、変数名に「x」を使っているのが ちょっと気になります。 例えば敵キャラを出すなら、プレイヤーの座標は player_x、敵キャラの座標は enemy_x のように改名しないといけないですよね。 さらにアイテムの座標も……と考えると、似たような変数がたくさんあって混乱してしまいそうです。

Rubyはオブジェクト指向言語なので、こういうときはクラスを作ります。特にDXRubyではゲームの各要素は[Spriteクラス](http://mirichi.github.io/dxruby-doc/api/Sprite.html)を継承しておくと、当たり判定が簡単に実装できたりして便利です。

{% highlight text %}
{% raw %}
require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:player, 'images/player.png')

# プレイヤーを表すクラスを定義
class Player < Sprite
  def initialize
    x = Window.width / 2
    y = GROUND_Y - Image[:player].height
    image = Image[:player]
    super(x, y, image)
  end

  # 移動処理(xからself.xになった)
  def update
    if Input.key_down?(K_LEFT) && self.x > 0
      self.x -= 8
    elsif Input.key_down?(K_RIGHT) && self.x < (Window.width - Image[:player].width)
      self.x += 8
    end
  end
end
# クラスここまで

Window.load_resources do
  # Playerクラスのオブジェクトを作る
  player = Player.new

  Window.loop do
    # 入力と移動の処理をする
    player.update

    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    # 描画する
    player.draw
  end
end
{% endraw %}
{% endhighlight %}


動作としては同じですが、機能を増やしていくための土台ができました。

[Spriteクラス](http://mirichi.github.io/dxruby-doc/api/Sprite.html)はx座標、y座標、画像を持ち、player.drawのようにしてdrawメソッドを呼ぶとx座標、y座標の場所に画像が表示されます。これらのデータはPlayerクラスの内部からはself.x, self.y, self.imageのようにしてアクセスできます。

Spriteクラスを使うときは、移動などの更新処理はupdateというメソッドに書くことになっています。([Sprite.update](http://mirichi.github.io/dxruby-doc/api/Sprite_update.html)でまとめて呼べたりします)

### アイテムを降らせてみよう

主人公だけでは寂しいので、他の物も描画してみましょう。imagesディレクトリにりんごと爆弾の絵があるので、「爆弾を避けつつリンゴを集める」ゲームにしてみましょうか。まずは、images/apple.pngにりんごの絵があるのでそれを使います。

アイテムを表すItemクラスと、アイテムの生成・削除を行うItemsクラスを作りましょう。

{% highlight text %}
{% raw %}
require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:player, 'images/player.png')
# アイテム用の画像を宣言
Image.register(:apple, 'images/apple.png')

class Player < Sprite
  # ...一緒なので省略...
end

# アイテムを表すクラスを追加
class Item < Sprite
  def initialize
    image = Image[:apple]
    x = rand(Window.width - image.width)  # x座標をランダムに決める
    y = 0
    super(x, y, image)
    @speed_y = rand(9) + 4  # 落ちる速さをランダムに決める
  end

  def update
    self.y += @speed_y
    if self.y > Window.height
      self.vanish
    end
  end
end

# アイテム群を管理するクラスを追加
class Items
  # 同時に出現するアイテムの個数
  N = 5

  def initialize
    @items = []
  end

  def update
    # 各スプライトのupdateメソッドを呼ぶ
    Sprite.update(@items)
    # vanishしたスプライトを配列から取り除く
    Sprite.clean(@items)

    # 消えた分を補充する(常にアイテムがN個あるようにする)
    (N - @items.size).times do
      @items.push(Item.new)
    end
  end

  def draw
    # 各スプライトのdrawメソッドを呼ぶ
    Sprite.draw(@items)
  end
end
# クラスここまで

Window.load_resources do
  player = Player.new
  # Itemsクラスのオブジェクトを作る
  items = Items.new

  Window.loop do
    player.update
    # アイテムの作成・移動・削除
    items.update

    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    player.draw
    # アイテムの描画
    items.draw
  end
end
{% endraw %}
{% endhighlight %}


こんな感じになったでしょうか。
![22.53.13.png]({{base}}{{site.baseurl}}/images/0057-GameProgramingWithDXOpal/22.53.13.png)

ItemクラスはPlayerクラスと同様に、Spriteクラスを継承しています。

Itemsクラスはアイテムの個数を管理するクラスで、Spriteの機能は特に使わないため普通のクラスにしています。ただし、更新を行うメソッドはupdate、描画を行うメソッドはdrawのように、名前だけ合わせています。同じことをするメソッドは同じ名前にしたほうが分かりやすいですからね。

Itemクラスのupdateメソッドでは、y座標を少しずつ増やすことでアイテムの落下を実装しています。y座標がWindow.heightより大きくなったら、画面外に出たということなので、[vanishメソッド](http://mirichi.github.io/dxruby-doc/api/Sprite_23vanish.html)を呼んでいます。vanishを呼ぶと、Spriteオブジェクトのvanishフラグが立ちます。

vanishフラグは、Sprite.cleanと組み合わせて使います。Spriteクラスには、Spriteオブジェクトの配列を渡して一括で操作するメソッドがいくつかあります。(以下ではSpriteオブジェクトのことを、単に「スプライト」と呼びます)

* [Sprite.update(sprites)](http://mirichi.github.io/dxruby-doc/api/Sprite_update.html) : 各スプライトのupdateメソッドを順に呼ぶ
* [Sprite.draw(sprites)](http://mirichi.github.io/dxruby-doc/api/Sprite_draw.html) : 各スプライトのdrawメソッドを順に呼ぶ
* [Sprite.clean(sprites)](http://mirichi.github.io/dxruby-doc/api/Sprite_clean.html) : vanishフラグが立ったスプライトを配列から取り除く
* [Sprite.check(sprites1, sprites2)](http://mirichi.github.io/dxruby-doc/api/Sprite_check.html) : 当たり判定をチェックする


### アイテムを二種類にしよう

次はアイテムの種類を増やしてみましょう。images/bomb.pngに爆弾の絵があるのでそれを使います。

アイテムの絵を変えるのはどうしましょうか。一番単純なのはItemクラスにフラグを持たせる方法ですね。絵を変えるだけならそれでもいいですが、今回はりんごの方は「当たってもいいアイテム」、爆弾は「当たってはいけないアイテム」と、違う動作をさせたいので、別々のクラスにしておきます。とはいえ落下などの基本的な動作は同じなので、Itemクラスを継承してAppleクラスとBombクラスを作ります。

{% highlight text %}
{% raw %}
require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:player, 'images/player.png')
Image.register(:apple, 'images/apple.png')
# アイテム画像を追加
Image.register(:bomb, 'images/bomb.png')

class Player < Sprite
  # ...一緒なので省略...
end

class Item < Sprite
  # imageを引数にとるようにした
  def initialize(image)
    x = rand(Window.width - image.width)
    y = 0
    super(x, y, image)
    @speed_y = rand(9) + 4
  end

  def update
    # ...一緒なので省略...
  end
end

# 加点アイテムのクラスを追加
class Apple < Item
  def initialize
    super(Image[:apple])
  end
end

# 妨害アイテムのクラスを追加
class Bomb < Item
  def initialize
    super(Image[:bomb])
  end
end

class Items
  N = 5

  def initialize
    @items = []
  end

  def update
    Sprite.update(@items)
    Sprite.clean(@items)

    (N - @items.size).times do
      # どっちのアイテムにするか、ランダムで決める
      if rand(1..100) < 40
        @items.push(Apple.new)
      else
        @items.push(Bomb.new)
      end
    end
  end

  def draw
    Sprite.draw(@items)
  end
end

Window.load_resources do
  # ...一緒なので省略...
end
{% endraw %}
{% endhighlight %}


りんごと爆弾がまぜこぜに発生するよう、Itemsクラスを修正しています。

### 当たり判定を付けてみよう

上から落ちてきたものがすり抜けてしまうのではゲームになりませんね。次は当たり判定を付けて、

* リンゴに当たったらスコアが増える
* 爆弾に当たったらスコアが0になる


という風にしてみましょう。

{% highlight text %}
{% raw %}
require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:player, 'images/player.png')
Image.register(:apple, 'images/apple.png')
Image.register(:bomb, 'images/bomb.png')

# ゲームの状態を記憶するハッシュを追加
GAME_INFO = {
  score: 0      # 現在のスコア
}

class Player < Sprite
  def initialize
    x = Window.width / 2
    y = GROUND_Y - Image[:player].height
    image = Image[:player]
    super(x, y, image)
    # 当たり判定を円で設定(中心x, 中心y, 半径)
    self.collision = [image.width / 2, image.height / 2, 16]
  end

  # ...省略...
end

# ...省略...

class Apple < Item
  def initialize
    super(Image[:apple])
    # 衝突範囲を円で設定(中心x, 中心y, 半径)
    self.collision = [image.width / 2, image.height / 2, 56]
  end

  # playerと衝突したとき呼ばれるメソッドを追加
  def hit
    self.vanish
    GAME_INFO[:score] += 10
  end
end

# 妨害アイテム
class Bomb < Item
  def initialize
    super(Image[:bomb])
    # 衝突範囲を円で設定(中心x, 中心y, 半径)
    self.collision = [image.width / 2, image.height / 2, 42]
  end

  # playerと衝突したとき呼ばれるメソッドを追加
  def hit
    self.vanish
    GAME_INFO[:score] = 0  # スコアを0点にする
  end
end

class Items
  # ...省略...

  # playerを引数に取るようにした
  def update(player)
    @items.each{|x| x.update(player)}
    # playerとitemsが衝突しているかチェックする。衝突していたらhitメソッドが呼ばれる
    Sprite.check(player, @items)
    Sprite.clean(@items)

    (N - @items.size).times do
      if rand(100) < 40
        @items.push(Apple.new)
      else
        @items.push(Bomb.new)
      end
    end
  end

  # ...省略...
end

Window.load_resources do
  player = Player.new
  items = Items.new

  Window.loop do
    player.update
    items.update(player)  # 引数を増やした

    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    # スコアを画面に表示する
    Window.draw_font(0, 0, "SCORE: #{GAME_INFO[:score]}", Font.default)
    player.draw
    items.draw
  end
end
{% endraw %}
{% endhighlight %}


最初にGAME_INFOという定数を用意しています。今はスコアしか入れていませんが、あとでゲームのいろいろな状態を持たせるために使います。

[Spriteクラス](http://mirichi.github.io/dxruby-doc/api/Sprite.html)は当たり判定の機能を持っています。collision=メソッドを呼ぶことで当たり判定が設定されます。当たり判定の形状は点、円、長方形、三角形の4種類があり、配列の長さによって指定します。

{% highlight text %}
{% raw %}
# 点
self.collision = [x, y]
# 円
self.collision = [x, y, r]
# 長方形
self.collision = [x1, y1, x2, y2]
# 三角形
self.collision = [x1, y1, x2, y2, x3, y3]
{% endraw %}
{% endhighlight %}


今回はプレイヤー、リンゴ、爆弾のいずれも円で当たり判定を指定することにしました。絵に対して厳密ではありませんが、そのほうがゲームとしては面白く感じることもあります。特に加点アイテムは当たり判定を広めに、減点アイテムは少し狭めにしておくと、気持ちいいゲームになります。

collision=で当たり判定を設定したあとは、Sprite.checkというメソッドでスプライト同士が衝突したかをチェックできます。衝突している場合、衝突されたオブジェクトのhitメソッドが呼ばれます。

Sprite.checkは他にもいろいろな機能があるので知りたい場合は[マニュアル](http://mirichi.github.io/dxruby-doc/api/Sprite_check.html)を見てください。

### 効果音を鳴らしてみよう

DXOpalには[WebAudio](https://developer.mozilla.org/ja/docs/Web/API/Web_Audio_API)を使って効果音を鳴らす機能があります。アイテムに当たったときに音を鳴らすようにしてみましょう。

{% highlight text %}
{% raw %}
require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:player, 'images/player.png')
Image.register(:bomb, 'images/bomb.png')
Image.register(:apple, 'images/apple.png')

# 読み込みたい音声を登録する
Sound.register(:get, 'sounds/get.wav')
Sound.register(:explosion, 'sounds/explosion.wav')

# ...省略...

class Apple < Item
  # ...省略...

  def hit
    # 効果音を鳴らす
    Sound[:get].play
    self.vanish
    GAME_INFO[:score] += 10
  end
end

class Bomb < Item
  # ...省略...

  def hit
    # 効果音を鳴らす
    Sound[:explosion].play
    self.vanish
    GAME_INFO[:score] = 0
  end
end

# ...あとは一緒なので省略...
{% endraw %}
{% endhighlight %}


効果音は画像と同じように、Sound.registerで名前とファイル名を宣言します。そうするとWindow.load_resourcesの中で「Sound[名前]」という形でアクセスできるようになります。

### タイトル画面を付けてみよう

だいぶゲームらしくなりましたね。最後の仕上げとして、タイトル画面とゲームオーバー画面を作ってみましょう。

{% highlight text %}
{% raw %}
# ...省略...

GAME_INFO = {
  scene: :title,  # 現在のシーン(起動直後は:title)
  score: 0,
}

# ...省略...

class Bomb < Item
  # ...省略...

  def hit
    Sound[:explosion].play
    self.vanish
    # スコアを0にするのをやめて、ゲームオーバー画面に遷移するようにした
    GAME_INFO[:scene] = :game_over
  end
end

# ...省略...

Window.load_resources do
  player = Player.new
  items = Items.new

  Window.loop do
    # 背景とスコア表示は、どの画面でも出すことにする
    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    Window.draw_font(0, 0, "SCORE: #{GAME_INFO[:score]}", Font.default)

    # シーンごとの処理
    case GAME_INFO[:scene]
    when :title
      # タイトル画面
      Window.draw_font(0, 30, "PRESS SPACE", Font.default)
      # スペースキーが押されたらシーンを変える
      if Input.key_push?(K_SPACE)
        GAME_INFO[:scene] = :playing
      end
    when :playing
      # ゲーム中
      player.update
      items.update(player)

      player.draw
      items.draw
    when :game_over
      # ゲームオーバー画面
      Window.draw_font(0, 30, "PRESS SPACE", Font.default)
      player.draw
      items.draw
      # スペースキーが押されたらゲームの状態をリセットし、シーンを変える
      if Input.key_push?(K_SPACE)
        player = Player.new
        items = Items.new
        GAME_INFO[:score] = 0
        GAME_INFO[:scene] = :playing
      end
    end
  end
end
{% endraw %}
{% endhighlight %}


GAME_INFOに:scene (シーン)という項目を追加しました。今回は:title (タイトル画面)、:playing (ゲーム中)、:game_over (ゲームオーバー画面)という3つのシーンを用意しました。

Window.loopでGAME_INFO[:scene]によって別々の処理をしています。GAME_INFO[:scene]にシーン名を代入することで、シーンが切り替わります。最初はシーン:titleで、スペースキーが押されたら:playingになって、爆弾に当たったら:game_overになります。ゲームオーバー画面でスペースキーを押すと:playingに戻ります。(この辺は好みで、タイトル画面に戻るようにしても良いでしょう)

### 余談

ここまでで今回のゲームはいったん完成とします。以降では補足として、ゲームがもっと大きくなったときのためのヒントをいくつか紹介します。

#### メイン部分をクラスにする

上ではWindow.load_resourcesの中にゲーム本体の処理を書いていましたが、規模が大きくなるとload_resourcesの中が長くなりすぎて大変かもしれません。こういうときは、ゲーム本体を表すクラスを作るという方法があります。以下は例です。

{% highlight text %}
{% raw %}
# ...省略...

# ゲーム本体を表すクラス
class Game
  def initialize
    reset
  end

  # ゲームの状態をリセットする
  def reset
    @player = Player.new
    @items = Items.new
    GAME_INFO[:score] = 0
  end

  # ゲームを実行する
  def run
    Window.loop do
      Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
      Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
      Window.draw_font(0, 0, "SCORE: #{GAME_INFO[:score]}", Font.default)

      case GAME_INFO[:scene]
      when :title
        Window.draw_font(0, 30, "PRESS SPACE", Font.default)
        if Input.key_push?(K_SPACE)
          GAME_INFO[:scene] = :playing
        end
      when :playing
        @player.update
        @items.update(@player)

        @player.draw
        @items.draw
      when :game_over
        @player.draw
        @items.draw
        Window.draw_font(0, 30, "PRESS SPACE", Font.default)
        if Input.key_push?(K_SPACE)
          reset
          GAME_INFO[:scene] = :playing
        end
      end
    end
  end
end

Window.load_resources do
  game = Game.new
  game.run
end
{% endraw %}
{% endhighlight %}


こうしておけば、シーンが増えてrunメソッドが長くなっても、メソッドを分割することで整理できます。

#### ファイルを分割する

今回はmain.rbに全てのプログラムを書きましたが、クラスが増えてくるとこの方法では大変です。main.rbが長くなってきたら、クラスごとにファイルを分けるのが良いでしょう。DXOpalではrequire_remoteでファイルをロードすることができます。例えばPlayerクラスをplayer.rbというファイルに切り出した場合は、main.rbに以下のように書くとplayer.rbをロードできます。

{% highlight text %}
{% raw %}
require_remote "player.rb"
{% endraw %}
{% endhighlight %}


(通常のRubyのrequireと違い、「.rb」は省略できません。)

#### デバッグする

Rubyのプログラムをデバッグするときは「p」メソッドをよく使います。pメソッドはOpal/DXOpalでも使えます(開発者コンソールに表示されます)が、ゲームプログラミングでは同じ処理が1秒に60回実行されたりするので、この方法だと表示が出すぎて困ることがあります。

そこでDXOpalでは、「p_」というメソッドを用意しています。p_にハッシュを渡すとその内容が開発者コンソールに出力されますが、10回以上実行した場合はそれ以上出力しなくなります。例えば、Itemクラスのupdateメソッドに以下の行を書いてみてください。

{% highlight text %}
{% raw %}
p_ x: self.x, y: self.y
{% endraw %}
{% endhighlight %}


### おわりに

実は本稿は2007年のRubyist Magazine記事のリライト版なのでした。

* [Rubyist Magazine \- Ruby/SDLで始めるゲームプログラミング【前編】](http://magazine.rubyist.net/?0018-GameProgramingForRubySDL)
* [Rubyist Magazine \- Ruby/SDLで始めるゲームプログラミング【後編】](http://magazine.rubyist.net/?0019-GameProgramingForRubySDL)


yhara(原 悠)
: 島根県在住のRubyプログラマ。滋賀から松江に引っ越してそろそろ10年になります。

* Website: [http://yhara.jp](http://yhara.jp)
* Twitter: [https://twitter.com/yhara](https://twitter.com/yhara)



