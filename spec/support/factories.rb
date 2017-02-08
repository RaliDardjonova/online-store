require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do

  factory :user do
    user_name 'pesho'
    email 'user_name@mail.com'
    admin false
    status 'active'
  end

end
