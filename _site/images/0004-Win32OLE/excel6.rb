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

  def []= y,x,value
    cell = self.Cells.Item(y,x)
    if cell.MergeCells
      cell.MergeArea.Item(1,1).Value = value
    else
      cell.Value = value
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
  xl.Visible = true
  book = xl.Workbooks.Open(filename)
  begin
    yield book
  ensure
    xl.Workbooks.Close
    xl.Quit
  end
end

openExcelWorkbook("sample2.xls") do |book|
  sheet = book.Worksheets.Item(2)
  sheet.extend Worksheet

  sheet[2,2] = "Ruby"
  sheet[2,3] = "Python"
  sheet[2,4] = "Perl"
  book.Save
end

