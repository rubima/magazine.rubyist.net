hash = {}
hash[:ou] = 'rubyistMagazine'
hash[:sn] = 'Ruby'

# "(&(ou=rubyistMagazine)(sn=Ruby))" ‚ª—˜—p‚³‚ê‚é
User.find :all, :filter => [:and, hash] 
