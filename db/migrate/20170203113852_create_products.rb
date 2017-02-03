class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
    t.string :product_name
    t.text :description
    t.float :price
    t.integer :product_id
    t.float :size_min
    t.float :size_max
    t.string :size
    t.string :color
    t.string :gender
    t.integer :amount
    t.string :category
    t.string :type
    end
  end
end
