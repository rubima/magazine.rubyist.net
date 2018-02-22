require 'net/http'

Net::HTTP.version_1_2

req = Net::HTTP::Get.new("/~gotoken/uu200410/basic/")
req.basic_auth "basic","basic"
Net::HTTP.start('www.notwork.org', 80) {|http|
  response = http.request(req)
  puts response.body
}
