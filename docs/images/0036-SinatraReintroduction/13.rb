  # gem を追記
  require 'padrino-helpers'

  class App < Sinatra::Base
    #...
    register Padrino::Helpers

    #...
    get '/' do
      haml :index
    end

    #...
  end
