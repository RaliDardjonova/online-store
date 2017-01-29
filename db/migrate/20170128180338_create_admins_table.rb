class CreateAdminsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
    t.string :admin_name
    t.string :salt1
    t.string :password_hash1
    t.string :salt2
    t.string :password_hash2
    end
  end
end
