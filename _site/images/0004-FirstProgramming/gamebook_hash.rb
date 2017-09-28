msg0 = "３本の分かれ道があります。どの道を進みますか。\n" +
       "  1 左の道\n  2 真ん中の道\n  3 右の道"
msg1 = "あっ！\n落とし穴に落ちてしまいました。\n～ GAME " +
       "OVER ～"
msg2 = "真ん中の道をまっすぐ歩いていくと……\n宝箱をみつ" +
       "けました！\n  1 そのままにしておく\n  2 あける"
msg3 = "しばらく歩き続けると　もとの場所にもどってしまい" +
       "ました。\n  1 次へ"
msg4 = "宝箱には見向きもせず　お家に帰りました。\n～ GAM" +
       "E OVER ～"
msg5 = "パカッ\nまばゆい光があふれだす……\n１００枚の金" +
       "貨を手に入れました！"

tbl = {
  'opening' => [msg0, 'left', 'center', 'right'],
  'left'    => [msg1],
  'center'  => [msg2, 'leave', 'ending'],
  'right'   => [msg3, 'opening'],
  'leave'   => [msg4],
  'ending'  => [msg5],
}

scene = 'opening'
while true
  scene_data = tbl[scene]
  message = scene_data[0]
  puts message

  if scene_data[1] == nil
    exit
  end

  print '  数字を入力してください '
  input_value = gets.to_i

  if input_value > 0
    next_scene = scene_data[input_value]
    if next_scene == nil
      puts '不正な値が入力されました'
    else
      scene = next_scene
    end
  else
    puts '不正な値が入力されました'
  end

  sleep 0.5
  print "\n"
end
