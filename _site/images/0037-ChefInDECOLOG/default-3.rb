# test/recipes/default.rb

template "/tmp/test.conf" do
 owner "root"
 group "root"
 mode "0644"
 notifies :restart, "service[hoge]"
end

service "hoge" do
  service_name "httpd"
  restart_command "service httpd restart"
end
