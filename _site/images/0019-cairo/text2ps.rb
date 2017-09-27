#!/usr/bin/env ruby

require 'pango'

input = ARGV.shift
output = input.sub(/\.[^.]+$/i, ".ps")

width = 595
height = 842

surface = Cairo::PSSurface.new(output, width, height)
context = Cairo::Context.new(surface)

layout = context.create_pango_layout
layout.text = File.read(input)
context.show_pango_layout(layout)

context.show_page

surface.finish
