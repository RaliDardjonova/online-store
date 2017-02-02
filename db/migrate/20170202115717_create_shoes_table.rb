class CreateShoesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :shoes do |t|
      t.string :shoes_name
      t.text :description
      t.float :price
      t.integer :product_id
      t.float :size_min
      t.float :size_max
      t.string :color
      t.string :gender
      t.integer :amount
      t.string :category
    end
  end
end
