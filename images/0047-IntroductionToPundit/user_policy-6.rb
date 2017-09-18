class Scope < Struct.new(:user, :scope)
  def resolve
    if user.admin?
      scope.all
    else
      scope.except_admin
    end
  end
end
