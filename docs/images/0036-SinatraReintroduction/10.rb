  require 'sinatra/base'
  require 'padrino-helpers'

  class Application < Sinatra::Base
    register Padrino::Helpers
  end
