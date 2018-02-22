class Group < ActiveLdap::Base
  ldap_mapping :prefix => "ou=Groups",
                :dn_attribute => "cn", :classes => ["posixGroup"]

  # User クラスを直接指定している
  has_many :members, :wrap => "memberUid",
                    :class => User, :primary_key => "uid"　
end
