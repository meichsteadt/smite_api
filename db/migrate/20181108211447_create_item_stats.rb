class CreateItemStats < ActiveRecord::Migration[5.2]
  def change
    create_table :item_stats do |t|
      t.integer :item_id
      t.string :stat_type
      t.integer :value
      t.boolean :percentage

      t.timestamps
    end
  end
end
