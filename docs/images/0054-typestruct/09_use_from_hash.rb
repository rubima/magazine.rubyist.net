composition = Composition.new
Type::Picture.from_hash(json).layers.each do |layer|
  layer.figures.each do |figure|
    case figure
    when Type::Circle
      circle = ::Circle.find(figure.circle_id)
      image = circle.download
      composition.add(image, figure.position)
    when Type::Triangle
      # ...
    when Type::Square
      # ...
    end
  end
end
composition.to_png
