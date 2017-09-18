require 'win32ole'

def getAbsolutePath filename
  fso = WIN32OLE.new('Scripting.FileSystemObject')
  return fso.GetAbsolutePathName(filename)
end
filename = getAbsolutePath("sample1.xls")

xl = WIN32OLE.new('Excel.Application')

book = xl.Workbooks.Open(filename)
begin
  book.Worksheets.each do |sheet|
    sheet.UsedRange.Rows.each do |row|
      record = []
      row.Columns.each do |cell|
        record << cell.Value
      end
      puts record.join(",")
    end
  end
ensure
  book.Close
  xl.Quit
end
