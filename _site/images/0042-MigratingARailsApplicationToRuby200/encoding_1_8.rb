# Ruby 1.8 に対するモンキーパッチ
class String
  alias b dup

  def force_encoding(encoding)
    self
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
    nkf_options = case from_encoding
                  when 'Windows-31J'
                    '-S'
                  when 'CP50221'
                    '-J'
                  else
                    raise 'invalid encoding'
                  end
    nkf_options += ' -w -m0 -x'
    NKF.nkf(nkf_options, self)
  end

  def encode_from_utf8(to_encoding)
    nkf_options = case from_encoding
                  when 'Windows-31J'
                    '-s'
                  when 'CP50221'
                    '-j'
                  else
                    raise 'invalid encoding'
                  end
    nkf_options += ' -W -m0 -x'
    NKF.nkf(nkf_options, self)
  end
end
