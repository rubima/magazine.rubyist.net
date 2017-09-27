#!/usr/bin/env ruby

require 'gtk2'
require 'rsvg2'
require 'poppler'

if ARGV.size != 1
  puts "Usage: #{$0} IMAGE"
  exit 1
end

input = ARGV.first

case input
when /\.pdf/i
  document = Poppler::Document.new(input)
  size = Proc.new do
    document[0].size
  end
  draw = Proc.new do |context|
    context.render_poppler_page(document[0])
  end
when /\.svg/i
  handle = RSVG::Handle.new_from_file(input)
  size = Proc.new do
    dim = handle.dimensions
    [dim.width, dim.height]
  end
  draw = Proc.new do |context|
    context.render_rsvg_handle(handle)
  end
else
  pixbuf = Gdk::Pixbuf.new(input)
  size = Proc.new do
    [pixbuf.width, pixbuf.height]
  end
  draw = Proc.new do |context|
    context.set_source_pixbuf(pixbuf)
    context.paint
  end
end

window = Gtk::Window.new
window.set_default_size(*size.call)
window.signal_connect("destroy") do
  Gtk.main_quit
  false
end

drawing_area = Gtk::DrawingArea.new
drawing_area.signal_connect("expose-event") do |widget, event|
  context = widget.window.create_cairo_context
  x, y, w, h = widget.allocation.to_a
  context.save do
    image_width, image_height = size.call
    context.scale(w / image_width.to_f, h / image_height.to_f)
    draw.call(context)
  end
  true
end

window.add(drawing_area)
window.show_all

Gtk.main
