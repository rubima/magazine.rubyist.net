class MyEruby3
  def self.desc; "pattern matching"; end

  ## ファイルを読み込んでRubyプログラムに変換する
  def convert_file(filename)
    return convert(File.read(filename))
  end

  ## Rubyプログラムに変換する
  def convert(input)
    s = '_buf = ""; '
    input.scan(/(.*?)<%(=?)(.*?)%>/m) do
      text, equal, code = $1, $2, $3
      s << _convert_str(text, :text) unless text.empty?  # テキスト
      if equal == '='
        s << _convert_str(code, :expr)  # 埋め込み式
      else
        s << _convert_str(code, :stmt)  # 埋め込み文
      end
    end
    text = $' || input                  # 残りのテキスト
    s << _convert_str(text, :text) unless text.empty?
    s << "_buf\n"
    return s
  end

  private

  ## テキストまたは埋め込み式や文を変換する
  def _convert_str(text, kind)
    case kind
    when :stmt ;  ret = text;  ret << "; " if ret[-1] != ?\n
    when :expr ;  ret = "_buf << (#{text}).to_s; "
    when :text ;  text.gsub!(/['\\]/, '\\\\\&')
                  ret = "_buf << '#{text}'; "
    else       ;  raise "*** error: kind=#{kind.inspect}"
    end
    return ret
  end

end
