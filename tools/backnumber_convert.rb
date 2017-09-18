filename = ARGV[0]

lines = File.readlines(filename)

fix_backnumber = lines.map { |line|
  line.gsub(/\{\{backnumber\('(.+)'\)\}\}/) {
    tag_name = $1
    insert_contents = []
    insert_contents << "{% for post in site.tags.#{tag_name} %}\n"
    insert_contents << "  - [{{ post.title }}]({{ post.url }})\n{% endfor %}\n"
    insert_contents.join
  }
}

File.open(filename, "w") { |f| f.write(fix_backnumber.join) }


