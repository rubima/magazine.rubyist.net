require 'racknga'
require 'racknga/middleware/cache'

use Rack::Middleware::JSONP

base_dir = Pathname.new(__FILE__).dirname.cleanpath.realpath
cache_database_path = base_dir + "var" + "cache" + "db"
use Racknga::Middleware::Cache, :database_path => cache_database_path.to_s

run your_application # "Content-Type: application/json"のレスポンスを返す
