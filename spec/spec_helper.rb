ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'capybara/rspec'
require 'rack/test'

require_relative '../app'

require_relative 'support/database_cleaner'
require_relative 'support/factories'


Capybara.configure do |config|
  config.app = Sinatra::Application
end

RSpec.configure do |config|
  config.include Capybara::DSL

end
