filename = ARGV[0]
lines = File.readlines(filename)

fix_footnote = lines.map { |line|
  line.gsub(/\[\[ruby-dev:(\d+)\]\]/) { '[ruby-dev:' + $1 + '](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/' + $1 + ')' }.
    gsub(/\[\[ruby-core:(\d+)\]\]/) { '[ruby-core:' + $1 + '](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/' + $1 + ')' }.
    gsub(/\[\[ruby-talk:(\d+)\]\]/) { '[ruby-talk:' + $1 + '](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/' + $1 + ')' }.
    gsub(/RubyNoKai:([^\)]+)/) { 'http://jp.rubyist.net/?' + $1 }.
    gsub(/Wikipedia-en:([^\)]+)/) { 'http://en.wikipedia.org/wiki/' + $1 }.
    gsub(/W3C:([^\)]+)/) { 'http://www.w3.org/TR/' + $1 }.
    gsub(/RFC:([^\)]+)/) { 'http://www.ietf.org/rfc/rfc' + $1 }
}

File.open(filename, "w") { |f| f.write(fix_footnote.join) }

