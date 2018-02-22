# :filter オプションを組み立てて記述する例
users                 = ['ruby_taro', 'ruby_hanako']
exclude_uidnumber     = 10000

user_filter     = [:or,  {:uid => users}]
exclude_filter  = [:not, [:uidNumber, exclude_uidnumber]]

# "(&(|(uid=ruby_taro)(uid=ruby_hanako))(!(uidNumber=10000)))" が適用される
User.find :all, :filter => [:and, user_filter, exclude_filter]
