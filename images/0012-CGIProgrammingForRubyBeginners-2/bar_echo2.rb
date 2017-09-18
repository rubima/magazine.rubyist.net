#!/usr/local/bin/ruby

print "Content-Type: text/html\n\n"
print "<html><head></head><body>"

str = ENV["QUERY_STRING"]
print str
print "<br>"

arr1 = str.split("&")
print arr1[0]
print "<br>"
print arr1[1]
print "<br>"

arr2 = arr1[0].split("=")
print arr2[1]

print "</body></html>"
