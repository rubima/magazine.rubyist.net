require 'sample_tdp4r_1'
class FastCalc < MyCalc
  def expr1
    @expr1 ||= super()
  end

  def expr2
    @expr2 ||= super()
  end

  def prim
    @prim ||= super()
  end
end

calc = FastCalc.new
puts("5-2*(5-2*2) = " + calc.parse("5-2*(5-2*2)").to_s())
