#!/usr/bin/ruby

require "cgi"

print "Content-Type: text/html\n\n"

cgi = CGI.new
m = cgi["message"]

print m
