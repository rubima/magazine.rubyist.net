foo = {{*a*}} = { "name"=>"foo", "parent"=>nil }
bar = { "name"=>"bar", "parent"=>{{*a*}} }
baz = { "name"=>"baz", "parent"=>{{*a*}} }
[ foo, bar, baz ]
