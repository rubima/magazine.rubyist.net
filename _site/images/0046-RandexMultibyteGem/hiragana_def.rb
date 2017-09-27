def self.hiragana(options = {})
  length = options[:length] || 1
  length.of { ('ぁ'..'ん').to_a.pick }.join # invalid multibyte char (US-ASCII) 
end

