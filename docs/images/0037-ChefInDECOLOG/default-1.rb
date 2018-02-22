# test/recipes/default.rb

template "/tmp/test.conf" do
  notifies :restart, "service[httpd]"
end

service "httpd"
