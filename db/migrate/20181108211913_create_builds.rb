class CreateBuilds < ActiveRecord::Migration[5.2]
  def change
    create_table :builds do |t|
      t.integer :god_id
      t.integer :item1_id
      t.integer :item1_id
      t.integer :item1_id
      t.integer :item1_id
      t.integer :item1_id
      t.integer :item1_id
      t.integer :active1_id
      t.integer :active2_id
      
      t.timestamps
    end
  end
end
