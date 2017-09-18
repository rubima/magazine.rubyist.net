Name = TypeStruct.new(
  is_show: TypeStruct::Union.new(true, false), # trueもしくはfalse
  value: TypeStruct::Union.new(String, nil), # Stringもしくはnil
)
name = Name.new(
  is_show: true,
  value: nil,
)
p name.value = 'ksss' #=> 'ksss'
p name.is_show = nil
#=> TypeError: Name#is_show expect #<Union true|false> got nil
