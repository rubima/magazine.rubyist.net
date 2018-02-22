require "narray"
na = NArray.int(10).indgen!
str = 1
stop = 7
step = 2
p na[ str + step * NArray.to_na([0..((stop-str)/step)]) ]
