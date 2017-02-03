class User < ActiveRecord::Base
  validates :user_name, presence: true, length: {minimum: 3, maximum: 20}, format: { with: /\A[a-zA-Z1-9_]+\z/,
    message: "приема само латински букви, цифри и _" }
    validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "Невалиден e-mail адрес."}

  has_many :comments

  def self.authenticate(user_name, password)
    user = find_by user_name: user_name
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end

  def find_products
    orders.unpurchased.map { |order| order.product  }
  end
end
