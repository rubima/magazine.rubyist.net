require 'racknga'

# ...
use Racknga::Middleware::Deflater
# use Rack::ConditionalGet
# ...
run your_application
