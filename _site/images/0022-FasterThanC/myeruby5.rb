class MyEruby5
  def self.desc; "inline method"; end

  ## ファイルを読み込んでRubyプログラムに変換する
  def convert_file(filename)
    return convert(File.read(filename))
  end

  ## Rubyプログラムに変換する
  def convert(input)
    s = '_buf = ""; '
    pos = 0
    input.scan(/<%(=)?(.*?)%>/m) do
      equal, code = $1, $2
      match = Regexp.last_match
      len   = match.begin(0) - pos
      text  = input[pos, len]
      pos   = match.end(0)
      text.gsub!(/['\\]/, '\\\\\&')        # テキスト
      s << "_buf << '#{text}'; " unless text.empty?
      if equal
        s << "_buf << (#{code}).to_s; "    # 埋め込み式
      else
        s << "#{code}; "                   # 埋め込み文
      end
    end
    text = $' || input                     # 残りのテキスト
    text.gsub!(/['\\]/, '\\\\\&')
    s << "_buf << '#{text}'; " unless text.empty?
    s << "_buf\n"
    return s
  end

end
