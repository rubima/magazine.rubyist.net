filename = ARGV[0]
image_dir = File.basename(filename, ".md").split("-", 4)[3]

lines = File.readlines(filename)

fix_attach_view = lines.map { |line|
  line.gsub(/\{\{attach_anchor\('?([^']+)'?\)\}\}/) { '[' + $1 + ']({{site.baseurl}}/images/' + image_dir + '/' + $1 + ')' }
}

File.open(filename, "w") { |f| f.write(fix_attach_view.join) }

