require 'win32ole'

def getEachItem foldername
  ol = WIN32OLE::connect("Outlook.Application")
  myNameSpace = ol.getNameSpace("MAPI")
  folder = myNameSpace.GetDefaultFolder(6)
  folder2 = folder.Folders.Item(foldername)
  folder2.Items.each do |mail|
    GC.start
    yield mail
  end
end


getEachItem("ruby") do |mail|
  puts mail.Subject
end
