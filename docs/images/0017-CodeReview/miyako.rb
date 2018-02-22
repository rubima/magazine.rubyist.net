# Miyako main
=begin
Miyako v0.6
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

require 'sdl'
require 'forwardable'
require 'kconv'
require 'jcode'
require 'rbconfig'

$KCODE = 'u'

SDL.init(SDL::INIT_VIDEO | SDL::INIT_AUDIO | SDL::INIT_JOYSTICK)

=begin
=Yuki module
=end
module Yuki
=begin
=Yuki::YukiError class
=end
  class YukiError < Exception
  end

=begin
=Yuki::Direction class
=end

  class Direction
    CHAR            =   0
    FONTCOLOR       =   1
    FONTSIZE        =   2
    PAUSE           =   3
    CLEAR           =   4
    CR              =   5
    MESWAIT         =   6
    SLEEP           =   7
    LOCATE          =   8
    YESNO           =   9
    COMMAND_INIT    =  10
    COMMAND         =  11
    LABEL           =  12
    EXPR            =  13
    SOUND           =  14
    IMAGE_INIT      =  15
    DP              =  16
    ALPHA           =  17
    LAYOUT          =  18
    MOVE            =  19
    MOVE_TO         =  20
    SHOW            =  21
    HIDE            =  22
    PLOT_APPEND     =  23
    SCENARIO        =  24
    COMMAND_APPEND  =  25
    IMAGE_VIEW      =  26
    ANIMATION_INIT  =  27
    ANIMATION_START     =  28
    ANIMATION_STOP      =  29
    ANIMATION_RESET     =  30
    ANIMATION_CHARACTER =  31
    EOT                 = 999

    attr_reader :code, :type, :data

    @@type_list = [:setting, :exec]

    def initialize(c, d = nil, t = :exec)
      raise YukiError.new("Illegal type Format! : \":"+t.to_s+"\"") unless @@type_list.include?(t)
      @code = c
      @data = d
      @type = t
    end

    def append(s)
      @data = @data + s if s.class == String
    end

    @@cr = Direction.new(CR)
    @@eot = Direction.new(EOT)

    def Direction.cr
      return @@cr
    end

    def Direction.locate(x, y)
      return Direction.new(LOCATE, [x, y], :setting)
    end

    def Direction.yes_no
      return Direction.new(Direction::YESNO)
    end

    def Direction.command(label)
      raise YukiError,new("Command Label is Empty!") if label == nil
      return Direction.new(Direction::COMMAND, label)
    end

    def Direction.eot
      return @@eot
    end
  end

=begin
=Yuki::Scenario class
=end
  class Scenario
    extend Forwardable

    attr_reader :text, :separate

    def initialize
      @separate = false
      @text = ""
      @msg = Array.new()
      @base = Array.new()
      @ptr = 0
    end

    def setup
      @base = Compiler.compile(@text, @separate)
      @msg = Array.new()
      @ptr = 0
    end

    protected :setup

    def compile(str)
      @text = String.new(str.toutf8())
      setup
    end

    def text=(str)
      compile(str)
    end

    def separate=(f)
      @separate = f
      setup
    end

    def eot?
      @ptr == @base.length
    end

    def nextmsg
      return Direction.eot if eot?
      dat = @base[@ptr]
      @ptr = @ptr + 1
      dat
    end

    def copy
      @msg = @base.clone
      @ptr = 0
    end

    def append(d)
      if @msg.length > 0 && d.code == Direction::CHAR && @msg.last.code == Direction::CHAR
        @msg.last.append(d.data)
      else
        @msg.push(d)
      end
    end

    def clear
      @msg = Array.new
    end

    def reset(flag = true)
      @msg = Array.new if flag
      @ptr = 0
    end

    def get_ptr
      return @ptr
    end

    def set_ptr(p)
      @ptr = p if p < @base.length
    end

    def_delegators(:@msg, :push, :pop, :[], :[]=, :length, :size, :each, :delete, :delete_at)
    def_delegators(:@msg, :shift, :unshift, :collect, :map, :select, :inject, :reject, :concat, :empty?, :first, :last)
  end

=begin
=Yuki::Plot class
=end
  class Plot
    def initialize(plot_file)
      @scnr = Hash.new
      append(plot_file, :Main)
    end

    def append(plot_file, start = nil)
      raise YukiError.new("file not found : #{fname}") unless File.exist?(plot_file)

      name = start
      @scnr[name] = Scenario.new
      line = ""
      bg = false
      File.open(plot_file, "r"){|f|
        while f.eof? == false
          l = f.readline.chomp.toutf8
          next if l =~ /^[\s\t]+/ # empty line
          next if l =~ /^#/       # comment
          if l =~ /^:scenario[\s\t]+(.+)$/
            raise YukiError.new("not find :end!") if bg
            @scnr[name].text = line if name == :Main
            name = $1.intern
            @scnr[name] = Scenario.new
            line = ""
            bg = true
          elsif l =~ /^:end$/
            raise YukiError.new("not find :Scenario!") unless bg
            @scnr[name].text = line
            bg = false
          else
            line += l
          end
        end
        raise YukiError.new("not find :end!") if bg
        @scnr[name].text = line if name == :Main # Main Script Only
      }
    end

    def [](name)
      raise YukiError.new("name is Not String or Symbol!") unless name.kind_of?(String) || name.kind_of?(Symbol)
      name = name.intern if name.class == String
      raise YukiError.new("Illegal scenario name! : "+ name.to_s) unless @scnr.include?(name)
      @scnr[name].reset(false)
      return @scnr[name]
    end

    def listup
      @scnr.keys.sort.each{|n| print n.to_s+"\n" }
    end
  end

=begin
=Yuki::Compiler class
=end
  class Compiler
    def Compiler::add(cl, str, spr)
      return cl if str == ""
      if spr
        str.split(//).each{|s| cl.push(Direction.new(Direction::CHAR, s)) }
      else
        cl.push(Direction.new(Direction::CHAR, str))
      end
      return cl
    end

    def Compiler::compile(c, spr)
      cl = Scenario.new
      ctx = c.toutf8().split(/\n/)
      tmc = ""
      ctx.each{|l|
        while l != ""
          if l =~ /\\\{/
            tmc = tmc + $` if $` != nil
            tmc = tmc + "{$1}"
            l = $' == nil ? "" : $'
          elsif l =~ /\\\}/
            tmc = tmc + $` if $` != nil
            tmc = tmc + "}"
            l = $' == nil ? "" : $'
          elsif l =~ /\{([^\}]*)\}/
            tm = $` == nil ? "" : $`
            com = $1
            l = $' == nil ? "" : $'
            if com =~ /^color[=\s\t]+(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::FONTCOLOR, Miyako::Color.to_rgb($1), :setting))
            elsif com =~ /^size[=\s\t]+(\d+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::FONTSIZE, $1.to_i, :setting))
            elsif com == "pause"
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::PAUSE))
            elsif com == "clear"
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::CLEAR))
            elsif com == "cr"
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::CR))
            elsif com =~ /^message_wait[=\s\t]+(\d*\.?\d+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::MESWAIT, $1.to_f))
            elsif com =~ /^sleep[=\s\t]+(\d*\.?\d+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::SLEEP, $1.to_f))
            elsif com =~ /^locate[=\s\t]+(\d+),(\d+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::LOCATE, [$1 ? $1.to_i() : nil,$2 ? $2.to_i() : nil], :setting))
            elsif com =~ /^yesno[=\s\t]+([^,\s]+)\s*,\s*(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::YESNO, [$1,$2]))
            elsif com =~ /^command[=\s\t]+(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::COMMAND, $1))
            elsif com =~ /^next[=\s\t]+(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::LABEL, $1))
            elsif com =~ /^expr[=\s\t]+(.)\1(.+)\1\1$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::EXPR, [$2, true]))
            elsif com =~ /^expr[=\s\t]+(.)(.+)\1$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::EXPR, [$2, false]))
            elsif com =~ /^sound[=\s\t]+([^,\s]+)\s*,\s*(\d+)\s*,\s*(.+)$/
              raise YukiError,new("Sound flag is 'true' or 'false' !") if $3.downcase != "true" && $3.downcase != "false"
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::SOUND, [$1,$2.to_i,eval($3)]))
            elsif com =~ /^image_init[=\s\t]+([^,\s]+)\s*,\s*([^,\s]+)\s*,\s*(.+)$/
              raise YukiError,new("Transparent flag is 'true' or 'false' !") if $3.downcase != "true" && $3.downcase != "false"
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::IMAGE_INIT, [$1,$2,eval($3)]))
            elsif com =~ /^image_view[=\s\t]+([^,\s]+)\s*,\s*(\d+)\s*,\s*(\d+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::IMAGE_VIEW, [$1,eval($2),eval($3)]))
            elsif com =~ /^animation_init[=\s\t]+([^,\s]+)\s*,\s*([^,\s]+)\s*,\s*(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::ANIMATION_INIT, [$1, $2, eval($3)]))
            elsif com =~ /^animation_start[=\s\t]+(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::ANIMATION_START, $1))
            elsif com =~ /^animation_stop[=\s\t]+(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::ANIMATION_STOP, $1))
            elsif com =~ /^animation_reset[=\s\t]+(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::ANIMATION_RESET, $1))
            elsif com =~ /^animation_character[=\s\t]+([^,\s]+)\s*,\s*(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::ANIMATION_CHARACTER, [$1, eval($2)]))
            elsif com =~ /^command_init[=\s\t]+([^,\s]+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::COMMAND_INIT, $1))
            elsif com =~ /^command_append[=\s\t]+([^,\s]+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::COMMAND_APPEND, $1))
            elsif com =~ /^dp[=\s\t]+([^,\s]+)\s*,\s*(\d+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::DP, [$1, $2.to_i]))
            elsif com =~ /^move[=\s\t]+(\d+)\s*,\s*(\d+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::MOVE, [$1.to_i,$2.to_i]))
            elsif com =~ /^move_to[=\s\t]+(\d+)\s*,\s*(\d+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::MOVE_TO, [$1.to_s,$2.to_s]))
            elsif com =~ /^layout[=\s\t]+([^,\s]+)\s*,\s*(\[[^\]]+\])\s*,\s*(\[[^\]]+\])$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::LAYOUT, [$1, $2, $3]))
            elsif com =~ /^alpha[=\s\t]+([^,\s]+)\s*,\s*(\d+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::ALPHA, [$1, $2.to_i]))
            elsif com =~ /^show[=\s\t]+([^,\s]+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::SHOW, $1))
            elsif com =~ /^hide[=\s\t]+(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::HIDE, $1))
            elsif com =~ /^(.)\1(.+)\1\1$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::EXPR, [$2, true]))
            elsif com =~ /^(.)(.+)\1$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::EXPR, [$2, false]))
            elsif com =~ /^plot_append[=\s\t]+(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::PLOT_APPEND, $1))
            elsif com =~ /^scenario[=\s\t]+(.+)$/
              cl = add(cl, tmc + tm, spr)
              tmc = ""
              cl.push(Direction.new(Direction::SCENARIO, $1.intern))
            else
              tmc = "#{tmc}{#{com}}"
            end
          else
            cl = add(cl, tmc + l, spr)
            tmc = ""
            l = ""
          end
        end
        cl = add(cl, tmc, spr)
      }
      return cl
    end
  end

=begin
=Yuki::Variables class
=end

  class Variables
    attr_reader :var, :flag

    def initialize
      @var = Hash.new
      @flag = Hash.new
    end

    def reset
      @var = Hash.new
      @flag = Hash.new
    end

    def [](name)
      return @var[name]
    end

    def []=(name, value)
      @var[name] = value
    end

    def exec(expr)
      return instance_eval(expr)
    end
  end

=begin
=Yuki::Commands class
=end

  class Commands
    def initialize(filename)
      @commands = Hash.new
      compile(filename)
    end

    def [](name)
      raise YukiError.new("Command name not found : #{name}") unless @commands.has_key?(name)
      return @commands[name]
    end

    def add(name, title, cansel, clist)
      @commands[name] = {:title=>title, :cansel=>cansel, :list=>clist}
    end

    def append(filename)
      compile(filename)
    end

    def reset
      @commands = Hash.new
    end

    def debug
      @commands.keys.sort.each{|k|
        print "-----\n"
        print "name="+k.tosjis+"\n"
        print "title="+@commands[k][:title].tosjis+"\n"
        print " ------\n"
        @commands[k][:list].each{|cd|
          print ">name="+cd["name"].tosjis+"\n"
          print ">cond="+cd["condition"].tosjis+"\n"
          print ">next="+cd["label"].tosjis+"\n"
          print ">scen="+cd["scenario"].tosjis+"\n"
          print " ------\n"
        }
        print "-----\n"
      }
    end

    def compile(filename)
      raise YukiError.new("file not found : #{filename}") unless File.exist?(filename)
      l     = Array.new
      label = ""
      title = "コマンド？"
      cansel = nil
      name  = ""
      cond  = "true"
      lb    = nil
      scen  = nil
      incmd = false
      lcnt  = 1
      File.open(filename, "r"){|f|
        while f.eof? == false
          line = f.readline.chomp.toutf8
          lcnt += 1
          next if line =~ /^#/ # comment
          next if line =~ /^[\s\t\n\r]*$/ # empty-line
          if line =~ /^:begin\s+([^\s]+)/
            label = $1
          elsif line =~ /^:title\s+([^\s]+)/
            title = $1
          elsif line =~ /^:cansel\s+([^\s]+)/
            cansel = $1
          elsif line =~ /^:command\{/
            incmd = true
          elsif line =~ /^name=(.+)/
            name = $1
          elsif line =~ /^cond=(.+)/
            cond = $1
          elsif line =~ /^label=(.+)/
            lb = $1
          elsif line =~ /^scenario=(.+)/
            scen = $1
          elsif line =~ /^\}/
            raise YukiError.new("unexpected { .. } ! at #{lcnt}") unless incmd
            tmp = Hash.new
            tmp["name"] = name
            tmp["condition"] = cond
            tmp["label"] = lb
            tmp["scenario"] = scen
            l.push(tmp)
            tmp = nil
            name  = ""
            cond  = "true"
            lb  = nil
            scen = nil
            incmd = false
          elsif line =~ /^:end/
            raise YukiError.new("unexpected :begin - :end ! at #{lcnt}") if label == ""
            add(label, title, cansel, l)
            label = ""
            title = "コマンド？"
            l = Array.new
          else
            raise YukiError.new("syntax error! at #{lcnt}")
          end
        end
      }
    end

    protected :add, :compile
  end

=begin
=Yuki::Director class
=end

  class Director
    extend Forwardable

    @@event_name = [:select_result, :next_label, :select_scenario, :expr_result, :pause, :pause_cansel, :cansel, :cansel_scenario, :yn_scenario]

    attr_accessor :var, :event

    def initialize(box)

      @box = box

      @code2method = Hash.new
      Direction.constants.each{|c| instance_eval("@code2method[Direction::"+c+"]=self.method(:process_"+c.downcase+")") }

      @executing = false
      @var = Variables.new

      @event = Hash.new
      @@event_name.each{|r| @event[r] = nil }

      @anim = Hash.new

      @message = nil

      @wait    = Miyako::WaitCounter.new(0)
      @sleep   = Miyako::WaitCounter.new(0)

      @y       = 0

      @eot     = true

      @setting_mode = true

      @selecting    = false
      @selects      = 0

      @title = ""
      @cansel = nil
      @select2label = nil
      @select2num   = nil
      @select2scenario = nil
      @yn2scenario = nil

      @res          = 0

      @plot = nil
      @cmds = nil
    end

    def set_text(str)
      @box.msg.text = str
      @selecting = false
    end

    def set_plot(plot_file)
      raise YukiError.new("file not found : #{plot_file}") unless File.exist?(plot_file)

      @plot = Plot.new(plot_file)

      @box.msg = @plot[:Main]
      @selecting = false
    end

    def scenario(scenario_name = :Main)
      @box.msg = @plot[scenario_name]
    end

    def set_commands(com_file)
      raise YukiError.new("file not found : #{com_file}") unless File.exist?(com_file)
      @cmds = Commands.new(com_file)
    end

    def append_commands(com_file)
      raise YukiError.new("commands is not initialized : #{com_file}") unless @cmd
      raise YukiError.new("file not found : #{com_file}") unless File.exist?(plot_file)
      @cmds.append(com_file)
    end

    def start(wait = 0)
      @eot  = false
      @wait = Miyako::WaitCounter.new(wait)
      @wait.start
    end

    def message_loop
      begin
        @message = @box.msg.nextmsg
        @code2method[@message.code].call(@message.data)
      end while @message.type == :setting
    end

    def clear_select_array
      @select2scenario = nil
      @select2label = nil
      @select2num   = nil
      @yn2scinario = nil
      @title = ""
      @cansel = nil
      @selecting = false
      @selects = 0
    end

    def array_to_bitmap(array)
      return array.inject(0){|r, i| r |= i << array.length; r >>= 1 }
    end

    def update
      @@event_name.each{|r| @event[r] = nil }
      if @selecting && @selects > 0
        if Miyako::Input.pushed_all?(:btn1)
          @event[:next_label] = @select2label[@select2num[@res]] if @select2label
          @event[:select_result] = @select2num ? @select2num[@res] : @res
          @event[:select_scenario] = @select2scenario[@select2num[@res]] if @select2scenario
          @event[:yn_scenario] = @yn2scenario[@res] if @yn2scenario
          @box.cursorVisible = false
          @selecting = false
          clear_select_array
          return
        elsif @cansel && Miyako::Input.pushed_all?(:btn2)
          @event[:cansel_scenario] = @cansel
          @event[:cansel] = true
          @box.cursorVisible = false
          @selecting = false
          clear_select_array
          return
        end
        dx, dy = Miyako::Input.pushedAmount
        @res = (@res + @selects + dy) % @selects
        @box.cursorY = @y + @res * @box.font.line_skip
      elsif @box.pause?
        cansel_pause if Miyako::Input.pushed_all?(:btn1)
      elsif @sleep && @sleep.waiting?
        return
      elsif @eot
        return
      elsif @wait.finish?
        message_loop
      end
    end

    def execute?
      return @eot == false
    end

    def selecting?
      return @selecting
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

    def reset_select
      @res = 0
    end

    def reset
      @box.clear
      @box.msg.reset
    end

    def cansel_pause
      @box.pause = false
      @event[:pause_cansel] = true
    end

    def yes_no(ynscenarios)
      return if @selecting
      @yn2scenario = ynscenarios
      @box.msg.push(Direction.cr) if @box.kind_of?(Miyako::TextBox)
      @box.msg.push(Direction.locate(@box.cursor_params.select_cursor[:r].w, nil))
      @box.msg.push(Direction.new(Direction::CHAR, "はい"))
      @box.msg.push(Direction.cr)
      @box.msg.push(Direction.locate(@box.cursor_params.select_cursor[:r].w, nil))
      @box.msg.push(Direction.new(Direction::CHAR, "いいえ"))
      @box.msg.push(Direction.cr)
      @box.cursorDir = :r # left
      @y = @box.textMarginTop + @box.locateY + (@box.font.line_skip - @box.cursor_params.select_cursor[:r].h) / 2
      @y += @box.font.line_skip if @box.kind_of?(Miyako::TextBox)
      @box.cursorX = @box.textMarginLeft + @box.locateX
      @box.cursorY = @y
      @res = 0
      @selects = 2

      @box.cursorVisible = false
      @selecting = false
    end

    def command_inner(c, i)
      @box.msg.push(Direction.locate(@box.cursor_params.select_cursor[:r].w, nil))
      @box.msg.push(Direction.new(Direction::CHAR, c["name"]))
      @box.msg.push(Direction.cr)
      @select2scenario.push(c["scenario"])
      @select2label.push(c["label"])
      @select2num.push(i)
    end

    def command(clabel)
      return if @selecting
      @select2scenario = Array.new
      @select2label = Array.new
      @select2num   = Array.new
      cnt = 0
      @title = @cmds[clabel][:title]
      @cansel = @cmds[clabel][:cansel]
      @cmds[clabel][:list].each_with_index{|c, i|
        if @var.exec(c["condition"])
          command_inner(c, i)
          cnt += 1
        end
      }
      return if cnt == 0
      @box.cursorDir = :r # left
      @y = @box.textMarginTop + @box.locateY + (@box.font.line_skip - @box.cursor_params.select_cursor[:r].h) / 2
      @box.cursorX = @box.textMarginLeft + @box.locateX
      @box.cursorY = @y
      @res = 0
      @selects = cnt

      @selecting = false
      @box.cursorVisible = false
    end

    def process_default
      @box.msg.push(@message)
    end

    def process_char(data)
      process_default
      @wait.start
    end

    def process_fontcolor(data)
      @box.font.setColor(data)
    end

    def process_fontsize(data)
      @box.font.size = data
    end

    def process_pause(data)
      @box.pause = true
      @event[:pause] = true
    end

    def process_clear(data)
      @box.clear
    end

    def process_cr(data)
      @box.cr
    end

    def process_meswait(data)
      @wait = Miyako::WaitCounter.new(data)
      @wait.start
    end

    def process_sleep(data)
      @sleep = Miyako::WaitCounter.new(data)
      @sleep.start
    end

    def process_locate(data)
      @box.locate(data[0], data[1])
    end

    def process_yesno(data)
      yes_no(data)
    end

    def process_command(data)
      command(data)
    end

    def process_label(data)
      @event[:next_label] = data
    end

    def process_expr(data)
      r = @var.exec(data[0])
      @event[:expr_result] = r
      @box.msg.push(Direction.new(Direction::CHAR, r.to_s)) if data[1]
    end

    def process_sound(data)
      snd = Miyako::Audio::SE.new(data[0])
      snd.setVolume(data[1])
      snd.play
      if data[2]
        while snd.playing? do
        end
      end
    end

    def process_show(data)
      @var[data.intern].show
    end

    def process_hide(data)
      @var[data.intern].hide
    end

    def process_image_init(data)
      @var[data[0].intern] ||= data[2] ? Miyako::Sprite.new(data[1]) : Miyako::Sprite.new(data[1], nil)
    end

    def process_image_view(data)
      @var[data[0].intern].ow = data[1]
      @var[data[0].intern].oh = data[2]
    end

    def process_animation_init(data)
      @var[data[0].intern] = Miyako::SpriteAnimation.new(@var[data[1].intern], data[2])
    end

    def process_animation_start(data)
      @var[data.intern].start
      @anim[data.intern] = true
    end

    def process_animation_stop(data)
      @var[data.intern].stop
      @anim[data.intern] = false
    end

    def process_animation_reset(data)
      @var[data.intern].pattern(0)
    end

    def process_animation_character(data)
      @var[data[0].intern].character(data[1])
    end

    def process_command_init(data)
      set_commands(data)
    end

    def process_command_append(data)
      append_commands(data)
    end

    def process_dp(data)
      @var[data[0].intern].dp = data[1]
    end

    def process_move(data)
      @var[data[0].intern].move(data[1], data[2])
    end

    def process_move_to(data)
      @var[data[0].intern].move_to(data[1], data[2])
    end

    def process_alpha(data)
      @var[data[0].intern].alpha = data[1]
    end

    def process_layout(data)
      @var[data[0].intern].set_layout(eval(data[1]), eval(data[2]))
    end

    def process_plot_append(data)
      @plot.append(data)
    end

    def process_scenario(data)
      @box.msg = @plot[data]
    end

    def process_eot(data)
      @eot = true
    end

    def dispose
      @code2method = nil
      @var = nil
    end

    protected :process_default

    def show
      @box.show
      if @selects > 0
        @selecting = true
        @box.cursorVisible = true
      end
    end

    def hide
      @box.hide
      if @selects > 0
        @selecting = false
        @box.cursorVisible = false
      end
    end

    def_delegators(:@box, :clear, :visible)
  end

end

=begin
=Miyako module
=end
module Miyako

  SDL::TTF.init
  SDL::Mixer.open(192000, SDL::Mixer::DEFAULT_FORMAT, 2, 16384)
  
=begin
=Miyako::MiyakoError class
=end
  class MiyakoError < Exception
  end
  
  osn = Config::CONFIG["target_os"].downcase
  @@osName = osn =~ /win/ ? "win" : (osn =~ /linux/ ? "linux" : "other")
  
  def Miyako::getOSName
    return @@osName
  end
  
  def Miyako::setTitle(title)
    raise MiyakoError.new("Title is not String! : "+title.class().to_s()) if title.class != String
    SDL::WM.setCaption(getOSName == "win" ? title.to_s().tosjis() : title.to_s().toeuc(), "")
  end
  
=begin
=Miyako::Point class
=end

  class Point
    attr_accessor :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    def point
      return [@x, @y]
    end

    def to_s
      return @x.to_s+","+@y.to_s
    end
  end
  
=begin
=Miyako::Size class
=end
  class Size
    attr_accessor :w, :h

    def initialize(w, h)
      @w, @h = w, h
    end

    def size
      [@w, @h]
    end

    def to_s
      return @w.to_s+","+@h.to_s
    end
  end
  
=begin
=Miyako::Rect class
=end
  class Rect # structure class
    extend Forwardable

    def initialize(x, y, w, h)
      @p = Point.new(x, y)
      @s = Size.new(w, h)
    end

    def rect
      [@p.x, @p.y, @s.w, @s.h]
    end

    def to_s
      @p.to_s+","+@s.to_s
    end
    
    def_delegators(:@p, :x, :y)
    def_delegators(:@s, :w, :h)
  end
  
=begin
=Miyako::Color class
=end

  class Color
    ShiftX = 0x1000000
    ShiftR = 0x10000
    ShiftG = 0x100

    # color const
    BLACK       = [  0,  0,  0]
    WHITE       = [255,255,255]
    BLUE        = [  0,  0,255]
    GREEN       = [  0,255,  0]
    RED         = [255,  0,  0]
    CYAN        = [  0,255,255]
    PURPLE      = [255,  0,255]
    YELLOW      = [255,255,  0]
    LIGHT_GRAY  = [200,200,200]
    HALF_GRAY   = [128,128,128]
    HALF_BLUE   = [  0,  0,128]
    HALF_GREEN  = [  0,128,  0]
    HALF_RED    = [128,  0,  0]
    HALF_CYAN   = [  0,128,128]
    HALF_PURPLE = [128,  0,128]
    HALF_YELLOW = [128,128,  0]
    DARK_GRAY   = [ 80, 80, 80]
    DARK_BLUE   = [  0,  0, 80]
    DARK_GREEN  = [  0, 80,  0]
    DARK_RED    = [ 80,  0,  0]
    DARK_CYAN   = [  0, 80, 80]
    DARK_PURPLE = [ 80,  0, 80]
    DARK_YELLOW = [ 80, 80,  0]

    def Color::to_rgb(v)
      return nil unless v
      if v.kind_of?(Array)
        raise MiyakoError.new("Illegal color array!") unless v.length == 3
        return v
      end
      return cc2rgb(v) if v.kind_of?(Integer)
      return str2rgb(v.to_s) if v.kind_of?(Symbol)
      return str2rgb(v) if v.kind_of?(String)
      raise MiyakoError.new("Illegal parameter")
    end

    def Color::str2rgb(str)
      return eval("["+str+"]") if str =~ /^\[?(\s*\d+\s*,\s*\d+\s*,\s*\d+\s*)\]?$/
      return hex2rgb(str) if str =~ /^\#[\da-fA-F]{6}/
      const_str = str.upcase
      return eval("Miyako::Color::"+str.upcase) if Module.constants.include?(const_str)
      raise MiyakoError.new("Illegal parameter")
    end

    def Color::hex2rgb(hex)
      return [hex[1,2].hex, hex[3,2].hex, hex[5,2].hex]
    end

    def Color::cc2rgb(cc)
      return [(cc % ShiftX) / ShiftR, (cc % ShiftR) / ShiftG, cc % ShiftG]
    end

    def Color::rgb2cc(r, g, b)
      return r * ShiftR + g * ShiftG + b
    end

    def Color::to_s(cc)
      c = to_rgb(cc)
      return "["+c[0].to_s+","+c[1].to_s+","+c[2].to_s+"]"
    end
  end

=begin
=Miyako::SpriteList class
=end
  
  class SpriteList
    def initialize
      @hash = Hash.new
      @list = Array.new
    end
    
    def clear
      @hash.clear
      @list.clear
    end
    
    def createList
      @hash = @hash.reject{|k, v| @hash[k].empty?() }
      @list = Array.new
      @hash.keys.sort.each{|k|
        @hash[k].keys.sort.each{|kk| @list.push(@hash[k][kk]) if @hash[k][kk] } if @hash[k]
      }
    end
    
    protected :createList
    
    def add(sprite)
      @hash[sprite.dp] ||= {}
      @hash[sprite.dp][sprite.id] ||= sprite
      createList
    end
    
    def replaceDp(sprite, old)
      return unless @hash[old]
      @hash[old].delete(sprite.id) if @hash[old][sprite.id]
      add(sprite)
      createList
    end
    
    def remove(sprite)
      @hash[sprite.dp].delete(sprite.id)
      createList
    end
    
    def getList
      @list
    end
  end

=begin
=Miyako::Font class
=end

  class Font
    extend Forwardable
    attr_reader :size, :line_skip, :height, :ascent, :descent

    FONT_LIST_FILE = "./miyako.fonts"

    @@font_cache = {}

    @@name_2_font_path = Hash.new

    @@font_base_path = Hash.new
    @@font_base_path["win"] = ENV['SystemRoot'] ? ["./", ENV['SystemRoot'] + "/fonts/"] : ["./"]
    @@font_base_path["linux"] = ["./", "/usr/share/fonts/", "/usr/X11R6/lib/X11/fonts/"]

    @@font_base_name = Hash.new
    @@font_base_name["win"] = [{:serif=>"msmincho.ttc", :sans_serif=>"msgothic.ttc"},
                               {:serif=>"mikachan.ttf", :sans_serif=>"mikachan.ttf"}]
    @@font_base_name["linux"] = [{:serif=>"sazanami-mincho.ttf", :sans_serif=>"sazanami-gothic.ttf"},
                                 {:serif=>"mikachan.ttf", :sans_serif=>"mikachan.ttf"}]

    def Font.search_font_path_file(hash, path)
      Dir.glob(path+"*"){|d|
        hash = Font.search_font_path_file(hash, d+"/") if test(?d, d)
        hash[$1] = d if d =~ /\/([^\/\.]+\.tt[fc])$/
      }
      return hash
    end

    def Font.create_font_path_file
      unless File.exist?(FONT_LIST_FILE)
        osn = Miyako::getOSName
        @@font_base_path[osn].each{|p|
          @@name_2_font_path = Font.search_font_path_file(@@name_2_font_path, p)
        }
        File.open(FONT_LIST_FILE, "w"){|f|
          @@name_2_font_path.each{|k, v| f.print k+"\t"+v+"\n" }
        }
      else
        @@name_2_font_path = Hash.new
        File.open(FONT_LIST_FILE, "r"){|f|
          until f.eof?
            k, v = f.readline.chomp.split("\t")
            @@name_2_font_path[k] = v
          end
        }
      end
    end

    def Font.findFontPath(fname)
      return @@name_2_font_path.fetch(fname, nil)
    end

    def Font.get_font_inner(fname, fpath, size=16)
      @@font_cache[fname] ||= {}
      @@font_cache[fname][size] ||= SDL::TTF.open(fpath, size)
      return @@font_cache[fname][size]
    end

    def init_height
      @line_skip = @font.line_skip
      @height    = @font.height
      @ascent    = @font.ascent
      @descent   = @font.descent
    end

    protected :init_height

    def initialize(fname, size=16)
      @size = size
      @col = [255, 255, 255]
      @fname = ""
      @font = nil
      @fname = fname
      @fpath = Font.findFontPath(@fname)
      raise MiyakoError.new("Cannot Find Font! : #{@fname}") unless @fpath
      @font = Font.get_font_inner(@fname, @fpath, @size)
      init_height
    end

    def size=(sz)
      @size = sz
      @font = Font.get_font_inner(@fname, @fpath, @size)
      init_height
    end

    def textSize(str)
      @font.textSize(str.toutf8())
    end

    def setColor(c)
      @col = Color.to_rgb(c)
    end

    def getColor
      @col
    end

    def _drawText(dst, str, x, y, c, s)
      xx = x
      maxh = @line_skip
      if s != 0
        maxh = s if s > maxh
        @font.drawSolidUTF8(dst, str, xx, y, c[0], c[1], c[2])
        xx = xx + @font.textSize(str)[0]
      end
      [xx, maxh]
    end

    def get_offset_x_center(width, length)
      return (width - length) / 2
    end

    def get_offset_x_right(width, length)
      return width - length
    end

    def get_offset_y_middle(height, size)
      return (height - size + 1) / 2
    end

    def get_offset_y_bottom(height, size)
      return height - size
    end

    def get_offset_x(layout_x, row)
      return 0 if layout_x == :left
      return instance_eval("get_offset_x_"+layout_x[0].id2name+"("+layout_x[1].to_s+","+layout_x[2][row].to_s+")")
    end

    def get_offset_y(layout_y, row, size)
      return 0 if layout_y == :top
      return instance_eval("get_offset_y_"+layout_y[0].id2name+"("+layout_y[1][row].to_s+","+size.to_s+")")
    end

    def drawText_with_layout(dst, str, x=0, y=0, sp=0, layout_x = :left, layout_y = :top)
      str = Yuki::Compiler.compile(str, false) if str.class == String
      l = ""
      row = 0
      xp = x + get_offset_x(layout_x, row)
      yp = y
      c = @col
      sz = @line_skip
      offset_y = get_offset_y(layout_y, row, sz)
      str.each{|s|
        if s.code == Yuki::Direction::CHAR
          l = l + s.data
        elsif s.code == Yuki::Direction::CR
          xp, hh = _drawText(dst, l, xp, yp + offset_y, c, sz)
          l = ""
          row += 1
          xp = x + get_offset_x(layout_x, row)
          yp = yp + hh + sp
        elsif s.code == Yuki::Direction::FONTCOLOR
          xp, hh = _drawText(dst, l, xp, yp + offset_y, c, sz)
          c = s.data
          l = ""
        elsif s.code == Yuki::Direction::FONTSIZE
          xp, hh = _drawText(dst, l, xp, yp + offset_y, c, sz)
          self.size = s.data
          sz = @line_skip
          offset_y = get_offset_y(layout_y, row, sz)
          l = ""
        end
      }
      xp, hh = _drawText(dst, l, xp, yp + offset_y, c, sz) if l != ""
       [xp, yp]
    end

    def drawText(dst, str, x=0, y=0, sp=0)
      str = Yuki::Compiler.compile(str, false) if str.class == String
      l = ""
      xp = x
      yp = y
      c = @col
      sz = @line_skip
      str.each{|s|
        if s.code == Yuki::Direction::CHAR
          l = l + s.data
        elsif s.code == Yuki::Direction::CR
          xp, hh = _drawText(dst, l, xp, yp, c, sz)
          l = ""
          xp = x
          yp = yp + hh + sp
        elsif s.code == Yuki::Direction::FONTCOLOR
          xp, hh = _drawText(dst, l, xp, yp, c, sz)
          c = s.data
          l = ""
        elsif s.code == Yuki::Direction::FONTSIZE
          xp, hh = _drawText(dst, l, xp, yp, c, sz)
          self.size = s.data
	  sz = @line_skip
          l = ""
        elsif s.code == Yuki::Direction::LOCATE
          xp, hh = _drawText(dst, l, xp, yp, c, sz)
          xp = x + s.data[0] if s.data[0] != nil
          yp = y + s.data[1] if s.data[1] != nil
          l = ""
        end
      }
      xp, hh = _drawText(dst, l, xp, yp, c, sz) if l != ""
       [xp, yp]
    end

    def drawTextRange(dst, str, from = 0, range = 1, x=0, y=0, sp=0)
      str = Yuki::Compiler.compile(str, false) if str.class == String
      return if from >= str.size
      l = ""
      xp = x
      yp = y
      c = @col
      sz = @size
      p = from
      off = 0
      loop do
        s = str[p]
        if s.code == Yuki::Direction::CHAR
          l = l + s.data
          off += 1
        elsif s.code == Yuki::Direction::CR
          xp, hh = _drawText(dst, l, xp, yp, c, sz)
          l = ""
          xp = x
          yp = yp + hh + sp
        elsif s.code == Yuki::Direction::FONTCOLOR
          xp, hh = _drawText(dst, l, xp, yp, c, sz)
          c = s.data
          @col = c
          l = ""
        elsif s.code == Yuki::Direction::FONTSIZE
          xp, hh = _drawText(dst, l, xp, yp, c, sz)
          self.size = s.data
          sz = @line_skip
          l = ""
        elsif s.code == Yuki::Direction::LOCATE
          xp, hh = _drawText(dst, l, xp, yp, c, sz)
          xp = x + s.data[0] if s.data[0] != nil
          yp = y + s.data[1] if s.data[1] != nil
          l = ""
        end
        p += 1
        break if (range != 0 && off == range) || p == str.size
      end
      xp, hh = _drawText(dst, l, xp, yp, c, sz) if l != ""
       [xp, yp, p]
    end

    def _drawTextMild(dst, str, x, y, c, s)
      xx = x
      maxh = @line_skip
      f2 = @font
      if s != 0 && s != @line_skip
        maxh = s if s > maxh
        f2 = Font.get_font_inner(@fname, @fpath, s)
        f2.style = @style
      end
      if s < 24 # 何故か24ドット以下で表示させると文字が崩れるため
        f2.drawSolidUTF8(dst, str, xx, y, c[0], c[1], c[2])
      else
        f2.drawBlendedUTF8(dst, str, xx, y, c[0], c[1], c[2])
      end
      xx = xx + f2.textSize(str)[0]
      [xx, maxh]
    end

    def drawTextMild(dst, str, x=0, y=0, sp=0)
      if @size < 24 # 何故か24ドット以下で表示させると文字が崩れるため
        return drawText(dst, str, x, y, sp)
      end
      str = Yuki::Compiler.compile(str, false) if str.class == String
      l = ""
      xp = x
      yp = y
      c = @col
      sz = @line_skip
      str.each{|s|
        if s.code == Yuki::Direction::CHAR
          l = l + s.data
        elsif s.code == Yuki::Direction::CR
          xp, hh = _drawTextMild(dst, l, xp, yp, c, sz)
          l = ""
          xp = x
          yp = yp + hh + sp
        elsif s.code == Yuki::Direction::FONTCOLOR
          xp, hh = _drawTextMild(dst, l, xp, yp, c, sz)
          c = s.data
          l = ""
        elsif s.code == Yuki::Direction::FONTSIZE
          xp, hh = _drawTextMild(dst, l, xp, yp, c, sz)
          self.size = s.data
          sz = @line_skip
          l = ""
        elsif s.code == Yuki::Direction::LOCATE
          xp, hh = _drawTextMild(dst, l, xp, yp, c, sz)
          xp = x + s.data[0] if s.data[0] != nil
          yp = y + s.data[1] if s.data[1] != nil
          l = ""
        end
      }
      xp, hh = _drawTextMild(dst, l, xp, yp, c, sz) if l != ""
       [xp, yp]
    end

    def drawTextMildRange(dst, str, from = 0, range = 1, x=0, y=0, sp=0)
      if @size < 24 # 何故か24ドット以下で表示させると文字が崩れるため
        return drawTextRange(dst, str, from, range, x, y, sp)
      end
      str = Yuki::Compiler.compile(str, false) if str.class == String
      return if from >= str.size
      l = ""
      xp = x
      yp = y
      c = @col
      sz = @size
      p = from
      off = 0
      loop do
        s = str[p]
        if s.code == Yuki::Direction::CHAR
          l = l + s.data
          off += 1
        elsif s.code == Yuki::Direction::CR
          xp, hh = _drawTextMild(dst, l, xp, yp, c, sz)
          l = ""
          xp = x
          yp = yp + hh + sp
        elsif s.code == Yuki::Direction::FONTCOLOR
          xp, hh = _drawTextMild(dst, l, xp, yp, c, sz)
          c = s.data
          @col = c
          l = ""
        elsif s.code == Yuki::Direction::FONTSIZE
          xp, hh = _drawTextMild(dst, l, xp, yp, c, sz)
          self.size = s.data
          sz = @line_skip
          l = ""
        elsif s.code == Yuki::Direction::LOCATE
          xp, hh = _drawTextMild(dst, l, xp, yp, c, sz)
          xp = x + s.data[0] if s.data[0] != nil
          yp = y + s.data[1] if s.data[1] != nil
          l = ""
        end
        p += 1
        break if (range != 0 && off == range) || p == str.size
      end
      xp, hh = _drawTextMild(dst, l, xp, yp, c, sz) if l != ""
       [xp, yp, p]
    end

    protected :_drawText, :_drawTextMild

    Font.create_font_path_file

    @@serif_base = nil
    @@sans_serif_base = nil

    def Font::serif
      @@serif_base = @@font_base_name[Miyako::getOSName].detect{|base| Font.findFontPath(base[:serif]) }[:serif] unless @@serif_base
      return Font.new(@@serif_base)
    end

    def Font::sans_serif
      @@sans_serif_base = @@font_base_name[Miyako::getOSName].detect{|base| Font.findFontPath(base[:sans_serif]) }[:sans_serif] unless @@sans_serif_base
      return Font.new(@@sans_serif_base)
    end

    def Font::system_font
      return Font.serif
    end
  end
  
=begin
=Screenモジュール
Miyakoで表示する画面に関するモジュール
=end
  
  module Screen
    DefaultWidth = 640
    DefaultHeight = 480
    BPP = 0
    FpsMax = 1000
    WINMODES = 2
    WINDOW_MODE = 0
    FULLSCREEN_MODE = 1

    ScreenFlag = Array.new
    ScreenFlag.push(SDL::HWSURFACE | SDL::DOUBLEBUF | SDL::ANYFORMAT)
    ScreenFlag.push(SDL::ANYFORMAT | SDL::FULLSCREEN)

    def Screen::getFpsCnt
      return @@fps == 0 ? 0 : (FpsMax + (@@fps+ 1) / 2) / @@fps
    end

    @@width     = DefaultWidth
    @@height    = DefaultHeight

    @@fps = 0 # fps=0 : no-limit
    @@fpsView = false
    @@fpscnt = Screen::getFpsCnt
    @@min_interval = 5
    @@min_interval_r = @@min_interval / 1000
    @@t = 0
    @@freezing  = false
    @@x         = 0
    @@y         = 0
    @@mode      = WINDOW_MODE

    @@screen = nil

    def Screen::setScreen(f)
      return false unless SDL.checkVideoMode(@@width, @@height, BPP, f)
      @@screen = SDL.setVideoMode(@@width, @@height, BPP, f)
      return true
    end

    def Screen::setSize(w, h, f=true)
      return false unless SDL.checkVideoMode(w, h, BPP, ScreenFlag[@@mode])
      @@width     = w
      @@height    = h
      @@screen = SDL.setVideoMode(@@width, @@height, BPP, ScreenFlag[@@mode])

      @@buf = SDL::Surface.new(SDL::HWSURFACE | SDL::SRCCOLORKEY | SDL::SRCALPHA, @@width, @@height, @@screen)
      @@buf = @@buf.displayFormat

      if f
        l = Sprite.getList
        if l.length > 0
          l.each{|s|
            s.setViewPort(0, 0, @@width, @@height) 
            s.calc_layout
          }
        end
        Plane.getList.each{|p| p.reSize } if l.length > 0
        Map.getList.reverse.each{|m| m.reSize } if l.length > 0
      end
      return true
    end

    def Screen::check_mode_error
      unless Screen::setScreen(ScreenFlag[@@mode])
        print "Sorry, this system not supported display...\n";
        exit(1)
      end
    end

    def Screen::setMode(v)
      if v.to_i == WINDOW_MODE || v.to_i == FULLSCREEN_MODE
        @@mode = v.to_i
        Screen::check_mode_error
      end
    end
    
    def Screen::toggleMode
      @@mode = (@@mode + 1) % WINMODES
      Screen::check_mode_error
    end
    
    Screen::check_mode_error
    
    @@buf = SDL::Surface.new(SDL::HWSURFACE | SDL::SRCCOLORKEY | SDL::SRCALPHA, @@width, @@height, @@screen)
    @@buf = @@buf.displayFormat
    
    def Screen::fps
      @@fps
    end
    
    def Screen::fps=(val)
      @@fps = val
      @@fpscnt = @@fps == 0 ? 0 : Screen::getFpsCnt
    end
    
    def Screen::fpsView
      @@fpsView
    end
    
    def Screen::fpsView=(val)
      @@fpsView = val
    end
    
    def Screen::screen
      @@screen
    end
    
    def Screen::w
      @@width
    end
    
    def Screen::h
      @@height
    end
    
    def Screen::x
      @@x
    end
    
    def Screen::x=(v)
      @@x = v
    end
    
    def Screen::y
      @@y
    end
    
    def Screen::y=(v)
      @@y = v
    end
    
    def Screen::update_tick
      t = SDL.getTicks
      cnt = @@fpscnt - (t - @@t)
      if @@fps > 0 && cnt > 0
        sleep(cnt > @@min_interval ? cnt / 1000.0 : @@min_interval_r)
      else
        sleep(@@min_interval_r)
      end
      t = SDL.getTicks
      return t
    end
    
    def Screen::update
      t = Screen::update_tick
      unless @@freezing
        Window.getList.each{|ww| ww.drawWindow if ww }
        TextBox.getList.each{|ww| ww.drawWindow if ww }
        l = Sprite.getList
        @@buf.fillRect(0, 0, @@buf.w, @@buf.h, [0, 0, 0]) if l.length > 0
        l.each{|s|
          if s.visible
            @@buf.setClipRect(s.viewPort.x, s.viewPort.y, s.viewPort.w, s.viewPort.h)
            s.update
            if s.bitmap
              if s.effect && s.effect.effecting?
                s.effect.update(@@buf)
              elsif s.scaleX != 1.0 || s.scaleY != 1.0 || s.angle != 0
                SDL.transformBlit(s.bitmap, @@buf, s.angle, s.scaleX, s.scaleY, s.centerX * s.scaleX, s.centerY * s.scaleY, s.x + s.centerX * s.scaleX, s.y + s.centerY * s.scaleY, 0)
              else
               SDL.blitSurface(s.bitmap, s.ox, s.oy, s.ow, s.oh, @@buf, s.x, s.y)
              end
            end
            if s.font && s.textVisible && s.text && s.text != ""
              x = s.x+s.textMarginLeft+s.locateX
              y = s.y+s.textMarginTop+s.locateY
              @@buf.setClipRect(x, y, s.textAreaW-s.textMarginLeft-s.textMarginRight, s.textAreaH-s.textMarginTop-s.textMarginBottom)
              s.nowLocateX, s.nowLocateY = s.font.drawTextMild(@@buf, s.msg, x, y, 0)
            end
            if s.drawBlock
              @@buf.lock
              s.drawBlock.call(@@buf)
              @@buf.unlock
            end
          elsif s.effect && s.effect.effecting?
            s.effect.update(@@buf)
          end
          @@buf.setClipRect(0, 0, @@width, @@height)
          @@screen.setClipRect(0, 0, @@width, @@height)
        }
      end
      SDL.blitSurface(@@buf, 0, 0, 0, 0, @@screen, @@x, @@y)
      Font.systemFont.drawText(@@screen, ((FpsMax/(t - @@t)).to_s() + " fps"), 0, 0, 0) if @@fpsView
      @@t = t
      @@screen.flip
      @@screen.fillRect(0,0,@@screen.w,@@screen.h,[0,0,0])
    end
    
    def Screen::freeze
      @@freezing = true
    end
    
    def Screen::freezing?
      @@freezing
    end
    
    def Screen::trasition
      @@freezing = false
    end
  end

=begin
=WaitCounterクラス
=end

  class WaitCounter # Time to Count
    SECOND2TICK = 1000

    def WaitCounter.get_second_to_tick(s)
      return (SECOND2TICK * s).to_i
    end
    
    def initialize(seconds)
      @seconds = seconds
      @wait = WaitCounter.get_second_to_tick(@seconds)
      @st = 0
      @counting = false
    end
    
    def start
      @st = SDL.getTicks
      @counting = true
    end

    def stop
      @counting = false
      @st = 0
    end

    def wait_inner(f)
      return !f unless @counting
      t = SDL.getTicks
      return f unless (t - @st) >= @wait
      @counting = false
      return !f
    end

    def waiting?
      return wait_inner(true)
    end

    def finish?
      return wait_inner(false)
    end

    def wait
      st = SDL.getTicks
      t = SDL.getTicks
      until (t - st) >= @wait do
        t = SDL.getTicks
      end
    end
  end

=begin
=Bitmapクラス
画像領域を示すクラス。スプライトもこのBitmapを使用して貼り付ける
実際はSDL::Surfaceクラスを継承したものなので、SDL::Surfaceクラスで定義されている描画命令を全てサポートする。
但し、実装は後述のSprite.drawBlockプロパティにブロックとして登録した方が危険性が少ない
=end

  class Bitmap < SDL::Surface
    def Bitmap.create(w, h)
      SDL::Surface.new(SDL::HWSURFACE | SDL::SRCCOLORKEY | SDL::SRCALPHA, w, h, Screen::screen)
    end
  end

=begin
=Inputモジュール
Miyakoで使用している入力デバイス情報を管理しているモジュール
=end

  module Input
    DIRS  = 4
    BTNS  = 12
    DOWN  = 0
    LEFT  = 1
    RIGHT = 2
    UP    = 3
    BTN1  = 4
    BTN2  = 5
    BTN3  = 6
    BTN4  = 7
    BTN5  = 8
    BTN6  = 9
    BTN7  = 10
    BTN8  = 11
    BTN9  = 12
    BTN10 = 13
    BTN11 = 14
    BTN12 = 15
    
    @@joy = nil
    @@joy = SDL::Joystick.open(0) if SDL::Joystick.num >= 1
    @@quit = false
    @@exbtn = [:spc, :ent, :esc, :alt, :ctl, :sft]
    @@sym2btn = Hash[SDL::Key::SPACE, :spc, SDL::Key::RETURN, :ent, SDL::Key::ESCAPE, :esc]
    @@mod2btn = Hash[SDL::Key::MOD_LALT, :alt, SDL::Key::MOD_RALT, :alt, SDL::Key::MOD_LCTRL, :ctl, SDL::Key::MOD_RCTRL, :ctl, SDL::Key::MOD_LSHIFT, :sft, SDL::Key::MOD_RSHIFT, :sft]
    @@trigger    = Hash.new
    @@pushed     = Hash.new
    @@pushed_pre = Hash.new
    @@exbtn.each{|b|
      @@trigger[b] = false
      @@pushed[b] = false
      @@pushed_pre[b] = false
    }
    @@trigger_dir = [0, 0, 0, 0]
    @@trigger_btn = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @@pushed_dir = [0, 0, 0, 0]
    @@pushed_btn = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @@pushed_dir_pre = [0, 0, 0, 0]
    @@pushed_btn_pre = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @@btn_list = [SDL::Key::Z, SDL::Key::X, SDL::Key::C,
                  SDL::Key::A, SDL::Key::S, SDL::Key::D,
                  SDL::Key::Q, SDL::Key::W, SDL::Key::E,
                  SDL::Key::V, SDL::Key::B, SDL::Key::N]
    @@dir_list = [SDL::Key::KP2, SDL::Key::KP4, SDL::Key::KP6, SDL::Key::KP8]
    @@dir_list2 = [SDL::Key::DOWN, SDL::Key::LEFT, SDL::Key::RIGHT, SDL::Key::UP]
    @@move_amount_x = [0, -1, 1, 0]
    @@move_amount_y = [1, 0, 0, -1]
    @@input2num = {:down=>0x000001, :left=>0x000002,:right=>0x000004,   :up=>0x000008,
                   :btn1=>0x000010, :btn2=>0x000020, :btn3=>0x000040, :btn4=>0x000080,
                   :btn5=>0x000100, :btn6=>0x000200, :btn7=>0x000400, :btn8=>0x000800,
                   :btn9=>0x001000,:btn10=>0x002000,:btn11=>0x004000,:btn12=>0x008000,
                    :spc=>0x010000,  :ent=>0x020000,  :esc=>0x040000,  :alt=>0x080000,
                    :ctl=>0x100000}
    @@pushed_bitmap = 0
    @@trigger_bitmap = 0

    def Input::set_btn(n)
      @@trigger_btn[n] = 1
      if @@pushed_btn_pre[n] == 0
        @@pushed_btn[n] = 1
        @@pushed_btn_pre[n] = 1
      end
    end

    def Input::reset_btn(n)
      @@trigger_btn[n] = 0
      @@pushed_btn[n] = 0
      @@pushed_btn_pre[n] = 0
    end

    def Input::set_dir(n)
      @@trigger_dir[n] = 1
      if @@pushed_dir_pre[n] == 0
        @@pushed_dir[n] = 1
        @@pushed_dir_pre[n] = 1
      end
    end
    
    def Input::reset_dir(n)
      @@trigger_dir[n] = 0
      @@pushed_dir[n] = 0
      @@pushed_dir_pre[n] = 0
    end
    
    def Input::set_ex(n)
      @@trigger[n] = true
      if @@pushed_pre[n] == false
        @@pushed[n] = true
        @@pushed_pre[n] = true
      end
    end
    
    def Input::reset_ex(n)
      @@trigger[n] = false
      @@pushed[n] = false
      @@pushed_pre[n] = false
    end
    
    def Input::array_to_bitmap(array)
      return array.inject(0){|r, i| r |= i << array.length; r >>= 1 }
    end
    
    def Input::set_bitmap(dir, btn, ext)
      b = array_to_bitmap(dir)
      b |= array_to_bitmap(btn) << 4
      [:spc, :ent, :esc, :alt, :ctl].each{|e| b |= @@input2num[e] if ext[e] }
      return b
    end
    
    def Input::update
      SDL::Joystick.updateAll
      @@pushed_btn_pre.each_with_index{|p, i| @@pushed_btn[i] = 0 if p == 1 }
      @@pushed_dir_pre.each_with_index{|p, i| @@pushed_dir[i] = 0 if p == 1 }
      @@exbtn.each{|b| @@pushed[b] = false if @@pushed_pre[b] }
      while e = SDL::Event2.poll
        case e
        when SDL::Event2::Quit
          @@quit = true
        when SDL::Event2::KeyDown
          @@btn_list.length.times{|b| set_btn(b) if e.sym == @@btn_list[b] }
          @@dir_list.length.times{|d| set_dir(d) if e.sym == @@dir_list[d] }
          @@dir_list2.length.times{|d| set_dir(d) if e.sym == @@dir_list2[d] }
          @@sym2btn.keys.each{|s| set_ex(@@sym2btn[s]) if e.sym == s }
          @@mod2btn.keys.each{|m| set_ex(@@mod2btn[m]) if e.mod & m == m}
        when SDL::Event2::KeyUp
          @@btn_list.length.times{|b| reset_btn(b) if e.sym == @@btn_list[b] }
          @@dir_list.length.times{|d| reset_dir(d) if e.sym == @@dir_list[d] }
          @@dir_list2.length.times{|d| reset_dir(d) if e.sym == @@dir_list2[d] }
          @@sym2btn.keys.each{|s| reset_ex(@@sym2btn[s]) if e.sym == s }
          @@mod2btn.keys.each{|m| reset_ex(@@mod2btn[m]) if e.mod & m == m }
        when SDL::Event2::JoyAxis
          if e.axis == 0
            if e.value >= 16384
              set_dir(2)
            elsif e.value < -16384
              set_dir(1)
            else
              reset_dir(1)
              reset_dir(2)
            end
          elsif e.axis == 1
            if e.value >= 16384
              set_dir(0)
            elsif e.value < -16384
              set_dir(3)
            else
              reset_dir(0)
              reset_dir(3)
            end
          end
        when SDL::Event2::JoyButtonDown
          set_btn(e.button) if e.button < @@trigger_btn.length
        when SDL::Event2::JoyButtonUp
          reset_btn(e.button) if e.button < @@trigger_btn.length
        when SDL::Event2::Quit
          @@quit = true
        end
        if @@trigger[:alt] && @@pushed[:ent]
          Screen.toggleMode
        end
      end
      @@trigger_bitmap = set_bitmap(@@trigger_dir, @@trigger_btn, @@trigger)
      @@pushed_bitmap = set_bitmap(@@pushed_dir, @@pushed_btn, @@pushed)
    end
    
    def Input::trigger?(num)
      return @@trigger_btn[num - DIRS] == 1 if num >= DIRS
      return @@trigger_dir[num] == 1
    end
    
    def Input::pushed?(num)
      return @@pushed_btn[num - DIRS] == 1 if num >= DIRS
      return @@pushed_dir[num] == 1
    end
    
    def Input::buttons_to_bitmap(inputs)
      return inputs.flatten.inject(0){|r, i| r |= @@input2num[i]}
    end

    def Input::trigger_all?(*inputs)
      return @@trigger_bitmap != 0 if inputs.length == 0
      f = buttons_to_bitmap(inputs)
      return @@trigger_bitmap & f == f
    end
    
    def Input::trigger_any?(*inputs)
      return @@trigger_bitmap != 0 if inputs.length == 0
      f = buttons_to_bitmap(inputs)
      return @@trigger_bitmap & f != 0
    end
    
    def Input::pushed_all?(*inputs)
      return @@pushed_bitmap != 0 if inputs.length == 0
      f = buttons_to_bitmap(inputs)
      return @@pushed_bitmap & f == f
    end
    
    def Input::pushed_any?(*inputs)
      return @@pushed_bitmap != 0 if inputs.length == 0
      f = buttons_to_bitmap(inputs)
      return @@pushed_bitmap & f != 0
    end
    
    def Input::triggerDirNum
      4.times{|d| return d if @@trigger_dir[d] == 1 }
      return -1
    end
    
    def Input::pushedDirNum
      4.times{|d| return d if @@pushed_dir[d] == 1 }
      return -1
    end
    
    def Input::triggerAmount
      amt_x = 0
      amt_y = 0
      @@trigger_dir.length.times{|n|
        amt_x = amt_x + @@trigger_dir[n] * @@move_amount_x[n]
        amt_y = amt_y + @@trigger_dir[n] * @@move_amount_y[n]
      }
      return [amt_x, amt_y]
    end
    
    def Input::pushedAmount
      amt_x = 0
      amt_y = 0
      @@pushed_dir.length.times{|n|
        amt_x = amt_x + @@pushed_dir[n] * @@move_amount_x[n]
        amt_y = amt_y + @@pushed_dir[n] * @@move_amount_y[n]
      }
      return [amt_x, amt_y]
    end
    
    def Input::amountX(dir)
      return @@move_amount_x[dir]
    end
    
    def Input::amountY(dir)
      return @@move_amount_y[dir]
    end
    
    def Input::triggerDir
      return @@trigger_dir
    end
    
    def Input::pushedDir
      return @@pushed_dir
    end
    
    def Input::triggerBtn
      return @@trigger_btn
    end
    
    def Input::pushedBtn
      return @@pushed_btn
    end
    
    def Input::triggerSpc?
      return @@trigger[:spc]
    end
    
    def Input::triggerEnter?
      return @@trigger[:ent]
    end
    
    def Input::triggerEscape?
      return @@trigger[:esc]
    end
    
    def Input::triggerAlt?
      return @@trigger[:alt]
    end
    
    def Input::triggerCtrl?
      return @@trigger[:ctl]
    end
    
    def Input::triggerShift?
      return @@trigger[:sft]
    end
    
    def Input::pushedSpc?
      return @@pushed[:spc]
    end
    
    def Input::pushedEnter?
      return @@pushed[:ent]
    end
    
    def Input::pushedEscape?
      return @@pushed[:esc]
    end
    
    def Input::pushedAlt?
      return @@pushed[:alt]
    end
    
    def Input::pushedCtrl?
      return @@pushed[:ctl]
    end
    
    def Input::pushedShift?
      return @@pushed[:sft]
    end
    
    def Input::quit?
      return @@quit
    end
  end
  
=begin
=Audioモジュール
音楽関連のモジュール
==Audio::BGMクラス
BGMを管理するクラス
==Audio::SEクラス
効果音を管理するクラス。
=end
  
  module Audio
    class BGM
      def initialize(fname, loops = true)
        @bgm = SDL::Mixer::Music.load(fname)
        @loops = loops
      end
      
      def setVolume(v)
        SDL::Mixer.setVolumeMusic(v)
      end
      
      def play
        l = @loops ? -1 : 0
        SDL::Mixer.playMusic(@bgm, l).to_s()
      end
      
      def fadeIn(msec=5000)
        l = @loops ? -1 : 0
        SDL::Mixer.fadeInMusic(@bgm, l, msec)
      end
      
      def playing?
        SDL::Mixer.playMusic?
      end
      
      def pause
        SDL::Mixer.pauseMusic if SDL::Mixer.playMusic?
     end
      
      def resume
        SDL::Mixer.resumeMusic if SDL::Mixer.pauseMusic?
      end
      
      def stop
        SDL::Mixer.haltMusic if SDL::Mixer.playMusic?
      end
      
      def fadeOut(msec = 5000, wmode = false)
        if SDL::Mixer.playMusic?
          SDL::Mixer.fadeOutMusic(msec)
          SDL::delay(msec) if wmode
        end
      end
    end
    
    class SE
      def initialize(fname)
        @wave = SDL::Mixer::Wave.load(fname)
        @channel = -1
      end
      
      def play
        @channel = SDL::Mixer.playChannel(-1, @wave, 0)
      end
      
      def playing?
        return SDL::Mixer.play?(@channel) if @channel != -1
        return false
      end
      
      def stop
        SDL::Mixer.halt(@channel) if @channel != -1
      end
      
      def setVolume(v)
        @wave.setVolume(v)
      end
    end
  end

  def Miyako::update
    Input::update
    Screen::update
  end

=begin
=Spriteクラス
スプライト全般を管理するクラス
=end

  class Sprite
    extend Forwardable
    attr_accessor :ox, :oy, :visible, :angle, :centerX, :centerY
    attr_accessor :textAreaW, :textAreaH
    attr_accessor :font, :drawBlock, :textVisible
    attr_accessor :nowLocateX, :nowLocateY, :effect
    attr_reader :x, :y, :ow, :oh
    attr_reader :dp, :id, :alpha, :scaleX, :scaleY
    attr_reader :textMarginLeft, :textMarginTop, :textMarginRight, :textMarginBottom
    attr_reader :locateX, :locateY, :msg, :tr_color

    @@sprites = SpriteList.new
    @@idcnt = 1

    @@draw_list = {:line => {:normal=>"@img.draw_line", :fill=>"@img.draw_line"},
                   :rect => {:normal=>"@img.draw_rect", :fill=>"@img.fill_rect"},
                   :circle => {:normal=>"@img.draw_circle", :fill=>"@img.draw_filled_circle"},
                   :ellipse => {:normal=>"@img.draw_ellipse", :fill=>"@img.draw_filled_ellipse"}}

    def setup
      @img=nil
      @viewport = Rect.new(0, 0, Screen.w, Screen.h)
      @ow = 0
      @oh = 0
      @alpha = 255
      @aa = false
      @tr_color = Color::BLACK
      @angle = 0
      @scaleX = 1.0
      @scaleY = 1.0
      @font = nil
      @msg = Yuki::Scenario.new()
      @drawBlock = nil
      @update = nil
      @effect = nil
      @x = 0
      @y = 0
      @w = 0
      @h = 0
      @dp = 0
      @ox = 0
      @oy = 0
      @centerX = 0
      @centerY = 0
      @collisionX = 0
      @collisionY = 0
      @collisionW = 0
      @collisionH = 0
      @textAreaW = 0
      @textAreaH = 0
      @textMarginLeft = 0
      @textMarginTop = 0
      @textMarginRight = 0
      @textMarginBottom = 0
      @locateX = 0
      @locateY = 0
      @nowLocateX = 0
      @nowLocateY = 0
      @visible = false
      @textVisible = false
      @enable_layout = true
      @layoutX  = :left
      @layoutY  = :top
      @layoutXi = 0
      @layoutYi = 0
      @layoutXf = 0.0
      @layoutYf = 0.0
      @base_x = 0
      @base_y = 0
      @base_width = nil
      @base_height = nil
      @layout_offset_x = 0
      @layout_offset_y = 0
      @layout_side_x = :inside
      @layout_side_y = :inside
      @snap_sprite = nil
      @snap_children = Array.new
    end

    protected :setup

    def initialize(img_data, tr_data = Color::BLACK, alpha = 255, is_fill = false)
      setup()

      bitmap = nil
      
      if img_data.kind_of?(Size)
        bitmap = Bitmap.create(img_data.w, img_data.h)
        is_fill = true
      elsif img_data.kind_of?(Array)
        bitmap = Bitmap.create(img_data[0], img_data[1])
        is_fill = true
      elsif img_data.kind_of?(SDL::Surface)
        bitmap = img_data
      elsif img_data.kind_of?(String)
        bitmap = Bitmap.load(img_data)
        tr_data = Point.new(0, 0) if tr_data
      else
        raise MiyakoError.new("Illegal Sprite parameter!")
      end

      @tr_color = nil

      if tr_data.class == Point
        @tr_color = Color.to_rgb(bitmap.getPixel(tr_data.x, tr_data.y))
      elsif tr_data
        @tr_color = Color.to_rgb(tr_data)
      end
      bitmap.fill_rect(0, 0, bitmap.w, bitmap.h, @tr_color) if @tr_color && is_fill
      bitmap.setColorKey(SDL::SRCCOLORKEY|SDL::RLEACCEL, @tr_color) if tr_data
      bitmap.setAlpha(SDL::SRCALPHA|SDL::RLEACCEL, alpha)
      self.bitmap = bitmap.displayFormat
      self.alpha  = alpha

      @id = @@idcnt
      @@idcnt = @@idcnt + 1
      @@sprites.add(self)
    end

    def Sprite.create_plane(bmp, w, h, tr_data=[0,0,0], alpha=255)
      img=Bitmap.create(w, h)
      (h / bmp.h).times{|y|
        (w / bmp.w).times{|x|
          SDL.blitSurface(bmp, 0, 0, 0, 0, img, x * bmp.w, y * bmp.h)
        }
      }
      spr = Sprite.new(img, tr_data, alpha)
      spr.ow = Screen::screen.w
      spr.oh = Screen::screen.h
      return spr
    end

    def crate_transform_sprite(xscale, yscale, angle)
      return Sprite.new(@img.transformSurface(org_spr.tr_color,angle,xscale,yscale,SDL::TRANSFORM_AA), @tr_color, @alpha)
    end

    def_delegators(:@img, :w, :h)

    def x=(v)
      @x = v
      @enable_layout = false
    end

    def y=(v)
      @y = v
      @enable_layout = false
    end

    def scaleX=(v)
      @scaleX = v.to_f()
    end

    def scaleY=(v)
      @scaleY = v.to_f()
    end

    def bitmap
      @img
    end

    def bitmap=(bmp)
      @img = bmp
      @ow = @img.w
      @oh = @img.h
      @w = @img.w
      @h = @img.h
      @collisionW = @ow
      @collisionH = @oh
    end

    def draw_line(rect, color, attribute = :normal)
      instance_eval(@@draw_list[:line][attribute]+"("+rect.to_s+","+Color.to_s(color)+")") if @@draw_list[:line][attribute]
    end

    def draw_rect(rect, color, attribute = :normal)
      instance_eval(@@draw_list[:rect][attribute]+"("+rect.to_s+","+Color.to_s(color)+")") if @@draw_list[:rect][attribute]
    end

    def draw_circle(point, r, color, attribute = :normal)
      instance_eval(@@draw_list[:circle][attribute]+"("+point.to_s+","+r.to_s+","+Color.to_s(color)+")") if @@draw_list[:circle][attribute]
    end

    def draw_ellipse(rect, color, attribute = :normal)
      instance_eval(@@draw_list[:ellipse][attribute]+"("+rect.to_s+","+Color.to_s(color)+")") if @@draw_list[:ellipse][attribute]
    end

    def draw_text(str, x = 0, y = 0, sp = 0)
      raise MiyakoError.new("Sprite object is not regist font!") unless @font
      @font.drawTextMild(self.bitmap, str, x, y, sp)
    end

    def alpha=(val)
      @alpha = val
      @img.setAlpha(SDL::SRCALPHA|SDL::RLEACCEL, @alpha)
    end

    def dp=(val)
      odp = @dp
      @dp = val
      @@sprites.replaceDp(self, odp)
    end

    def ow=(v)
      @ow = v
      @collisionW = @ow
    end

    def oh=(v)
      @oh = v
      @collisionH = @oh
    end

    def get_base_x
      return @base_width == nil ? 0 : @base_x
    end

    def get_base_y
      return @base_height == nil ? 0 : @base_y
    end

    def get_base_width
      return @base_width == nil ? Screen.w : @base_width
    end

    def get_base_height
      return @base_height == nil ? Screen.h : @base_height
    end

    def layout_left_inside
      return get_base_x + (get_base_width * @layoutXf + @layoutXi).to_i + @layout_offset_x
    end

    def layout_center_inside
      return get_base_x + ((get_base_width - @ow) / 2 + @layoutXi).to_i + @layout_offset_x
    end

    def layout_right_inside
      return get_base_x + (get_base_width * (1.0 - @layoutXf) - @layoutXi - @ow).to_i + @layout_offset_x
    end

    def layout_top_inside
      return get_base_y + (get_base_height * @layoutYf + @layoutYi).to_i + @layout_offset_y
    end

    def layout_middle_inside
      return get_base_y + ((get_base_height - @oh) / 2 + @layoutYi).to_i + @layout_offset_y
    end

    def layout_bottom_inside
      return get_base_y +  (get_base_height * (1.0 - @layoutYf) - @layoutYi - @oh).to_i + @layout_offset_y
    end

    def layout_left_outside
      return get_base_x - (get_base_width * @layoutXf + @layoutXi).to_i - @ow + @layout_offset_x
    end

    def layout_center_outside
      return get_base_x + (get_base_width / 2 + @layoutXi).to_i + @layout_offset_x
    end

    def layout_right_outside
      return get_base_x + get_base_width + (get_base_width * @layoutXf + @layoutXi).to_i + @layout_offset_x
    end

    def layout_top_outside
      return get_base_y - (get_base_height * @layoutYf + @layoutYi).to_i - @oh + @layout_offset_y
    end

    def layout_middle_outside
      return get_base_y + (get_base_height / 2 + @layoutYi).to_i + @layout_offset_y
    end

    def layout_bottom_outside
      return get_base_y + get_base_height + (get_base_height * @layoutYf + @layoutYi).to_i + @layout_offset_y
    end

    def calc_layout
      return unless @enable_layout
      instance_eval("@x = layout_"+@layoutX.id2name+"_"+@layout_side_x.id2name)
      instance_eval("@y = layout_"+@layoutY.id2name+"_"+@layout_side_y.id2name)
      @snap_children.each{|sc|
        sc.snap
      }
    end

    protected :layout_left_inside, :layout_right_inside, :layout_center_inside
    protected :layout_top_inside, :layout_middle_inside, :layout_bottom_inside
    protected :layout_left_outside, :layout_right_outside, :layout_center_outside
    protected :layout_top_outside, :layout_middle_outside, :layout_bottom_outside
    protected :get_base_width, :get_base_height
    protected :get_base_x, :get_base_y

    @@layout_list_x = [:left, :center, :right]
    @@layout_list_y = [:top, :middle, :bottom]
    @@layout_side_list = [:inside, :outside]

    def set_side_x(xside)
      @layout_side_x = xside if @@layout_side_list.include?(xside)
    end

    def set_side_y(yside)
      @layout_side_y = yside if @@layout_side_list.include?(yside)
    end

    def set_side(xside, yside)
      set_side_x(xside)
      set_side_y(yside)
      calc_layout
    end
    
    def get_side
      [@layout_side_x, @layout_side_y]
    end

    def set_base_size(w, h)
      @base_width, @base_height = [w, h]
      calc_layout
    end

    def reset_base_size
      @base_width, @base_height = [nil, nil]
      calc_layout
    end

    def set_base_point(x, y)
      @base_x = x if x != nil
      @base_y = y if y != nil
      calc_layout
    end

    def snap(spr = nil)
      unless spr == nil
        @snap_sprite.delete_snap_child(self) unless @snap_sprite == nil
        @snap_sprite = spr
        spr.add_snap_child(self)
      end
      @base_x, @base_y, @base_width, @base_height = @snap_sprite.rect.rect unless @snap_sprite == nil
      calc_layout
    end
    
    def reset_snap
      @snap_sprite = nil
      @snap_children = Array.new
      calc_layout
    end
    
    def add_snap_child(spr)
      @snap_children.push(spr) unless @snap_children.include?(spr)
      calc_layout
    end
    
    def delete_snap_child(spr)
      @snap_children.delete(spr) if @snap_children.include?(spr)
      calc_layout
    end
    
    def get_snap_children
      return @snap_children
    end

    def set_snap_children(cs)
      @snap_children.each{|c|
        c.set_snap_sprite(nil)
      }
      @snap_children = cs
      @snap_children.each{|c|
        c.set_snap_sprite(self)
      }
      calc_layout
    end

    def get_snap_sprite
      return @snap_sprite
    end

    def set_snap_sprite(ss)
      @snap_sprite.delete_snap_child(self) unless @snap_sprite == nil
      @snap_sprite = ss
      @snap_sprite.add_snap_child(self) unless @snap_sprite == nil
      calc_layout
    end

    def set_base(x, y, w, h)
      @base_x       = x if x != nil
      @base_y       = y if y != nil
      @base_width  = w if w != nil
      @base_height = h if h != nil
      calc_layout
    end

    def reset_base
      @base_x, @base_y, @base_width, @base_height = [0, 0, nil, nil]
      calc_layout
    end
    
    def get_base
      return [@base_x, @base_y, @base_w, @base_h]
    end

    def set_offset_x(x)
      @layout_offset_x = x
      calc_layout
    end

    def set_offset_y(y)
      @layout_offset_y = y
      calc_layout
    end

    def set_offset(x, y)
      set_offset_x(x) if x != nil
      set_offset_y(y) if y != nil
    end

    def get_offset_x
      return @layout_offset_x
    end

    def get_offset_y
      return @layout_offset_y
    end

    def get_offset
      return [get_offset_x, get_offset_y]
    end

    def reset_offset
      @layout_offset_x = 0
      @layout_offset_y = 0
      calc_layout
    end

    def enable_layout
      @enable_layout = true
      calc_layout
    end

    def enable_layout?
      return @enable_layout
    end
    
    def disenable_layout
      @enable_layout = false
    end

    def set_layout(x, y)
      if x.class == Symbol
        @layoutX = x
        @layoutXi, @layoutXf = [0, 0.0]
      elsif x.class == Array
        x.each{|v|
          @layoutX  = v if v.kind_of?(Symbol) && @@layout_list_x.include?(v)
          @layout_side_x = v if v.kind_of?(Symbol) && @@layout_side_list.include?(v)
          @layoutXi = v if v.kind_of?(Integer)
          @layoutXf = v if v.kind_of?(Float)
        }
      end
      if y.class == Symbol
        @layoutY = y
        @layoutYi, @layoutYf = [0, 0.0]
      elsif y.class == Array
        y.each{|v|
          @layoutY  = v if v.kind_of?(Symbol) && @@layout_list_y.include?(v)
          @layout_side_y = v if v.kind_of?(Symbol) && @@layout_side_list.include?(v)
          @layoutYi = v if v.kind_of?(Integer)
          @layoutYf = v if v.kind_of?(Float)
        }
      end
      @enable_layout = true
      calc_layout
    end
    
    def reset_layout
      @layoutX, @layoutXi, @layoutXf = [:left, 0, 0.0]
      @layoutY, @layoutXi, @layoutXf = [:top, 0, 0.0]
      reset_base
      reset_offset
    end

    def get_layout_x
      [@layoutX, @layoutXf, @layoutXi]
    end

    def get_layout_y
      [@layoutY, @layoutYf, @layoutYi]
    end

    def get_layout
      [get_layout_x, get_layout_y]
    end

    def centering
      set_layout(:center, :middle)
    end

    def move(x, y)
      if @enable_layout
        @layout_offset_x += x
        @layout_offset_y += y
        calc_layout
      else
        @x += x
        @y += y
      end
    end

    def move_to(x, y)
      move(x - @x, y - @y)
    end

    def setCollisionMargin(x, y, w, h)
      @collisionX = x
      @collisionY = y
      @collisionW = w
      @collisionH = h
    end

    def getCollisionMargin
      Rect.new(@x + @collisionX, @y + @collisionY, @collisionW, @collisionH)
    end

    def viewPort
      @viewport
    end

    def setViewPort(x, y, w, h)
      @viewport = Rect.new(x, y, w, h)
    end

    def in_bounds?(dx, dy, flag = true)
      return [in_bounds_x?(dx, flag), in_bounds_y?(dy, flag)]
    end

    def in_bounds_x?(dx, flag = true)
      nx = @x + dx
      return false if flag & (nx == @viewport.x | ((nx + @ow) == (@viewport.x + @viewport.w)))
      return nx > @viewport.x & (nx + @ow) < (@viewport.x + @viewport.w)
    end

    def in_bounds_y?(dy, flag = true)
      ny = @y + dy
      return false if flag & (ny == @viewport.y | ((ny + @oh) == (@viewport.y + @viewport.h)))
      return ny > @viewport.y & (ny + @oh) < (@viewport.y + @viewport.h)
    end

    def in_bounds_ex?(dx, dy, flag = true)
      return [in_bounds_ex_x?(dx, flag), in_bounds_ex_y?(dy, flag)]
    end

    def in_bounds_ex_x?(dx, flag = true)
      nx = @x + dx
      return -1 if (nx < @viewport.x) | (flag & (nx == @viewport.x))
      r = @viewport.x + @viewport.w
      return 1 if ((nx + @ow) > r) | (flag & ((nx + @ow) == r))
      return 0
    end

    def in_bounds_ex_y?(dy, flag = true)
      ny = @y + dy
      return -1 if (ny < @viewport.y) | (flag & (ny == @viewport.y))
      b = @viewport.y + @viewport.h
      return 1 if ((ny + @oh) > b) | (flag & ((ny + @oh) == b))
      return 0
    end

    def round(dx, dy, flag = true)
      return [round_x(dx, flag), round_y(dy, flag)]
    end

    def round_x(dx, flag = true)
      fx = in_bounds_ex_x?(dx, flag)
      case fx
        when -1
          self.move_to(0, @y)
        when 0
          self.move_to(@x + dx, @y)
        when 1
          self.move_to(@viewport.x + @viewport.w - @ow, @y)
      end
      return fx
    end

    def round_y(dy, flag = true)
      fy = in_bounds_ex_y?(dy, flag)
      case fy
        when -1
          self.move_to(@x, 0)
        when 0
          self.move_to(@x, @y + dy)
        when 1
          self.move_to(@x, @viewport.y + @viewport.h - @oh)
      end
      return fy
    end

    def_delegators(:@msg, :compile, :text, :text=, :separate, :separate=)
    def_delegators(:@msg, :copy, :nextmsg, :append)
    def_delegators(:@msg, :clear, :reset, :next, :append)
    def_delegators(:@msg, :push, :pop, :[], :[]=, :length, :size, :each)

    def getDirection
      @msg
    end

    def setDirection(cx)
      @msg = cx
    end

    def setTextArea(w, h)
      @textAreaW = w
      @textAreaH = h
    end

    def textMarginLeft=(v)
      @textMarginLeft = v
    end

    def textMarginTop=(v)
      @textMarginTop = v
    end

    def textMarginRight=(v)
      @textMarginRight = v
    end

    def textMarginBottom=(v)
      @textMarginBottom = v
    end

    def setTextMargin(l, t, r, b)
      @textMarginLeft = l
      @textMarginTop = t
      @textMarginRight = r
      @textMarginBottom = b
    end

    def locateX=(x)
      @locateX = x if x != nil
    end

    def locateY=(y)
      @locateY = y if y != nil
    end

    def locate(x, y)
      @locateX = x if x != nil
      @locateY = y if y != nil
    end

    def getLocate
      [@locateX, @locateY]
    end

    def rect
      Rect.new(@x, @y, @ow, @oh)
    end

    def update
      if @update != nil
        @update.call(self)
      end
      if block_given?
        yield self
      end
    end

    def update=(u)
      @update = u
    end

    def collision?(spr)
      r1 = getCollisionMargin
      r2 = spr.getCollisionMargin
      return SDL::CollisionMap.boundingBoxCheck(r1.x, r1.y, r1.w, r1.h, r2.x, r2.y, r2.w, r2.h)
    end

    def show
      @visible = true
    end

    def hide
      @visible = false
    end

    @@backup_list = [:@x, :@y, :@enable_layout, :@layoutX, :@layoutY, :@layoutXi, :@layoutYi,
                     :@layoutXf, :@layoutYf, :@base_x, :@base_y, :@base_width, :@base_height,
                     :@layout_offset_x, :@layout_offset_y, :@layout_side_x, :@layout_side_y,
                     :@snap_sprite, :@snap_children]

    def backup
      bdata = Hash.new
      @@backup_list.each{|d| instance_eval("bdata[\""+d.id2name+"\"] = "+d.id2name) }
      return bdata
    end

    def restore(bdata)
      bdata.keys.each{|k| instance_eval(k + " = bdata[\""+k+"\"]") }
      snap(@snap_sprite) unless @snap_sprite == nil
      @snap_children.each{|c| c.snap(self) }
    end

    def dispose(delete_node = true)
      @snap_sprite.delete_snap_child(self) unless @snap_sprite == nil
      @snap_children.each{|sc| sc.reset_snap }
      @@sprites.remove(self)
      @img = nil
    end

    def Sprite::getList
      @@sprites.getList
    end
  end

  class Shape
    class ShapeParameter
      @@method_list    = [:text, :box, :roundbox, :circle, :ellipse, :arrow]
      @@dir_list       = [:left, :right, :up, :down]
      @@type_list      = [:normal, :edge, :trcolor, :layout]

      def ShapeParameter.collect_method?(m)
        return @@method_list.include?(m)
      end

      def ShapeParameter.collect_dir?(d)
        return @@dir_list.include?(d)
      end

      def ShapeParameter.collect_type?(t)
        return @@type_list.include?(t)
      end

      def initialize
        @type = nil
        @params = Hash.new
        init_type(:normal)
      end

      def init_type(t)
        @type = t
        @params[@type] = Array.new
      end

      def append(d)
        @params[@type].push(d)
      end

      def edge?
        @params.has_key?(:edge)
      end

      def trcolor?
        @params.has_key?(:trcolor)
      end

      def layout?
        @params.has_key?(:layout)
      end

      def get_param(type)
        return nil unless @params.has_key?(type)
        return @params[type]
      end
      
      def to_s
        s = ""
        @params.keys.each{|k|
          s += "#{k} : "
          @params[k].each{|v| s += "#{v} " }
          s += "\n"
        }
        return s
      end
    end

    def Shape.get_trcolor(sp)
      return sp.get_param(:trcolor)[0] if sp.trcolor?
      return Color::BLACK
    end

    def Shape.text(sp)
      p = sp.get_param(:normal)
      str, font, size, color, layout_method_x, layout_method_y = p[0..5]
      osz = font.size
      ocl = font.getColor
      sz2 = size
      font.size = size unless size == 0
      font.setColor(color) unless color == []
      sz = font.line_skip
      w = 0
      ww = 0
      h = 0
      s = nil
      m = Yuki::Scenario.new
      m.separate = false
      m.text = str
      w_list = Array.new
      h_list = Array.new
      until m.eot? do
        c = m.nextmsg
        case c.code
        when Yuki::Direction::FONTSIZE
          sz2 = c.data if c.data > sz2
          font.size = sz1
          sz = font.line_skip
          m.push(c)
        when Yuki::Direction::FONTCOLOR
          m.push(c)
        when Yuki::Direction::CR
          w_list.push(ww)
          h_list.push(sz)
          h += sz
          w = ww if ww > w
          ww = 0
          m.push(c)
        when Yuki::Direction::CHAR
          ww += font.textSize(c.data)[0]
          m.push(c)
        end
      end
      if ww != 0
        w_list.push(ww)
        h_list.push(sz)
        h += sz
        w = ww if ww > w
      end
      font.size = size unless size == 0
      font.setColor(color) unless color == []
      s = Sprite.new([w, h], get_trcolor(sp))
      layout_list_x = layout_method_x
      layout_list_y = layout_method_y
      layout_list_x = [layout_method_x, w, w_list] unless layout_method_x == :left
      layout_list_y = [layout_method_y, h_list] unless layout_method_y == :top
      font.drawText_with_layout(s.bitmap, m, 0, 0, 0, layout_list_x, layout_list_y)
      font.size = osz
      font.setColor(ocl)
      return s
    end

    def Shape.box(sp)
      p = sp.get_param(:normal)
      w, h, c = p[0..2]
      s = Sprite.new([w, h], get_trcolor(sp))
      if sp.edge?
        et, ec = sp.get_param(:edge)[0..1]
        s.bitmap.fill_rect(0, 0, w-1, h-1, ec)
        s.bitmap.fill_rect(et, et, w-et*2-1, h-et*2-1, c)
      else
        s.bitmap.fill_rect(0, 0, w-1, h-1, c)
      end
      return s
    end

    def Shape.roundbox_basic(s, x, y, w, h, r, c)
      s.bitmap.fill_rect(x, y+r, w-x*2, h-y*2-r*2, c)
      s.bitmap.fill_rect(x+r, y, w-x*2-r*2, h-x*2, c)
      s.bitmap.draw_filled_circle(r+x, r+y, r, c)
      s.bitmap.draw_filled_circle(w-r-x-1, r+y, r, c)
      s.bitmap.draw_filled_circle(r+x, h-r-y-1, r, c)
      s.bitmap.draw_filled_circle(w-r-x-1, h-r-y-1, r, c)
    end

    def Shape.roundbox(sp)
      p = sp.get_param(:normal)
      w, h, r, c = p[0..3]
      s = Sprite.new([w, h], get_trcolor(sp))
      if sp.edge?
        et, ec = sp.get_param(:edge)[0..1]
        roundbox_basic(s, 0, 0, w, h, r, ec)
        roundbox_basic(s, et, et, w, h, r, c)
      else
        roundbox_basic(s, 0, 0, w, h, r, c)
      end
      return s
    end

    def Shape.circle(sp)
      p = sp.get_param(:normal)
      r, c = p[0..1]
      s = Sprite.new([r * 2 + 1, r * 2 + 1], get_trcolor(sp))
      if sp.edge?
        et, ec = sp.get_param(:edge)[0..1]
        s.bitmap.draw_filled_circle(r, r, r, ec)
        s.bitmap.draw_filled_circle(r, r, r-et, c)
      else
        s.bitmap.draw_filled_circle(r, r, r, c)
      end
      return s
    end

    def Shape.ellipse(sp)
      p = sp.get_param(:normal)
      rx, ry, c = p[0..2]
      s = Sprite.new([rx * 2 + 1, ry * 2 + 1], get_trcolor(sp))
      if sp.edge?
        et, ec = sp.get_param(:edge)[0..1]
        s.bitmap.draw_filled_ellipse(rx, ry, rx, ry, ec)
        s.bitmap.draw_filled_ellipse(rx, ry, rx-et, ry-et, c)
      else
        s.bitmap.draw_filled_ellipse(rx, ry, rx, ry, c)
      end
      return s
    end

    def Shape.create(method, params)
      return nil unless ShapeParameter.collect_method?(method)
      shape = nil
      sp = ShapeParameter.new
      params.each{|p|
        if ShapeParameter.collect_type?(p)
          sp.init_type(p)
        else
          sp.append(p)
        end
      }
      instance_eval("shape = "+method.id2name+"(sp)")
      return shape
    end
  end

  class SpriteAnimation

    def initialize(sprite, wait = 0)
      @spr   = sprite
      @pats  = @spr.h / @spr.oh
      if wait.kind_of?(Integer)
        @waits = Array.new
        @waits.fill(wait, 0, @pats)
      elsif wait.kind_of?(Float)
        @waits = Array.new
        @waits.fill(WaitCounter.new(wait), 0, @pats)
      elsif wait.kind_of?(Array)
        @waits = wait.collect{|w| w.kind_of?(Float) ? WaitCounter.new(w) : w }
      else
        # Error!
      end
      @pats  = @waits.length if @pats > @waits.length
      @chrs  = @spr.w / @spr.ow
      @cnum  = 0
      @pnum  = 0
      @cnt   = 0
      @exec  = false
    end

    def pattern(pnum)
      @pnum = pnum if pnum < @pats
      @spr.oy = @spr.oh * @pnum
      @cnt = @waits[@pnum] if @exec
    end

    def get_pattern
      return @pnum
    end

    def character(cnum)
      @cnum = cnum if cnum < @chrs
      @spr.ox = @spr.ow * @cnum
    end

    def move_character(d)
      @cnum = (@cnum + d) % @chrs
      @cnum = @cnum + @chrs if @cnum < 0
      @spr.ox = @spr.ow * @cnum
    end

    def get_character
      return @cnum
    end

    def show
      @spr.show
    end

    def hide
      @spr.hide
    end

    def toggle_visible
      if @spr.visible
        hide
      else
        show
      end
    end

    def start
      return if @exec
      @cnt = @waits[@pnum]
      @exec = true
    end

    def stop
      return unless @exec
      @cnt.stop if @cnt.kind_of?(WaitCounter)
      @exec = false
    end

    def toggle_exec
      if @exec
        stop
      else
        start
      end
    end

    def update
      return unless @exec
      if @cnt.kind_of?(Integer)
        update_frame
      else
        update_wait_counter
      end
    end

    def update_frame
      if @cnt == 0
        @pnum = (@pnum + 1) % @pats
        @spr.oy = @spr.oh * @pnum
        @cnt = @waits[@pnum]
      else
        @cnt -= 1
      end
    end
    
    def update_wait_counter
      unless @cnt.waiting?
        @pnum = (@pnum + 1) % @pats
        @spr.oy = @spr.oh * @pnum
        @cnt = @waits[@pnum]
        @cnt.start
      end
    end

    def reset
      @pnum = 0
      @cnt  = 0
    end

    def visible?
      @spr.visible
    end

    def exec?
      @exec
    end
  end

=begin
=Effectクラス
スプライトに効果を与えるクラス(基本クラス)
=end

  class Effect
    def initialize(sspr, dspr = nil)
      @src = sspr
      @dst = dspr
      @effecting = false
      @wait = 0
      @cnt = 0
      @params = Array.new
    end
    
    def start(w, *param)
      return if @effecting
      @wait = w
      @cnt = @wait
      @param = param
      @effecting = true
    end
    
    def effecting?
      @effecting
    end
    
    def update(screen)
      @effecting = false # dummy code
    end
    
    def stop
      @effecting = false
    end
    
    def dispose
      @dst = nil
    end
  end

=begin
=Planeクラス
ビットマップイメージを敷き詰めたような表示を実装するクラス
=end

  class Plane
    extend Forwardable
    @@planes = Array.new

    def reSize
      @rw = ((Screen.w + @img.w) / @img.w + 1) * @img.w  # real width
      @rh = ((Screen.h + @img.h) / @img.h + 1) * @img.h  # real height
      v = false
      d = 0
      ox = 0
      oy = 0
      if @spr != nil
        @spr.dispose
        v = @spr.visible
        d = @spr.dp
        ox = @spr.ox
        oy = @spr.oy
      end
      @spr = Sprite.create_plane(@img, @rw, @rh, Point.new(@px, @py))
      @spr.dp = d
      @spr.ox = ox
      @spr.oy = oy
      @spr.visible = v
    end

    def initialize(fname, px = 0, py = 0)
      @img = Bitmap.load(fname)
      @px = px
      @py = py
      @rw = 0
      @rh = 0
      @spr = nil
      reSize
      @spr.dp = -1
      @x = 0
      @y = 0
      @@planes.push(self)
    end

    def x
      @x
    end

    def x=(v)
      @x = v
      @spr.ox = @x % @img.w
    end

    def y
      @y
    end

    def y=(v)
      @y = v
      @spr.oy = @y % @img.h
    end

    def drawBlock
      @drawBlock
    end

    def drawBlock=(b)
      @drawBlock = b
    end

    def dispose
      @spr.dispose
      @@planes.delete(self)
    end

    def Plane::getList
      @@planes
    end

    def_delegators(:@spr, :visible, :visible=, :dp, :dp=, :show, :hide)
  end

=begin
=WindowParameterクラス
ウィンドウ用に表示する書くグラフィックの範囲を格納するクラス
=end

  class WindowParameter # structure class
    FR_LEFT_T  = 0
    FR_TOP     = 1
    FR_RIGHT_T = 2
    FR_LEFT    = 3
    FR_RIGHT   = 4
    FR_LEFT_B  = 5
    FR_BOTTOM  = 6
    FR_RIGHT_B = 7

    def initialize(fn, lt, top, rt, left, right, lb, bottom, rb, client)
      @filename = fn
      @frame = [lt, top, rt, left, right, lb, bottom, rb]
      @client = client
      @w = @frame[FR_LEFT].w
      @h = @frame[FR_TOP].h
    end

    @@default_parameter = WindowParameter.new(
      "window.png",                 # ウィンドウイメージ名
      Rect.new(  0,  0, 32, 32),    # 左上
      Rect.new( 32,  0, 32, 32),    # 上
      Rect.new( 64,  0, 32, 32),    # 右上
      Rect.new(  0, 32, 32, 32),    # 左
      Rect.new( 64, 32, 32, 32),    # 右
      Rect.new(  0, 64, 32, 32),    # 左下
      Rect.new( 32, 64, 32, 32),    # 下
      Rect.new( 64, 64, 32, 32),    # 右下
      Rect.new( 96,  0,128,128)     # クライアント
    )

    @@part = {:lt=>FR_LEFT_T, :t=>FR_TOP,    :rt=>FR_RIGHT_T,
              :l=>FR_LEFT,                   :r=>FR_RIGHT,
              :lb=>FR_LEFT_B, :b=>FR_BOTTOM, :rb=>FR_RIGHT_B}

    attr_reader :filename
    attr_reader :frame
    attr_reader :client
    attr_reader :w, :h

    def WindowParameter::default
      return @@default_parameter
    end

    def [](part)
      return @@part.key?(part) ? @frame[@@part[part]] : @client
    end

    def get_parts
      return WindowParts.new(self) unless @parts
    end
  end

=begin
=CursorParameterクラス
カーソル用に表示する書くグラフィックの範囲を格納するクラス
=end

  class CursorParameter # structure class
    DOWN  = 0
    LEFT  = 1
    RIGHT = 2
    UP    = 3
    DIRS  = 4

    @@dir2symbol = {UP=>:u,
                    LEFT=>:l, RIGHT=>:r,
                    DOWN=>:d}

    @@part = {:u=>UP,
              :l=>LEFT, :r=>RIGHT,
              :d=>DOWN}

    def initialize(fn, wait, wp, cr, cp, pg, pp)
      @filename = fn
      @wait = wait
      @cursor = Hash.new
      x = cr.x
      DIRS.times{|d|
        @cursor[@@dir2symbol[d]]=Rect.new(x, cr.y, cr.w, cr.h)
        x += cr.w
      }
      @page = Hash.new
      x = pg.x
      DIRS.times{|d|
        @page[@@dir2symbol[d]]=Rect.new(x, pg.y, pg.w, pg.h)
        x += pg.w
      }
      @waitpat, @cursorpat, @pagepat = [wp, cp, pp]
      @ww = @wait.w
      @wh = @wait.h
      @cw = @cursor[:l].w
      @ch = @cursor[:l].h
    end

    @@default_parameter = CursorParameter.new(
      "window.png",                  # ウィンドウイメージ名
      Rect.new(224,  0, 32, 32), 4, # ウェイト、パターン数
      Rect.new(  0,128, 32, 32), 4, # カーソル、パターン数
      Rect.new(128,128, 32, 32), 4  # ページカーソル、パターン数
    )

    attr_reader :filename
    attr_reader :wait, :waitpat
    attr_reader :cursor, :cursorpat
    attr_reader :page, :pagepat
    attr_reader :ww, :wh, :cw, :ch

    def CursorParameter::default
      return @@default_parameter
    end

    def select_cursor
      return @cursor
    end

    def scroll_cursor
      return @page
    end

    def get_parts
      return CursorParts.new(self) unless @parts
    end
  end

=begin
=WindowPartsクラス
ウィンドウ用に描画する各パーツをスプライト単位で管理するクラス
=end

  class WindowParts
    attr_reader :tr_color
    attr_reader :client
    attr_reader :frame_t, :frame_l, :frame_r, :frame_b
    attr_reader :frame_lt, :frame_rt, :frame_lb, :frame_rb

    def copy_rect(base, x, y, w, h)
      return Sprite.new(base.bitmap.copyRect(x, y, w, h), @tr_color)
    end

    def get_copy(base, param, part)
      fr = param[part]
      return copy_rect(base, fr.x, fr.y, fr.w, fr.h)
    end

    def initialize(param)
      @base = Sprite.new(param.filename, nil)
      @tr_color = Color.to_rgb(@base.bitmap.getPixel(0, 0))

      cl_rect = param.client
      @client = Sprite.new([cl_rect.w, cl_rect.h], @tr_color)
      SDL.blitSurface(@base.bitmap, cl_rect.x, cl_rect.y, cl_rect.w, cl_rect.h, @client.bitmap, 0, 0)

      @frame_t = get_copy(@base, param, :t)
      @frame_l = get_copy(@base, param, :l)
      @frame_r = get_copy(@base, param, :r)
      @frame_b = get_copy(@base, param, :b)
      @frame_lt = get_copy(@base, param, :lt)
      @frame_rt = get_copy(@base, param, :rt)
      @frame_lb = get_copy(@base, param, :lb)
      @frame_rb = get_copy(@base, param, :rb)
    end
  end

=begin
=CursorPartsクラス
カーソル用に描画する各パーツをスプライト単位で管理するクラス
=end

  class CursorParts
    DOWN  = 0
    LEFT  = 1
    RIGHT = 2
    UP    = 3
    DIRS = 4

    attr_reader :wait_cursor, :tr_color

    @@part = {:u=>UP,
              :l=>LEFT, :r=>RIGHT,
              :d=>DOWN}

    def copy_rect(base, x, y, w, h)
      return Sprite.new(base.bitmap.copyRect(x, y, w, h), @tr_color)
    end

    def get_copy(base, param, part)
      fr = param.get_frame(part)
      return copy_rect(base, fr.x, fr.y, fr.w, fr.h)
    end

    def initialize(param)
      @base = Sprite.new(param.filename, nil)
      @tr_color = Color.to_rgb(@base.bitmap.getPixel(0, 0))

      @wait_cursor = copy_rect(@base, param.wait.x, param.wait.y, param.wait.w, param.wait.h * param.waitpat)
      @wait_cursor.oh = param.wait.h

      @select_cursor = Array.new
      [:d, :l, :r, :u].each{|t|
        rect = param.select_cursor[t]
        tmp = copy_rect(@base, rect.x, rect.y, rect.w, rect.h * param.cursorpat)
        tmp.oh = rect.h
        @select_cursor.push(tmp)
      }

      @scroll_cursor = Array.new
      [:d, :l, :r, :u].each{|t|
        rect = param.scroll_cursor[t]
        tmp = copy_rect(@base, rect.x, rect.y, rect.w, rect.h * param.pagepat)
        tmp.oh = rect.h
        @scroll_cursor.push(tmp)
      }
    end

    def select_cursor(part)
      return @select_cursor[@@part[part]]
    end
    
    def scroll_cursor(part)
      return @scroll_cursor[@@part[part]]
    end
  end

=begin
=Windowクラス
ウィンドウを管理するクラス
=end

  class Window
    extend Forwardable
    @@windows = Array.new

    def drawWindow
    end

    def createWindow
      @back=Sprite.new([@cw+@params.w*2, @ch+@params.h*2])

      lw = @params[:lt].w
      lh = @params[:lt].h
      cl = @parts.client

      if @isTile
        w = (@cw + lw * (1-@margin) + @params[:rb].w * (1-@margin)).to_i()
        h = (@ch + lh * (1-@margin) + @params[:rb].h * (1-@margin)).to_i()
        x = (lw * @margin).to_i()
        y = (lh * @margin).to_i()
        tx = w / cl.w
        mx = w % cl.w
        ty = h / cl.h
        my = h % cl.h
        ty.times{|t1|
          tx.times{|t2| SDL.blitSurface(cl.bitmap, 0, 0, 0, 0, @back.bitmap, x + t2 * cl.w, y + t1 * cl.h) }
          SDL.blitSurface(cl.bitmap, 0, 0, mx, cl.h, @back.bitmap, x + tx * cl.w, y + t1 * cl.h) if mx > 0
        }
        tx.times{|t2| SDL.blitSurface(cl.bitmap, 0, 0, cl.h, my, @back.bitmap, x + t2 * cl.w, y + ty * cl.h) } if my > 0
        SDL.blitSurface(cl.bitmap, 0, 0, mx, my, @back.bitmap, x + tx * cl.w, y + ty * cl.h) if mx > 0 && my > 0
      else
        SDL.transform(cl.bitmap, @back.bitmap, 0, @back.w / cl.w + 2, @back.h / cl.h + 2, 0, 0, 0, 0, SDL::TRANSFORM_AA) # why + 2 ???
        @back.bitmap.fillRect(0, 0, lw * @margin, @back.h, @back.tr_color)
        @back.bitmap.fillRect(lw + @cw + @params[:rb].w * (1-@margin), 0, @params[:rt].w * @margin, @back.h, @back.tr_color)
        @back.bitmap.fillRect(0, 0, @back.w, lh * @margin, @back.tr_color)
        @back.bitmap.fillRect(0, lh + @ch + @params[:rb].h * (1-@margin), @back.w, @params[:lb].h * @margin, @back.tr_color)
      end
      @back.alpha = @balpha

      @window=Sprite.new([@cw+@params.w*2, @ch+@params.h*2], nil)
      @window.bitmap.setColorKey(SDL::SRCCOLORKEY|SDL::RLEACCEL, @parts.tr_color)
      @window.bitmap.fillRect(0, 0, @window.w, @window.h, @parts.tr_color)

      SDL.blitSurface(@parts.frame_lt.bitmap, 0, 0, 0, 0, @window.bitmap, 0, 0)
      SDL.blitSurface(@parts.frame_rt.bitmap, 0, 0, 0, 0, @window.bitmap, lw+@cw, 0)
      SDL.blitSurface(@parts.frame_lb.bitmap, 0, 0, 0, 0, @window.bitmap, 0, lh+@ch)
      SDL.blitSurface(@parts.frame_rb.bitmap, 0, 0, 0, 0, @window.bitmap, lw+@cw, lh+@ch)
      f  = @parts.frame_t
      tx = @cw / f.w
      mx = @cw % f.w
      tx.times{|t| SDL.blitSurface(f.bitmap, 0, 0, 0, 0, @window.bitmap, lw + t * f.w, 0) }
      SDL.blitSurface(f.bitmap, 0, 0, mx, f.h, @window.bitmap, lw + tx * f.w, 0) if mx > 0
      f  = @parts.frame_l
      tx = @ch / f.h
      mx = @ch % f.h
      tx.times{|t| SDL.blitSurface(f.bitmap, 0, 0, 0, 0, @window.bitmap, 0, lh + t * f.h) }
      SDL.blitSurface(f.bitmap, 0, 0, f.w, mx, @window.bitmap, 0, lh + tx * f.h) if mx > 0
      f  = @parts.frame_r
      tx = @ch / f.h
      mx = @ch % f.h
      tx.times{|t| SDL.blitSurface(f.bitmap, 0, 0, 0, 0, @window.bitmap, lw + @cw, lh + t * f.h) }
      SDL.blitSurface(f.bitmap, 0, 0, f.w, mx, @window.bitmap, lw + @cw, lh + tx * f.h) if mx > 0
      f  = @parts.frame_b
      tx = @cw / f.w
      mx = @cw % f.w
      tx.times{|t| SDL.blitSurface(f.bitmap, 0, 0, 0, 0, @window.bitmap, lw + t * f.w, lh + @ch) }
      SDL.blitSurface(f.bitmap, 0, 0, mx, f.h, @window.bitmap, lw + tx * f.w, lh + @ch) if mx > 0

      @window.snap(nil)
      @window.get_snap_children.each{|c| c.snap(nil) }
      @window.calc_layout
    end

    def setMargin(v)
      if v > 1.0
        return 1.0
      elsif v < 0.0
        return 0.0
      end
      return v
    end

    protected :createWindow, :setMargin

    def initialize(size = Size.new(256, 256), params = WindowParameter::default, cparams = CursorParameter::default, balpha = 255, istile = true, margin = 0.5)
      @size = size.kind_of?(Array) ? Size.new(size[0], size[1]) : size
      @params = params
      @parts  = @params.get_parts
      @balpha = balpha
      @isTile = istile
      @ccol = Color::BLACK
      @margin = setMargin(margin)
      @cw = @size.w
      @ch = @size.h
      
      @back = nil
      @client = nil
      @window = nil

      createWindow()

      @client = TextBox.new(size, cparams, @balpha, @istile, @margin)
      @client.visible = false

      @x = 0
      @y = 0
      @dp = 0

      @client.x = @x + @params[:lt].w
      @client.y = @y + @params[:lt].w

      @@windows.push(self)
    end

    def msg
      @client.msg
    end

    def msg=(m)
      raise MiyakoError("Parameter is not Yuki::Scenario class!") unless m.kind_of?(Yuki::Scenario)
      @client.msg = m
    end

    def margin
      @margin
    end

    def margin=(v)
      @margin = setMargin(v)
    end

    def_delegators(:@client, :clientX, :clientX=)
    def_delegators(:@client, :clientY, :clientY=)

    def clientW
      @cw
    end

    def clientH
      @ch
    end

    def clientSize
      [@cw, @ch]
    end

    def clientLeft
      @params[:lt].w
    end

    def clientTop
      @params[:lt].h
    end

    def_delegators(:@client, :setClient)
    def_delegators(:@client, :pauseWait, :pauseWait=)
    def_delegators(:@client, :pauseType, :pauseType=)
    def_delegators(:@client, :cusrsorVisible, :cursorVisible=)
    def_delegators(:@client, :cursorWait, :cursorWait=)
    def_delegators(:@client, :cursorDir, :cursorDir=)
    def_delegators(:@client, :cursorX, :cursorX=)
    def_delegators(:@client, :cursorY, :cursorY=)
    def_delegators(:@client, :pageWait, :pageWait=)
    def_delegators(:@client, :pause=, :pause?)
    def_delegators(:@client, :clear, :cr)

    def x=(v)
      @back.x = v
      @client.x = v + @params[:lt].w
      @window.x = v
    end

    def y=(v)
      @back.y = v
      @client.y = v + @params[:lt].h
      @window.y = v
    end

    def calc_layout
      @back.calc_layout
      @client.calc_layout
      @window.calc_layout
    end

    def set_layout(x, y)
      @back.set_layout(x, y)
      @client.set_layout(x, y)
      @client.set_layout([@back.get_layout_x[2]+@params[:lt].w], [@back.get_layout_y[2]+@params[:lt].h])
      @window.set_layout(x, y)
    end

    def enable_layout
      @back.enable_layout
      @client.enable_layout
      @window.enable_layout
    end

    def disenable_layout
      @back.disenable_layout
      @client.disenable_layout
      @window.disenable_layout
    end

    def set_side_x(xside)
      @back.set_side_x(xside)
      @client.set_side_x(xside)
      @window.set_side_x(xside)
    end

    def set_side_y(yside)
      @back.set_side_y(yside)
      @client.set_side_y(yside)
      @window.set_side_y(yside)
    end

    def set_side(xside, yside)
      @back.set_side(xside, yside)
      @client.set_side(xside, yside)
      @window.set_side(xside, yside)
    end
    
    def set_base_size(w, h)
      @back.set_base_size(w, h)
      @client.set_base_size(w, h)
      @window.set_base_size(w, h)
    end

    def reset_base_size
      @back.reset_base_size
      @client.reset_base_size
      @window.reset_base_size
    end

    def set_base_point(x, y)
      @back.set_base_point(x, y)
      @client.set_base_point(x, y)
      @window.set_base_point(x, y)
    end

    def snap(spr = nil)
      @window.snap(spr)
    end

    def reset_snap
      @window.reset_snap
    end

    def add_snap_child(spr)
      @window.add_snap_child(spr)
    end

    def delete_snap_child(spr)
      @window.delete_snap_child(spr)
    end

    def set_base(x, y, w, h)
      @back.set_base(x, y, w, h)
      @client.set_base(x, y, w, h)
      @window.set_base(x, y, w, h)
    end

    def reset_base
      @back.reset_base(x, y, w, h)
      @client.reset_base(x, y, w, h)
      @window.reset_base(x, y, w, h)
    end

    def set_offset_x(x)
      @back.set_offset_x(x)
      @client.set_offset_x(x)
      @window.set_offset_x(x)
    end

    def set_offset_y(y)
      @back.set_offset_y(y)
      @client.set_offset_y(y)
      @window.set_offset_y(y)
    end

    def set_offset(x, y)
      @back.set_offset(x, y)
      @client.set_offset(x, y)
      @window.set_offset(x, y)
    end

    def reset_offset
      @back.reset_offset
      @client.reset_offset
      @window.reset_offset
    end

    def reset_layout
      @back.reset_layout
      @client.reset_layout
      @client.set_layout([@back.get_layout_x[2]+@params[:lt].w], [@back.get_layout_y[2]+@params[:lt].h])
      @window.reset_layout
    end

    def centering
      @back.centering
      @client.centering
      @window.centering
    end

    def move(x, y)
      @back.move(x, y)
      @client.move(x, y)
      @window.move(x, y)
    end

    def move_to(x, y)
      dx = x - @window.x
      dy = y - @window.y
      @back.move(dx, dy)
      @client.move(dx, dy)
      @window.move(dx, dy)
    end

    def_delegators(:@window, :get_layout_x, :get_layout_y, :get_layout, :get_side, :get_base)
    def_delegators(:@window, :get_offset, :get_offset_x, :get_offset_y)

    def dp
      @window.dp
    end

    def dp=(v)
      @back.dp = v
      @client.dp = v + 1
      @window.dp = v + 2
    end

    def visible=(f)
      @back.visible = f
      @client.textVisible = f
      @window.visible = f
    end

    def show
      @back.show
      @client.show_text
      @window.show
    end

    def hide
      @back.hide
      @client.hide_text
      @window.hide
    end

    def clientVisible
      @client.visible
    end

    def clientVisible=(v)
      @client.visible = f
    end

    def bgAlpha
      @balpha
    end

    def bgAlpha=(b)
      @balpha = b
      @back.alpha = @balpha
    end

    def rect
      return Rect.new(@window.x, @window.y, @window.w, @window.h)
    end

    def window_params
      return @params
    end

    def dispose
      @back.dispose
      @back = nil
      @window.dispose
      @window = nil
      @params = nil
      @parts = nil
      @base = nil
      @@windows.delete(self)
    end

    def Window::getList
      @@windows
    end

    def_delegators(:@window, :visible, :x, :y)
    def_delegators(:@client, :text, :text=)
    def_delegators(:@client, :font, :font=)
    def_delegators(:@client, :textVisible, :textVisible=)
    def_delegators(:@client, :drawBlock, :drawBlock=)
    def_delegators(:@client, :textMarginLeft, :textMarginTop, :textMarginRight, :textMarginBottom)
    def_delegators(:@client, :textMarginLeft=, :textMarginTop=, :textMarginRight=, :textMarginBottom=)
    def_delegators(:@client, :setTextMargin)
    def_delegators(:@client, :locateX, :locateY, :nowLocateX, :nowLocateY, :locate)
    def_delegators(:@client, :cursor_params)
  end

  class TextBox
    extend Forwardable

    DIRS = [:d, :l, :r, :u]

    @@windows = Array.new

    attr_accessor :font
    attr_reader :msg

    def setPauseLocate
      case @waittype
      when 0
        @wait_cursor.x = @textarea.x + (@size.w - @params.wait.w) / 2
        @wait_cursor.y = @textarea.y + @size.h - @params.wait.h
      when 1
        @wait_cursor.x = @textarea.x + @textarea.nowLocateX
        @wait_cursor.y = @textarea.y + @textarea.nowLocateY
      end 
    end

    protected :setPauseLocate

    def drawWindow
      @client.bitmap.fillRect(0, 0, @size.w, @size.h, @bcol)
      if @font != nil && @msgpos < @msg.size
        x = @textarea.textMarginLeft + @textarea.locateX
        y = @textarea.textMarginTop + @textarea.locateY
        dat = @msg[@msgpos].data
        dat = dat.tosjis if dat.class == String
        @textarea.nowLocateX, @textarea.nowLocateY, @msgpos = @font.drawTextRange(@textarea.bitmap, @msg, @msgpos, 0, x, y, 0)
        @textarea.locateX = @textarea.nowLocateX - @textarea.textMarginLeft
        @textarea.locateY = @textarea.nowLocateY - @textarea.textMarginTop
      end
      SDL.blitSurface2(@clientimg, [@cx, @cy, @size.w, @size.h], @client.bitmap, [0, 0, @size.w, @size.h]) if @clientimg
      if @waiting
        if @waitwait.finish?
          @waitpat = (@waitpat + 1) % @params.waitpat
          @wait_cursor.oy = @params.wait.h * @waitpat
          setPauseLocate()
          @waitwait.start
        end
      else
        DIRS.each{|dir| @parts.scroll_cursor(dir).visible = false }
        if @clientimg
          pdir = nil
          pdir = :d if @clientimg.h > (@cy + @size.h)
          pdir = :l if @cx > 0
          pdir = :r if @clientimg.w > (@cx + @size.w)
          pdir = :u if @cy > 0
          if pdir
            @parts.scroll_cursor(pdir).visible = true
            if @pagewait.finish?
              @pagepat = (@pagepat + 1) % @params.pagepat
              @parts.scroll_cursor(pdir).oy = @page[pdir].oh * @pagepat
              case pdir
              when :d
                x = @textarea.x + (@size.w - @params.scroll_cursor(:d).w) / 2
                y = @textarea.y +  @size.h - @params.scroll_cursor(:d).h
              when :l
                x = @textarea.x
                y = @textarea.y + (@size.h - @params.scroll_cursor(:l).h) / 2
              when :r
                x = @textarea.x +  @size.w - @params.scroll_cursor(:r).w
                y = @textarea.y + (@size.h - @params.scroll_cursor(:r).h) / 2
              when :u
                x = @textarea.x + (@size.w - @params.scroll_cursor(:u).w) / 2
                y = @textarea.y
              end
              @parts.scroll_cursor(pdir).x = x
              @parts.scroll_cursor(pdir).y = y
              @pagewait.start
            end
          end
        end
        if @cursorvisible
          rect = @params.select_cursor[@cursordir]
          if @cursorwait.finish?
            @cursorpat = (@cursorpat + 1) % @params.cursorpat
            @parts.select_cursor(@cursordir).oy = rect.h * @cursorpat
            @parts.select_cursor(@cursordir).x = @cursorx
            @parts.select_cursor(@cursordir).y = @cursory
            @cursorwait.start
          end
        end
      end
    end

    def setPointerDP
      @wait_cursor.dp = @client.dp + 1
      DIRS.each{|p|
        @parts.scroll_cursor(p).dp = @wait_cursor.dp
        @parts.select_cursor(p).dp = @wait_cursor.dp
      }
    end

    def createWindow
      @client=Sprite.new(@size, @parts.tr_color, @balpha, true)
      @textarea=Sprite.new(@size, @parts.tr_color, 255, true)

      setPointerDP

      @client.snap(nil)
      @client.get_snap_children.each{|c| c.snap(nil) }
      @client.calc_layout
    end

    def setMargin(v)
      if v > 1.0
        return 1.0
      elsif v < 0.0
        return 0.0
      end
      return v
    end

    protected :createWindow, :setMargin

    def initialize(size = Size.new(256, 256), params = CursorParameter::default, balpha = 255, istile = true, margin = 0.5)
      @size = size.kind_of?(Array) ? Size.new(size[0], size[1]) : size
      @params = params
      @parts  = @params.get_parts
      @wait_cursor = @parts.wait_cursor
      @balpha = balpha
      @isTile = istile
      @cx = 0
      @cy = 0
      @waiting = false
      @waitvisible = false
      @waitwait = WaitCounter.new(0)
      @waitpat = 0
      @waittype = 0
      @cursorvisible = false
      @cursorwait = WaitCounter.new(0)
      @cursorpat = 0
      @cursordir = :r
      @cursorx = 0
      @cursory = 0
      @pagewait = WaitCounter.new(0)
      @pagepat = 0
      @textMarginLeft = 0
      @textMarginTop = 0
      @textMarginRight = 0
      @textMarginBottom = 0
      @clientimg = nil
      @bcol = Color::BLACK
      @margin = setMargin(margin)
      @font = nil
      @msg = Yuki::Scenario.new
      @msgpos = 0

      @client = nil
      @textarea = nil

      createWindow()
      drawWindow()

      @x = 0
      @y = 0
      @cx = 0
      @cy = 0
      @dp = 0

      @textarea.setTextArea(@size.w, @size.h)

      @cursorx = @textarea.x
      @cursory = @textarea.y

      @@windows.push(self)
    end

    def msg=(m)
      raise MiyakoError("Parameter is not Yuki::Scenario class!") unless m.kind_of?(Yuki::Scenario)
      tsp = @msg.separate
      @msg = m
      @msg.separate = tsp
    end

    def margin
      @margin
    end

    def margin=(v)
      @margin = setMargin(v)
    end

    def clientX
      @cx
    end

    def clientX=(v)
      @cx = v
    end

    def clientY
      @cy
    end

    def clientY=(v)
      @cy = v
    end

    def clientW
      return @size.w
    end

    def clientH
      return @size.h
    end

    def clientSize
      return @size
    end

    def setClient(spr)
      @clientimg=spr
      drawWindow()
    end

    def pauseWait=(v)
      @waitwait = WaitCounter.new(v)
      @waitwait.start
      @waitvisible = true if @waiting
    end

    def pauseType
      @waittype
    end

    def pauseType=(v)
      @waittype = v
    end

    def cursorVisible
      @cursorvisible
    end

    def cursorVisible=(v)
      @cursorvisible = v
      @parts.select_cursor(@cursordir).x = @cursorx
      @parts.select_cursor(@cursordir).y = @cursory
      @parts.select_cursor(@cursordir).visible = @cursorvisible
    end

    def cursorWait=(v)
      @cursorwait = WaitCounter.new(v)
      @cursorwait.start
    end

    def cursorDir
      @cursordir
    end

    def cursorDir=(v)
      raise MiyakoError,new("cursorDir parameter is not Symbol!") unless DIRS.include?(v)
      @cursordir = v
      DIRS.each{|p| @parts.select_cursor(p).hide }
      @parts.select_cursor(v).show
    end

    def cursorX
      @cursorx - @textarea.x
    end

    def cursorX=(v)
      @cursorx = @textarea.x + v
    end

    def cursorY
      @cursory - @textarea.y
    end

    def cursorY=(v)
      @cursory = @textarea.y + v
    end

    def cursorSize
      [@parts.select_cursor(@cursordir).ow, @parts.select_cursor(@cursordir).oh]
    end

    def pageWait=(v)
      @pagewait = WaitCounter.new(v)
      @pagewait.start
    end

    def pause=(v)
      @waiting = v
      setPauseLocate()
      @wait_cursor.visible = @waiting
    end

    def pause?
      @waiting
    end

    def x=(v)
      @client.x = v
      @textarea.x = v
      @cursorx = @textarea.x + v
    end

    def y=(v)
      @client.y = v
      @textarea.y = v
      @cursory = @textarea.y + v
    end

    def calc_layout
      @client.calc_layout
      @textarea.calc_layout
    end

    def set_layout(x, y)
      @client.set_layout(x, y)
      @textarea.set_layout(x, y)
    end

    def enable_layout
      @client.enable_layout
      @textarea.enable_layout
    end

    def disenable_layout
      @client.disenable_layout
      @textarea.disenable_layout
    end

    def set_side_x(xside)
      @client.set_side_x(xside)
      @textarea.set_side_x(xside)
    end

    def set_side_y(yside)
      @client.set_side_y(yside)
      @textarea.set_side_y(yside)
    end

    def set_side(xside, yside)
      set_side_x(xside)
      set_side_y(yside)
    end

    def set_base_size(w, h)
      @client.set_base_size(w, h)
      @textarea.set_base_size(w, h)
    end

    def reset_base_size
      @client.reset_base_size
      @textarea.reset_base_size
    end

    def set_base_point(x, y)
      @client.set_base_point(x, y)
      @textarea.set_base_point(x, y)
    end

    def snap(spr = nil)
      @client.snap(spr)
    end

    def reset_snap
      @client.reset_snap(spr)
    end

    def add_snap_child(spr)
      @client.add_snap_child(spr)
    end

    def delete_snap_child(spr)
      @client.delete_snap_child(spr)
    end

    def set_base(x, y, w, h)
      @client.set_base(x, y, w, h)
      @textarea.set_base(x, y, w, h)
    end

    def reset_base
      @client.reset_base
      @textarea.reset_base
    end

    def set_offset_x(x)
      @client.set_offset_x(x)
      @textarea.set_offset_x(x)
    end

    def set_offset_y(y)
      @client.set_offset_y(y)
      @textarea.set_offset_y(y)
    end

    def set_offset(x, y)
      @client.set_offset(x, y)
      @textarea.set_offset(x, y)
    end

    def reset_offset
      @client.reset_offset
      @textarea.reset_offset
    end

    def reset_layout
      @client.reset_layout
      @textarea.reset_layout
    end

    def centering
      @client.centering
      @textarea.centering
    end

    def move(x, y)
      @client.move(x, y)
      @textarea.move(x, y)
    end

    def move_to(x, y)
      @client.move_to(x, y)
      @textarea.move_to(x, y)
    end

    def_delegators(:@client, :get_layout_x, :get_layout_y, :get_layout, :get_side, :get_base)
    def_delegators(:@client, :get_offset, :get_offset_x, :get_offset_y)

    def dp
      @client.dp
    end

    def dp=(v)
      @client.dp = v
      @textarea.dp = v
      setPointerDP
    end

    def visible=(f)
      @client.visible = f
    end

    def bgAlpha
      @balpha
    end

    def bgAlpha=(b)
      @balpha = b
      @client.alpha = @balpha
    end

    def bgColor
      @bcol
    end

    def bgColor=(c)
      @bcol = c if Color.to_rgb(c)
      @client.bitmap.fillRect(0, 0, @client.w, @client.h, @bcol)
    end

    def clear
      @msg.clear
      @textarea.bitmap.fillRect(0, 0, @size.w, @size.h, @parts.tr_color)
      @textarea.locateX = 0
      @textarea.locateY = 0
      @msgpos = 0
    end

    def cr
      @msg.push(Yuki::Direction.cr)
      @textarea.locateX = 0
    end

    def textVisible
      @textarea.visible
    end

    def textVisible=(f)
      @textarea.visible = f
    end

    def show
      @client.show
      @textarea.show
    end

    def hide
      @client.hide
      @textarea.hide
    end

    def show_text
      @textarea.show
    end

    def hide_text
      @textarea.hide
    end

    def show_client
      @client.show
    end

    def hide_clientt
      @client.hide
    end

    def cursor_params
      return @params
    end

    def rect
      return Rect.new(@client.x, @client.y, @client.w, @client.h)
    end

    def dispose
      @client.dispose
      @client = nil
      @textarea.dispose
      @textarea = nil
      @clientimg = nil
      @params = nil
      @parts = nil
      @base = nil
      @src = nil
      @@windows.delete(self)
    end

    def TextBox::getList
      @@windows
    end

    def_delegators(:@client, :visible, :x, :y)
    def_delegators(:@client, :drawBlock, :drawBlock=)
    def_delegators(:@textarea, :textMarginLeft, :textMarginTop, :textMarginRight, :textMarginBottom)
    def_delegators(:@textarea, :textMarginLeft=, :textMarginTop=, :textMarginRight=, :textMarginBottom=)
    def_delegators(:@textarea, :setTextMargin)
    def_delegators(:@textarea, :locateX, :locateY, :nowLocateX, :nowLocateY, :locate)
  end

=begin
=MParamクラス
=end

  class MParam
    attr_accessor :name, :tsize, :tpixels
    attr_accessor :px, :py
    attr_accessor :csv, :blist

    def initialize
      @name = ""
      @tsize = 0
      @tpixels = 0
      @px = -1
      @py = -1
      @csv = ""
      @blist = []
    end
  end

=begin
=Mapクラス
所定のマップチップとマップデータを元にマップ画像を作成するクラス
=MapLayerクラス
実際のマップデータと表示画像(レイヤ)を扱うクラス
=end
  
  class Map
    @@maps = Array.new

    class MapLayer
      extend Forwardable

      attr_reader :x, :y, :w, :h

      def copyRect(bmp, x, y, w, h)
        src = bmp.copyRect(x, y, w, h)
        src.setColorKey(SDL::SRCCOLORKEY|SDL::RLEACCEL, @bcol)
        src.displayFormat
      end

      def draw_chip(buf, x, y, rx, ry)
        SDL.blitSurface(@chipdb[@mapdat[@pos_y[y]][@pos_x[x]]], 0, 0, 0, 0, buf, rx, ry)
      end

      def draw(s)
        @buf.fillRect(0, 0, @buf.w, @buf.h, @bcol)
        tx = @param.tpixels
        @ch.times{|y| @cw.times{|x| draw_chip(@buf, x, y, x * tx, y * tx) } }
        SDL.blitSurface(@buf, 0, 0, 0, 0, s.bitmap, -@mx, -@my)
      end
      
      def cdraw(s) # with clipping
        @buf2.fillRect(0, 0, @buf2.w, @buf2.h, @bcol)
        lft, rgt = @dx < 0 ? [-@dx, 0] : [0, @dx]
        top, btm = @dy < 0 ? [-@dy, 0] : [0, @dy]
        tx = @param.tpixels
        SDL.blitSurface(@buf, rgt * tx, btm * tx, @buf.w - @dx.abs * tx, @buf.h - @dy.abs * tx, @buf2, lft * tx, top * tx)

        (0..(top-1)).each{|y| @cw.times{|x| draw_chip(@buf2, x, y, x * tx, y * tx) } } if top != 0

        (top..(@ch-btm-1)).each{|y|
          (0..(lft-1)).each{|x| draw_chip(@buf2, x, y, x * tx, y * tx) } if lft != 0
          ((@cw-rgt)..(@cw-1)).each{|x| draw_chip(@buf2, x, y, x * tx, y * tx) } if rgt != 0
        }

        ((@ch-btm)..(@ch-1)).each{|y| @cw.times{|x| draw_chip(@buf2, x, y, x * tx, y * tx) } } if btm != 0

        @buf, @buf2 = [@buf2, @buf]
        SDL.blitSurface(@buf, 0, 0, 0, 0, s.bitmap, -@mx, -@my)
      end
      
      protected :copyRect, :draw, :cdraw

      def update_position_x
        @pos_x.fill(0,@cw){|i| (@cx + i) % @w}
      end

      def update_position_y
        @pos_y.fill(0,@ch){|i| (@cy + i) % @h}
      end

      def update_position
        update_position_x
        update_position_y
      end

      def reSize
        tx = @param.tpixels
        @cw = (Screen.w + tx - 1) / tx + 1
        @ch = (Screen.h + tx - 1) / tx + 1
        if @baseimg != nil
          f = @spr != nil
          v = false
          d = 0
          x = 0
          y = 0
          ox = 0
          oy = 0
          if f
            v = @spr.visible
            d = @spr.dp
            x = @spr.x
            y = @spr.y
            ox = @spr.ox
            oy = @spr.oy
            @spr.dispose
            @buf = nil
            @buf2 = nil
          end
          @spr = Sprite.new([Screen.w, Screen.h], nil)
          @spr.visible = v
          @spr.dp = d
          @spr.x = x
          @spr.y = y
          @spr.ox = ox
          @spr.oy = oy
          @buf = Bitmap.create((@cw + 1) * tx, (@ch + 1) * tx)
          @buf2 = Bitmap.create((@cw + 1) * tx, (@ch + 1) * tx)
          if @px != -1 || @py != -1
            @bcol = @baseimg.getPixel(@param.px, @param.py)
            @spr.bitmap.setColorKey(SDL::SRCCOLORKEY|SDL::RLEACCEL, @bcol)
          end
          update_position
          draw(@spr) if f
          @spr.update = Proc.new{|o|
            return if @eventlayer
            dx = @dx.abs
            dy = @dy.abs
            if dx == 0 && dy == 0
              SDL.blitSurface(@buf, 0, 0, 0, 0, o.bitmap, -@mx, -@my)
            elsif dx < @cw && dy < @ch
              cdraw(o)
            else
              draw(o)
            end
            @dx = 0
            @dy = 0
          }
        end
      end

      def initialize(param, mapdat, w, h, basedat)
        @param = param
        @x = 0
        @cx = 0
        @mx = 0
        @dx = 0
        @y = 0
        @cy = 0
        @my = 0
        @dy = 0
        @mapdat = mapdat
        @baseimg = nil
        if basedat != nil
          img = Bitmap.load(basedat)
          imgsize = img.w > img.h ? img.w : img.h
          @baseimg = Bitmap.create(imgsize , imgsize)
          @baseimg.fillRect(0, 0, imgsize, imgsize, img.get_pixel(@param.px, @param.py))
          SDL.blit_surface(img, 0, 0, 0, 0, @baseimg, 0, 0)
        end
        @eventlayer = @baseimg == nil ? true : false
        @w = w
        @h = h
        @cw = 0
        @ch = 0
        @bcol = 0 # black
        @spr = nil
        @buf = nil
        @buf2 = nil
        @pos_x = Array.new
        @pos_y = Array.new
        reSize
        if @baseimg != nil
          @chipdb = Hash.new()
          th = @baseimg.h / @param.tpixels
          tw = @baseimg.w / @param.tpixels
          px = @param.tpixels
          th.times{|y|
            tw.times{|x|
              @chipdb[y * @param.tsize + x] = copyRect(@baseimg, px * x, px * y, px, px)
            }
          }
          draw(@spr)
        end
      end

      def getCode(x, y)
        @mapdat[y][x]
      end

      def x=(v)
        tx = @param.tpixels
        @x = v
        ocx = @cx
        @cx = @x / tx
        @mx = @x % tx
        @dx = @cx - ocx
        update_position_x
      end

      def y=(v)
        tx = @param.tpixels
        @y = v
        ocy = @cy
        @cy = @y / tx
        @my = @y % tx
        @dy = @cy - ocy
        update_position_y
      end

      def dispose
        @mapdat = nil
        @baseimg = nil
        @spr.dispose if @spr != nil
      end

      def eventLayer?
        @eventlayer
      end

      def_delegators(:@spr, :visible, :visible=, :dp, :dp=)
    end

    attr_reader :name, :layers, :x, :y, :w, :h

    def initialize(param)
      @param = param
      if @param.tsize != 16 && @param.tsize != 256 then
        raise Miyakorror.new("MapChip size is 16 or 256!")
      end
      @layers = nil
      @visible = false
      @x = 0
      @y = 0
      
      h = 0
      
      # llistの座標軸が逆になるので注意！
      llist = Array.new()
      File.open(@param.csv, "r"){|f|
        mlist = Array.new()
        while !(f.eof?()) do
          l = f.readline()
          if l =~ /^[\r\n]+$/
            h = mlist.length if h == 0
            llist.push(mlist)
            mlist = Array.new()
            next
          end
          mlist.push(l.split(",").collect{|v| v.to_i()})
        end
        h = mlist.length if h == 0
        llist.push(mlist) if mlist.length != 0
      }

      w = llist[0].length

      brlist = @param.blist.reverse
      @layers = Array.new
      llist.each_with_index{|l, i| @layers.push(MapLayer.new(@param, l, w, h, brlist[i])) }
      @layers = @layers.reverse
      @w = @layers[0].w
      @h = @layers[0].h
      @@maps.push(self)
    end

    def x=(v)
      wp = @w * @param.tpixels
      @x = v
      if wp - @x <= Screen.w
        @x = @x % wp
      elsif @x < 0
        @x = wp + @x
      end
      @layers.each{|l| l.x = @x }
    end

    def y=(v)
      hp = @h * @param.tpixels
      @y = v
      if hp - @y <= Screen.h
        @y = @y % hp
      elsif @y < 0
        @y = hp + @y
      end
      @layers.each{|l| l.y = @y }
    end

    def dp
       @layers.collect{|l| l.eventLayer? ? nil : l.dp }
    end

    def dp=(d)
      @layers.each{|l| l.dp = d }
    end

    def setDPs(*dl)
      l = dl.length
      l = @layers.length if l > @layers.length
      l.length.each_with_index{|l, d| l.dp = dl[d] }
    end

    def layer(idx)
      @layers[idx]
    end

    def visible
      @visible
    end

    def visible=(f)
      @visible = f
      @layers.each{|ll| ll.visible = @visible if ll.eventLayer? == false }
    end

    def getCodeReal(idx, x, y)
      @layers[idx].getCode(x % @param.tpixels, y % @param.tpixels)
    end

    def getCode(idx, x, y)
      @layers[idx].getCode(x, y)
    end

    def chipSize
      @tpixels
    end

    def dispose
      @layers.each{|l|
        l.dispose
        l = nil
      }
      @layers = Array.new
      @@maps.delete(self)
    end

    def reSize
      @layers.reverse.each{|l| l.reSize }
    end

    def Map::getList
      @@maps
    end
  end

  module Story
    @@class_prefix = "Scene"
    @@sub_prefix = "Sub"
    @@script_list = Hash.new
    
    @@prev_label = nil
    @@next_label = nil

    @@stack = Array.new

    @@scene_cache = Hash.new
    @@scene_cache_list = Array.new
    @@scene_cache_max = 20

    def Story.class_prefix
      @@class_prefix
    end

    def Story.sub_prefix
      @@sub_prefix
    end

    def Story.class_prefix=(n)
      @@class_prefix = n
    end

    def Story.sub_prefix=(n)
      @@sub_prefix = n
    end

    def Story.script_list
      @@script_list
    end

    def Story.prev_label
      @@prev_label
    end

    def Story.next_label
      @@next_label
    end

    def Story.upper_label
      return @@stack.empty? ? nil : @@stack.last[0]
    end

    class Scene
      def Scene.inherited(c)
        name = c.to_s.split(/::/).last
        clname = ""
        prefix = ""
        if name =~ /^#{Story.class_prefix}\_(.+)/
          clname = $1
          prefix = Story.class_prefix
        elsif name =~ /^#{Story.sub_prefix}\_(.+)/
          clname = $1
          prefix = Story.sub_prefix
        else
          raise MiyakoError.new("Illegal Class Name! use only #{Story.class_prefix} or #{Story.sub_prefix}!")
        end
        raise MiyakoError.new("Redefine Class Name! : #{name}") if Story.script_list.has_key?(clname)
        Story.script_list[clname] = prefix
      end

      def initialize(n)
        @now = n
        @prev = nil
        @upper = nil
        self.init
      end

      def init_inner(p, u)
        @prev = p
        @upper = u
      end

      def init
      end

      def setup
      end

      def view_in
        return false
      end

      def update
        return @now
      end

      def view_out
        return false
      end

      def final
      end

      def interrupt
        return nil
      end

      def Scene.notice
        return ""
      end
    end

    def initialize
    end

    def get_scene(pf, n, s)
      class_name = pf.to_s+"_"+n.to_s
      class_symbol = (class_name+"_"+s.to_s).intern
      if @@scene_cache_list.length == @@scene_cache_max
        del_symbol = @@scene_cache_list.shift
        @@scene_cache.delete(del_symbol)
      end
      @@scene_cache_list.delete(class_symbol)
      @@scene_cache_list.push(class_symbol)
      @@scene_cache[class_symbol] ||= instance_eval(class_name+".new(\""+n.to_s+"\")")
      return @@scene_cache[class_symbol]
    end

    def run(n)
      return nil if n == nil
      u = nil
      on = nil
      @@stack = Array.new # reset
      while n != nil
        @@prev_label = on
        on = n
        inp = nil

        raise MiyakoError.new("Illegal Script-label name! : "+n.to_s) if @@script_list.has_key?("#{n}") == false
        pref = @@script_list[n.to_s]
        u = get_scene(pref.to_s, n, @@stack.size) if u == nil
        u.init_inner(@@prev_label, Story.upper_label)
        u.setup
        Miyako::Input.update
        while inp == nil && u.view_in
          inp = u.interrupt
          break if inp != nil
          Miyako::Screen.update
          Miyako::Input.update
        end
        while inp == nil && n != nil && on.to_s == n.to_s
          Miyako::Input.update
          inp = u.interrupt
          break if inp != nil
          n = u.update
          Miyako::Screen.update
        end
        @@next_label = n
        Miyako::Input.update
        while inp == nil && u.view_out
          inp = u.interrupt
          break if inp != nil
          Miyako::Screen.update
          Miyako::Input.update
        end
        u.final
        if inp != nil
          n = inp
          @@next_label = inp
          @@stack.push([on, u]) if @@script_list[n.to_s] == Story.sub_prefix
          u = nil
        elsif n.to_s == "return" # return from subroutine is only return-label is "return"
          if @@stack.empty? == false
            n, u = @@stack.pop
          else
            return # when stack is empty is same as return nil
          end
        elsif n == nil
          return
        elsif @@script_list[n.to_s] == Story.sub_prefix
          @@stack.push([on, u])
          u = nil
        else
          u = nil
        end
      end
    end

    def listup
      list = Array.new
      @@script_list.keys.sort.each{|k|
        pref = @@script_list["#{k}"]
        s = instance_eval("#{pref}_#{k}.notice")
        list.push("#{k}, #{pref}_#{k}, \"#{s}\"\n")
      }
      return list
    end

    def listup2csv(csvfname)
      csvfname += ".csv" if csvfname !~ /\.csv$/
      list = listup
      File.open(csvfname, "w"){|f| list.each{|l| f.print l } }
    end
  end
end
