class MyShip
  attr_accessor :x, :y, :collision, :delta_x, :delete

  # 画像読み込みと影画像生成
  @@image0 = Image.loadToArray("image/myship.png", 4, 1)
  @@image1 = Array.new(4) {Image.new(32, 32)}
  black = [128, 0, 0, 0]
  for i in 0..3
    for y in 0..31
      for x in 0..31
        # 元画像で透明じゃない部分を黒にする
        @@image1[i][x, y] = black if @@image0[i][x, y][0] != 0
      end
    end
  end

  # ショット音生成
  f = 4000
  @@sound = SoundEffect.new(20, WAVE_TRI) do   # 20ms の三角波を生成する
    f = f - 120      # 周波数は 4000Hz から 1ms ごとに 120Hz 下げる
    [f, 15]          # [ 周波数, 音量 ] の配列を返す
  end

  # 初期化処理
  def initialize
    @x = 140          # x 座標
    @y = 400          # y 座標
    @oldx = 140       # 前フレームのx座標
    @delete = false   # 自機が消えたときは true
    @animecount = 0   # アニメーション用カウント
    @collision = CollisionBox.new(nil, 4, 4, 27, 27)  # 衝突判定オブジェクト
  end

  def update
    # 移動
    dx = Input.x * 2.4
    dy = Input.y * 3
    if Input.x != 0 and Input.y != 0   # ナナメの時は 0.7 倍
      dx *= 0.7
      dy *= 0.7
    end
    @x += dx
    @y += dy

    # 画面端の判定
    @x = 0 if @x < 0
    @x = 360 - 32 if @x > 360 - 32
    @y = 0 if @y < 0
    @y = 480 - 32 if @y > 480 - 32

    # 衝突判定範囲の移動
    @collision.set(@x, @y)

    # ショット
    if Input.padPush?(P_BUTTON0)
      ObjectGroup.push(MyShot.new(@x - 18, @y - 32, 270))
      ObjectGroup.push(MyShot.new(@x + 18, @y - 32, 270))
      ObjectGroup.push(MyShot.new(@x + 32, @y - 16, 300))
      ObjectGroup.push(MyShot.new(@x - 32, @y - 16, 240))
      @@sound.play
    end

    # 背景や敵などの横補正値計算
    @delta_x = -((@x - @oldx) / 5)
    @oldx = @x

    # アニメーション用カウント
    @animecount += 1
    @animecount -= 80 if @animecount >= 80
  end

  # 描画
  def draw
    Window.draw(@x, @y, @@image0[@animecount / 20], 15)           # 自機
    Window.draw(@x - 16, @y - 16, @@image1[@animecount / 20], 1)  # 影
  end
end