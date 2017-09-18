#!/usr/bin/ruby

require "cgi"

c = CGI.new

f = open("access.txt", "w")
f.write(Time.new)
f.write(": ")
f.write(c.remote_addr)
f.write(", ")
f.write(c.remote_host)
f.write("\n")

print "Content-Type: text/html\n\n"
print "OK"

