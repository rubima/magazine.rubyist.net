require 'win32ole'
require 'Win32API'

class Clipboard
  OpenClipboard = Win32API.new('user32', 'OpenClipboard', ['I'], 'I');
  CloseClipboard = Win32API.new('user32', 'CloseClipboard', [], 'I');
  EmptyClipboard = Win32API.new('user32', 'EmptyClipboard', [], 'I');
  IsClipboardFormatAvailable = Win32API.new('user32', 'IsClipboardFormatAvailable', ['I'], 'I');

  GetClipboardData = Win32API.new('user32', 'GetClipboardData', ['I'], 'I');

  GlobalLock = Win32API.new('kernel32', 'GlobalLock', ['I'], 'P');
  GlobalUnlock = Win32API.new('kernel32', 'GlobalUnlock', ['I'], 'I');
  
  CF_TEXT = 1;
  
  def self.GetText
    result = ""
    
    while OpenClipboard.Call(0) == 0
      sleep 1
    end
    begin
      if (h = GetClipboardData.Call(CF_TEXT)) != 0
        if (p = GlobalLock.Call(h)) != 0
          result = p;
          GlobalUnlock.Call(h);
        end
      end
    ensure
      CloseClipboard.Call
    end
    return result;
  end
end

url = "http://apollo.u-gakugei.ac.jp/~sunaoka/ajax/ajaxzip/"
wsh = WIN32OLE.new("Wscript.Shell")
wsh.Run("explorer.exe #{url}",1,true)
sleep 2
wsh.AppActivate("Ajax")
sleep 2
wsh.SendKeys("%D")
wsh.SendKeys("{TAB}{TAB}{TAB}1000001")
sleep 1
wsh.SendKeys("{TAB}^c")
puts Clipboard::GetText()
wsh.SendKeys("{TAB}^c")
puts Clipboard::GetText()
wsh.SendKeys("{TAB}^c")
puts Clipboard::GetText()
