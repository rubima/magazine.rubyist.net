require 'sample_tdp4r_1'
class MyCalc
  def expr1
    n = nil;
    (rule(:expr2) >> proc{|x| n = x[0] }) -
    ((token("+")|token("-")) - rule(:expr2) >> proc{|x|
      case x[0]
      when "+"; n += x[1]
      when "-"; n -= x[1]
      end
      n
    })*0 >> proc{ n }
  end

  def expr2
    n = nil;
    (rule(:prim) >> proc{|x| n = x[0] }) -
    ((token("*")|token("/")) - rule(:prim) >> proc{|x|
      case x[0]
      when "*"; n *= x[1]
      when "/"; n /= x[1]
      end
      n
    })*0 >> proc{ n }
  end
end

calc = MyCalc.new
puts("5-2*(5-2*2) = " + calc.parse("5-2*(5-2*2)").to_s())
