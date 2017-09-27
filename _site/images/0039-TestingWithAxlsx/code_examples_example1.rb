require 'axlsx'

package = Axlsx::Package.new

worksheet = package.workbook.add_worksheet(name: 'Example')
worksheet.add_row(['Hello', 'World'])

package.serialize('example.xlsx')
