#! /usr/bin/env ruby

require 'benchmark/ips'

class Foo < Struct.new(:a, :b, :c)
end

Benchmark.ips do |x|
  x.report("Foo.new(1,2,3)") do
    Foo.new(1,2,3)
  end
  x.report("{a: 1, b: 2, c: 3}") do
    {a: 1, b: 2, c: 3}
  end
  x.compare!
end
