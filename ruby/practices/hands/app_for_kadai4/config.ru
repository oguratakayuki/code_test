use Rack::Reloader, 0
require "./dummy_app"
run DummyApp.new
