require 'win32ole'

module Worksheet
  def [] y,x
    cell = self.Cells.Item(y,x)
    if cell.MergeCells
      cell.MergeArea.Item(1,1).Value
    else
      cell.Value
    end
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

openExcelWorkbook("sample2.xls") do |book|
  sheet = book.Worksheets.Item("Sheet1")
  sheet.extend Worksheet
  puts sheet[7,2]
  puts sheet[7,3]
end
