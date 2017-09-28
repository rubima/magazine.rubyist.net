  def index
    @users = policy_scope(User)
  end
