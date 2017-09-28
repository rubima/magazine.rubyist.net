class UserPolicy < ApplicationPolicy
  def update?
    user.admin?
  end

