# test/recipes/default.rb

execute "sendmail" do
  command 'echo "Cook me something tasty." | mail -s "Hello! Chef!" morotomi@328w.co.jp'
  action :nothing
end

template "/tmp/test.conf" do
 owner "root"
 group "root"
 mode "0644"
# notifies :restart, "service[hoge]"
 notifies :run, resources(:execute => "sendmail")
end
