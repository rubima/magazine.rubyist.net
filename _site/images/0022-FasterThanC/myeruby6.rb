class MyEruby6
  def self.desc; "array buffer"; end

  ## ファイルを読み込んでRubyプログラムに変換する
  def convert_file(filename)
    return convert(File.read(filename))
  end

  ## Rubyプログラムに変換する
  def convert(input)
    s = '_buf = []; '
    pos = 0
    args = []
    input.scan(/<%(=)?(.*?)%>/m) do
      equal, code = $1, $2
      match = Regexp.last_match
      len   = match.begin(0) - pos
      text  = input[pos, len]
      pos   = match.end(0)
      text.gsub!(/['\\]/, '\\\\\&')          # テキスト
      args << "'#{text}'"
      if equal
        args << code                         # 埋め込み式
      else
	s << "_buf.push(#{args.join(', ')}); " unless args.empty?
	args = []
        s << code << "; "                    # 埋め込み文
      end
    end
    text = $' || input                       # 残りのテキスト
    text.gsub!(/['\\]/, '\\\\\&')
    args << "'#{text}'"
    s << "_buf.push(#{args.join(', ')}); " unless args.empty?
    s << "_buf.join\n"
    return s
  end

end
