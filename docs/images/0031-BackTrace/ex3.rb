def debug_puts(message)
  caller()[0] =~ /(.*?):(\d+)/   # ŒÄ‚Ño‚µŒ³‚ğ’²‚×‚é
  filename, linenum = $1, $2
  $stderr.puts "[DEBUG] #{filename}:#{linenum}"
  $stderr.puts "[DEBUG] #{message}"
end

x = "foo"
debug_puts "x=#{x.inspect}"
x = "bar"
debug_puts "x=#{x.inspect}"