class MyEruby7
  def self.desc; "interpolation"; end

  ## ファイルを読み込んでRubyプログラムに変換する
  def convert_file(filename)
    return convert(File.read(filename))
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
    s << "_buf << %Q`#{str}`; " unless str.empty?
    s << "_buf\n"
    return s
  end

end
