#!/usr/bin/env ruby
# There are the paper foldings diagram class definitions with Adobe Illustrator(10.0.3)
#   Author::    HShimura  (mailto:hs9587@yahoo.co.jp)
#   Copyright:: Copyright (c) 2004,5 HShimura
#   License::   Distributes under the same terms as Ruby
#   $Id: illustruby.rb,v 1.49 2005/03/21 06:48:33 hs9587 Exp $
#   $Name:  $

include Math
require 'illustruby/illustrator'

# Representative constants of Origam: Maekawa, Rakuda, ...
module OrigamiConstants
  Mkw	= Math::tan(Math::PI/8)
  MkwH	= (1.0 - Math::tan(Math::PI/8))

  MkwS	= Math::sin(Math::PI/8)
  MkwC	= Math::cos(Math::PI/8)
  
  # Rakuda Base Point
  # Mkw/(1+Mkw) = tanPI/8 /(1 + tanPi/8) = (sinPI/8 / cosPi/8) / (1 + sinPI/8 / cosPi/8) 
  #             = sinPI/8 /(cosPI/8 + sinPI/8)
  # 1/(1+Mkw)   = cosPI/8 /(cosPI/8 + sinPI/8)
  Rkd   = Math::sin(Math::PI/8)/(Math::cos(Math::PI/8) + Math::sin(Math::PI/8)) # smaller
  RkdH  = Math::cos(Math::PI/8)/(Math::cos(Math::PI/8) + Math::sin(Math::PI/8)) # bigger

  StrokeType = Hash[
#    :mountain => [5, 2, 0.5, 1, 0.5, 2].freeze ,
    :mountain => [5, 2, 0.7, 1.5, 0.7, 2].freeze ,
    :valley   => [4, 2].freeze ,
    :dotted   => [1, 1.5].freeze ,
#    :solid    => [].freeze
    :solid    => nil
    ].freeze
  StrokeWidth = Hash[
    :folding => 0.3 , # a stroke width of folding lines
#    :cutting => 1.0 , # a stroke width of basic or cutting lines 
    :cutting => 0.7 , # a stroke width of basic or cutting lines
    :arrows => 0.5 , # a stroke width of explanatin arrtows
    ].freeze

end # module OrigamiConstants


# Article is paged illustrubies
class Article
  attr_reader :pages
  attr_accessor :name
  def initialize(name=Time.now.strftime('article.%Y%m%d-%H%M%S'))
    @name = name
    @pages = Pages.new
  end # def initialize(name=Time.now.strftime('article.%Y%m%d-%H%M%S'))

  def addpage(left=0, bottom=left)
    @pages << Illustruby.new(left, bottom)
  end # def addpage(left=0, bottom=left)

  def pushpage(page=Illustruby.new)
    raise if not page.kind_of?(Illustruby) # !Duck
    @pages << page
  end # def pushpage(page=Illustruby.new)
end # class Article


# Our main class: the wraper and tools for Illustrator-Ruby
class Illustruby < Illustrator
  include Math
#  include AiConstants
  include OrigamiConstants
  
  #attr_reader :paper, :app # paper and application are Ilustrator::attr
  #attr_reader :margin, :size, :wide, :high
  attr_accessor :left, :bottom

  def initialize(left=0, bottom=left)
    @left, @bottom = left, bottom
    super()
  end # def initialize

  
  # glaphics

  def poly_segment(points, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'), closed=nil)
    super(points.mplus([@left, @bottom]), layer, name, closed)
  end # def poly_segment(points, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'), closed=nil)
  # the methods: segment, segments are of poly_segment
  
  def ellipse(left_top, width_height, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'), 
              reversed = true, inscribed = true)
    super(left_top.plus([@left, @bottom]), width_height, layer, name, reversed, inscribed)
  end # def ellipse(left_top, width_height, layer=self.ActiveLayer, name=Time.now.strftime('%Y%m%d-%H%M%S'))
  # the method: circle, ellipse_c are of ellipse

  # We over write the method 'arrow' with arrow! width.
  def arrow(spt, ept, mode='1', layer=self.ActiveLayer, name=nil, sdir=[+2,+1], edir=sdir, ko=0.1)
    name = Time.now.strftime('%Y%m%d-%H%M%S') if not name
    res = two_p_arc(spt, ept, layer, name, sdir, edir, ko).arrows!
    res = arrowize(res, mode)
    res
  end # def arrpw(spt, ept, mode='1', layer=self.ActiveLayer, name=nil, sdir=[+2,+1], edir=sdir, ko=0.1)

  
  # text
  
  def textart(string='', center=[0,0], direction=0, scale=0.5, layer=self.ActiveLayer, name=nil, align='CC')
    super(string, center.plus([@left, @bottom]), direction, scale, layer, name, align)
  end # def textart(string='', center=[0,0], direction=0, scale=0.5, layer=self.ActiveLayer, name=nil)
  
end # class Illustruby


# stroke type and stroke width of PathItem segment ,
class WIN32OLE # Illustruby
  # stroke type and stroke width of PathItem segment ,
  strokes = Illustruby::StrokeType
  strokes.each_pair do |key, value|
    eval <<-EOD
    def #{key.to_s}!
      self.StrokeDashes = #{value.inspect}
      self.StrokeWidth = Illustruby::StrokeWidth[:folding]
      self # if self.ole_respond_to(:StrokeDashes)
    end
    EOD
  end # Illsutruby::StrokeType.each_pair do |key, value|

  strokes = Illustruby::StrokeWidth
  strokes.each_pair do |key, value|
    eval <<-EOD
    def #{key.to_s}!
      self.StrokeWidth = #{value.inspect}
      self # if self.ole_respond_to(:StrokeWidth)
    end
    EOD
  end # Illsutruby::StrokeWidth.each_pair do |key, value|

end # class WIN32OLE # Illustruby
