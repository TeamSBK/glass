require 'rubygems'
require 'bundler/setup'

require 'glass'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpec::Matchers

  config.before(:each) do

  end

  config.after(:each) do

  end
end

