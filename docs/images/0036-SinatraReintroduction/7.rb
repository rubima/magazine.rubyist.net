  class App < Sinatra::Base
    enable :inline_templates
    enable :logging
    set :server, "webrick"
    register Sinatra::Reloader
    #...
  end
