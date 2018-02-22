class User < ActiveLdap::Base
  ldap_mapping :prefix => "ou=Users",
                :dn_attribute => "uid",
                :classes => ["inetOrgPerson", "posixAccount"]
  def before_save
    puts "before_save received"
  end
  def after_save
    puts "after_save received"
  end
end
