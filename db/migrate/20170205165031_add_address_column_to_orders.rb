class AddAddressColumnToOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :adress
    add_column :orders, :address, :text
  end
end
