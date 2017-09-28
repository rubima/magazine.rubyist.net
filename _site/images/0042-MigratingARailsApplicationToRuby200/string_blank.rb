class String
  def blank?
    case encoding
    when Encoding::UTF_8
      /\A[\s\u{3000}]*\z/ === self
    when Encoding::US_ASCII, Encoding::ASCII_8BIT
      /\A\s*\z/ === self
    else
      begin
        self.encode('UTF-8').blank?
      rescue
        self.dup.force_encoding('BINARY').blank?
      end
    end
  end
end
