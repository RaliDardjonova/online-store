OrderStatus.delete_all
OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"

User.delete_all
password_salt = BCrypt::Engine.generate_salt
password_hash = BCrypt::Engine.hash_secret('admin123', password_salt)
User.create!(user_name: 'admin', email: 'admin@abv.bg', salt: password_salt, password_hash: password_hash, admin: true, status: 'active')
