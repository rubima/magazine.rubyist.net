Window.caption = "るびま用 DXRuby サンプルゲーム" # ウィンドウのキャプション設定
Window.width = 360        # ウィンドウの横サイズ設定
Window.height = 480       # ウィンドウの縦サイズ設定
Input.setRepeat(0, 5)     # キーのオートリピート設定。5 フレームに 1 回 on

ObjectGroup = []          # オブジェクト配列
Collision_MyShot = []     # 弾の判定範囲配列
Collision_Enemy = []      # 敵の判定範囲配列
Collision_EnemyShot = []  # 敵の弾の判定範囲配列

count = 0                 # 敵出現処理用カウント
font = Font.new(32)       # フォント生成

$myship = MyShip.new      # 自機生成
ObjectGroup.push($myship) # 自機をオブジェクト配列に追加
ObjectGroup.push(Map.new) # 背景オブジェクト生成＆オブジェクト配列に追加

# メインループ
Window.loop do

  # 敵出現処理
  count += 1
  if count % 20 == 0      #  20 カウントに 1 回
    if count % 400 == 0   # 400 カウントに 1 回
      # 敵 2 のオブジェクト生成＆オブジェクト配列に追加
      ObjectGroup.push(Enemy2.new(rand(240), -64))
      count = 0
    else
      # 敵 1 のオブジェクト生成＆オブジェクト配列に追加
      ObjectGroup.push(Enemy1.new(rand(320), -48))
    end
  end

  # オブジェクト情報更新
  ObjectGroup.each do |obj|
    obj.update
  end

  # 衝突判定
  Collision.check(Collision_MyShot, Collision_Enemy)      # 自機ショットと敵
  Collision.check(Collision_EnemyShot, $myship.collision) # 敵ショットと自機

  # 衝突判定配列初期化
  Collision_MyShot.clear
  Collision_Enemy.clear
  Collision_EnemyShot.clear

  # 移動や衝突判定で消えたキャラを配列から削除
  ObjectGroup.delete_if do |obj|
    obj.delete
  end

  # オブジェクトを描画
  ObjectGroup.each do |obj|
    obj.draw
  end

  # Esc キーで終了
  break if Input.keyPush?(K_ESCAPE)

  # 各種情報出力
  Window.drawFont(0, 0, Window.getLoad.to_i.to_s + " %", font, :z => 100)
  Window.drawFont(0, 32, ObjectGroup.size.to_s + " objects", font, :z => 100)
end