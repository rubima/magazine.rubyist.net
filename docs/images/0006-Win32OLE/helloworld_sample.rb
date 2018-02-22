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
pt1.LeftDirection, pt1.RightDirection = [pt1.Anchor]*2
pt2.LeftDirection, pt2.RightDirection = [pt2.Anchor]*2

text = doc.TextArtItems.Add
text.Position = [200, 500]
text.Contents = 'Hello,World!'
text.TextRange.Size = 32

# 「Hello, World !」サンプルの四角と対角線をグループ化
grp = doc.GroupItems.Add
rect.MoveToBeginning(grp)
path.MoveToBeginning(grp)

# グループを回転、反転
grp.Rotate(90)
grp.Resize(-100, 100)

# カラーの変更
cmyk_m = WIN32OLE.new('Illustrator.CMYKColor')
cmyk_m.Cyan, cmyk_m.Magenta, cmyk_m.Yellow, cmyk_m.Black = 0,100,0,0  # マゼンタ
path.StrokeColor.CMYK = cmyk_m

# 文字色やフォントを変えます。
cmyk_c = WIN32OLE.new('Illustrator.CMYKColor')
cmyk_c.Cyan, cmyk_c.Magenta, cmyk_c.Yellow, cmyk_c.Black = 100,0,0,0  # シアン

hello = text.TextRange(1,5)       # Hello のところ
hello.FillColor.CMYK = cmyk_c     # 色をつける

world = text.TextRange(7,11)      # World のところ
world.Font = 'MS-PMincho'         # フォントを変える

# アクション用の Selection に備えてグループを解除
grp.PageItems.Count.downto(1) do |key| # 逆順
  grp.PageItems.item(key).MoveToBeginning(doc)
end

# myActions は 私製アクション集です
# ないときはこの一節はコメントアウトしてください
doc.Selection = []                     # 全選択解除
path.Selected = true                   # 対角線の選択
illu.DoScript('myDoubleArrow','myActions')
sleep 0.23 while illu.ActionIsRunning  # 0.23に深い意味はない
doc.Selection = []                     # 選択の解除

require 'vr/vruby'
frm = VRLocalScreen.newform
name = 'helloworld_sample.png'
yesno = frm.messageBox("ファイル '#{name}'\n に保存します。", 'Hello, World!', 4 + 32 + 0x40000)
if yesno == 6 then
  png8export = WIN32OLE.new('Illustrator.ExportOptionsPNG8')
  fname = File.join(Dir.pwd, name)
  doc.Export(fname, Illu::AiPNG8, png8export)
end

wsh = WIN32OLE.new('WScript.Shell')
name = 'helloworld_sample.pdf'
yesno = wsh.Popup("PDFファイル '#{name}'\n に保存します。", 0, 'Hello, World!', 4 + 32 + 0x40000)
if yesno == 6 then
  pdfsave = WIN32OLE.new('Illustrator.PDFSaveOptions')
  fname = File.join(Dir.pwd, name)
  fname.gsub!(File::SEPARATOR, File::ALT_SEPARATOR) if File::ALT_SEPARATOR
  doc.SaveAs(fname, pdfsave)
end

illu.DoJavaScript('alert("おしまい");')
doc.Close(Illu::AiDoNotSaveChanges)
