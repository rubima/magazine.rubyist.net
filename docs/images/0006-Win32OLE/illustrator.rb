#!/usr/bin/env ruby
# There are the paper foldings diagram class definitions with Adobe Illustrator(10.0.3)
#   Author::    HShimura  (mailto:hs9587@yahoo.co.jp)
#   Copyright:: Copyright (c) 2004,5 HShimura
#   License::   Distributes under the same terms as Ruby
#   $Id: illustrator.rb,v 1.76 2005/03/27 07:14:09 hs9587 Exp $
#   $Name:  $

include Math


# Extensions of ruby classes for Illustrator and Illustruby, ... .

# Vector plus and vectors m(ultiple)plus, product, swap, abs, centre of rectangle, minus, rotate upon pivot
#   we will require matrix in the future
class Array
  
  alias swap reverse
  def mswap; self.map{|arr| (arr.respond_to?(:swap) ? arr.swap : arr) }; end
  alias swap! reverse!
  def mswap!; self.map{|arr| (arr.respond_to?(:swap!) ? arr.swap! : arr) }; end

  def abs
    Math::sqrt(self.inject(0){ |res, elm| res + elm**2 })
  end # def abs
  def center_rect
    if self[0].respond_to?(:[]) then
      left, top, = self[0]
      if self[1].respond_to?(:[]) then
        right, bottom, = self[1]
      else # if self[0].respond_to?(:[])
        right, bottom, = self[1..-1]
      end # if self[0].respond_to?(:[])
    else # if self[0].respond_to?(:[])
      left, top, = self
      if self[2].respond_to?(:[]) then
        right, bottom, = self[2]
      else # if self[2].respond_to?(:[])
        right, bottom, = self[2..-1]
      end # if self[2].respond_to?(:[])
    end # if self[0].respond_to?(:[])
    [(left+right)/2.0, (top+bottom)/2.0]
  end # def center_rect
  def rotate_upon(deg, pivot, mode=:degree)
    mode = mode.to_s if not mode.kind_of?(String)
    case mode
      when /\AD/i # egree
        theta = deg*PI/180
      when /\AR/i # adian
        theta = deg
      else
        theta = deg*PI/180
    end # case mode
    v = self.minus(pivot); res = pivot.plus(v)
    res[0] = pivot[0] + cos(theta)*v[0] - sin(theta)*v[1] 
    res[1] = pivot[1] + sin(theta)*v[0] + cos(theta)*v[1] 
    res
  end # def rotate_upon(deg, pivot, mode=:degree)
    
  def operate!(op, arr = [], overflow_zero=false)
    arr = [arr] if not arr.kind_of?(Array)
    if self.size > arr.size then
      arr.size.times{ |i| self[i] = self[i].send(op, arr[i]) }
    else # if self.size > arr.size 
      self.size.times{ |i| self[i] = self[i].send(op, arr[i]) }
      self.size.upto(arr.size-1){ |i| self << ((overflow_zero)?(0.send(op, arr[i])):(arr[i])) }
    end # end # if self.size > arr.size
    self
  end # def operate!(op, arr = [])
  def operate(op, arr = [], overflow_zero=false)
    res = []
    arr = [arr] if not arr.kind_of?(Array)
    if self.size > arr.size then
      arr.size.times{ |i| res[i] = self[i].send(op, arr[i]) }
      arr.size.upto(self.size-1){ |i| res[i] = self[i] }
      return res
    else # if self.size > arr.size 
      self.size.times{ |i| res[i] = self[i].send(op, arr[i]) }
      self.size.upto(arr.size-1){ |i| res[i] = ((overflow_zero)?(0.send(op, arr[i])):(arr[i])) }
      return res
    end # end # if self.size > arr.size 
  end # def operate(op, arr = [])
  def moperate!(op, arr = [], overflow_zero=false)
    arr = [arr] if not arr.kind_of?(Array)
    self.map! do |elm|
      elm = [elm] if not elm.kind_of?(Array)
      elm.operate!(op, arr, overflow_zero)
    end # self.each do |elem|
  end # def moperate(op, arr = [])
  def moperate(op, arr = [], overflow_zero=false)
    res = []
    arr = [arr] if not arr.kind_of?(Array)
    self.each do |elm|
      elm = [elm] if not elm.kind_of?(Array)
      res << elm.operate(op, arr, overflow_zero)
    end # self.each do |elem|
    return res
  end # def moperate(op, arr = [])
#  private :operate!, :operate, :moperate!, :moperate # private, undef, undef_method, or remove_method.
  protected :operate!, :operate, :moperate!, :moperate

  def self.multi(name, op, overflow_zero)
    [['','!'], ['',''], ['m','!'], ['m','']].each do |w|
    eval <<-EOM
      def #{w[0]+name+w[1]}(arr = [])
        #{w[0]}operate#{w[1]}(#{op}, arr, #{overflow_zero})
      end # def plus!(arr = [])
    EOM
    end # [['','!'], ['',''], ['m','!'], ['m','']].each do |w| 
  end # def multi(name, op)

  multi('plus', ':+', true)
  multi('minus', ':-', true)
  multi('product', ':*', false)
  
end # class Array
#Array.__send__(:undef_method, :multi)


# multiply Array.elements by self
#   we will require matrix in the future
class Numeric
  def multiply(arr = [])
    res = []
    arr = [arr] if not arr.kind_of?(Array)
    arr.each{ |elm| res << (self * elm) }
    return res
  end # def multiply(arr = [])
  def mmultiply(arr = [])
    if arr.respond_to?(:each)
      res = []
      arr.each{ |elm| res << self.mmultiply(elm) }
    else # if elm.respond_to?(:each)
      res = self * arr
    end # end # if elm.respond_to?(:each)
    return res
  end # def mmultiply(arr = [])
end # class numeric


# Utility Classes for objects < illustruby

# Pages assenbled with illustrubies.
class Pages < Array
  def method_missing(name, *args)
    res = Pages.new
    self.each{ |page| res << page.__send__(name, *args) }
    return res
  end # def method_missing(name, *args)
end # class Pages < Array


# # WIN32OLE and Illsutrator, Our main classes and methods 

# win32ole in the platform "Windows", not at the Mac OS
# We add methods: name, respond_to
require 'win32ole'
class WIN32OLE
  def ole_name
    return self.ole_obj_help.name
  end # def ole_name
  def ole_respond_to(name)
    name = name.to_s if name.class == Symbol
    return self.ole_methods.map{ |m| m.name }.include?(name)
  end # def ole_repond_to?(name)
end # class WIN32OLE


# Load Adobe Illustrator constants
#   Retry some times if Illustrator is not running.
module AiEnumerations
  def self.ais # number of AiEnumerationConstants
    self.constants.select{ |c| /^Ai/=~c }.size
  end # def ais 
end # module AiEnumerations
begin # WIN32OLE::const_load
  ole_name = 'Illustrator.Application'
  ole_const_loaded = false
  ole_connected = false
  ole_created = false
  ole_retry_times = 3 # The times of retring to create Illustrator Application object.
  ole_retry_sleep = 1 # times, sleep = 3,1 | 4,0 ...(3,12: sleep larger but times more than 3)
  puts 'flags are initialized' if $VERBOSE
  begin # WIN32OLE.const_load
    begin
      puts 'try connect'  if $VERBOSE
      illustrator = WIN32OLE.connect(ole_name)
#      illustrator.Visible = true
      ole_connected = true
      puts 'connected' if $VERBOSE
    rescue WIN32OLERuntimeError => err
      puts err if $VERBOSE
#      raise
      puts 'not connected' if $VERBOSE
      begin
        puts "try to create(new): #{ole_retry_times}" if $VERBOSE
        illustrator = WIN32OLE.new(ole_name)
#        illustrator.Visible = true
        ole_created = true
        puts 'created(newed)' if $VERBOSE
      rescue  WIN32OLERuntimeError => err
        puts err if $VERBOSE
#        raise
        puts 'not created(newed)' if $VERBOSE
        if (ole_retry_times -= 1)>0 and not illustrator
          sleep ole_retry_sleep
          retry
        end # if (ole_retry_times -= 1)>0 and not illustrator
      end
    end
    if illustrator and illustrator.class == WIN32OLE
      begin
        puts 'try to const_load' if $VERBOSE
        WIN32OLE::const_load(illustrator, AiEnumerations) 
        ole_const_loaded = true
        puts 'const_loaded' if $VERBOSE
      rescue => err
        puts err
        puts 'const_load failed' if $VERBOSE
      ensure
      end
    end # if illustrator and illustrator.type == WIN32OLE
  rescue => err
    puts err if $VERBOSE
    puts 'not conset_load 1stly' if $VERBOSE
    raise
#    raise
  end # WIN32OLE.const_load
ensure # WIN32OLE::const_load
  if illustrator
    puts 'illustrator defined' if $VERBOSE
    if (ole_created and not ole_connected) or
       (ole_const_loaded and not ole_connected)
      puts 'ole_created and not ole_connected' if $VERBOSE and ole_created and not ole_connected
      puts 'ole_const_loaded and not ole_connected' if $VERBOSE and ole_const_loaded and not ole_connected
      puts 'not ole_created' if $VERBOSE and not ole_created
      puts 'not ole_const_loaded' if $VERBOSE and not ole_const_loaded
      illustrator.quit
      puts 'quited (illustrator did quit)' if $VERBOSE
    end # if ole_created and not ole_connected
  end # if illustrator
end # WIN32OLE::const_load
AiConstants = AiEnumerations

puts 'end of constants section' if $VERBOSE
# Constants, Constants, Constants.


# Our main wrapper for Illustrator (OLE)
class Illustrator
  # starting with only initialize and destroy
  include AiConstants
  MM = 2.834645 # points
  CM, INCH, PICA, Q = 28.34645, 72, 12, 0.709 # (1Q = 0.23mm)
  A4 = Hash[:width, 595.28, :height, 841.89] ; A4.each_pair{ |key, value| key.freeze; value.freeze }; A4.freeze
  B5 = Hash[:width, 515.91, :height, 728.50] ; B5.each_pair{ |key, value| key.freeze; value.freeze }; B5.freeze

  attr_reader :application, :paper
  # @defaults has no accesser

  def initialize(colorspace = 2, width = A4[:width], height = A4[:height])
    # 2 == AiConstants::AiDocumentCMYKColor: if AiConstants did not const_load then retry load in this initialize method
    begin
      @application = WIN32OLE.connect('Illustrator.Application')
    rescue WIN32OLERuntimeError => err
      puts err
      puts 'Retry (WIN32OLE.new)' if $VERBOSE
      begin
        @application = WIN32OLE.new('Illustrator.Application')
      rescue WIN32OLERuntimeError => err
        puts err
        puts 'Can not connect nor create Illustrator.Application. Exit!'
        exit 1
      end # begin WIN32OLE.new
    end # begin WIN32OLE.connect
    WIN32OLE::const_load(@application, AiConstatnts) if AiConstants::ais==0

    @paper = @application.Documents.Add(colorspace, width, height)
    @defaults = get_defaults.clone.freeze
    @defaults.each_value{ |value| value.freeze }
  end # def initialize

  def destroy
    recover_defaults
    @paper.Close(AiDoNotSaveChanges)
  end # def destroy

end # class Illustrator

# # win32ole in the platform "Windows", not at the Mac OS
alias WIN32OLE WIN32OLE

# Our main wrapper for Illustrator (OLE): basic methods 
class Illustrator
  # We add basic methods to the above only initialized class;
  # miss
  # hevisides, defaults, file (document) accesses
  @@exports = Hash['Flash','.fls', 'GIF','.gif', 'Photoshop','.ps5', 'JPEG','.jpg', 'PNG24','.png', 'PNG8','.png', 'SVG','.svg']
  @@exports.freeze; @@exports.each_pair{ |word, ext| word.freeze; ext.freeze }
  @@saves = Hash['EPS','.eps', 'Illustrator','.ai', 'PDF','.pdf']
  @@saves.freeze; @@saves.each_pair{ |word, ext| word.freeze; ext.freeze }
  
  def self.hs(sign) # Heaviside function
    return 1 if sign.to_f > 0
    return 0 if sign.to_f < 0
    return 1/2.0
  end # def self.hs(sign) # Heaviside function
  def self.sh(heviside)
    heviside = heviside.to_f
    return +1 if heviside == 1
    return -1 if heviside == 0
    return  0 if heviside == 1/2.0

    return +1 if heviside > 1/2.0
    return -1 if heviside < 1/2.0
    return  0
  end # the inverse function of Heaviside function

  def self.mm2pt(mm)
    return mm*MM
  end # def self.mm2pt(mm)
  def self.pt2mm(pt)
    return pt/MM
  end # def self.mm2pt(mm)
  # cm, inch, pica, Q <-> point
  
  @@saves.each_key do |type|
  eval <<-EOS
    def self.#{type.downcase}SaveOptions
      return WIN32OLE.new('Illustrator.#{type}SaveOptions')
    end # def self.#{type.downcase}SaveOptions
  EOS
  end # Array['EPS', 'Illustrator', 'PDF'].each do |type|

  @@exports.each_key do |type|
  eval <<-EOS
    def self.#{type.downcase}SaveOptions
      return WIN32OLE.new('Illustrator.ExportOptions#{type}')
    end # def self.#{type.downcase}SaveOptions
  EOS
  end # Array['Flash', 'GIF', 'Photoshop', 'JPEG', 'PNG24', 'PNG8', 'SVG'].each do |type|

  def self.erase_tmp(path_or_name = '.')
    aitmp = %r{AI\d{6}\.tmp}
    path_or_name.gsub!(File::ALT_SEPARATOR, File::SEPARATOR) if File::ALT_SEPARATOR
    
    if aitmp =~ File.basename(path_or_name) then
      return File.delete(path_or_name) if FileTest.exist?(path_or_name) 
    end # end # if /AI\d{6}\.tmp/ =~ File.basename(path_or_name)

    num, names = 0, Dir.entries(File.dirname(path_or_name)).select{ |n| aitmp =~ n }
    names.each{ |n| num += File.delete(File.join(File.dirname(path_or_name), n)) }
    return num
  end # def self.erase_tmp(path_or_name = '.')

    
  def saveas(name = Time::now.strftime('%Y%m%d-%H%M%S'), options = Illustrator.illustratorSaveOptions, notmp = true)
    name.gsub!(File::ALT_SEPARATOR, File::SEPARATOR) if File::ALT_SEPARATOR
    name = File.join(Dir.pwd, name) if /\A[a-zA-Z]:/!~name
    name.gsub!(File::SEPARATOR, File::ALT_SEPARATOR) if File::ALT_SEPARATOR
    
    if options.respond_to?(:ole_name) then
      
      @@saves.each_pair do |type, ext|
        if options.ole_name == eval("Illustrator.#{type.downcase}SaveOptions.ole_name")
          name += ext if File.extname(name) != ext
          @paper.SaveAs(name, options)
          tmp = Illustrator.erase_tmp if notmp
          puts "We delete #{tmp} temporal file likes AI\d{6}.tmp" if notmp and $VERBOSE
          return name
        end # if options.ole_name == eval("Illustrator.#{type.downcase}SaveOptions.ole_name")
      end # saves.each_pair do |type, ext|

      @@exports.each_pair do |type, ext|
        if options.ole_name == eval("Illustrator.#{type.downcase}SaveOptions.ole_name")
          name += ext if File.extname(name) != ext
          eval("@paper.Export(name, Illustrator::Ai#{type}, options)")
          return name
        end # if options.ole_name == eval("Illustrator.#{type.downcase}SaveOptions.ole_name")
      end # exports.each_pair do |type, ext|
        
    end # if options.respond_to?(:ole_name)

    @@exports.each_pair do |type, ext|
      if options == eval("Illustrator::Ai#{type}")
        name += ext if File.extname(name) != ext
        @paper.Export(name, options)
        return name
      end # if options == eval("Illustrator::Ai#{type}")
    end # exports.each do |type|

    @paper.Export(name, options)
    return ''
  end # def saveas(name = Time::now.strftime('%Y%m%d-%H%M%S'), options = Illustrator.illustratorSaveOptions)

  DefaultItems = [:DefaultFillColor, :DefaultFilled, :DefaultFillOverprint, 
    :DefaultStrokeCap, :DefaultStrokeColor, :DefaultStroked,
    :DefaultStrokeDashes, :DefaultStrokeDashOffset, :DefaultStrokeJoin,
    :DefaultStrokeMiterLimit, :DefaultStrokeOverprint, :DefaultStrokeWidth #,
  ] # DefaultItems =
  def get_defaults
    defaults = Hash.new
    DefaultItems.each do |item|
      defaults[item] = @paper.__send__(item)
    end # DefaultItems.each do |item|
    return defaults
  end # def get_defaults
  def set_defaults(defaults)
    DefaultItems.each do |item|
      eval("@paper.#{item} = defaults[item]") if defaults.has_key?(item)
    end # DefaultItems.each do |item|
  end # def set_defaults(defaults)
  def recover_defaults
    set_defaults(@defaults)
  end # def recover_defaults
  
  def method_missing(name, *args)
    begin
      @paper.__send__(name, *args)
    rescue WIN32OLERuntimeError
      @application.__send__(name, *args)
    end
  end # def method_missing(name, *args)
  
end # class Illustrator # file and document

# Our main wrapper for Illustrator (OLE): PageItem..., Color(cmyk)...
class Illustrator
  # PageItem polymorphism
  PItemTypes = Array[:CompoundPathItem, :GraphItem, :GroupItem, :MeshItem,
   :PathItem, :PlacedItem, :PluginItem, :RasterItem, :SymbolItem, :TextArtItem ]
  PItemTypes.each{ |word| word.freeze }

  # Colors
  ColorValue = Hash[
    :gray      => [0, 0, 0, 50] .freeze ,
    :darkgray  => [0, 0, 0, 40] .freeze ,
    :silver    => [0, 0, 0, 30] .freeze ,
    :lightgray => [0, 0, 0, 20] .freeze ,
    :paleblue  => [60, 0, 0, 0] .freeze ,
    :pink      => [0, 50, 0, 0] .freeze ,
    :yyellow   => [0, 0, 70, 0] .freeze ,
#    :none => nil, # preserved, all zero or color-off
#    :on   => nil, # color-on (Stroked or Filled)
#    :off  => nil, # color-off (not Stroked or not Filled)
    ].freeze

  def self.cmyk(c=nil,m=nil,y=nil,k=nil)
    color = WIN32OLE.new('Illustrator.CMYKColor')
    color.cmyk(c,m,y,k) if c
    return color
  end # def self.cmyk(c=nil,m=nil,y=nil,k=nil)
  
end # class Illustrator # PageItem polymorphism

# We extent the class WIN32OLE, (sub)Objects of Illustrator.Aplication
# page item, collection object, cut and paste with its position_s
# CMYKColor, StrokeColor, FillColor
# Translate along the item
class WIN32OLE
  def pitem
#    return nil if not self.ole_name == '_PageItem' # raise ?
#    return nil if not self.respond_to?(:ole_methods) # raise ?
    return nil if not self.respond_to?(:ole_respond_to) # raise ?
    return nil if not self.ole_respond_to('PageItemType') # raise ?
    Illustrator::PItemTypes.each do |type|
      if self.PageItemType == eval("Illustrator::Ai#{type.to_s}")
        return self.__send__(type)
      end # if self.PageItemType == eval("Illustrator::Ai#{type.to_s}")
    end # Illustrator::pitemtypes.each do |type|
    self
  end # def pitem

  def col_to_a
#    return self # collection has the each method
    # A nil collection will return [] (an empty Array)
    return nil if not self.respond_to?(:ole_respond_to) # raise ?
    
    res = Array.new
    if self.ole_respond_to(:item) and self.ole_respond_to(:Count) then
      self.Count.times{ |i| res << self.item(i+1) }
    elsif self.respond_to?(:each)
      begin
        self.each{ |item| res << item }
      rescue WIN32OLERuntimeError
        return nil # raise ? or return self ?
        raise Exception.new("self.class #{self.class} is not kind of WIN32OLE:Collection")
      end # self.each{ |item| res << item }
    else # if self.ole_respond_to(:item) and self.ole_respond_to(:Count)
      raise Exception.new("self.class #{self.class} hss no method WIN32OLE:each")
    end # if self.ole_respond_to(:item) and self.ole_respond_to(:Count) 
    return res
  end # def col_to_a
  
  def [](key)
    # raise Exception.new('WIN32OLE<Illustrator>::Collection do not respond to item() .') if not self.ole_respond_to(:item)
    return nil if (not self.respond_to?(:ole_respond_to)) or (not self.ole_respond_to(:item))  # raise ?
    return nil if (key < 0) and (not self.ole_respond_to(:Count))  # raise ?
    key = self.Count + key if key < 0
    self.item(key+1)
  end # def [](key)
  def key_of(obj)
    # raise Exception.new('WIN32OLE<Illustrator>::Collection do not respond to Index() .') if not self.ole_respond_to(:Index)
    return nil if (not self.respond_to?(:ole_respond_to)) or (not self.ole_respond_to(:Index)) # raise ?
    self.Index(obj) - 1
  end # def key_of(obj)

  # colors, stroke and fill color
  Hash['filled' => ['Filled', 'FillColor'],
       'stroke' => ['Stroked','StrokeColor'] ].each_pair do |key, words|
  eval <<-EOD
    def color_#{key}(cname=:on)
      return nil if (not self.respond_to?(:ole_respond_to)) or (not self.ole_respond_to(:#{words[1]})) # raise ?
      cname = cname.intern if cname.respond_to?(:intern)
      case cname
      when :on
        self.#{words[0]} = true
      when :off
        self.#{words[0]} = false
      when :none
        color = self.#{words[1]}.CMYK # => CMYKColor or nil:NilClass
        color = Illustrator.cmyk if not color
        self.#{words[1]}.CMYK = color.cmyk(0,0,0,0)
      else
        self.#{words[0]} = true
        color = self.#{words[1]}.CMYK # => CMYKColor or nil:NilClass
        color = Illustrator.cmyk if not color
        self.#{words[1]}.CMYK = color.cmyk(Illustrator::ColorValue[cname])
      end # case cname
      self # if self.ole_respond_to(:.#{words[1]})
    end # def color_#{key}(cname=:on)
  EOD
  end #Hash['filled' => ['Filled', 'FillColor'],
      #     'stroke' => ['Stroked','StrokeColor'] ].each_pair do |key, words|
  alias colorF color_filled
  alias colorS color_stroke

  # colors Let CMYKcolors with Array
  def cmyk(c,m=nil,y=nil,k=nil)
    return nil if (not self.respond_to?(:ole_name)) or (not self.ole_name == '_CMYKColor') # raise ?
    c,m,y,k = c if c.kind_of?(Array)
    c,m,y,k = c[:Cyan], c[:Magenta], c[:Yellow], c[:Black] if c.kind_of?(Hash)
    self.Cyan, self.Magenta, self.Yellow, self.Black = c, m, y, k
    self
  end # def cmyk(c,m,y,k)

  # cut(copy) and paset with item's position
  ['cut', 'copy'].each do |cc|
  eval <<-EOD
    def #{cc}2paste(pastee)
      return nil if (not pastee.respond_to?(:ole_respond_to)) or (not pastee.ole_respond_to(:Paste))  # raise ?
      pos = self.Position
      item_type = self.ole_name.to_s
      self.#{cc.capitalize}
      pastee.Paste
      res = eval("pastee.\#{item_type[1..-1]}s")[0]
      res.Position, res.Selected = pos, false
      res
    end # def #{cc}2paset(pastee)
    def paste_#{cc}(item)
      return nil if (not self.respond_to?(:ole_respond_to)) or (not self.ole_respond_to(:Paste))  # raise ?
      pos = item.Position
      item_type = item.ole_name
      item.#{cc.capitalize}
      self.Paste
      res = eval("self.\#{item_type[1..-1]}s")[0]
      res.Position, res.Selected = pos, false
      res
    end # def paste_#{cc}(item)
  EOD
  end # ['Cut', 'Copy'].each do |cc|

  # We re-arrange the item(s) position along LCRTMB of a page item
  #   translate along LCRTMB of a page item.
  #   Left|Center|Right, Top|Mid|Bottom
  def translate_along(item, along=:MidCenter, bound=:G)#eometricBounds
    return nil if (not self.respond_to?(:ole_respond_to)) or (not self.ole_respond_to(:Translate))  # raise ?
    bound = bound.to_s if not bound.kind_of?(String)
    case bound
      when /C/i
        bounds = 'ControlBounds'
      when /G/i
        bounds = 'GeometricBounds'
      when /V/i
        bounds = 'VisibleBounds'
    end # case bound
    self_bounds = eval("self.#{bounds}")
    item_bounds = eval("item.#{bounds}")
    
    deltaX, deltaY = 0, 0
    along = along.to_s # if not along.kind_of?(String)
    if match = /[LCR]/i.match(along) then
      case match[0]
        when /L/i #eft
          deltaX = item_bounds[0] - self_bounds[0]
        when /R/i #ight
          deltaX = item_bounds[2] - self_bounds[2]
        when /C/i #enter
          deltaX = ((item_bounds[0]+item_bounds[2]) - (self_bounds[0]+self_bounds[2]))/2.0
      end # case match[0]
    end # if match = /[LCR]/.match(along)
    if match = /[TMB]/i.match(along) then
      case match[0]
        when /T/i #op
          deltaY = item_bounds[1] - self_bounds[1]
        when /B/i #ottom
          deltaY = item_bounds[3] - self_bounds[3]
        when /M/i #id #dle
          deltaY = ((item_bounds[1]+item_bounds[3]) - (self_bounds[1]+self_bounds[3]))/2.0
      end # case match[0]
    end # if match = /[TMB]/.match(along)
    
    self.Translate(deltaX, deltaY)
    self
  end # def translate_along(item, along=:CB, bound=:G)

  # We rotate an item upon the given pivot point
  def rotate_upon(deg, pivot=[0,0], mode=:degree)
    mode = mode.to_s if not mode.kind_of?(String)
    case mode
      when /\AD/i # egree
        degree = deg
      when /\AR/i # adian
        degree = deg*180/PI
      else
        degree = deg
    end # case mode
    center = self.GeometricBounds.center_rect
    pivot_to = pivot.rotate_upon(deg, center, mode)
    self.Rotate(degree)
    self.Translate(*(pivot.minus(pivot_to)))
    self
  end # def rotate_upon(deg, pivot=[0,0], mode=:degree)

end # class WIN32OLE # page item, collection object; colors

  
# Our main wrapper fro Illustrator (OLE)
class Illustrator # graphic methods
  # # bellow # # are to IllustRuby ???
  
  def poly_segment(points, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'), closed=nil)
    return nil if not points.kind_of?(Array) # raise ?
    points.each{ |pt| return nil if not pt.kind_of?(Array) } # raise ?

    pathitems = (layer.ole_name=='_PathItems')?layer:layer.PathItems
    res = pathitems.Add

    res.Name = name
    points.each do |pt|
      vtx = res.PathPoints.Add
      vtx.Anchor, vtx.LeftDirection, vtx.RightDirection = Array.new(3, pt)
    end # points.each do |pt|
    res.Closed = (true == closed) if not closed.instance_of?(NilClass)
    # (true==closed) is true only when closed is true, (closed and true) is false only when closed is false .
    # But when closed is nil (true==) is false and (and true) is nil, and when closed is '' (true==) is false and (==true) is nil .

    return res
  end # def poly_segment(points, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'), closed=false)
  
  def segment(startpt, endpt=startpt, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S') )
    return nil if not( startpt.kind_of?(Array) and endpt.kind_of?(Array) ) # raise ?
    
    return poly_segment([startpt, endpt], layer, name, false) 
  end # def segment(startpt, endpt, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S') )
  
  def segments(points, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'), closed=false)
    return nil if not points.kind_of?(Array) # raise ?
    points.each{ |pt| return nil if not pt.kind_of?(Array) } # raise ?
    return [] if points.size <= 0

    res = Array.new
    (points.size - 1).times{ |i| res << segment(points[i], points[i+1], layer, name+"_#{i.to_s}") }
    res << segment(points[-1], points[0], layer, name+"_#{(points.size-1).to_s}") if (true == closed)
    
    return res
  end # def segments(points, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'), closed=false)
   
  # polygon, square
  def pathfindout
  end
  
  def ellipse(left_top, width_height, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'), 
              reversed = true, inscribed = true)
    # inscribed or circumscribed means the ellipse NaiSetsu or GaiSetsu with a rectangle left_top to width_height.
    pathitems = (layer.ole_name=='_PathItems')?layer:layer.PathItems
    
    res = pathitems.Ellipse(left_top[1],left_top[0], width_height[0],width_height[1], reversed, inscribed)
    res.Name = name
    
    return res
  end # def ellipse(left_top, width_height, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'))
  def ellipse_c(center, r, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'), 
                reversed = true, inscribed = true)
    rx = ry = r
    if r.kind_of?(Array) # Fixnum.respond_to?(:[]) => true
      rx = ry = r[0]
      ry = r[1] if r.size>=2
    end # if r.respond_to?(:[])
    return ellipse([center[0]-rx, center[1]+ry], [rx*2, ry*2], layer, name, reversed, inscribed)
  end # def ellipse_c
  alias circle ellipse_c

  def arc
  end

end # class Illustrator # graphic methods

class Illustrator # text
  def textart(string='', center=[0,0], direction=0, scale=0.5, layer=self.ActiveLayer, name=nil, align='CC')
    return nil if not center.kind_of?(Array) # raise or commentout ?
    name = string.to_s if not name
    name = Time.now.strftime('%Y%m%d-%H%M%S') if name == ''
    
    textartitems = (layer.ole_name=='_TextArtItems')?layer:layer.TextArtItems
    res = textartitems.Add
#    res.Kind = AiPointText
#    res.Kind = AiPathText
#    res.Kind = AiAreaTextxt

    res.Contents, res.Name = string, name
    res.Resize(100*scale, 100*scale)
    res.Rotate(direction)

    # align Left|Center|Right + Top|Center|Bottom
    lr, tb = 1, 1
    if /L/i=~align then lr=0 elsif /R/i=~align then lr=2 end
    if /T/i=~align then tb=0 elsif /B/i=~align then tb=2 end
    res.Position = center.plus([-res.Width*lr/2.0, res.Height*tb/2.0])
    return res
  end # def textart(string='', center=[0,0], direction=0, scale=0.5, layer=self.ActiveLayer, name=nil)

end # class Illustrator # text

class Illustrator # arrow works
  # two poiinted arc
  def two_p_arc(spt, ept, layer=self.ActiveLayer, name=nil, sdir=[+2,+1], edir=sdir, ko=0.1)
    name = Time.now.strftime('%Y%m%d-%H%M%S') if not name
    arrow_h = ept.minus(spt)
    arrow_v = [arrow_h[1], -arrow_h[0]]

    svar = ko.multiply(sdir[0].multiply(arrow_h).plus(sdir[1].multiply(arrow_v)))
    arrow_h = -1.multiply(arrow_h)
    evar = ko.multiply(edir[0].multiply(arrow_h).plus(edir[1].multiply(arrow_v)))

    res = self.segment(spt, ept, layer, name)
    res.Filled, startpt, endpt  = false, res.PathPoints[0], res.PathPoints[1]

    startpt.PointType = AiEnumerations::AiSmooth
    startpt.RightDirection, startpt.LeftDirection = [startpt.Anchor.plus(svar)]*2

    endpt.PointType = AiEnumerations::AiSmooth
    endpt.LeftDirection, endpt.RightDirection = [endpt.Anchor.plus(evar)]*2

    res
  end # def two_p_arc(spt, ept, layer=self.ActiveLayer, name=nil, sdir=[+1,+1], edir=sdir, ko=false)

  # We will rename actions and action-file. We will be arrowize to the Class::method .
  def arrowize(path, mode='1')
    defaults = get_defaults
    name = path.name
    mode = mode.to_s if mode.class == Symbol
    case mode
    when '1',/^1/
      sname = 'myArrow'
    when '2',/^2/
      sname = 'myArrow2'
    when '5',/^5/
      sname = 'myArrow1_5'
    when 'd',/^d/i
      sname = 'myDoubleArrow'
    when 'w',/^w/i
      sname = 'myArrowWH'
    when 'b',/^b/i
      sname = 'myArrowBlow'
    else
      sname = 'myArrow'
    end # case mode
    
    @application.Selection = Array.new()
    path.Selected = true

    @application.DoScript(sname, 'myActions')

    sleep 0.23 while @application.ActionIsRunning
    selected = @application.Selection
    @application.Selection = Array.new()
    selected[0].name = name
    set_defaults(defaults)
    return selected[0]
  end # def arrowize(folding, path, mode=2)

  def arrow(spt, ept, mode='1', layer=self.ActiveLayer, name=nil, sdir=[+2,+1], edir=sdir, ko=0.1)
    name = Time.now.strftime('%Y%m%d-%H%M%S') if not name
    res = two_p_arc(spt, ept, layer, name, sdir, edir, ko)
    res = arrowize(res, mode)
    res
  end # def arrpw(spt, ept, mode='1', layer=self.ActiveLayer, name=nil, sdir=[+2,+1], edir=sdir, ko=0.1)
  
end # class Illustrator # arrow works

class Illustrator # color, line style
  # -> methods of the class WIN32OLE (PageItem)
end # class Illustrator # color, line style

class Illustrator # fill and filled object
  # -> methods of the class WIN32OLE (PageItem)
end # class Illustrator # fill and filled object

