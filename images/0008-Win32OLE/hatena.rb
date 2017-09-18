require 'win32ole'
include WIN32OLE::VARIANT

ie = WIN32OLE.new("InternetExplorer.Application")
ie.Visible = true

url = "https://www.hatena.ne.jp/sslregister"
def ie.navigate_post url,query_string
  header = "Content-type: application/x-www-form-urlencoded"
  postdata = query_string.unpack("c*")
  navi = self.ole_method("Navigate2")
  ret = self._invoke(navi.dispid, [url, nil, nil, postdata, header], [VT_BYREF|VT_VARIANT, VT_BYREF|VT_VARIANT, VT_BYREF|VT_VARIANT, VT_ARRAY|VT_UI1, VT_BYREF|VT_VARIANT])
  @lastargs = WIN32OLE::ARGV
  ret
end

query_string = "mode=login&backurl=http%3a%2f%2fwww%2ehatena%2ene%2ejp%2f&key=myname&password=mypassword"
ie.navigate_post url,query_string
