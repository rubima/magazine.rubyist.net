filename = ARGV[0]

lines = File.readlines(filename)

fix_val = lines.map { |line|
  line.gsub(/\{\{e\((.+?)\)\}\}/) { '&#' + $1 + ';' }
}

File.open(filename, "w") { |f| f.write(fix_val.join) }

