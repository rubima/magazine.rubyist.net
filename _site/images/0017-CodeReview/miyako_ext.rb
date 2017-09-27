# Miyako拡張クラス
=begin
Miyako Extention Library v0.6
Copyright (C) 2006  Cyross Makoto

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
=end

module Miyako

class RasterScroll < Effect
  def initialize(sspr, dspr = nil)
    super
    @lines = 0
    @h = @src.h
    @size = 0
    @angle = 0
    @sangle = 0
    @dangle = 0
    @fade_out = false
    @fo_size = 0
  end
    
  def start(w, *param)
    super
    @lines = @param[0]
    @size = @param[1]
    @sangle = @param[2]
    @dangle = @param[3]
    @h = @h / @lines
    @fade_out = false
    @fo_size = 0
  end
  
  def update(screen)
    @angle = @sangle
    @h.times{|y|
      rsx = @size * Math.sin(@angle)
      SDL.blitSurface(@src.bitmap, @src.ox, @src.oy + y * @lines, @src.ow, @lines, screen, @src.x + rsx, @src.y + y * @lines)
      @angle = @angle + @dangle
    }
    if @cnt == 0
      if @fade_out
        @fo_cnt -= 1
        return if @fo_cnt != 0
        @size = @size - @fo_size
        @fo_cnt = @fo_wait
        @effecting = false if @size <= 0
      end
      @sangle = (@sangle + 1) % 360
      @cnt = @wait
    else
      @cnt = @cnt - 1
    end
  end
  
  def fade_out(fs, fw)
    @fo_size = fs
    @fo_wait = fw
    @fo_cnt = @fo_wait
    @fade_out = true
  end
end

class Comps # コンポーネント管理クラス
  @@common_comps = Hash.new

  def Comps.[](name)
    if @@common_comps.has_key?(name) == false
      throw MiyakoError.new("Not Registered Common Component name! : #{name}")
    end
    @@common_comps[name]
  end

  def Comps.[]=(name, value)
    @@common_comps[name] = value
  end

   def Comps.delete(name)
    return if @@common_comps.has_key?(name) == false
    @@common_comps.delete(name)
  end

  def Comps.reset
    @@common_comps = Hash.new
  end

  def Comps.listup
    l = "<<Common Component>>\n"
    l += @@common_comps.keys.sort.map{|k| k.to_s + " / " + @@common_comps[k].class.to_s}.join("\n")
    return l
  end

  def initialize
    @local_comps = Hash.new
  end

  def [](name)
    if @local_comps.has_key?(name)
      return @local_comps[name]
    end
    if @@common_comps.has_key?(name)
      return @@common_comps[name]
    end
    throw MiyakoError.new("Not Registered Common and Local Component name! : #{name}")
  end

  def []=(name, value)
    @local_comps[name] = value
  end

  def delete(name)
    return if @local_comps.has_key?(name) == false
    @local_comps.delete(name)
  end

  def reset
    @local_comps = Hash.new
  end

  def listup
    l = Comps.listup + "<<Local Component : #{name}>>\n"
    l += @local_comps.keys.sort.map{|k| k.to_s + " / " + @local_comps[k].class.to_s}.join("\n")
    return l
  end
end

class Slides # スライド集
  @@names = Array.new
  @@name_to_slides = Hash.new

  def init(name)
    @titles = Array.new
    @manager = Hash.new
    @@names.push(name)
    @@name_to_slides[name] = self
  end

  def initialize(name)
    init(name)
  end

  def [](title)
    return @manager[title] if title.kind_of?(String)
  end

  def add(title, slide)
    if title.kind_of?(String) && slide.kind_of?(Slide)
      @manager[title] = slide
      @titles.push(title)
    end
  end

  def delete(title)
    if title.kind_of?(String)
      @manager.delete(title)
      @titles.remove(title)
    end
  end

  def pickup(slides)
    self.hide
    self.show(slides)
  end

  def show(p = 0)
    if p.kind_of?(Integer)
      return if @titles.length == 0 || p >= @titles.length
      @manager[@titles[p]].show
    elsif p.kind_of?(String)
      return unless @manager.has_key?(p)
      @manager.keys.each{|k| @manager[k].hide }
      @manager[p].show
    elsif p.kind_of?(Array)
      p = p.collect{|s| @manager.has_key?(s) }
      return if p == []
      @manager.keys.each{|k| @manager[k].hide }
      p.each{|s| show(s)}
    end
  end

  def hide(slides = nil)
    if slides == nil
      @manager.keys.each{|k| @manager[k].hide }
    elsif slides.kind_of?(String)
      @manager[slides].hide
    elsif slides.kind_of?(Array)
      slides.each{|s| @manager[s].hide if s.kind_of?(String) }
    end
  end

  def get_name_list
    return @titles
  end

  def dispose
    @manager.clear
    @titles.clear
  end

  def Slides.get_name_list
    return @@names
  end

  def Slides.get_slides(p)
    if p.kind_of?(String)
      return @@name_to_slides[p] if @@name_to_slides.key?(p)
    elsif p.kind_of?(Integer)
      return @@name_to_slides[@@names[p]] if p < @@names.length
    end
  end
end

class Slide # スライド
  extend Forwardable

  def init(w, h, dp, c, a)
    @slide = Sprite.new([w, h], nil)
    @dp    = dp
    @color = c
    @alpha = a
    @comps = Hash.new
    @titles = Array.new
    
    @slide.bitmap.fill_rect(0, 0, w, h, @color)
    @slide.dp = @dp
    @slide.alpha = @alpha
  end

  def initialize(w, h, dp=-1, c=[255,255,255], a=255)
    init(w, h, dp, c, a)
  end

  def add(title, sprite)
    return unless title.kind_of?(String) && sprite.kind_of?(Sprite)
    return if @comps.has_key?(title)
    @comps[title] = sprite
    @comps[title].visible = false
    @comps[title].snap(@slide)
    @titles.push(title)
  end

  def [](title)
    return nil unless title.kind_of?(String) || @comps.has_key?(title)
    return @comps[title]
  end

  def show
    @comps.keys.each{|k| @comps[k].visible = true }
    @slide.visible = true
  end

  def hide
    @comps.keys.each{|k| @comps[k].visible = false }
    @slide.visible = false
  end

  def set_color(c)
    @color = c
    @slide.bitmap.fill_rect(0, 0, w, h, @color)
  end

  def set_alpha(a)
    @alpha = a
    @comps.keys.each{|k| @comps[k].alpha = @alpha }
    @slide.alpha = @alpha
  end

  def locate(x, y)
    @slide.set_offset(x, y)
    @slide.calc_layout
  end

  def_delegators(:@slide, :x, :y)
  def_delegators(:@slide, :calc_layout, :enable_layout, :disenable_layout)
  def_delegators(:@slide, :set_side_x, :set_side_y, :set_side)
  def_delegators(:@slide, :set_base_size, :reset_base_size, :set_base_point)
  def_delegators(:@slide, :set_offset_x, :set_offset_y, :set_offset, :reset_offset)
  def_delegators(:@slide, :get_layout_x, :get_layout_y, :get_layout, :get_side, :get_base)
  def_delegators(:@slide, :get_offset, :get_offset_x, :get_offset_y)
  def_delegators(:@slide, :move, :set_layout, :reset_layout, :centering)
  def_delegators(:@slide, :set_base_size, :reset_base_size, :set_base_point)
  def_delegators(:@slide, :snap, :reset_snap, :add_snap_child, :delete_snap_child)
  def_delegators(:@slide, :get_snap_children, :set_snap_children, :get_snap_sprite)
  def_delegators(:@slide, :set_snap_sprite, :rect)

  def slide_to_sprite
    sprite = Sprite.new([@slide.w, @slide.h], nil)
    sprite.bitmap.fill_rect(0, 0, sprite.w, sprite.h, @color)

    comps = @comps.values.sort{|a, b| a.dp <=> b.dp && a.id <=> b.id }
    comps.each{|c|
      if c != nil
        SDL.blitSurface(c.bitmap, c.ox, c.oy, c.ow, c.oh, sprite.bitmap, c.x - @slide.x, c.y - @slide.y)
      end
    }
    return sprite
  end

  def dispose
    @comps.clear
    @slide.dispose
  end

  def get_sprite_list
    return @titles
  end
end

class Dice # サイコロ
  VMAX = 4
  
  @@dice_bmp = nil
  
  attr_reader :x, :y, :sx, :sy, :dp, :margin
  
  def initialize(a)
    @amount      = a
    @dices       = Array.new
    @dnums       = Array.new
    @x           = 0
    @y           = 0
    @sx          = 4
    @sy          = 4
    @dp          = 100
    @margin      = 4
    @wait        = 0
    @wcnt        = 0
    @dicing      = false
    @have_result = false
    @bgcolor     = [0, 0, 0]
    @balpha      = 128
    @@dice_bmp = Bitmap.load("dice.png") if @@dice_bmp == nil
    @amount.times{|i|
      @dices.push(Sprite.new(@@dice_bmp, Point.new(0, 0)))
      @dices[i].dp = @dp
      @dices[i].oh = @dices[i].w
      @dices[i].x = @x + @margin + (@dices[i].ow + @sx) * (i % VMAX)
      @dices[i].y = @y + @margin + (@dices[i].oh + @sy) * (i / VMAX)
      @dnums.push(0)
    }
    sh = @dices.length / VMAX + 1
    sw = @dices.length > VMAX ? VMAX : @dices.length
    w = @dices[0].ow * sw + @sx * (sw - 1) + @margin * 2
    h = @dices[0].oh * sh + @sy * (sh - 1) + @margin * 2
    @max = @dices[0].h / @dices[0].oh
    @bg = Sprite.new([w, h], nil)
    @bg.x = @x
    @bg.y = @y
    @bg.dp = @dp - 1
    @bg.bitmap.fillRect(0, 0, @bg.w, @bg.h, @bgcolor)
    @bg.alpha = @balpha
  end
  
  def start(wait = 0)
    @wait = wait
    @wcnt = wait
    @dnums.length.times{|d|
      @dnums[d] = rand(@max)
      @dices[d].oy = @dices[d].oh * @dnums[d]
    }
    @dicing = true
  end
  
  def update
    if @dicing && Input::pushed?(Input::BTN1)
      @have_result = true
      @dicing = false
      return
    end
    if @wcnt == 0
      @dnums.length.times{|d|
        @dnums[d] = rand(@max)
        @dices[d].oy = @dices[d].oh * @dnums[d]
      }
      @wcnt = @wait
    else
      @wcnt -= 1
    end
  end
  
  def stop
    @have_result = true if @dicing
    @dicing = false
  end
  
  def x=(x)
    @x = x
    @dnums.length.times{|d|
      @dices[d].x = @x + @margin + (@dices[d].ow + @sx) * (d % VMAX)
    }
    @bg.x = @x
  end
  
  def y=(y)
    @y = y
    @dnums.length.times{|d|
      @dices[d].y = @y + @margin + (@dices[d].oh + @sy) * (d / VMAX)
    }
    @bg.y = @y
  end
  
  def dp=(dp)
    @dp = dp
    @dices.each{|dc|
      dc.dp = @dp
    }
    @bg.dp = @dp - 1
  end
  
  def setBG(color, alpha)
    @bgcolor = color
    @bgalpha = alpha
    @bg.bitmap.fillRect(0, 0, @bg.w, @bg.h, @bgcolor)
    @bg.alpha = @balpha
  end
  
  def show
    return if @dices == nil
    @dices.each{|dc|
      dc.visible = true
    }
    @bg.visible = true
  end
  
  def hide
    return if @dices == nil
    @dices.each{|dc|
      dc.visible = false
    }
    @bg.visible = false
  end
  
  def dicing?
    @dicing
  end
  
  def have_result?
    @have_result
  end
  
  def result
    return @dnums.inject(0){|r, i| r + i + 1}
  end
  
  def result_array
    return @dnums.map{|n| n + 1}
  end
  
  def reset
    @dnums.length.times{|d|
      @dnums[d] = 0
      @dices[d].oy = 0
    }
    @reset_result
  end
  
  def reset_result
    @have_result = false
  end
  
  def size
    [@bg.w, @bg.h]
  end
end

class MessageBox
  extend Forwardable

  CURSOR_SIZE = 24

  patterns = 4
  cursor_other = Rect.new(0, 0, 1, 1)
  cursor_back  = Rect.new(0, CURSOR_SIZE, CURSOR_SIZE, CURSOR_SIZE)
  wait   = Rect.new(CURSOR_SIZE * 1, 0, CURSOR_SIZE, CURSOR_SIZE)
  cursor = Rect.new(CURSOR_SIZE * 2, 0, CURSOR_SIZE, CURSOR_SIZE)
  page   = Rect.new(CURSOR_SIZE * 3, 0, CURSOR_SIZE, CURSOR_SIZE)
  @@wparam = WindowParameter.new(
    "cursors.png",
    cursor_other,
    cursor_other,
    cursor_other,
    cursor_other,
    cursor_other,
    cursor_other,
    cursor_other,
    cursor_other,
    cursor_back
  )
  @@cparam = CursorParameter.new(
    "cursors.png",
    wait, patterns,
    cursor, patterns,
    page, patterns
  )
  
  def reset_select
    @selecting = false
    @have_result = false
    @res = 0
    @selects = 0
    @select2label = Array.new
    
    @have_label = false
    @label = ""
  end
  
  def reset
    @have_stuff = false
    @p = -1
    @eot = false
    @pause = false
    @wait = 0
    @cnt = 0
    @sleep = 0
    
    # 2006.05.13 Cyross
    @code = Yuki::Direction::EOT
    
    reset_select
  end

  def initialize(size = Size.new(640, 480), params = @@cparam, font = Font.system_font, fontsize = 24)
    @params = params
    @prts = @params.get_parts
    @font = font
    @fontsize = fontsize
    @font.size = @fontsize

    @box = TextBox.new(size, @params, 255, false, 0)

    @box.bgColor = [0, 0, 0]
    @box.bgAlpha = 0
    @box.x = 0
    @box.y = 0
    @box.font = @font
    @box.msg.separate = true
    @box.pauseType = 1
    @box.pauseWait = 0

    @vars = Yuki::Variables.new
    @cmds = nil

    @have_show_image = false
    @have_hide_image = false

    reset
  end
  
  def setBG(color, alpha)
    @box.bgColor = color
    @box.bgAlpha = alpha
  end
  
  def draw_text(str, wait = 0)
    reset
    @box.msg.text = str
    @wait = wait
    @have_stuff = true
  end
  
  def stuff(fname, wait = 0)
    raise MiyakoError.new("file not found : #{fname}") if File.exist?(fname) == false
    reset
    @wait = wait

    line = ""
    File.open(fname, "r"){|f|
      while f.eof? == false
        l = f.readline.chomp.toutf8
        next if l =~ /^[\s\t]+/ # empty line
        next if l =~ /^#/       # comment
        line += l
      end
    }
    @box.msg.text = line
    
    @have_result = false
    @selecting = false
    @have_stuff = true
  end

  def set_commands(filename)
    @cmds = Commands.new(filename)
  end

  def update
    if @selecting
      if Input.pushed?(Input::BTN1)
        @selecting = false
        @have_result = true
        @have_label = true if @select2label.length > 0 # command only
        @box.cursorVisible = false
        @vars.var[0] = @res
        @selects = 0
        return
      end
      dx, dy = Input.pushedAmount
      @res = (@res + @selects + dy) % @selects
      @box.cursorY = @y + @res * @box.font.size
    elsif @sleep > 0
      @sleep -= 1
      return
    elsif @box.pause?
      @box.pause = false if Input.pushed?(Input::BTN1)
    elsif @have_stuff == false
      return
    elsif @cnt == 0
      @have_show_image = false
      @have_hide_image = false
      ct = @box.msg.nextmsg
      # 2006.05.13 Cyross
      @code = ct.code
      if ct.code == Yuki::Direction::EOT
        @eot = true
        return
      elsif ct.code == Yuki::Direction::CHAR
        @box.msg.push(ct)
        @cnt = @wait
        return
      elsif ct.code == Yuki::Direction::PAUSE
        @box.pause = true
        return
      elsif ct.code == Yuki::Direction::FONTCOLOR
        @box.msg.push(ct)
        return
      elsif ct.code == Yuki::Direction::FONTSIZE
        @box.msg.push(ct)
        return
      elsif ct.code == Yuki::Direction::CR
        @box.cr
        return
      elsif ct.code == Yuki::Direction::CLEAR
        @box.clear
        return
      elsif ct.code == Yuki::Direction::MESWAIT
        @wait = ct.data
        @cnt = @wait
        return
      elsif ct.code == Yuki::Direction::SLEEP
        @sleep = ct.data
        return
      elsif ct.code == Yuki::Direction::LOCATE
        @box.locate(ct.data[0], ct.data[1])
        return
      elsif ct.code == Yuki::Direction::YESNO
        yes_no
        return
      elsif ct.code == Yuki::Direction::COMMAND
        command(ct.data)
        return
      elsif ct.code == Yuki::Direction::LABEL
        @label = ct.data
        @have_label = true
        return
      elsif ct.code == Yuki::Direction::EXPR
        r = @vars.exec(ct.data[0])
        return @box.msg.push(Yuki::Direction.new(Yuki::Direction::CHAR, "#{r}")) if ct.data[1]
      elsif ct.code == Yuki::Direction::SOUND
        snd = Audio::SE.new(ct.data[0])
        snd.setVolume(ct.data[1])
        snd.play
        if ct.data[2]
          while snd.playing? do
          end
        end
        return
      elsif ct.code == Yuki::Direction::SHOW
        @vars.var[0] = ct.data
        return
      elsif ct.code == Yuki::Direction::HIDE
        @vars.var[0] = ct.data
        return
      else
        @box.msg.push(ct)
        @cnt = @wait
        return
      end
    else
      @cnt = @cnt - 1
    end
  end
  
  def yes_no
    return if @selecting || @dicing
    reset_select
    @box.msg.push(Yuki::Direction.cr)
    @box.msg.push(Yuki::Direction.locate(@params.cursor[0].w, nil))
    @box.msg.push(Yuki::Direction.new(Yuki::Direction::CHAR, "はい"))
    @box.msg.push(Yuki::Direction.cr)
    @box.msg.push(Yuki::Direction.locate(@params.cursor[0].w, nil))
    @box.msg.push(Yuki::Direction.new(Yuki::Direction::CHAR, "いいえ"))
    @box.msg.push(Yuki::Direction.cr)
    @selecting = true
    @have_result = false
    @box.cursorDir = :d
    @y = @box.locateY + @fontsize
    @box.cursorX = @box.locateX
    @box.cursorY = @y
    @box.cursorVisible = true
    @selects = 2
  end
  
  def command(clabel)
    return if @selecting || @dicing
    reset_select
    cnt = 0
    @cmds[clabel][:list].each{|c|
      if @vars.exec(c["condition"])
        @box.msg.push(Yuki::Direction.cr)
        @box.msg.push(Yuki::Direction.locate(@params.select_cursor[:r].w, nil))
        @box.msg.push(Yuki::Direction.new(Yuki::Direction::CHAR, c["name"]))
        @select2label.push(c["label"])
        cnt += 1
      end
    }
    return if cnt == 0
    @box.msg.push(Yuki::Direction.cr)
    @selecting = true
    @have_result = false
    @have_label = false
    @box.cursorDir = :d
    @y = @box.locateY + @fontsize
    @box.cursorX = @box.locateX
    @box.cursorY = @y
    @box.cursorVisible = true
    @selects = cnt
  end
  
  def visible
    return @box.visible
  end
  
  def visible=(f)
    @box.visible = f
  end
  
  def show
    @box.show
  end

  def hide
    @box.hide
  end

  def text_separate?
    @box.msg.separate
  end
  
  def text_separate=(f)
    @box.msg.separate = f
  end
  
  def eot?
    return @eot
  end
  
  def have_result?
    return @have_result
  end
  
  def have_label?
    return @have_label
  end
  
  def result
    return @res
  end
  
  def get_label
    return @label if @label != ""
    return "" if @select2label.length == 0
    return @select2label[@res]
  end
  
  def have_show_image?
    return @have_show_image
  end
  
  def have_hide_image?
    return @have_hide_image
  end
  
  # 2006.05.13 Cyross
  attr_reader :code
  
  def_delegators(:@box, :pauseWait, :pauseWait=)
  def_delegators(:@box, :cr, :clear, :dp, :dp=)
  def_delegators(:@box, :clientW, :clientH, :x, :x=, :y, :y=)
end

module W_Params
  @@w_param = WindowParameter.new(
    "win_base.png",                 # ウィンドウイメージ名
    Rect.new(  0,  0, 16, 16),    # 左上
    Rect.new( 16,  0, 16, 16),    # 上
    Rect.new( 32,  0, 16, 16),    # 右上
    Rect.new(  0, 16, 16, 16),    # 左
    Rect.new( 32, 16, 16, 16),    # 右
    Rect.new(  0, 32, 16, 16),    # 左下
    Rect.new( 16, 32, 16, 16),    # 下
    Rect.new( 32, 32, 16, 16),    # 右下
    Rect.new( 48,  0, 32, 32)     # クライアント
  )

  @@c_param = CursorParameter.new(
    "win_base.png",                  # ウィンドウイメージ名
    Rect.new( 80,  0, 16, 16), 4, # ウェイト、パターン数
    Rect.new( 96,  0, 16, 16), 4, # カーソル、パターン数
    Rect.new(160,  0, 16, 16), 4  # ページカーソル、パターン数
  )
end

class ScinarioWindowDirector < Yuki::Director
  @@event_name << :select_name
  
  def initialize(box_m, box_y, box_c, mw, mh, cw, ch)
    super(box_m)
    @box.set_layout(:center, :bottom)
    @x = 0
    @y = 0
    @w = mw
    @h = mh
    @cw = cw
    @ch = ch
    @msg_stack = Array.new
    @yn = box_y
    @yn.set_layout(:right, :top)
    @cm = box_c
    @cm.set_layout(:right, :top)
    @ptr = 0
    @mod = 0
    @select2name = nil
    @yn_selecting = false
    @cm_selecting = false
  end

  def reset_locate
    @x = 0
    @y = 0
  end

  def push_command(n)
    @cm.clear
    n.times{|i|
      @cm.msg.push(Yuki::Direction.cr) if @cm.kind_of?(TextBox)
      @cm.msg.push(Yuki::Direction.locate(@cm.cursor_params.select_cursor[:r].w, nil))
      @cm.msg.push(Yuki::Direction.new(Yuki::Direction::CHAR, @select2name[@ptr+i][0,@cw*2]))
      @cm.msg.push(Yuki::Direction.cr) if @cm.kind_of?(Window)
    }
    @cm.msg.push(Yuki::Direction.cr) if @cm.kind_of?(TextBox)
  end

  def move(n, d)
    p = n % @ch
    if n == 0 && d == 1
      @ptr = 0
      push_command(@selects > @ch ? @ch : @selects)
    elsif p == 0 && d == 1
      @ptr += @ch
      d = @selects - @ptr
      push_command(d == @mod ? d : @ch)
    elsif n == @selects - 1 && d == -1
      @ptr = @selects - @mod
      push_command(@mod)
    elsif p == @ch -1 && d == -1
      @ptr -= @ch
      push_command(@ch)
    end
    @cm.cursorY = @y + p * @cm.font.line_skip
  end

  def update
    @@event_name.each{|r| @event[r] = nil }
    @anim.keys.each{|a| @var[a].update if @anim[a] }
    if @yn_selecting
      if Miyako::Input.pushed?(Miyako::Input::BTN1)
        @event[:select_result] = @res
        @event[:yn_scenario] = @yn2scenario[@res]
        @yn.hide
        @yn.cursorVisible = false
        @yn_selecting = false
        clear_select_array
        @box.clear
        return
      elsif Miyako::Input.pushed?(Miyako::Input::BTN2)
        @event[:select_result] = 1 # No
        @event[:yn_scenario] = @yn2scenario[1] if @yn2scenario
        @yn.hide
        @yn.cursorVisible = false
        @yn_selecting = false
        clear_select_array
        @box.clear
        return
      end
      dx, dy = Miyako::Input.pushedAmount
      @res = (@res + @selects + dy) % @selects
      @yn.cursorY = @y + @res * @yn.font.line_skip
      return
    end
    if @cm_selecting
      if Input.pushed?(Input::BTN1)
        r = @select2num[@res]
        @event[:select_result] = r
        @event[:next_label] = @select2label[r]
        @event[:select_scenario] = @select2scenario[r]
        @event[:select_name] = @select2name[r]
        
        @cm.hide
        @cm.cursorVisible = false
        @cm_selecting = false
        clear_select_array
        @box.clear
        return
      elsif @cansel && Input.pushed?(Input::BTN2)
        @event[:cansel_scenario] = @cansel
        @event[:cansel] = true
        @cm.hide
        @cm.cursorVisible = false
        @cm_selecting = false
        clear_select_array
        @box.clear
        return
      end
      dx, dy = Input.pushedAmount
      @res = (@res + @selects + dy) % @selects
      move(@res, dy)
      return
    elsif @sleep && @sleep.waiting?
      return
    elsif @box.pause?
      if Miyako::Input.pushed?(Miyako::Input::BTN1)
        @box.pause = false
        @event[:pause_cansel] = true
      end
    elsif @eot
      return
    elsif @wait.finish?
      message_loop
    end
  end

  def reset_select
    @res = 0
    @ptr = 0
  end

  def init_window(window, selects)
    window.cursorDir = :r # left
    @y = window.textMarginTop + window.locateY + (window.font.line_skip - window.cursor_params.select_cursor[:r].h) / 2
    @y += window.font.line_skip if window.kind_of?(Miyako::TextBox)
    window.cursorX = @box.textMarginLeft + window.locateX
    window.cursorY = @y
    @res = 0
    @selects = selects
  end

  def show_window(window)
    window.show
    window.cursorVisible = true
  end

  def yes_no(ynscenarios)
    return if @yn_selecting
    @yn2scenario = ynscenarios
    @yn.clear
    @yn.msg.push(Yuki::Direction.cr) if @yn.kind_of?(Miyako::TextBox)
    @yn.msg.push(Yuki::Direction.locate(@yn.cursor_params.select_cursor[:r].w, nil))
    @yn.msg.push(Yuki::Direction.new(Yuki::Direction::CHAR, "はい"))
    @yn.msg.push(Yuki::Direction.cr)
    @yn.msg.push(Yuki::Direction.locate(@yn.cursor_params.select_cursor[:r].w, nil))
    @yn.msg.push(Yuki::Direction.new(Yuki::Direction::CHAR, "いいえ"))
    @yn.msg.push(Yuki::Direction.cr)
    init_window(@yn, 2)
    show_window(@yn)
    @yn_selecting = true
  end

  def command(clabel)
    return if @cm_selecting
    @select2scenario = Array.new
    @select2name   = Array.new
    @select2label = Array.new
    @select2num   = Array.new
    cnt = 0
    @title = @cmds[clabel][:title]
    @cansel = @cmds[clabel][:cansel]
    @cmds[clabel][:list].each_with_index{|c, i|
      if @var.exec(c["condition"])
        @select2name.push(c["name"])
        @select2label.push(c["label"])
        @select2scenario.push(c["scenario"])
        @select2num.push(i)
        cnt += 1
      end
    }
    return if cnt == 0
    push_command(cnt>@ch ? @ch : cnt)
    init_window(@cm, cnt)

    @ptr = 0
    @mod = @selects % @ch
    @mod = @ch if @mod == 0

    unless @title == ""
      @box.msg.push(Yuki::Direction.new(Yuki::Direction::CHAR, @title, :setting))
      @box.msg.push(Yuki::Direction.cr)
    end

    show_window(@cm)
    @cm_selecting = true
  end

  def message_loop
    begin
      @message = @msg_stack.shift || @box.msg.nextmsg
      @code2method[@message.code].call(@message.data)
    end while @message.type == :setting
  end

  def process_char(data)
    slen = data.split(//).size
    if @x + slen < @w
      @box.msg.push(Yuki::Direction.new(Yuki::Direction::CHAR, data, :setting))
      @x += slen
      data = nil
    else
      l = slen + @x - @w
      if l > 0
        str = data[0, l]
        @box.msg.push(Yuki::Direction.new(Yuki::Direction::CHAR, str, :setting))
      end
      @x = 0
      @y += 1
      if @y == @h - 1
        @msg_stack.push(Yuki::Direction.new(Yuki::Direction::PAUSE))
        @msg_stack.push(Yuki::Direction.new(Yuki::Direction::CLEAR))
        @y = 0
      else
        @box.cr
      end
      data = data[l..data.length-1]
      @msg_stack.push(Yuki::Direction.new(Yuki::Direction::CHAR, data, :setting)) if data
    end
    @wait.start
  end

  def process_clear(data)
    @box.clear
    @x = 0
    @y = 0
  end

  def process_cr(data)
    @x = 0
    @y += 1
    if @y == @h - 1
      @msg_stack.push(Yuki::Direction.new(Yuki::Direction::PAUSE))
      @msg_stack.push(Yuki::Direction.new(Yuki::Direction::CLEAR))
      @y = 0
    else
      @box.cr
    end
  end

  def process_eot(data)
    super
    @x = 0
    @y = 0
  end
end

class ScinarioWindow
  extend Forwardable
  include W_Params

  def initialize(mw, mh, cw, ch, size=16, font=Font.sans_serif, alpha = 128)
    @mw = mw
    @mh = mh

    font.size = size

    ww = font.size * @mw
    hh = font.line_skip * @mh
    @win_m = Window.new([ww, hh], @@w_param, @@c_param, alpha, false, 1.2)
    @win_m.font = font
    @win_m.pauseWait = 0.5
    @win_m.dp = 100

    @cw = cw
    @ch = ch

    ww = font.size * @cw
    hh = font.line_skip * @ch
    @win_c = Window.new([ww, hh], @@w_param, @@c_param, alpha, false, 1.2)
    @win_c.font = font
    @win_c.dp = 105
    @win_c.cursorWait = 0.5

    yw = font.size * 6
    yh = font.line_skip * 2
    @win_y = Window.new([yw, yh], @@w_param, @@c_param, alpha, false, 1.2)
    @win_y.font = font
    @win_y.dp = 105
    @win_y.cursorWait = 0.5

    @dir = ScinarioWindowDirector.new(@win_m, @win_y, @win_c, @mw, @mh, @cw, @ch)
    @dir.text_separate = true

    @yn_value = -1
    @cm_value = -1
  end

  def update
    @dir.update
  end

  def pause?
    return @dir.event[:pause]
  end

  def cansel_pause?
    return @dir.event[:cansel_pause]
  end

  def load(filename)
    @dir.set_plot(filename)
  end

  def scenario(name = :Main)
    @dir.scenario(name)
  end

  def start(str = nil)
    @dir.clear
    @dir.set_text(str) if str
    @dir.start
  end

  def result
    return @dir.event[:select_result]
  end

  def next_name
    return @dir.event[:select_name]
  end

  def next_scenario
    return @dir.event[:select_scenario] || @dir.event[:yn_scenario]
  end

  def next_label
    return @dir.event[:next_label]
  end

  def_delegators(:@win_m, :visible)
  def_delegators(:@dir, :eot?, :show, :hide, :var)

  def_delegators(:@win_m, :calc_layout, :set_layout, :enable_layout, :disenable_layout, :set_side_x, :set_side_y)
  def_delegators(:@win_m, :set_side, :set_base_size, :reset_base_size, :set_base_point, :snap, :reset_snap, :add_snap_child, :delete_snap_child, :set_base)
  def_delegators(:@win_m, :reset_base, :set_offset_x, :set_offset_y, :set_offset, :reset_offset, :reset_layout, :centering, :move, :move_to)
  def_delegators(:@win_m, :get_layout_x, :get_layout_y, :get_layout, :get_side, :get_base)
  def_delegators(:@win_m, :get_offset, :get_offset_x, :get_offset_y)
end
end
