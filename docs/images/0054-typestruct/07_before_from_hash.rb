composition = Composition.new
json["layers"].each do |layer|
  layer["figures"].each do |figure|
    case figure["typo"]
    when "circle"
      circle = Circle.find(figure["circle_id"])
      image = circle.download
      composition.add(image, figure["position"])
    when "triangle"
      # ...
    when "square"
      # ...
    end
  end
end
composition.to_png
