require Rails.root.join('app/services/sign_up')

Monban.configure do |config|
  config.sign_up_service = Services::SignUp
end
