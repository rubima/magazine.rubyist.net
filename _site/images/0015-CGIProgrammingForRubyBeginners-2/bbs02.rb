#!/usr/local/bin/ruby

require 'cgi'

filename = "bbs02.rb"
num_list = [10, 20, 50, 100]

f = open("bbs02.dat", "r") 
arr = []
l = f.gets

while l 
  arr << CGI.escapeHTML(l)
  l = f.gets
end

f.close

cgi = CGI.new

en = cgi["en"]
if en == ""
  en = arr.length - 1
else
  en = en.to_i
  if en < 0 or en > arr.length - 1
    en = arr.length - 1
  end
end

num = cgi["num"].to_i
if num <= 0 or num > 100
  num = 20
end

st = en - num + 1
if st < 0 
  st = 0
end

link = "<div class=\"navi\">"
if st > 0 
  link = link + " <a href=\"#{filename}?num=#{num}&en=#{st-1}\">前のページ</a> "
else
  link = link + " 前のページ "
end  

if en < arr.length-1
  link = link + " <a href=\"#{filename}?num=#{num}&en=#{en+num}\">次のページ</a> "
else  
  link = link + " 次のページ "
end
num_list.each do |i|
  link = link + " <a href=\"#{filename}?num=#{i}&en=#{en}\">#{i}件ごと</a> "
end
link = link + "</div>"


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
#{link}

<hr class="sep">
EOF



i = en
while i >= st 
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
#{link}
<div class="footer">
</div>

</body>
</html>
EOF

