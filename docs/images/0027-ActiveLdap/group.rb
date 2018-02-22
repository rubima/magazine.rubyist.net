class Group < ActiveLdap::Base
  ldap_mapping :prefix => "ou=Groups",
                :dn_attribute => "cn", :classes => ["posixGroup"]

  has_many :primary_users, :primary_key => "gidNumber",
                            :class_name => "User", :foreign_key => "gidNumber"

  has_many :users, :wrap => "memberUid",
                    :class_name => "User", :primary_key => "uid"
end
