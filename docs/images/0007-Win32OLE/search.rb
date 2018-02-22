#! ruby -Ks

require 'win32ole'
require 'singleton'

class Outlook 
  include Singleton
  def initialize 
    @ol = WIN32OLE::connect("Outlook.Application")
  end

  def each_mail_filtered folder,subject
    events = WIN32OLE_EVENT.new(@ol,"ApplicationEvents_11")
    search_done = false
    events.on_event("AdvancedSearchComplete") do |search|
      results = search.Results
      count = results.Count
      break if count == 0
      1.upto(count) do |i|
        yield results.Item(i)
      end
      search_done = true
    end

    if subject !~ /\%/ then
      @ol.AdvancedSearch(folder,"urn:schemas:mailheader:subject = '#{subject}'")
    else
      @ol.AdvancedSearch(folder,"urn:schemas:mailheader:subject LIKE '#{subject}'")
    end
    WIN32OLE_EVENT.message_loop until search_done
  end
end


outlook = Outlook.instance

str = "%“ü‰ïŠó–]%"
outlook.each_mail_filtered("Inbox",str) do |mail|
  mail.GetInspector.Activate
end
