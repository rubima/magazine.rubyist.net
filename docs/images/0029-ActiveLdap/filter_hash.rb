# "(|(uid=ruby_taro)(uid=ruby_hanako))" ‚ª—˜—p‚³‚ê‚é
User.find :all, :filter => [:or, [:uid, ['ruby_taro', 'ruby_hanako']]]     

# ‚±‚ê‚à“¯‚¶
User.find :all, :filter => [:or, {:uid => ['ruby_taro', 'ruby_hanako']}]
