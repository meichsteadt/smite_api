class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :child_item_id
      t.string :device_name
      t.integer :icon_id
      t.integer :item_id
      t.integer :item_tier
      t.integer :price
      t.string :restricted_roles
      t.integer :root_item_id
      t.string :short_desc
      t.boolean :starting_item
      t.string :type
      t.string :item_icon_url
      t.boolean :active

      t.timestamps
    end
  end
end
