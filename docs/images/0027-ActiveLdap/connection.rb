 ActiveLdap::Base.setup_connection :base => "o=rubyistMagazine,c=jp",
                                     :bind_dn => "cn=Manager,o=rubyistMagazine,c=jp",
                                     :password_block => lambda{"secret"}
