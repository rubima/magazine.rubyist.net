#! ruby -Ks
require 'win32ole'
require 'singleton'

class Outlook 
  include Singleton
  def initialize 
    @ol = WIN32OLE::connect("Outlook.Application")
    WIN32OLE.const_load(@ol,self.class)
  end

  def new_mail
    mail =  @ol.CreateItem(OlMailItem)
    mail.BodyFormat = OlFormatPlain
    return mail
  end
end

outlook = Outlook.instance
mail = outlook.new_mail
mail.To = 'rubima@cuzic.com'
mail.Subject = 'WIN32OLE test mail'
mail.Body = 'WIN32OLE を使って Outlook でメールを送信するテストです。'
mail.GetInspector.Activate
mail.Send
