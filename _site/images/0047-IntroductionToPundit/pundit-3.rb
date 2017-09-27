  def policy!(user, record)
    PolicyFinder.new(record).policy!.new(user, record)
  end
