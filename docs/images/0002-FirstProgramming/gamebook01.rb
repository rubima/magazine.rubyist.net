tbl = {
  's1'  => ["メッセージ1", "s2","s3"],
  's2'  => ["メッセージ2", "end"],
  's3'  => ["メッセージ3", "s1","end"],
  'end' => [nil],
}
scene = 's1'

while true
  message = tbl[scene].first
  break if message == nil
  begin
    puts message
    input_value = STDIN.gets.chomp
    raise if /[^\d]/ =~ input_value
    break if input_value.to_i == 0
    new_scene = tbl[scene][input_value.to_i]
    raise if new_scene == nil
  rescue
    puts '不正な値が入力されました'
    retry
  end
  scene = new_scene
end
