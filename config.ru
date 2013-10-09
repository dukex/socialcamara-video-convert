require './app'

use Rack::CommonLogger
use Rack::ShowExceptions
use Rack::Lint
use Rack::Static, :urls => ["/video"], :root => "public"

run App.new
