require 'win32ole'

module Worksheet
  def [] y,x
    self.Cells.Item(y,x).Value
  end

  def getTitle(y,x,titles)
    while y > 0
      v = self[y,x]
      if titles.include?(v)
        return v
      end
      y -= 1
    end
    return nil
  end
end

def getAbsolutePath filename
  fso = WIN32OLE.new('Scripting.FileSystemObject')
  return fso.GetAbsolutePathName(filename)
end

def openExcelWorkbook filename
  filename = getAbsolutePath(filename)

  xl = WIN32OLE.new('Excel.Application')
  book = xl.Workbooks.Open(filename)
  begin
    yield book
  ensure
    xl.Workbooks.Close
    xl.Quit
  end
end

openExcelWorkbook("sample1.xls") do |book|
  sheet = book.Worksheets.Item("Sheet1")
  sheet.extend Worksheet
  
  recordset = []
  
  titles = ["発生日","名称","マグニチュード","死者･不明者","死者の有無"]
  2.upto(5) do |y|
    record = {}
    1.upto(5) do |x|
      v = sheet[y,x]
      title = sheet.getTitle(y,x,titles)
      record[title] = v     if title
    end
    recordset << record
  end

  recordset.each do |record|
    puts record.map{|title,value| 
      "#{title}=#{value}"
    }.join(",")
  end
end
