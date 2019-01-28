class Checker
  attr_reader :fname, :fdata, :errors

  def initialize(fname)
    @fname = fname
    @fdata = IO.readlines(@fname)
    @errors = []
  end
  
  def check
    check_filename
  end

  def check_filename
    if File.basename(fname) !~ /\d{4}-\d{2}-\d{2}-(\d{4}-)?.+\.md/
      @errors << "#{fname}のファイル名が規則違反です。「YYYY-mm-dd-号数-記事名.md」の名前にしてください。"
    end
  end
end

have_error = false

Dir.glob("articles/**/_posts/*.md") do |fname|
  c = Checker.new(fname)
  c.check
  unless c.errors.empty?
    have_error = true

    c.errors.each do |error|
      puts error
    end
  end
end

if have_error
  exit(1)
else
  exit(0)
end
