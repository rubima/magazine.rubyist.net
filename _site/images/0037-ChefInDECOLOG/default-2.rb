# test/recipes/default.rb

template "/tmp/test.conf" do
  notifies :restart, "service[httpd]", :immediately
end

service "httpd"
