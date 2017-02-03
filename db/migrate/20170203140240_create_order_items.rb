class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.belongs_to :product, index: true
      t.belongs_to :order, index: true
      t.float :unit_price
      t.integer :amount
      t.float :total_price
      t.string :size
      t.timestamps
    end
  end
end
