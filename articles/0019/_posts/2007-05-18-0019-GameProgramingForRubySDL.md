---
layout: post
title: Ruby/SDL で始めるゲームプログラミング【後編】
short_title: Ruby/SDL で始めるゲームプログラミング【後編】
tags: 0019 GameProgramingForRubySDL
---
{% include base.html %}


書いた人：yhara

## はじめに

[前編]({{base}}{% post_url articles/0018/2007-02-28-0018-GameProgramingForRubySDL %})では、Ruby/SDL を利用して簡単なアクションゲームを作成しました。
後編では効果音や点数表示の実装など、よりゲームとしての完成度を高めていきたいと思います。

## 準備

まだ Ruby/SDL をインストールしていない場合は、[前編]({{base}}{% post_url articles/0018/2007-02-28-0018-GameProgramingForRubySDL %})を参考に開発環境を整えてください。

それができたら、[サンプルパック 2](http://mono.kmc.gr.jp/~yhara/files/rubima_sdl_sample2.zip) をダウンロードし解凍してください。音声やフォントなどゲームに必要なファイルが入っています。(Ruby/SDLスターターキットにはほぼ同じデータが入っているのですが、title.png と game_over.png だけ入っていないのでダウンロードして image/ 以下にコピーしてください。)

前編の内容を実際に試してみた方なら、手元に main.rb、player.rb、items.rb という 3 つのファイルができているはずです。サンプルパック 2 にはこれらのファイルも同梱してあります。以下ではこれらのスクリプトを少しずつ改造して機能を付け加えていきます。

## タイトル画面を付けてみよう

前編では、爆弾に当たったらすぐにゲームを終了するようになっていました。
これではゲームオーバーになるたびにゲームを起動し直さなくてはならず、面倒ですよね。
ゲームにタイトル画面を付け、ゲームオーバーになったらタイトル画面に戻るようにしてみましょう。

### シーン管理

さて、「タイトル画面」「ゲーム画面」「ゲームオーバー画面」のように複数の場面 (シーン) を用意するにはどうすれば良いでしょうか？「メインループを複数用意する」というのが最も簡単なやり方ですが、この方法は似たようなコードをあちこちに書くはめになるのであまりお薦めしません。代わりに、ここでは別のやり方を考えてみます。

「タイトル画面」「ゲーム画面」「ゲームオーバー画面」のいずれのシーンでも、1 秒に 60 回画面を更新することは変わりません。違うのは 1 フレームごとに行う処理、act と render の内容だけです。となれば、これらをあらわすオブジェクトを用意してやれば良さそうですね。

### シーンオブジェクト

ここでは TitleScene、GameScene、GameOverScene という 3 つのクラスを作り、それぞれに act と render というメソッドを定義することにします。act にはそのシーンでやりたいことを書きます。render にはそのシーンの画面を表示するコードを書きます。

ついでにもう一つ、シーンが始まったときに呼び出される start というメソッドも定義しています。

場面の切り替えを行うために、act の戻り値を以下のようにしています。

* 場面が切り替わったら、次のシーンを返す
* そうでなければ、nil を返す


言葉で説明するより、実際にコードを見てもらった方が早いかも知れません。main.rb の class Input 以下を、以下のコードに置き換えてください。

{% highlight text %}
{% raw %}
# キー定義 (Enter キーを追加)
class Input
  define_key SDL::Key::ESCAPE, :exit
  define_key SDL::Key::RETURN, :ok    # Enter キー (タイトル画面で使う)
  define_key SDL::Key::LEFT, :left
  define_key SDL::Key::RIGHT, :right
end

# タイトル画面
class TitleScene
  def initialize
    @title_image = SDL::Surface.load("image/title.png")
  end

  def start
  end

  # Enter が押されたらゲーム画面へ
  def act(input)
    if input.ok
      return :game
    else
      return nil
    end
  end

  # タイトル画像を表示するだけ
  def render(screen)
    screen.put(@title_image, 0, 0)
  end
end

# ゲーム画面
class GameScene
  def initialize
    @player = Player.new(240)
    @items = Items.new
  end

  def start
    @items.clear
  end

  # 爆弾に当たったらゲームオーバー画面へ
  def act(input)
    @player.act(input)            
    is_crashed = @items.act(@player)
    if is_crashed  
      return :game_over
    else
      return nil
    end
  end

  def render(screen)
    screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
    screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])
    @player.render(screen)  
    @items.render(screen) 
  end
end

# ゲームオーバー画面
class GameOverScene
  def initialize
    @game_over_image = SDL::Surface.load("image/game_over.png")
  end

  def start
    @time = 0
  end

  # 一定時間 (120 フレーム、約 2 秒) 経ったらタイトル画面へ
  def act(input)
    @time += 1

    if @time > 120
      return :title
    else
      return nil
    end
  end

  # ゲームオーバー画像を表示するだけ
  def render(screen)
    screen.put(@game_over_image, 0, 0)
  end
end

SDL.init(SDL::INIT_EVERYTHING)
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)

# 各シーンのインスタンスを最初に作っておく
Scenes = {
  :title     => TitleScene.new,
  :game      => GameScene.new,
  :game_over => GameOverScene.new,
}
input = Input.new        
timer = FPSTimerLight.new
timer.reset

scene = Scenes[:title]  # 最初はタイトル画面から
loop do  
  input.poll            
  break if input.exit

  next_scene = scene.act(input)
  if next_scene                   # next_scene が nil (か false) でなければ
    scene = Scenes[next_scene]    # 新しいシーンに移動する
    scene.start                   # シーンが開始したときの処理
  end

  scene.render(screen)
  timer.wait_frame{ screen.update_rect(0, 0, 0, 0) }
end
{% endraw %}
{% endhighlight %}


次に、items.rb の class Items のところを以下のように書き換えてください。

{% highlight text %}
{% raw %}
class Items

  def clear
    @items = []
  end

  (後略)
{% endraw %}
{% endhighlight %}


ここで一度 main.rb を実行してみてください。タイトル画面で Enter を押すとゲームが始まります。爆弾に当たるとゲームオーバーなのは前回と同じです。ゲームオーバーになったら画像が表示され、一定時間後にタイトル画面に戻るはずです。

main.rb の一番最後にメインループがあります。前編ではここで player や items の act と render を呼んでいましたが、改造後は scene.act と scene.render だけを呼び出すようになっています。プレイヤーやアイテムを動かす処理は、GameScene の act と render に移動しています。

Items クラスにも一つだけ clear というメソッドを増やしています。何回ゲームをプレイしても GameScene や Items のインスタンスは最初に作った一つを使いまわすので、ゲームが開始するたびに Items も初期化してやらないといけないわけです (これをしないと、2 回目のゲームが始まった瞬間に爆弾に当たってゲームオーバーになってしまいます)。

## BGM を鳴らしてみよう

次は BGM を鳴らしてみましょう。音楽があるだけで、雰囲気が全然違いますよ。

### BGM のフォーマット

BGM として利用可能なフォーマットは以下のいずれかです。

* MP3 (.mp3) (注 1、注 2)
* Ogg Vorbis (.ogg)
* MIDI (.mid)
* MOD (.mod .s3m .xm .it) (注 3)
* Wave (.wav) (注 4)


注 1
: 一時期、Windows 版の Ruby/SDL で MP3 が再生できない不具合 (というか仕様) がありました。現在配布されている [Ruby/SDL 1.3.0 のバイナリ](http://www.kmc.gr.jp/~ohai/rubysdl_download.html)では MP3 がまた再生可能になっています。Windows で古い Ruby/SDL を使っている場合はアップグレードをお勧めします。

注 2
: ゲームで MP3 を利用する場合、5000 コピーを超えるゲームについては特許料を払う必要があるようです ([mp3licencing.com - Royalty Rates](http://www.mp3licensing.com/royalty/games.html))。もしあなたがヒット作を作る予定なら、Ogg Vorbis を使っておいた方が良いでしょう。:-)

注 3
: MOD 形式については [Wikipedia - MOD (ファイルフォーマット)](http://ja.wikipedia.org/wiki/MOD_%28%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%83%E3%83%88%29) 等を参照してください。

注 4
: Wave 形式は非常にファイルサイズが大きくなるので BGM の保存には向きません。MP3 か Ogg Vorbis を使いましょう。

### BGM の再生

サンプルパック 2 には MOD 形式の音楽ファイル (famipop3.it) が入っているので、これを鳴らしてみましょう。main.rb を変更して、

* ゲームが始まったら BGM を再生
* ゲームオーバーになったら BGM を停止


という風にします。

Ruby/SDL で音を鳴らすには、最初に初期化を行う必要があります。
まず、[SDL.init](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-7) の引数で SDL::INIT_AUDIO (または SDL::INIT_EVERYTHING) を指定します。
次に、[SDL::Mixer.open](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-350) で音声の初期化を行います。

main.rb の初期化部分を以下のように変更してください。

{% highlight text %}
{% raw %}
SDL.init(SDL::INIT_EVERYTHING)
SDL::Mixer.open   # 音声の初期化
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)
{% endraw %}
{% endhighlight %}


次に、[SDL::Mixer::Music.load](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-393) で音楽ファイルを読み込み、
[SDL::Mixer.play_music](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-364) で再生します。
引数には読み込んだ BGM と再生する回数を指定します。回数に -1 を指定すると無限ループになります。 
停止には [SDL::Mixer.halt_music](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-370) を使います。
halt_music には引数がありません (一度に 2 つ以上の BGM を鳴らすことはできないからです)。

では、main.rb を BGM を鳴らすように書き換えてみましょう。音楽を鳴らすのはゲーム中だけなので、GameScene を書き換えます。

{% highlight text %}
{% raw %}
class GameScene
  def initialize
    @player = Player.new(240)
    @items = Items.new
    # BGM の読み込み
    @bgm = SDL::Mixer::Music.load("sound/famipop3.it")
  end

  def start
    # ゲームが始まったら BGM を再生
    SDL::Mixer.play_music(@bgm, -1) 
  end

  def act(input)
    @player.act(input)            
    is_crashed = @items.act(@player)
    if is_crashed  
      # ゲームオーバーになったら BGM を停止
      SDL::Mixer.halt_music
      return :game_over
    else
      return nil
    end
  end

  (後略)
{% endraw %}
{% endhighlight %}


書き換えたら、main.rb を実行してみてください。正しく音は鳴りましたか？

### 音楽ファイルを用意するには？

さて、肝心の音楽をどこから手に入れるかですが、以下の 2 通りが考えられます。

* 自分で作る
* フリー素材を利用する


自分で作る場合は DTM の知識が必要になりますが、作りたいゲームに合った曲を用意できるという利点があります。
MIDI なら MIDI シーケンサ [(google 検索)](http://www.google.co.jp/search?num=100&hl=ja&q=midi+%E3%82%B7%E3%83%BC%E3%82%B1%E3%83%B3%E3%82%B5&lr=lang_ja)、
MOD ならトラッカー ([modplug tracker](http://www.forest.impress.co.jp/article/2000/03/17/dancemusic8.html) など) を使うことになるでしょう。MP3 や Ogg Vorbis は単に音声データを圧縮したものなので、wav 形式で保存できる音楽ソフトなら何でも使えます。

自分で作るのが難しければ、フリー素材を利用するという手もあります。
[「音楽 素材」で検索](http://www.google.co.jp/search?num=100&hl=ja&q=%E9%9F%B3%E6%A5%BD+%E7%B4%A0%E6%9D%90&lr=lang_ja)すればいろいろなサイトが見つかると思います。作者の方に感謝しつつゲームに組み込みましょう。

ただ、フリー素材は利用に条件が課せられていることもあります (商用利用は不可、など)。事前によく確認しておきましょう。

## 効果音を鳴らしてみよう

BGM が付いたところで、もう一種類の音、効果音を付けてみましょう。

### 効果音のフォーマット

効果音として利用可能なフォーマットには Wave, AIFF, RIFF, Ogg, VOC がありますが、Wave 形式を使うのが一般的です。
効果音を非常にたくさん使う場合は、Ogg 形式に圧縮すればゲーム配布時のファイルサイズを抑えることができます。
(ただし、効果音をロードすれば元の Wave ファイルと同じだけのメモリが消費されるので、メモリ不足には注意してください。)

### 効果音の再生

効果音を鳴らすには、最初に SDL::Mixer の初期化が必要です。これは BGM のときと同じです。

{% highlight text %}
{% raw %}
SDL.init(SDL::INIT_EVERYTHING)
SDL::Mixer.open   # 音声の初期化
{% endraw %}
{% endhighlight %}


効果音を読み込むには [SDL::Mixer::Wave.load](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-386) を使います。

{% highlight text %}
{% raw %}
wave = SDL::Mixer::Wave.load("sound/get.wav")
{% endraw %}
{% endhighlight %}


効果音を再生するには [SDL::Mixer.play_channel](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-355) を使います。
SDL::Mixer ではチャンネルという仕組みを利用して、複数の効果音を同時に鳴らせるようになっています。
play_channel の引数には再生に使うチャンネル番号、読み込んだ効果音、(再生回数 - 1)を指定します。

{% highlight text %}
{% raw %}
SDL::Mixer.play_channel(0, wave, 0)   # チャンネル0で wave を 1 回だけ再生する
{% endraw %}
{% endhighlight %}


チャンネル番号を考えるのが面倒なときは、-1 を指定すると空いているチャンネルを適当に選んでくれます。
ただしチャンネル数には限りがあるので、1 秒に何十回も効果音の再生を始めるとチャンネルが足らなくなり、例外 SDL::Error が発生してしまいます。
これを避けるには、

* 効果音が極端に連続して鳴らないようにする
* 各効果音ごとに再生するチャンネルを決めておく


など、何らかの工夫が必要になります。

### 効果音を鳴らしてみる

では実際に効果音を鳴らしてみましょう。
サンプルパック 2 ではリンゴを取ったとき (get.wav) と爆弾に当たったとき (bom08.wav) の 2 種類の音を用意しています。どちらも「プレイヤーと物が接触したとき」に鳴らす音なので、当たり判定のところを書き換えるのが良さそうですね。

items.rb を以下のように書き換えてください。

{% highlight text %}
{% raw %}
class Items

  def initialize
    @items = []
    
    # 音声の読み込み
    @sound_get  = SDL::Mixer::Wave.load("sound/get.wav")
    @sound_bomb = SDL::Mixer::Wave.load("sound/bom08.wav")
  end
 
  def act(player)
    (中略)

    @items.each do |item|
      case item
      when Apple
        # リンゴに当たったら
        if item.collides?(player)
          item.is_dead = true 
          SDL::Mixer.play_channel(-1, @sound_get, 0)    # 効果音を鳴らす
        end
      when Bomb
        # 爆弾に当たったら
        if item.collides?(player)
          crash = true                                    
          SDL::Mixer.play_channel(-1, @sound_bomb, 0)   # 効果音を鳴らす
        end
      end
    end

  (後略)
{% endraw %}
{% endhighlight %}


書き換えたら、main.rb を実行してみてください。正しく効果音が鳴りましたか？

### 効果音の遅延について

環境によっては、効果音が遅れて再生される場合があります。こんなときは、[SDL::Mixer.open](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-350) の引数でバッファサイズを小さくすると直ることがあります。

例えばバッファサイズをデフォルト (4096 バイト) の半分にするには以下のようにします。

{% highlight text %}
{% raw %}
SDL::Mixer.open(SDL::Mixer::DEFAULT_FREQUENCY, SDL::Mixer::DEFAULT_FORMAT,
                SDL::Mixer::DEFAULT_CHANNELS,  2048)
{% endraw %}
{% endhighlight %}


### 効果音を用意するには？

効果音は単なる Wave ファイルなので、コンピュータにマイクを繋いで録音したり、音楽ソフトを使って自作することができます。

が、爆発音など自分で作るのが難しい音もあります。そういうものに関してはフリー素材を利用するのが良いでしょう。
[「効果音」で検索](http://www.google.co.jp/search?num=100&hl=ja&q=%E5%8A%B9%E6%9E%9C%E9%9F%B3&lr=lang_ja)すればいろいろなサイトが見つかると思います。作者の方に感謝しつつゲームに組み込みましょう。

ただ、フリー素材は利用に条件が課せられていることもあります (商用利用は不可、など)。事前によく確認しておきましょう。

サンプルパック 2 の爆発音は以下のサイトのものを使わせていただいています。ありがとうございます。

* [ザ・マッチメイカァズ](http://osabisi.sakura.ne.jp/m2/)


## 文字を表示してみよう

だいぶゲームらしくなってきましたが、ただ一つゲームと呼ぶには決定的に足りないものがあります。そう、得点 (スコア) です。次はスコア表示を付けてみましょう。

### フォントの種類

スコアを表示するには Ruby/SDL のフォント機能を使います。

フォントファイルには以下の形式が利用可能です。

* TTF フォント
* ビットマップフォント
* SFont
* BDF フォント


それぞれどういうものか……の説明はあと回しにして、とりあえずスコア表示を実装してみましょう。
サンプルパック2 には boxfont2.ttf という TTF フォントが入っているので、これを使います。

### TTF フォントの表示

TTF フォントの表示には、最初に初期化が必要です。

{% highlight text %}
{% raw %}
SDL::TTF.init
{% endraw %}
{% endhighlight %}


次に、[SDL::TTF.open](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-487) でフォントファイルを読み込みます。引数にはファイル名と文字のサイズを指定します。

{% highlight text %}
{% raw %}
font = SDL::TTF.open('boxfont2.ttf', 24)
{% endraw %}
{% endhighlight %}


フォントを描画するためには 3 種類のメソッドが用意されています。それぞれの特徴は、ごく大雑把に言えば以下のようになります。

[SDL::TTF#draw_solid_utf8](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-506)
: 速い。画質はあまり良くない。

[SDL::TTF#draw_shaded_utf8](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-510)
: 遅い。背景が一色のときに使う。

[SDL::TTF#draw_blended_utf8](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-508)
: 遅い。画質は綺麗。

基本的には、ゲーム中は高速に描画できる方がいいので draw_solid_utf8 を、タイトル画面は動きが少ないので draw_blended_utf8 を……といった感じで使い分けるのが良いでしょう。

SDL::TTF#draw_solid_utf8 の使い方は以下のような感じです。

{% highlight text %}
{% raw %}
font.draw_solid_utf8(screen, 'Hello, world!', x, y, 255, 255, 255)
{% endraw %}
{% endhighlight %}


### スコアを計算する

スコアの計算方法にはいろいろなものが考えられますが、ここでは簡単に「リンゴを一つ取ったら 10 点」ということにしましょう。(別に 1 点でも良いのですが、10 点のほうがスコアの桁が大きくなってなんとなく気分がいいですよね。)
また、ゲーム中の最高得点を「ハイスコア」として表示したいと思います。

必要な処理は

1. プログラム起動時にはハイスコアは 0 にする
1. ゲームが始まったらスコアを 0 にする
1. リンゴを 1 個取るごとに 10 点加算する
1. ゲームオーバーになったらハイスコアを更新する


といったところでしょうか。

基本的には main.rb を書き換えていきますが、
(3) のところだけ items.rb を書き換える必要があります。
「リンゴを取る」処理が Items#act に書かれているからです。

Items#act を以下のように書き換えてください。配列を返り値にすることで、「爆弾に当たったかどうか」と「取ったリンゴの数」という 2 種類の値を返しています。

{% highlight text %}
{% raw %}
class Items
  (中略)

  def act(player)
    # 取ったリンゴの数を数える
    apples = 0
    crash = false

    (中略)
      
    @items.each do |item|
      case item
      when Apple
        # リンゴを取ったら
        if item.collides?(player)
          item.is_dead = true 
          SDL::Mixer.play_channel(-1, @sound_get, 0) 
          apples += 1     # apples を 1 増やす
        end
      when Bomb
        if item.collides?(player)
          crash = true 
          SDL::Mixer.play_channel(-1, @sound_bomb, 0) 
        end
      end
    end

    (中略)

    # 爆弾に当たったかどうかと、取ったリンゴの数を返す
    [crash, apples]
  end

  (後略)
{% endraw %}
{% endhighlight %}


さて、ではこれを使って main.rb を書き換えてみましょう。まず、初期化のところに SDL::TTF.init を追加します。

{% highlight text %}
{% raw %}
SDL.init(SDL::INIT_EVERYTHING)
SDL::Mixer.open
SDL::TTF.init     # フォント機能の初期化
screen = SDL.set_video_mode(SCREEN_W, SCREEN_H, 16, SDL::SWSURFACE)
{% endraw %}
{% endhighlight %}


次に、GameScene を以下のように書き換えます。initialize でフォントを読み込んで、render で文字を描画しています。

{% highlight text %}
{% raw %}
class GameScene

  def initialize
    @high_score = 0          # (1) プログラム起動時にはハイスコアは 0 にする
    @player = Player.new(240)
    @items = Items.new
    @bgm = SDL::Mixer::Music.load("sound/famipop3.it")
    # フォントの読み込み
    @font = SDL::TTF.open('image/boxfont2.ttf', 50)
  end

  def start
    @items.clear
    @score = 0               # (2) ゲームが始まったらスコアを 0 にする
    SDL::Mixer.play_music(@bgm, -1) 
  end

  def act(input)
    @player.act(input)            
    is_crashed, apples = @items.act(@player)

    if is_crashed  
      SDL::Mixer.halt_music
      # (4) ゲームオーバーになったらハイスコアを更新する
      @high_score = @score if @high_score < @score 
      return :game_over
    else
      @score += apples * 10  # (3) リンゴを 1 個取るごとに 10 点加算する
      return nil
    end
  end

  def render(screen)
    screen.fill_rect(0, 0,       SCREEN_W, HOLIZON,          [128, 255, 255])
    screen.fill_rect(0, HOLIZON, SCREEN_W, SCREEN_H-HOLIZON, [0, 128, 0])

    @player.render(screen)  
    @items.render(screen) 

    # スコアを描画する
    @font.draw_solid_utf8(screen, "score: #{@score} hi-score: #{@high_score}", 0, 0, 255, 0, 0)
  end
end
{% endraw %}
{% endhighlight %}


ここまでできたら、main.rb を起動してみてください。最初はスコアもハイスコアも 0 であること、リンゴを 1 個取るごとにスコアが 10 点増えること、最高得点を出すとハイスコアが更新されることを確認してください。

### フォントを用意するには？

さて、今回はサンプルパック2 付属のフォントを使いましたが、ゲームの雰囲気によってはもっと丸い感じのフォントが欲しい……と思うこともあるでしょう。そういう時は[「フリーフォント」で検索](http://www.google.co.jp/search?hl=ja&lr=lang_ja&num=100&q=%e3%83%95%e3%83%aa%e3%83%bc%e3%83%95%e3%82%a9%e3%83%b3%e3%83%88)すれば、フリーで公開されている TTF フォントがいくつも見つかります。

が、ちょっと待ってください！　TTF フォントの場合、「画像の一部に使うのは自由だが、.ttf ファイルそのものを再配布するのは不可」というライセンスになっているものが多くみられます。これでは、いい感じのフォントが見つかったとしてもゲームに組み込んで公開することができません。

そんな時に役に立つのがビットマップフォントです。

### ビットマップフォント

ビットマップフォントは、ASCII コード 0 から 255 までの全ての文字を横に並べた画像をフォントとして使用するものです。一度画像に変換してしまえば .ttf ファイルを再配布する必要はないので、多くのフリーフォントが使用可能になります。

TTF フォントからビットマップフォントを自動生成するツールを以下の URL で公開しています。どうぞご利用ください。

* [http://mono.kmc.gr.jp/~yhara/w/?SDL-BMFontMaker](http://mono.kmc.gr.jp/~yhara/w/?SDL-BMFontMaker)


#### ビットマップフォントの使い方

まず [SDL::BMFont.open](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-462) でフォントを読み込みます。フラグに SDL::BMFont::TRANSPARENT を指定すると、(画像のカラーキーのように) 文字の背景を透化することができます。

{% highlight text %}
{% raw %}
font = SDL::BMFont.open("filename.bmp", SDL::BMFont::TRANSPARENT)
{% endraw %}
{% endhighlight %}


描画は [SDL::BMFont#textout](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-468) で行います。

{% highlight text %}
{% raw %}
font.textout(screen, "Hello, world!", x, y)
{% endraw %}
{% endhighlight %}


単色のフォントの場合は、[SDL::BMFont#set_color](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-465) で文字の色を変えることができます。ただし open のときに SDL::BMFont::PALETTE を指定しておいてください。

{% highlight text %}
{% raw %}
font = SDL::BMFont.open("filename.bmp", SDL::BMFont::TRANSPARENT|SDL::BMFont::PALETTE)
font.set_color(0,255,0)
{% endraw %}
{% endhighlight %}


### その他のフォント形式

その他のフォント形式についても少しだけ解説しておきます。

#### SFont

SFont はビットマップフォントと似ていますが、文字ごとに幅を変えられたり、半透明が使えるなどより高機能になっています。

SFont に関するより詳しい情報については [Linux-games.com](http://www.linux-games.com/sfont/) を参照してください。Linux-games.com では [SFont のサンプル](http://user.cs.tu-berlin.de/~karlb/sfont/fonts.html) もいくつか公開されています。

また、TTF フォントから SFont を自動生成するツールを現在製作中です。以下の URL にて公開予定です。

* [http://mono.kmc.gr.jp/~yhara/w/?SDLFontMaker](http://mono.kmc.gr.jp/~yhara/w/?SDLFontMaker)


SFont の読み込みは、ビットマップフォントと同じく [SDL::BMFont.open](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-462) を使います (フラグに SDL::BMFont::SFONT を指定すると SFont の読み込みになります)。SFont の描画には [SDL::BMFont#textout](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-468) を使います。

{% highlight text %}
{% raw %}
font = SDL::BMFont.open("filename.bmp", SDL::BMFont::TRANSPARENT|SDL::BMFont::SFONT)
font.textout(screen, "Hello, world!", x, y)
{% endraw %}
{% endhighlight %}


#### BDF フォント

BDF フォントは Unix 系 OS を中心に利用されているフォーマットで、漢字・ひらがな・カタカナなど英数記号以外の文字を表示できるのが特徴です。
ノベルゲーム・アドベンチャーゲームなど、日本語の文章を表示するなら事実上唯一の選択肢でしょう。
[^1]

BDF フォントの入手先については [(X11 を中心とした) フリーの日本語ビットマップフォント一覧](http://khdd.net/kanou/fonts/x11bdfs.html)等が参考になります。

BDF フォントの表示には [SDL::Kanji](http://shinh.skr.jp/sdlkanji/) が必要です (Windows 版バイナリには最初から組み込まれています)。

BDF フォントを使用するには、まず [SDL::Kanji.open](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-472) にファイル名と文字のサイズを指定して読み込みを行います。次に、[SDL::Kanji#set_coding_system](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-476) で表示する文字列の文字コードを指定します。.rb の文字コードに合わせて、SJIS, EUC, JIS のいずれかを指定してください。

{% highlight text %}
{% raw %}
font = SDL::Kanji.open("fileame.bdf", 12)
font.set_coding_system(SDL::Kanji::SJIS) #Rubyスクリプトの文字コードがshift_jisのとき
{% endraw %}
{% endhighlight %}


文字の表示には [SDL::Kanji#put](http://www.kmc.gr.jp/~ohai/rubysdl_doc.html#label-480) を使います。

{% highlight text %}
{% raw %}
  font.put(screen, "こんにちは世界", x, y, r, g, b) 
{% endraw %}
{% endhighlight %}


## ハイスコアを保存してみよう

現在の仕様では、一度ゲームを終了するとハイスコアは消去されてしまいます。
最後の仕上げとして、ゲーム終了時にハイスコアをファイルに保存し、次の起動時にも引き継げるようにしてみましょう。

### データの保存形式について

セーブデータを簡単に保存する方法としてはテキストファイルや YAML 形式 などが考えられますが、ここでは Ruby の標準ライブラリである Marshal モジュールを使ってみます。Marshal は Ruby のオブジェクトをバイナリデータに変換するモジュールで、Ruby のほとんどのオブジェクトをファイルに保存することができます (保存できないものは IO オブジェクトなど。詳細は [Marshal#dump](http://www.ruby-lang.org/ja/man/?cmd=view;name=Marshal#Marshal.2edump) の項を参照してください)。

### Marshal の使い方

Marshal は Ruby の標準ライブラリなので、特にインストールや require などは必要ありません。

あるデータをファイルに Marshal 形式で保存するには以下のようにします。

{% highlight text %}
{% raw %}
 File.open("savefile.dat", "wb"){|f| Marshal.dump(data,f) }
{% endraw %}
{% endhighlight %}


ここで、ファイルモードに「wb」を指定することに注意してください。Marshal 形式のデータはバイナリデータなので、ファイルモードに b を付けてバイナリモードにしないと Windows 上でデータがうまく読み書きできません。

逆にファイルから Marshal 形式のデータを読み込むには以下のようにします。

{% highlight text %}
{% raw %}
 data = File.open("savefile.dat","rb"){|f| Marshal.load(f) }
{% endraw %}
{% endhighlight %}


ここでもファイルモードに b を付けています。

### ハイスコアを保存してみる

では、実際にハイスコアの保存処理を書いてみましょう。
ハイスコアの読み込み・保存はゲームの開始時と終了時に行うので、main.rb のトップレベルに書くのが良さそうです。しかしハイスコアのデータは GameScene が持っているので、これを外からアクセスできるようにしないといけませんね。

ということで、まず GameScene の定義を以下のように書き換えます。

{% highlight text %}
{% raw %}
class GameScene
  attr_reader :high_score  # @high_score へのアクセサを定義

  def initialize(high_score)
    @high_score = high_score  # 前回のハイスコアを引数から受け取る
    @player = Player.new(240)
    @items = Items.new
    @bgm = SDL::Mixer::Music.load("sound/famipop3.it")
    @font = SDL::TTF.open('image/boxfont2.ttf', 50)
  end
  
  (後略)
{% endraw %}
{% endhighlight %}


次に、セーブデータを表すクラスを定義します。
今回は保存するデータが単純なのでありがたみが薄いですが、「ランキングも保存したい」「プレイ時間も記録したい」など保存するデータが複雑になってくれば、クラスに分けておいた方が便利です。

{% highlight text %}
{% raw %}
class SaveData

  def initialize(file_name)
    load(file_name)
  end
  attr_accessor :high_score

  # 読み込み
  def load(file_name)
    # セーブファイルが存在すれば読み込む
    if File.exist?(file_name)
      data = File.open(file_name, "rb"){|f| Marshal.load(f) } 
      @high_score = data
    else
      # セーブファイルが存在しなければ、ハイスコアは 0
      @high_score = 0
    end
  end

  # 書き込み
  def save
    data = @high_score
    File.open("savefile.dat", "wb"){|f| Marshal.dump(data, f) }
  end
end
{% endraw %}
{% endhighlight %}


これを使うと、ハイスコアの読み込みは以下のように書けます。main.rb の Scenes を定義しているところを以下のように書き換えてください。

{% highlight text %}
{% raw %}
save_data = SaveData.new("savefile.dat") #セーブデータの読み込み
Scenes = {
  :title     => TitleScene.new,
  :game      => GameScene.new(save_data.high_score), #前回のハイスコアを渡す
  :game_over => GameOverScene.new,
}
{% endraw %}
{% endhighlight %}


また、ハイスコアの保存は以下のように書けます。main.rb の一番最後に以下を付け足してください。

{% highlight text %}
{% raw %}
save_data.high_score = Scenes[:game].high_score
save_data.save
{% endraw %}
{% endhighlight %}


ここまでできたら main.rb を起動し、ハイスコアがちゃんと保存されるか確認してみてください。

## おわりに

本稿では 2 回にわたり、Ruby/SDL でのゲーム製作について解説してきました。

ごく簡単なゲームだったので、ゲーマーな方には物足りなかったかも知れません。しかし本稿を読み終えたあなたなら、どこをいじればゲームを難しくできるかはご存知のはずです。:-) 爆弾の数を多くする？　落下速度を速くする？　それとも、落ちてくる物の種類を増やす？　空を飛べるようにしてみるとか、色違いのキャラクターを用意して 2 人対戦なんてのも良いかも知れませんね。

何にせよソースコードがあなたの手にある以上、このゲームの行く末はあなたのアイデア次第です。お好きなように改造してみてください。

「ゲームを作ってみたい」と思っている方にとって、本稿が少しでも後押しになれば幸いです。

## 関連リンク

[Ruby/SDL](http://www.kmc.gr.jp/~ohai/rubysdl.html)
: Ruby/SDL の公式サイトです。

[Ruby/SDL Reference](http://www.kmc.gr.jp/~ohai/rubysdl.html)
: Ruby/SDL の日本語リファレンスです。

[Ruby/SDL Users](http://mono.kmc.gr.jp/proj/rubysdl/)
: Ruby/SDL の関連情報についてまとめたページです。[Ruby/SDL を利用した作品へのリンク集](http://mono.kmc.gr.jp/proj/rubysdl/?Works)や[逆引き Ruby/SDL](http://mono.kmc.gr.jp/proj/rubysdl/?GyakubikiRubySDL) などのコンテンツがあります。

## 著者について

yhara
:  [京大マイコンクラブ](http://www.kmc.gr.jp/)に所属する大学院生。最近はまっているゲームは [blocksum](http://infotech.rim.zenno.info/products/blocksum/ja/)。

----

[^1]: Windows の「MS ゴシック」など OS 固有の日本語フォントを使うという選択肢もありますが、他の OS で動かせなくなるのでおすすめしません。
