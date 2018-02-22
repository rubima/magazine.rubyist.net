foo = NewClassName.new(
  key_1: 123,
  key_2: 'hello',
)
p foo # #<NewClassName key_1=123, key_2="hello">
p foo.key_1 #=> 123
p foo.key_2 #=> 'hello'

foo.key_1 = 0
foo.key_2 = 'world'
p foo #<NewClassName key_1=0, key_2="world">
p foo.key_1 #=> 0
p foo.key_2 #=> 'world'
