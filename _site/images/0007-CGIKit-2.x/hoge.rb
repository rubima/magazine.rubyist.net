require 'cgikit'
require 'webrick'
require 'cgikit/webrick'

class HogePage < CGIKit::Component
  attr_accessor :title
  
  def init
    @title = 'Hoge'
  end
  
end

class FooPage < CGIKit::Component
  
  attr_accessor :body
  
  def init
    @body = 'FOO'
  end
  
end

class HogeAction < CGIKit::DirectAction
  
  def hoge_action
    a = page(HogePage)
    a.title = a.title + ' ' + Time.now.strftime('%Y%m%d') 
    a
  end
  
  def foo_action
    a = page(FooPage)
    a.body = a.body + ' ' + rand(10).to_s
    a
  end
  
  alias default_action hoge_action
  
end



if $0 == __FILE__
  port = (ARGV.shift || 8080).to_i
  
  app = CGIKit::Application.new
  app.direct_action_class = HogeAction
  
  server = WEBrick::HTTPServer.new({:Port => port})
  server.mount('/', WEBrick::CGIKitServlet::ApplicationHandler, app)
  
  trap("INT"){ server.shutdown }
  server.start  
end
