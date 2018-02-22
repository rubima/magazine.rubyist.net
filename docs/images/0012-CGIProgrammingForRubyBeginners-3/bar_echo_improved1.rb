#!/usr/local/bin/ruby

require "cgi"

print "Content-Type: text/html\n\n"
print "<html><head></head><body>"

c = CGI.new
text = c["t"]
print text
print "<br>"

print "</body></html>"
