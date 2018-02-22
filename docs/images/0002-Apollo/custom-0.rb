require 'phi'
require 'dialogs'
Phi.export 'Apollo'

fb = Apollo::FORM_BROWSER
fc = Apollo::FORM_CONSOLE
sc = Phi::SCREEN

fb.caption = 'Apollo - ' << Phi::VERSION
#fb.memo1.font.size += 3
fb.width = sc.width - fb.left*3 - fc.width
fb.height = sc.height - fb.top*3 - fc.height
