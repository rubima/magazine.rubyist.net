require 'yaml'
require 'type_struct/ext'
Bar = TypeStruct.new(
  baz: ArrayOf(Integer),
)
Foo = TypeStruct.new(
  bar: Bar,
  qux: String,
)
Root = TypeStruct.new(
  foo: Foo,
)
Root.from_hash(YAML.load_file("config.yml"))
#=> TypeStruct::MultiTypeError:
t.rb:13:in TypeError Foo#qux expect String got nil
