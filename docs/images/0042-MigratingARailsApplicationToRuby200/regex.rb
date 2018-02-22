word = RUBY_VERSION < '1.9' ? '\w' : '\p{Word}'
regex = /#{word}/
