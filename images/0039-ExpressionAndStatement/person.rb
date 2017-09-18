class Person
  def initialize(name, birth_year)
    @name = name
    @birth_year = birth_year
  end
  def hi
    return "My name is #{@name}, I was born in #{@birth_year}."
  end
end

person = Person.new('Taro', 1989)

puts person.hi
