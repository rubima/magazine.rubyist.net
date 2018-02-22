require 'win32ole'

def each_mail
  ol = WIN32OLE::connect("Outlook.Application")
  myNameSpace = ol.getNameSpace("MAPI")
  folder = myNameSpace.GetDefaultFolder(6)
  folder.Items.each do |mail|
    GC.start
    yield mail
  end
end

each_mail do |mail|
  puts mail.Subject
end
