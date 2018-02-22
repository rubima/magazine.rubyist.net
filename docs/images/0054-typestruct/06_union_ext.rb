using TypeStruct::Union::Ext
Foo = TypeStruct.new(
  num: Integer | nil #=> Integerもしくはnil
  name: Regexp | String #=> RegexpもしくはString
)
