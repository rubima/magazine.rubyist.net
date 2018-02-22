class MyEruby8
  def self.desc; "file caching"; end

  ## ファイルを読み込んでRubyプログラムに変換する
  def convert_file(filename, cache_filename=nil)
    cache_filename ||= filename + '.cache'
    if File.file?(cache_filename) && \
       File.mtime(filename) <= File.mtime(cache_filename)
      prog = File.read(cache_filename)
    else
      prog = convert(File.read(filename))
      File.open(cache_filename, 'w') do |f|
        f.flock(File::LOCK_EX)
        f.write(prog)
      end
    end
    return prog
  end

  ## Rubyプログラムに変換する
  def convert(input)
    s = '_buf = ""; '
    pos = 0
    str = ''
    input.scan(/<%(=)?(.*?)%>/m) do
      equal, code = $1, $2
      match = Regexp.last_match
      len   = match.begin(0) - pos
      text  = input[pos, len]
      pos   = match.end(0)
      text.gsub!(/[`\\]/, '\\\\\&')             # テキスト
      str << text
      if equal
        str << "\#{" << code << "}"             # 埋め込み式
      else
        s << "_buf << %Q`#{str}`; " unless str.empty?
        str = ''
        s << "#{code}; "                        # 埋め込み文
      end
    end
    text = $' || input                          # 残りのテキスト
    text.gsub!(/[`\\]/, '\\\\\&')
    str << text
    s << "_buf << %Q`#{str}`; " unless text.empty?
    s << "_buf\n"
    return s
  end

end
