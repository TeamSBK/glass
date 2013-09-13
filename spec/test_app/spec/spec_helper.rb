ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'request_helper'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include RequestHelper

  config.before(:each) do
    5.times do 
      User.create! name: "#{rand(100)}user", username: "#{rand(100)}myname", email: "#{rand(100)}email@email.com"
    end
  end
  config.after(:each) do
    User.delete_all
  end
end
