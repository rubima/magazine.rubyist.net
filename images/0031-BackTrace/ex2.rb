def f1()
  f2()
end

def f2()
  f3()
end

def f3()
  p caller()    #=> ["ex2.rb:6:in `f2'", "ex2.rb:2:in `f1'", "ex2.rb:15"]
  #p caller(0)  #=> ["ex2.rb:11:in `f3'", "ex2.rb:6:in `f2'", "ex2.rb:2:in `f1'", "ex2.rb:15"]
  #p caller(2)  #=> ["ex2.rb:2:in `f1'", "ex2.rb:15"]
end

f1()