require 'tdp'
class MyCalc
  include TDParser

  def expr1
    rule(:expr2) - ((token("+")|token("-")) - rule(:expr2))*0 >> proc{|x|
      n = x[0]
      x[1].each{|y|
        case y[0]
        when "+"; n += y[1]
        when "-"; n -= y[1]
        end
      }
      n
    }
  end

  def expr2
    rule(:prim) - ((token("*")|token("/")) - rule(:prim))*0 >> proc{|x|
      n = x[0]
      x[1].each{|y|
        case y[0]
        when "*"; n *= y[1]
        when "/"; n = n / y[1]
        end
      }
      n
    }
  end

  def prim
    token(/\d+/)                           >> proc{|x| x[0].to_i } |
    token("(") - rule(:expr1) - token(")") >> proc{|x| x[1] }
  end

  def parse(str)
    tokens = str.split(/(?:\s+)|([\(\)\+\-\*\/])/).select{|x| x != ""}
    expr1.parse(tokens)
  end
end

calc = MyCalc.new
puts("5-2*(5-2*2) = " + calc.parse("5-2*(5-2*2)").to_s())
