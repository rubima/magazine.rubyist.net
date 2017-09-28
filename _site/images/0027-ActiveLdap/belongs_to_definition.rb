class User < ActiveLdap::Base
  ldap_mapping :prefix => "ou=Users",
                :dn_attribute => "uid", :classes => ["inetOrgPerson", "posixAccount"]

  belongs_to :primary_group, :foreign_key  => "gidNumber",
                              :class_name => "Group", :primary_key => "gidNumber"
end

