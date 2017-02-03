class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.float :subtotal
      t.float :shipping
      t.float :total
      t.belongs_to :order_status, index: true
      t.string :user_name
      t.timestamps
    end
  end
end
