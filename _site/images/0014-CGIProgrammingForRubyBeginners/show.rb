#!/usr/bin/ruby

require "cgi"

c = CGI.new

print "Content-Type: text/plain\n\n"

print Time.new
print ": "
print c.remote_addr
print ", "
print c.remote_host
print "\n"
