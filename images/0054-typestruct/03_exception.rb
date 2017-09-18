p NewClassName.new(
  key_1: '123',
  key_2: 'hello',
)
# TypeStruct::MultiTypeError:
# ...:in TypeError NewClassName#key_1 expect Integer got "123"

foo = NewClassName.new(
  key_1: 123,
  key_2: 'hello',
)
foo.key_1 = '123'
#=> TypeError: NewClassName#key_1 expect Integer got "123"
