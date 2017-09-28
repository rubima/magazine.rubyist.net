class UsersController < ApplicationController
  before_action :pundit_auth
 
  ...
 
  private
    def pundit_auth
      authorize User.new
    end

