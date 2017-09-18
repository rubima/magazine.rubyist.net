filename = ARGV[0]

lines = File.readlines(filename)

fix_line = lines.map { |line|
  line.gsub(/\Ahttps*:\/\/.+\/(.+)\.(jpg|JPG)/) {
    "![#{$1}](#{$&})"
  }
}

File.open(filename, "w") { |f| f.write(fix_line.join) }
