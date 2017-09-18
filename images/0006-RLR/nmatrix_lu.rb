require "narray"

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
  begin
    h = hilbert(n)
    e = NMatrix.float(n,n).unit
    hi = e / h
    print "n=#{n}. Error in h*h^-1 : ", (e - h*hi).abs.max, "\n"
  rescue
    print "n=#{n}. COMPUTATION FAILED: ",$!,"\n"
  end
end
