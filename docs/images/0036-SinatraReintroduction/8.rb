  configure :development do
    register Sinatra::Reloader
    set :server, "webrick"
  end
