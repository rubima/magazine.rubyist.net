require 'net/http'

Net::HTTP.version_1_2

Net::HTTP.start('search.hatena.ne.jp', 80) {|http|
  response = http.post('/questsearch',"word=ruby")
  puts response.body
}

