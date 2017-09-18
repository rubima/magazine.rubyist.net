#!/usr/bin/env ruby

require "poppler"

if ARGV.size < 1
  puts "usage: #{$0} input.pdf"
  exit(-1)
end

input = ARGV.shift
output = input.sub(/(\.[^.]+)$/, '-thumb\1')

columns = 3
rows = 2
pages_in_a_page = rows * columns

x_ratio = 1.0 / columns
y_ratio = 1.0 / rows

input_uri = GLib.filename_to_uri(File.expand_path(input))
document = Poppler::Document.new(input_uri)

first_page = document[0]
width, height = first_page.size
surface = Cairo::PDFSurface.new(output, width, height)
context = Cairo::Context.new(surface)

width_per_page = width / columns
height_per_page = height / rows

need_show_page = true
document.each_with_index do |page, i|
  row, column = i.divmod(columns)
  row = row.modulo(rows)
  x = width_per_page * column
  y = height_per_page * row
  context.save do
    context.translate(x, y)
    context.scale(x_ratio, y_ratio)
    context.render_poppler_page(page)

    context.set_source_rgb(0.2, 0.2, 0.2)
    context.rectangle(0, 0, width, height)
    context.stroke
  end

  need_show_page = ((i + 1) % pages_in_a_page).zero?
  context.show_page if need_show_page
end
context.show_page unless need_show_page

surface.finish
