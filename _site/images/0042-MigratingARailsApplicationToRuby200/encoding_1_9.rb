# Ruby 1.9 に対するモンキーパッチ
class String
  def b
    dup.force_encoding('BINARY')
  end

  def to_utf8_from_win31j
    encode_to_utf8('Windows-31J')
  end

  def to_win31j_from_utf8
    encode_from_utf8('Windows-31J')
  end

  def to_utf8_from_cp50221
    encode_to_utf8('CP50221')
  end

  def to_cp50221_from_utf8
    encode_from_utf8('CP50221')
  end

  def encode_to_utf8(from_encoding)
    encode('UTF-8', from_encoding, :invalid => :replace, :undef => :replace, :replace => '')
  end

  def encode_from_utf8(to_encoding)
    encode(to_encoding, 'UTF-8', :invalid => :replace, :undef => :replace, :replace => '')
  end
end
