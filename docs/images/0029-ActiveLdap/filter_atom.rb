# "(uid=ruby_taro)" ‚ª—˜—p‚³‚ê‚é
User.find :all, :filter => [:uid, 'ruby_taro']

# "(uidNumber>=100)" ‚ª—˜—p‚³‚ê‚é
User.find :all, :filter => [:uidNumber, '>=', 100]
