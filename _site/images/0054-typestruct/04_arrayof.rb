Name = TypeStruct.new(
  values: TypeStruct::ArrayOf.new(String)
)
name = Name.new(values: ['foo', 'bar', 'baz'])

p name.values
#=> ["foo", "bar", "baz"]

name.values = [1, 2, 3]
#=> TypeError: Name#values expect TypeStruct::ArrayOf(String) got [1, 2, 3]
