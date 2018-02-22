require 'syntax'

INF = +1.0/0
LOOP0 = (0..INF)
LOOP1 = (1..INF)
num = (("0".."9")*LOOP1).qualify{|x| x.to_s().to_i()}

expr = Syntax::Pass.new()

prim = num.qualify{|x| x[0]} | ("(" + expr + ")").qualify{|x| x[1]}

expr2 = (prim + (("*" | "/") + prim)*LOOP0).qualify{|x|
  val = x[0]
  x[1].each{|y|
    case y[0]
    when "*"; val *= y[1]
    when "/"; val /= y[1]
    end
  }
  val
}

expr << (expr2 + (("+" | "-") + expr2)*LOOP0).qualify{|x|
  val = x[0]
  x[1].each{|y|
    case y[0]
    when "+"; val += y[1]
    when "-"; val -= y[1]
    end
  }
  val
}

p(expr === RandomAccessStream.new("5-2*2"))
