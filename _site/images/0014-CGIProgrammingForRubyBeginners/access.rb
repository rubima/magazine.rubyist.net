#!/usr/bin/ruby

require "cgi"

c = CGI.new

f = open("access.txt", "a")
f.write(Time.new)
f.write(": ")
f.write(c.remote_addr)
f.write(", ")
f.write(c.remote_host)
f.write("\n")

print "Content-Type: text/plain\n\n"
print "OK"
