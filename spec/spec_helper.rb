ENV["RAILS_ENV"] = 'test'
require 'rspec'
require 'glass'
require 'rspec-expectations'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpec::Matchers
  config.include RSpec::Expectations

  config.before(:each) do
    Glass::Config.reset
  end

  config.after(:each) do
  end

end

