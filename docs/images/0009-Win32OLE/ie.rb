require 'win32ole'

module InternetExplorer
end

ie = WIN32OLE.new('InternetExplorer.Application')
WIN32OLE.const_load(ie,InternetExplorer)

event = WIN32OLE_EVENT.new(ie,"DWebBrowserEvents2")
event.on_event("DownloadComplete") do 
  puts "Download Complete."
end

ie.Visible = true

ie.GoHome
while ie.ReadyState != InternetExplorer::READYSTATE_COMPLETE
  WIN32OLE_EVENT.message_loop
end

ie.Navigate 'http://www.ruby-lang.org/'
while ie.ReadyState != InternetExplorer::READYSTATE_COMPLETE
  WIN32OLE_EVENT.message_loop
end

count = 0
ie.Document.all.each do 
  count += 1
end
puts "complete\n#{count} elements found"
