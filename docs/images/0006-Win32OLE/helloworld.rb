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

print 'PRESS ENTER'; gets

doc.Close(Illu::AiDoNotSaveChanges)
