class CreateGodRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :god_ranks do |t|
      t.integer :player_id
      t.integer :god_id
      t.integer :rank, default: 0

      t.timestamps
    end
  end
end
