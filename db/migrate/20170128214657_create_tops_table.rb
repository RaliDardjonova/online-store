class CreateTopsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :tops do |t|
    t.string :top_name
    t.text :description
    t.float :price
    t.integer :product_id
    t.float :size
    t.float :color
    t.string :gender
    t.integer :amount
    t.string :category
    end
  end
end
