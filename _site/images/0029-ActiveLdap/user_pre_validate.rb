class User < ActiveLdap::Base
  ldap_mapping :prefix => "ou=Users",
                :dn_attribute => "uid",
                :classes => ["inetOrgPerson", "posixAccount"]
  
  validates_format_of :uid, :with => /\A[a-zA-Z0-9]+\z/,
                      :message => "must match with '/\\A[a-zA-Z0-9]+\\z/'."
end
