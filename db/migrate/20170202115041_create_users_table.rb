class CreateUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :salt
      t.string :password_hash
      t.boolean :admin
    end
  end
end
