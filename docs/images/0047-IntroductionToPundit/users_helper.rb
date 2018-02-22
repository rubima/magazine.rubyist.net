module UsersHelper
  def user_show?(user = current_user)
    Pundit.policy(user, User.new).show?
  end
 
  def user_edit?(user = current_user)
    Pundit.policy(user, User.new).edit?
  end
 
  def user_destroy?(user = current_user)
    Pundit.policy(user, User.new).destroy?
  end
 
  def user_create?(user = current_user)
    Pundit.policy(user, User.new).create?
  end
end
