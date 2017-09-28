require 'win32ole'
illu = WIN32OLE.connect('Illustrator.Application')
module Illu; end
WIN32OLE::const_load(illu, Illu)

doc = illu.Documents.Add

rect = doc.PathItems.Rectangle(500+20,200-5, 192,36)
rect.Filled = false

path = doc.PathItems.Add
pt1, pt2 = path.PathPoints.Add, path.PathPoints.Add
pt1.Anchor, pt2.Anchor = [200-5,500+20], [200-5+192,500+20-36]
pt1.LeftDirection, pt1.RIghtDirection = [pt1.Anchor]*2
pt2.LeftDirection, pt2.RIghtDirection = [pt2.Anchor]*2

text = doc.TextArtItems.Add
text.Position = [200, 500]
text.Contents = 'Hello,World!'
text.TextRange.Size = 32

print 'PRESS ENTER to export as "helloworld8.png"'; gets
png8export = WIN32OLE.new('Illustrator.ExportOptionsPNG8')
fname = File.join(Dir.pwd, 'helloworld8.png')
doc.Export(fname, Illu::AiPNG8, png8export)

print 'PRESS ENTER to save as "helloworld.pdf"'; gets
pdfsave = WIN32OLE.new('Illustrator.PDFSaveOptions')
fname = File.join(Dir.pwd, 'helloworld.pdf')
fname.gsub!(File::SEPARATOR, File::ALT_SEPARATOR) if File::ALT_SEPARATOR
doc.SaveAs(fname, pdfsave)

doc.Close(Illu::AiDoNotSaveChanges)
