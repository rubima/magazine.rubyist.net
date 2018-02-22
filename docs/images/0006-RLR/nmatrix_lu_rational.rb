require "narray"
require "rational"

def hilbert(n)
  h = NMatrix.object(n,n)
  for i in 0...n
    for j in 0...n
      h[j,i] = Rational(1, i+j+1)
    end
  end
  h
end

[3,6,12,13].each do |n|
  begin
    h = hilbert(n)
    e = NMatrix.object(n,n).fill!(0).unit
    hi = e / h
    print "n=#{n}. Error in h*h^-1 : ", (e - h*hi).abs.max, "\n"
    print "     max and min of h^-1 : #{hi.max}, #{hi.min}\n"
  rescue
    print "n=#{n}. COMPUTATION FAILED: ",$!,"\n"
  end
end
