require 'win32ole'

ie = WIN32OLE.new("InternetExplorer.Application")
ie.Navigate "http://apollo.u-gakugei.ac.jp/~sunaoka/ajax/ajaxzip/"

ie.Visible = true

while ie.Busy == true
  sleep 1
end

zip = ie.Document.getElementByID("zip")
zip.Value = "1000001"
zip.FireEvent("onkeyup")

sleep 1
%w(pref city ville).each do |name|
  puts "#{name} #{ie.Document.getElementByID(name).Value}"
end
