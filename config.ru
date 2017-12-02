require "bundler/setup"
Bundler.require(:default)
require "rack/rewrite"

run Rack::Jekyll.new(:destination => "_site")
use Rack::Rewrite do
  r301 %r{^/\?(.+)$}, '/changeurl.html?$1'
end
