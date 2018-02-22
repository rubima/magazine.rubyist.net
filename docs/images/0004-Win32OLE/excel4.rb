require 'win32ole'

module Border
  def linetype
    @@linestyles ||= nil
    if @@linestyles.nil?
      @@linestyles = {}
      %w(XlContinuous XlDash XlDashDot 
         XlDashDotDot XlDot XlDouble 
         XlLineStyleNone XlSlantDashDot).each do |linestyle|
        v = Border.const_get(linestyle)
        @@linestyles[v] = linestyle
      end
    end
    return @@linestyles.fetch(self.LineStyle) {|key| key}
  end

  def lineweight
    @@lineweights ||= nil
    if @@lineweights.nil?
      @@linewights = {}
      %w(XlHairline XlMedium
         XlThick XlThin).each do |weight|
        v = Border.const_get(weight)
        @@linewights[v] = weight
      end
    end
    return @@linewights.fetch(self.Weight) {|key| key }
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
  cell = sheet.Range("B2")

  borders = cell.Borders 
  WIN32OLE.const_load(borders,Border)
  
  [["è„" , Border::XlEdgeTop],
   ["âE" , Border::XlEdgeRight],
   ["â∫" , Border::XlEdgeBottom],
   ["ç∂" , Border::XlEdgeLeft],
  ].each do |direction,index|
    border = borders.Item(index)
    border.extend Border
    puts "#{direction} #{border.linetype} #{border.lineweight}"
  end
end
