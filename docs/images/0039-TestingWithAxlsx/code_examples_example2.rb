package.workbook.styles do |style|
  black = style.add_style(:bg_color => '000000', :fg_color => 'FFFFFF', :sz => 14, :alignment => { :horizontal=> :center })
  worksheet.add_row(['Hello', 'World'], style: black)
end
