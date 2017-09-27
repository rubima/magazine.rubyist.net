module Monban
  module ControllerHelpers
    # Sign up a user
    #
    # @note Uses the {Monban::Services::SignUp} service to create a user
    #
    # @param user_params [Hash] params containing lookup and token fields
    # @yield Yields to the block if the user is signed up successfully
    # @return [Object] returns the value from calling perform on the {Monban::Services::SignUp} service
    def sign_up user_params
      Monban.config.sign_up_service.new(user_params).perform.tap do |status|
        if status && block_given?
          yield
        end
      end
    end

# 後略
