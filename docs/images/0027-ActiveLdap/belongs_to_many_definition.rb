class User < ActiveLdap::Base
  ldap_mapping :prefix => "ou=Users",
                :dn_attribute => "uid", :classes => ["inetOrgPerson", "posixAccount"]

  belongs_to :groups, :primary_key => "uid",
                        :class_name => "Group", :many => "memberUid"
end
