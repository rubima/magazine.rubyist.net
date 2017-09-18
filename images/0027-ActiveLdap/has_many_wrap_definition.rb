class Group < ActiveLdap::Base
  ldap_mapping :prefix => "ou=Groups",
                :dn_attribute => "cn", :classes => ["posixGroup"]

  has_many :users, :wrap => "memberUid",
                    :class_name => "User", :primary_key => "uid"
end
