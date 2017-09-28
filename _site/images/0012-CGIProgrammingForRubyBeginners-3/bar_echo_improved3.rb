#!/usr/local/bin/ruby

require "cgi"

print "Content-Type: text/html\n\n"
print "<html><head></head><body>"

arr = ["nya", "nyan", "fuu", "nobi", "suya"]
c = CGI.new
text = CGI.escapeHTML(c["t"])

if text == "bar"
  i = rand(5)
  s = arr[i]
  print i
  print "<br>"
  print s
  print "<br>"
  print s * rand(10)
  num = rand 7
  print "<br>"
  print "<img src=\"images/#{num}.jpg\"></img>\n" 
else
  print text
  print "<br>"
end

print "</body></html>"
