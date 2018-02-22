# 普通の Ruby
class MyClass
  def my_method(num)
    while 0 < num
      if num % 2 == 0
        puts num
      end
      num -= 1
    end
  end
end
MyClass.new.my_method(10)
