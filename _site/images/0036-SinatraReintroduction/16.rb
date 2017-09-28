  require 'padrino-core'
  require 'padrino-cache'

  class App < Sinatra::Base
    # Sinatra::Reloader とは相性が悪いのでコメントアウトする
    #...
    set :app_name, "App"
    register Padrino::Routing
    register Padrino::Cache
    enable :caching

    #...
    get '/heavy_contents', :cache => true do
      expires_in 60 # 60 秒でキャッシュクリア
      sleep 5 # とても重い処理の代わり
      "Process done!"
    end
  end
