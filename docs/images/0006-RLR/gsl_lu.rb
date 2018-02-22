require "gsl"

def hilbert(n)
  # 実は GSL::Matrix にはクラスメソッドとして hilbert があるのだがデモのため
  h = GSL::Matrix.new(n,n)
  for i in 0...n
    for j in 0...n
      h[i,j] = 1.0 / (i+j+1)
    end
  end
  h
end

[3,6,12,13].each do |n|
  h = hilbert(n)
  hi = GSL::Linalg::LU.invert(h)
  e = GSL::Matrix.unit(n)
  diff = e - h*hi
  err = [ diff.max, -diff.min ].max      # diff.abs.max if rbgsl >= 1.6.3
  print "n=#{n}. Error in h*h^-1 : ", err, "\n"
end
