class Admin < ActiveRecord::Base
  validates :admin_name, presence: true, length: {minimum: 3, maximum: 20}, format: { with: /\A[a-zA-Z1-9_]+\z/,
    message: "приема само латински букви, цифри и _" }

    def self.authenticate(user_name, password1, password2)
    user = find_by admin_name: user_name
    if user && user.password_hash1 == BCrypt::Engine.hash_secret(password1, user.salt1) && user.password_hash2 == BCrypt::Engine.hash_secret(password2, user.salt2)
      user
    else
      nil
    end
  end
end
