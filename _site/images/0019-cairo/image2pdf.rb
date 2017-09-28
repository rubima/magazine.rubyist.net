#!/usr/bin/env ruby

require 'gdk_pixbuf2'
require 'cairo'

input = ARGV.shift
output = input.sub(/\.[^.]+$/i, ".pdf")

pixbuf = Gdk::Pixbuf.new(input)
width = pixbuf.width
height = pixbuf.height

surface = Cairo::PDFSurface.new(output, width, height)
context = Cairo::Context.new(surface)

context.set_source_pixbuf(pixbuf)
context.paint
context.show_page

surface.finish
