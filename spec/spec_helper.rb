ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'capybara/rspec'
require 'rack/test'
require "rack_session_access"
require "rack_session_access/capybara"
require_relative '../app'

require_relative 'support/database_cleaner'
require_relative 'support/factories'
ActiveRecord::Base.establish_connection

Capybara.configure do |config|
  config.app = Sinatra::Application
end

#Capybara.javascript_driver = :rack_test

RSpec.configure do |config|
  config.include Capybara::DSL
  #config.include Rack::Test::Methods
end

use RackSessionAccess::Middleware
