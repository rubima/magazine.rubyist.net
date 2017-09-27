#$ruby = "C:/ruby/bin/ruby.exe"
 
#########################################
#########################################

require 'webrick'

$ruby = $ruby || File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name']) + ".exe"

module WEBrick
  module HTTPServlet
    FileHandler.add_handler("rb", CGIHandler)
  end
end

def start_webrick(config = {})
  conf = {
    :Port => 8080,
    :CGIInterpreter => $ruby,
  }
  config.update(conf)  
  server = WEBrick::HTTPServer.new(config)
  yield server if block_given?
  ['INT', 'TERM'].each {|signal| 
    trap(signal) {server.shutdown}
  }
  server.start
end

start_webrick {|server|
  cgi_dir = File.dirname( File.expand_path(__FILE__) )
  server.mount("/", WEBrick::HTTPServlet::FileHandler, cgi_dir, {:FancyIndexing=>true})
}
