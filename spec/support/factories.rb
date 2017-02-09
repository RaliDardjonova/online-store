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
    #password is 'pesho123'
    salt  "$2a$10$kdz41f17DzXE.k.YFXqKoO"
    password_hash "$2a$10$kdz41f17DzXE.k.YFXqKoOxGyTvVj.UObePFSWYlII.9ry9UjStou"
  end

  factory :shoe do
    product_name 'adidas'
    description 'Описание на обувки adidas'
    price 60
    product_id 1
    size_min 40
    size_max 48
    color 'white'
    gender 'men'
    amount 50
    category 'sport'
    type 'Shoe'
  end

  factory :top do
    product_name 'bluza'
    description 'Описание на bluza'
    price 15
    product_id 1
    size_min 2
    size_max 5
    color 'white'
    gender 'women'
    amount 70
    category 'shirt'
    type 'Top'
  end

  factory :trouser do
    product_name 'pantaloni'
    description 'Описание на pantaloni'
    price 35
    product_id 1
    size_min 25
    size_max 32
    color 'green'
    gender 'unisex'
    amount 90
    category 'short-jeans'
    type 'Trouser'
  end

  factory :order_item do
    product_id 1
    order_id 1
    amount 1
    size 40
  end

  factory :order do
    user_name 'pesho'
    address 'na selo'
    #order_status_id '1'
  end

  factory :comment do
    user_name 'pesho'
    comment 'Коментар ще поставя аз тук'
    product_id 1
  end

  factory :order_status do
  end
end
