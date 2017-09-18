Sub ie_DownloadComplete()
     WScript.Echo "Download Complete"
End Sub

Dim ie
Set ie = WScript.CreateObject("InternetExplorer.Application","ie_")

ie.Visible = True
ie.GoHome()
While ie.ReadyState <> 4
  WScript.Sleep(1000)
Wend

ie.Navigate("http://www.ruby-lang.org/")
While ie.ReadyState <> 4
  WScript.Sleep(1000)
Wend

Dim element
Dim count
count = 0
For Each element In ie.Document.all
  count = count + 1
Next

WScript.Echo("complete" & vbCrLf & count & "elements found")
