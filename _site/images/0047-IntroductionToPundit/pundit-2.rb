  def policy(record)
    @policy or Pundit.policy!(pundit_user, record)
  end
  attr_writer :policy
  
  def pundit_user
    current_user
  end
