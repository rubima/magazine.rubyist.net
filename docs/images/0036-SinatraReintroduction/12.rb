  require 'sinatra/base'
  require 'padrino-cache'

  class Application < Sinatra::Base
    register Padrino::Cache
    enable :caching

    get '/foo', :cache => true do
      expires_in 30 # expire cached version at least every 30 seconds
      'Hello world'
    end
  end
