require 'win32ole'

module Worksheet
  def [] y,x
    self.Cells.Item(y,x).Value
  end
end

def getAbsolutePath filename
  fso = WIN32OLE.new('Scripting.FileSystemObject')
  return fso.GetAbsolutePathName(filename)
end
filename = getAbsolutePath("sample1.xls")

xl = WIN32OLE.new('Excel.Application')

begin
  xl.Workbooks.Open(filename)
  sheet = xl.Worksheets.Item("Sheet1")
  sheet.extend Worksheet
  
  recordset = []
  2.upto(5) do |y|
    record = {}
    1.upto(5) do |x|
      v = sheet[y,x]
      title = sheet[1,x]
      record[title] = v
    end
    recordset << record
  end

  recordset.each do |record|
    puts record.map{|title,value| 
      "#{title}=#{value}"
    }.join(",")
  end
ensure
  xl.Workbooks.Close
  xl.Quit
end
