  require 'padrino-core'
  #...
  class App < Sinatra::Base
    # Sinatra 自体のログを disable
    disable :logging

    use Padrino::Logger::Rack, "/"
    #...
  end
