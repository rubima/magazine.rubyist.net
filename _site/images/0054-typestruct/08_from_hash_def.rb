require 'type_struct/ext'
module Type
  using TypeStruct::Union::Ext
  Position = TypeStruct.new(
    x: Numeric,
    y: Numeric,
    width: Numeric,
    height: Numeric,
    rotation: Numeric,
  )
  Circle = TypeStruct.new(
    type: "circle",
    circle_id: Integer,
    position: Position
  )
  Triangle = TypeStruct.new(
    type: "triangle",
    triangle_id: Integer,
    position: Position
  )
  Square = TypeStruct.new(
    type: "square",
    square_id: Integer,
    position: Position
  )
  Layer = TypeStruct.new(
    figures: ArrayOf(Circle | Triangle | Square),
  )
  Picture = TypeStruct.new(
    layers: ArrayOf(Layer),
  )
end
