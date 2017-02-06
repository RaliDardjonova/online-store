class RemoveSizeColumnFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :size
    add_column :orders, :adress, :text
  end
end
