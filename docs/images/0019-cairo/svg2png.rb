#!/usr/bin/env ruby

require "rsvg2"

if ARGV.size < 1
  puts "usage: #{$0} input.svg [scale_ratio]"
  exit(-1)
end

input, ratio = ARGV
ratio ||= 1.0
ratio = ratio.to_f

handle = RSVG::Handle.new_from_file(input)

width, height, = handle.dimensions.to_a
width *= ratio
height *= ratio

surface = Cairo::ImageSurface.new(Cairo::FORMAT_ARGB32, width, height)
context = Cairo::Context.new(surface)

context.scale(ratio, ratio)
context.render_rsvg_handle(handle)

surface.write_to_png(input.sub(/\.[^.]+$/i, '.png'))
