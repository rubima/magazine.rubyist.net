class User < ActiveLdap::Base
  ldap_mapping :prefix => "ou=Users",
                :dn_attribute => "uid",
                :classes => ["inetOrgPerson", "posixAccount"]

  validate :validates_uid

  def validates_uid
    if self.uid !~ /\A[a-zA-Z0-9]+\z/
      errors.add :uid, "must match with '/\\A[a-zA-Z0-9]\\z/'."
    end
  end
end
