#!/usr/bin/ruby

require "cgi"

print "Content-Type: text/html\n\n"

cgi = CGI.new

p cgi.params
m = cgi["msg"]
p m

print m
