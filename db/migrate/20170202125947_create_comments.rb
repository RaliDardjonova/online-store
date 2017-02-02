class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :user_name
      t.text :comment
      t.datetime :date_time
      t.integer :product_id
    end
  end
end
