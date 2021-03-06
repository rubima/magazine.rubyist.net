require 'abnf'
fmt = <<EOS
  expr  = prim 0*(op prim)
  prim  = ["("] num [")"]
  op    = "+" | "-" | "*" | "/"
EOS
numfmt = <<EOS
  num   = 1*("0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9")
EOS
r1  = ABNF.parse(fmt)
r2  = ABNF.parse(numfmt)
r1.merge(r2)
reg = r1.regexp()
num = r2.regexp()
str = "3+(2-1)は4です。33(23)は33と(23)に区別されます。"
str.gsub(reg){|expr| p expr; expr.gsub(num){|n| p n} }
