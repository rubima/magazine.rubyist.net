  def authorize(record, query=nil)
    query ||= params[:action].to_s + "?"
    @_policy_authorized = true
   
    policy = policy(record)
    unless policy.public_send(query)
      error = NotAuthorizedError.new("not allowed to #{query} this #{record}")
      error.query, error.record, error.policy = query, record, policy
      
      raise error
    end
   
    true
  end
