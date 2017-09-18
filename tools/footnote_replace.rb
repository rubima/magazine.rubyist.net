filename = ARGV[0]
lines = File.readlines(filename)

fix_footnote = lines.map { |line|
  line.sub(/<div =class'footnotes'><ol>/, '').
  gsub(/<a href=.+?>←<\/a><\/p><\/li>/, "\n").
  sub(/<\/ol><\/div>/, '').
  gsub(/<li id='fn(.+?)'><p>/) { '[^' + $1 + ']: '}.
  gsub(/<sup id='fnref(.+?)'>.+<\/sup>/) { '[^' + $1 + ']' }
}

File.open(filename, "w") { |f| f.write(fix_footnote.join) }
