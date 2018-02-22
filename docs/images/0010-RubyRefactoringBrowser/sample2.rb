class ShoppingBasket
  def initialize
    @basket = []
  end

  def add(item)
    @basket << item
  end

  def print_receipt
    print "**************************\n"
    print "*         KMC Mart       *\n"
    print "**************************\n"
    print "\n"
    
    @basket.each do |item|
      printf "- %-15s %7d\n", item.name, item.price
    end

    amount = @basket.inject(0){|r, item| r+item.price}

    print "--------------------------\n"
    printf "amount: %17d\n", amount
  end
end

class Commodity
  attr_reader :name, :price
  
  def initialize(name, price)
    @name = name
    @price = price
  end
end

if __FILE__ == $0
  chocolate = Commodity.new("YARA chocolate", 150)
  cookie = Commodity.new("OHII cookies", 100)
  candy = Commodity.new("AXY candy", 85)

  basket = ShoppingBasket.new
  basket.add(chocolate)
  basket.add(cookie)
  basket.add(candy)

  basket.print_receipt
end
