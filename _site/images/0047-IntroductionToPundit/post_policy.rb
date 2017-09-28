# app/policies/post_policy.rb
class PostPolicy < ApplicationPolicy
  def permitted_attributes
    if user.admin? || user.owner_of?(post)
      [:title, :body, :tag_list]
    else
      [:tag_list]
    end
  end
end
