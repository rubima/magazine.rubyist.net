require "narray"

class NArray
  # differentiate along the dim-th dimension:
  #   self[.., 1..-1, ..] - self[.., 0..-2, ..]
  def diff(dim)
    idx1 = [true]*dim + [1..-1, false]
    idx2 = [true]*dim + [0..-2, false]
    self[*idx1].sbt!( self[*idx2] )   # sbt! : destructive subtraction
  end
end

nx = 5
ny = 4
x = NArray.float(nx,1).indgen!
y = NArray.float(1,ny).indgen!
na = x * y
p na, na.diff(1)
