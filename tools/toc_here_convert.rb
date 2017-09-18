filename = ARGV[0]

lines = File.readlines(filename)

fix_toc_here = lines.map { |line|
  line.sub(/\{\{toc_here\}\}/) { "* Table of content\n{:toc}\n" }
}

File.open(filename, "w") { |f| f.write(fix_toc_here.join) }

