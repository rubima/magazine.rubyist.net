# test/recipes/default.rb

execute "sendmail" do
  command 'echo "Cook me something tasty." | mail -s "Hello! Chef!" 164c@example.com'
end

template "/tmp/test.conf" do
 owner "root"
 group "root"
 mode "0644"
# notifies :restart, "service[hoge]"
 notifies :run, resources(:execute => "sendmail")
end
