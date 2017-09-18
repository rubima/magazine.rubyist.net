var ie = WScript.CreateObject("InternetExplorer.Application","ie_");

ie.Visible = 1;
ie.GoHome();
while (ie.ReadyState != 4) {
  WScript.Sleep(1000);
}

ie.Document.onclick = function (){
  WScript.Echo("click!!");
};


ie.Navigate('http://www.ruby-lang.org/');
while (ie.ReadyState != 4) {
  WScript.Sleep(1000);
}

var element,count=0;
for(element in ie.Document.all){
  count += 1
}

WScript.Echo("complete\n" + count + " elements found\n");

function ie_DownloadComplete() {
  WScript.Echo("Download Complete");
}

