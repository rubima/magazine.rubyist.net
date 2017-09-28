#!/usr/bin/env ruby

require 'gdk_pixbuf2'
require 'cairo'

input, margin = ARGV
output = input.sub(/\.[^.]+$/i, ".pdf")

margin ||= 10
margin = Integer(margin)

pixbuf = Gdk::Pixbuf.new(input)
width = pixbuf.width + 2 * margin
height = pixbuf.height + 2 * margin

surface = Cairo::PDFSurface.new(output, width, height)
context = Cairo::Context.new(surface)

context.translate(margin, margin)
context.set_source_pixbuf(pixbuf)
context.paint

context.show_page

surface.finish
