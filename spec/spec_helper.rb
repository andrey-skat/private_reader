ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'

require './app'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.include Rack::Test::Methods
end

def app
  PrivateReader
end