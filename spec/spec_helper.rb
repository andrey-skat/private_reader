ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'database_cleaner'
require 'factory_girl'

require 'coveralls'
Coveralls.wear!

require './app'

def app
  PrivateReader
end

Dir[app.settings.root + '/spec/factories/**/*.rb'].each {|f| require f}
ActiveRecord::Base.default_timezone = :utc

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    FactoryGirl.reload
  end
end