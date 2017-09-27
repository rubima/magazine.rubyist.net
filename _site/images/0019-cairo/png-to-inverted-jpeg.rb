#!/usr/bin/env ruby

require 'gdk_pixbuf2'

input = ARGV.shift
output = input.sub(/\.png$/i, ".jpg")
pixbuf = Gdk::Pixbuf.new(input)
inverted_pixbuf = pixbuf.flip(false)
inverted_pixbuf.save(output, "jpeg")
