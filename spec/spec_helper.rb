require 'rubygems'
require 'bundler/setup'
require 'rspec/rails'
require 'factories'
require 'database_cleaner'

require 'glass'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpec::Matchers
  config.include Warden::Test::Helpers

  config.before(:each) do
    DatabaseCleaner.start
    RailsAdmin::Config.reset
    login_as User.create(
      :email => "username@example.com",
      :password => "password"
    )
  end

  config.after(:each) do
    Warden.test_reset!
    DatabaseCleaner.clean
  end


end

