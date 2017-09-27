# "(uid=ruby_taro)" ‚Ì•Ê•\Œ»
User.find :first, :filter => [:uid, 'ruby_taro']

# "(|(uid=ruby_taro)(uid=ruby_hanako))" ‚Ì•Ê•\Œ»
User.find :all, :filter => [:or, {:uid => ['ruby_taro', 'ruby_hanako']}]
