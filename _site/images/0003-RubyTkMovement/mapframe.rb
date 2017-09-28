#!/usr/bin/env ruby

require 'tk'

#class MapFrame < TkWindow
class MapFrame < TkCanvas
  include TkComposite

  #########################################

  @@borderwidth = 0
  @@highlightthickness = 0

  @@labelfont = ['courier', 6]
  @@label_bg = '#101010'
  @@label_fg = 'white'

  @@imgwidth  = 50
  @@imgheight = 50

  @@grid_pad  = 1
  @@frame_bg_color  = 'gray'

  #########################################

  def button_callback(x, y)
    # please override this method
    puts "Button #{x}x#{y} is clicked!!"
  end

  #########################################

  def initialize_composite(width, height)
    @width  = width
    @height = height

    # create canvas
    @h_scroll = TkScrollbar.new(@frame)
    @v_scroll = TkScrollbar.new(@frame)

    @canvas = TkCanvas.new(@frame)
    @canvas.xscrollbar(@h_scroll)
    @canvas.yscrollbar(@v_scroll)

    @path = @canvas.path

    TkGrid.rowconfigure(@frame, 0, :weight=>1, :minsize=>0)
    TkGrid.columnconfigure(@frame, 0, :weight=>1, :minsize=>0)
    @canvas.grid(:row=>0, :column=>0, :sticky=>:news)
    @h_scroll.grid(:row=>1, :column=>0, :sticky=>:ew)
    @v_scroll.grid(:row=>0, :column=>1, :sticky=>:ns)

    # create a bindtag to scroll the canvas (events are generated on buttons)
    btag = TkBindTag.new
    btag.bind('3', proc{|x,y| 
		@canvas.scan_mark(x - @canvas.winfo_rootx, 
				  y - @canvas.winfo_rooty)
	      }, '%X %Y')
    btag.bind('B3-Motion', proc{|x,y| 
		@canvas.scan_dragto(x - @canvas.winfo_rootx, 
				  y - @canvas.winfo_rooty)
	      }, '%X %Y')

    @base = TkFrame.new(@canvas, :background=>@@frame_bg_color)

    # create buttons
    @buttons = Array.new(@width){|x|
      Array.new(@height){|y|
	TkLabel.new(@base, 
		    :image=>TkPhotoImage.new(:width=>@@imgwidth, 
					     :height=>@@imgheight), 
		    :borderwidth=>@@borderwidth, 
		    :highlightthickness=>@@highlightthickness){|b|
	  bindtags(bindtags.insert(1, btag)) # to scroll the canvas

	  @label = TkLabel.new(b, :text=>"#{x} x #{y}", :font=>@@labelfont, 
			       :background=>@@label_bg, 
			       :foreground=>@@label_fg, 
			       :padx=>1, :pady=>0){
	    place(:anchor=>:s, :rely=>1.0, :y=>-1, :relx=>0.5)
	  }
	  def self.label; @label; end

	  grid(:row=>y, :column=>x, 
	       :padx=>@@grid_pad, :pady=>@@grid_pad, :sticky=>:news)
	}.bind('ButtonRelease-1', proc{button_callback(x,y)})
      }
    }

    @base_win = TkcWindow.new(@canvas, 0, 0, :window=>@base, :anchor=>:nw)

    Tk.update_idletasks
    @canvas.scrollregion(@base_win.bbox)
  end

  def [](idx)
    @buttons[idx]
  end
end

map = MapFrame.new(nil, 20, 15).pack

map[4][2].background('red')
map[3][2].background('red')
map[3][3].background('red')
map[4][3].background('red')

p map[3][5].label.text

map[2][4].image[:data] = <<'EOI'
R0lGODlhMgAyAPf/AA8SARMVCxQZDRocAxsbCxQXBBYVEhQcFBgXFRobExobGhUeGx4fIRwg
BBwhCx0iEhwjHBwoFB0kIR8oJSUeBiAeCiocDCEeESAfGyEfICIjByMjDSYpDSokDSgrDiIj
EyMlGiQpFCUqGyomEyomGSoqFCssGy4xFSwxHCcwGzYgCzQjETIrEzEtGzgmEDotGTM0FjMz
HDU4HTo0HDo6HDk5FyEkIiMpJCUsKionICssIiotKyMkKS0uMiYxJSYwKS0yIy0yKi84Jyw0
MS84MjEuITM0IzM1KjU5JDQ6Kzk2Izg1KDo7JDs8KzI0MzQ1ODQ7MjU7Ozs8Mjw9Oj1BHT1B
JD1BKzxCMz5CPT9INzpDQkIpF0gyHUE8JEE9K0g2I0E+MVY4JVU7KUJCJUJDLEVJLUlBJklF
K0pLJUtLLUJIJkNEM0NEOUVJM0VJOklGM0hGOkpLM0tLOk9RKU1RNE1RO1RCLFBJLVJMM1JN
O1tFMVNGNVJTNVJTO1NYNFVZPFhUNllWOllcNlpbPFtgPWBBLWFEMmJLNWVNO2RQPGxRPnFS
PmBhPEtNQUVJRU1RQ05VSUdSQk9VUVJOQVNUQlRVSVVZQ1VaS1hVQ1lWSlpbRFtcSlZaUVpd
UlhXU11hRF1iSl5hUmFdQ2JeTGxVQ2laRGFfUnZbSXNXQmJjRGJkS2RqQ2VpS2liRmllSmlq
RmprTGNkUmVkWWZpUmZpWWhlUmhlXWprU2xsWmpwTG1xU25xWnVjTXhqT3pmTnJsUnBtWnlr
U3lqWX9mUnFyTnNzVHJ0W3R4VHV5W3lyVnlzW3p7VHt8XWhnZGtrYm5taW1xYnFtYXR0YnZ5
YXh1YXp7Y3t8aXd4anuBXX2BYn6Ban6AcIJsVoRxXYB+W4lyXYN9Y4F+aox3YpR9a4CDXYKD
ZIOEaoaJbI2CaoqLa4eKZYWEcYWIcYmFcYqLdIqRa46Rc5OCbJGMa5CPcJOMepuPdZSSbJOR
epSYdYeGgpmXgp2igqOdg6iZg6Oig7OhiSH5BAAAAAAALAAAAAAyADIAAAj+AC9BynIlSYQj
RxpRetMFECBYrVyJIkNGDhgCI2Iw2XQrTx9j7u6ZM1ZLFStd5bCVg/VH1yxNm+TIkVUpCYoU
ER4AoVVLDg1AePAAEgXoDaZNTQiMKGFEDqUmJvrculWrWrlag1Id05WqTBpVcarEqROr0yMh
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
NWa3UjFL46dKlTgxmGjS1ARFQAA7
EOI

img = TkPhotoImage.new(:data=><<'EOI')
R0lGODlhMgAyAPf/ABkXCxoZFxILDh4gHR0jJSQbGSATCiEfICMjHSokGDQuHy0sGSwrJCws
KyYlJSksMS0xKiwxMjIsIzItKjgqKDMtMTUyJDMzLDozLDo3JzMyMjo0Mjs6NDw7OjY5ODw8
QS89QD1BOTtCRUI4LEM8NEQ8OUU9QkRBLURCNURCO0pEO0tKPEdHN1NJPFhUO1NQL2VIOkND
QkVIQ0pEQktKRExLS0VHSkxMUU1SSEtUVVNLQ1FNSldFRlZNUVRRRFRSTFtVRVtUSlxaS1NS
UlRUWFpVUltaU1tbW1dXWF1dYV1gV15gSFhhZVxtdGNcTGJZR2JbVGJcW2dYWGxUTmFdY2dj
SGRiVGRiW2pjVGtkW2xqXGprVW5wXHNsW3FqVnpzW3ZyWnBsSWRkY2plYWtqY2xsa2dkaW1s
cW10dnNrY3VsaHNtc3RyZHNya3p0Ynt0a3x6ZH17a3Z5Z3Rzcnx6c3x7e3d3d2hzY318gWx5
gXyAa32BdHqDhH+SmYN4XYVqX4J8a4N6ZoN8coV8eZt4boZ/goSCbImEaoSDc4OCfIqEc4uE
eoyIdIyKe4aIeo6Qe5KLdJGLe5aFe5SRfZmTepCNbKKafYSDgoyKg4iHh4yLkYuUlpOMgpKM
iZaIg5WTgpSSi5uUgpuTipyYhJuaipaYgpSUkpuYlpCPlJecoZ+gk5qkp6Kbi6SZh6KdmqSb
k7KbjaySi6ehjKSim6qjk6qim62qm6ellbOqm7Opl7mym7OkjaSkoquro6uqqqmmpqyxqa6z
tbKrorWrqLGvsrOxpLSyq7uzo7u0qb25qLq6s7i3taqtsrm6wLzDuLrIyMaqmsS6qMG7s8e7
tsmxrMO/wMTCtcPDu8zEu8vGtdHKtdPMvNXEtNfSv87Eq+LKuc3LxMfGxc7QyMfT1dLLxNLJ
x9PN0tTSzdrUxtjX1s7P0d7c4s/e4dni29jn6dLn7eXZyePc2Pzf0ePe4eXl2vLk1Ojn5uvt
8O3x5uz3+fLu6ff06fz78/79/Pf09fDv9CH5BAAAAAAALAAAAAAyADIAAAj+AP316xfvX7oi
VxLxknHhR69wZJAcEWNHTLhTvjKZ8kWGw4wrQRoVQxTHihE6Ca6AI1duWJQCHGoUsRfv3LlO
ZRrQuTaLAwcydNrMGRLhSDobl5aZ8mevX69zK0iskLPCESIrgtL80IEJ05gJE0rsKEGmAA0j
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
Ggw/YjQgkEOECBsdaHRqBAdLQAA7
EOI

map[4][1].image.copy(img)
map[4][2].image.copy(img)
map[5][1].image.copy(img)
map[5][2].image.copy(img)

#################################

Tk.mainloop
