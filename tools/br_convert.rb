filename = ARGV[0]

lines = File.readlines(filename)

fix_val = lines.map { |line|
  line.gsub(/\{\{br\}\}/, "\n")
}

File.open(filename, "w") { |f| f.write(fix_val.join) }

