class EditItemsTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :type, :string
    add_column :items, :item_type, :string
  end
end
