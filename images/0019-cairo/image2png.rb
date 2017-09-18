#!/usr/bin/env ruby

require 'gdk_pixbuf2'

input = ARGV.shift
output = input.sub(/\.[^.]+$/i, ".png")
Gdk::Pixbuf.new(input).save(output, "png")
