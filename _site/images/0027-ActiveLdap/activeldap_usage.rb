# 接続設定
ActiveLdap::Base.setup_connection :host => "localhost", :base => "o=rubyistMagazine,c=jp"

# クラス定義
class User < ActiveLdap::Base 
  ldap_mapping :dn_attribute => "cn", :prefix => "ou=Users"
end

# ユーザの検索
u = User.find "Ruby Taro" #=> #<User ....>

# オブジェクトクラスの参照
u.classes                 #=> ["top", "posixAccount"]

# 属性 の getter
u.cn                   #=> "Ruby Taro"

# 属性への setter
u.gid_number = 9999       #=> 9999

# エントリの保存
u.save                    #=> true

# エントリの削除
u.destroy                 #=> true
