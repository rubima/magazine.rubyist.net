class User < ActiveLdap::Base
  ldap_mapping :prefix => "ou=Users",
                :dn_attribute => "uid",
                :classes => ["inetOrgPerson", "posixAccount"]

  def validate
    # uid が正規表現にマッチするか確認
    if self.uid !~ /\A[a-zA-Z0-9]+\z/
      # uid でエラーが起きた事を記録
      errors.add :uid, "must match with '/\\A[a-zA-Z0-9]+\\z/'."
    end
  end
end
