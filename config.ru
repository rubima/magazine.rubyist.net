require "bundler/setup"
Bundler.require(:default)
run Rack::Jekyll.new(:destination => "_site")

