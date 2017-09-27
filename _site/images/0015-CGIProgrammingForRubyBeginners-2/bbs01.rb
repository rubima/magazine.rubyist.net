#!/usr/local/bin/ruby
require 'cgi'

f = open("bbs01.dat", "r") 
arr = []
l = f.gets

while l 
  arr << CGI.escapeHTML(l)
  l = f.gets
end

f.close



print "Content-type: text/html\n\n"

print <<EOF
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
  <link rel="stylesheet" href="theme/blue-border/blue-border.css" type="text/css">
  <title>simple BBS </title>
</head>
<body>
<h1>簡易掲示板</h1>
<hr class="sep">

EOF



i = arr.length - 1
while i >= 0 
print <<EOF
  <div class="day">
    <div class="body">
      <div class="section">
      #{arr[i]}
      </div>
    </div>
  </div>
EOF
  i = i - 1
end



print <<EOF

<hr class="sep">

<div class="footer">
</div>

</body>
</html>
EOF

