require "narray"
require "gsl"

def hilbert(n)
  h = NMatrix.float(n,n)
  for i in 0...n
    for j in 0...n
      h[j,i] = 1.0 / (i+j+1)
    end
  end
  h
end

[3,6,12,13].each do |n|
  h = hilbert(n)
  ghi = GSL::Linalg::LU.invert(h.to_gm_view)
  hi = NMatrix.refer( ghi.to_na )       # Simply ghi.to_nm if RubyGSL >= 1.6.3
  e = NMatrix.float(n,n).unit
  print "n=#{n}. Error in h*h^-1 : ", (e - h*hi).abs.max, "\n"
end
