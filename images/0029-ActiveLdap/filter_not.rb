# (!(uid=ruby_taro))
User.find :all, :filter => [:not, [:uid, 'ruby_taro']] 
