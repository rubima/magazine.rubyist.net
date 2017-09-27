  def can?(ability)
    (user.ability.include?(record.class.to_s.underscore) && user.ability[record.class.to_s.underscore].include?(ability))
  end

