# user が保存される
# （has_many を利用し、posixAccount と posixGroup を ユーザ側の gidNumber で 関連付けている場合の例）
group.primary_users << user
