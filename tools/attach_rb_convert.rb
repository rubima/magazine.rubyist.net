filename = ARGV[0]
image_dir = File.basename(filename, ".md").split("-", 4)[3]

lines = File.readlines(filename)

fix_attach_view = lines.map { |line|
  line.gsub(/\{\{attach_rb ['"](.+)['"]\}\}/) {
    ruby_filename = $1
    insert_contents = []
    insert_contents << "```ruby\n"
    #insert_contents << File.readlines("images/" + image_dir + "/" + ruby_filename, encoding: "CP932:UTF-8")
    #insert_contents << File.readlines("images/" + image_dir + "/" + ruby_filename, encoding: "EUC-JP:UTF-8")
    insert_contents << File.readlines("images/" + image_dir + "/" + ruby_filename)
    insert_contents << "```\n"
    insert_contents.flatten.join.gsub(/\r\n/, "\n")
  }
}

File.open(filename, "w") { |f| f.write(fix_attach_view.join) }
