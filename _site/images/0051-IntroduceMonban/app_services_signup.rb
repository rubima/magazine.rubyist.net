# app/services/sign_up.rb
module Services
  class SignUp
    def initialize(user_params)
      @user_params = user_params
    end

    def perform
      User.new(@user_params) {|user|
        user.update(password_digest: Monban.hash_token(@user_params[:password])) if user.valid?
      }
    end
  end
end
