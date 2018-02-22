puts 'じゃんけん'
sleep 1
r = rand(3) + 1
case r
when 1 # r が 1 のとき
  puts 'グー'
when 2 # r が 2 のとき
  puts 'チョキ'
when 3 # r が 3 のとき
  puts 'パー'
end
