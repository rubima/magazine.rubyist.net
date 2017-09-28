import win32com.client
from win32com.server import util
import pythoncom

class WebBrowserEvent:
    def OnDownloadComplete(self,*args,**kwds):
        print "Download Complete"
    def OnQuit(self,*args,**kwds):
        exit

def com_collection_iter(collection):
    return (collection.Item(index)
            for index in range(1, collection.Count+1))

#ie = win32com.client.Dispatch("InternetExplorer.Application")
ie = win32com.client.DispatchWithEvents("InternetExplorer.Application",WebBrowserEvent)
ie.Visible = True
ie.GoHome()
while ie.ReadyState != win32com.client.constants.READYSTATE_COMPLETE:
    pass

ie.Navigate('http://www.ruby-lang.org/')

while ie.ReadyState != win32com.client.constants.READYSTATE_COMPLETE:
    pass

count = 0
for element in ie.Document.all:
    count += 1
print "complete\n %d elements found\n" % (count)
