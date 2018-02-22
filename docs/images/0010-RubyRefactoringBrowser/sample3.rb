class Employee
  attr_reader :name
  def initialize(name, days)
    @name = name
    @days = days
  end
  
end

class Salesman < Employee
  def initialize(name, days, sales)
    super(name, days)
    @sales = sales
  end

  def base_salary
    if @days > 20
      @days*8000 + (@days - 20)*3000
    else
      @days*8000
    end
  end

  # 給料計算
  # 基本給 + 売上比例
  def salary
    base_salary + (@sales / 250)
  end
end

class Engineer < Employee
  # 給料計算
  # 基本給 + 技能給
  def salary
    if @days > 20
      @days*8000 + (@days - 20)*1000 + 20000
    else
      @days*8000 + 20000
    end
  end
end

def print_salary(p)
  print p.name, " ", p.salary, "\n"
end
  
if __FILE__ == $0
  okamoto = Engineer.new("Okamoto", 21)
  wada = Salesman.new("Wada", 17, 20_000_000)
  print_salary(okamoto)
  print_salary(wada)
end
