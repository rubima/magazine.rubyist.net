#!/usr/local/bin/ruby

print "Content-Type: text/html\n\n"
print "<html><head></head><body>"
print ENV['QUERY_STRING']
print "</body></html>"
