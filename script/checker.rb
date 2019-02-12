class Checker
  attr_reader :fname, :fdata, :errors

  def initialize(fname)
    @fname = fname
    @fdata = IO.readlines(@fname)
    @errors = []
  end
  
  def check
    check_filename
    check_header
  end

  # ファイル名のチェックを行う
  # YYYY-mm-dd-号数-記事名.mdの形式であることを期待している。しかしながら
  # 号外などは号数がないケースがあるので、号数のチェックは厳密にはしていない。
  def check_filename
    if File.basename(fname) !~ /\d{4}-\d{2}-\d{2}-(\d{4}-)?.+\.md/
      @errors << "#{fname}のファイル名が規則違反です。「YYYY-mm-dd-号数-記事名.md」の名前にしてください。"
    end
  end

  # 59号以降の通常号に於いて、post_authorなどの新しいHeaderがあることをチェックする
  def check_header
    # 過去記事はpost_authorとかcreated_onとかのヘッダのチェックはしない
    if check_new_header
      unless fdata.any? { |line| line =~ /^post_author:/ }
        @errors << "#{fname}のヘッダに「post_author:」が存在しません。追加してください。"
      end
    end
  end

  # 新しいHeader（post_authorとかcreated_onとか）を適用し始めたか否かをチェック
  def check_new_header
    case fname
    when /\d{4}-\d{2}-\d{2}-\d{4}-index\.md/
      # indexページはすべての号でpost_authorなどの新しいHeaderを求めない
      false
    when /\d{4}-\d{2}-\d{2}-\d{4}-EditorsNote\.md/
      # 編集後記はすべての号でpost_authorなどの新しいHeaderを求めない
      false
    when /\d{4}-\d{2}-\d{2}-0059.+\.md/
      # 新しいHeaderを求めるのは59号から
      true
    when /\d{4}-\d{2}-\d{2}-00[6-9]\d.+\.md/
      # 60号以降も新しいHeaderを求める
      true
    else
      # 59号より前の過去記事や各種特別号は新しいHeaderを求めない
      false
    end
  end
end

if $0 == __FILE__
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
end
