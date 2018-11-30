class CreateAbilities < ActiveRecord::Migration[5.2]
  def change
    create_table :abilities do |t|
      t.integer :god_id
      t.string :name
      t.integer :cost_rank_1
      t.integer :cost_rank_2
      t.integer :cost_rank_3
      t.integer :cost_rank_4
      t.integer :cost_rank_5
      t.integer :cooldown_rank_1
      t.integer :cooldown_rank_2
      t.integer :cooldown_rank_3
      t.integer :cooldown_rank_4
      t.integer :cooldown_rank_5
      t.string :ability_type
      t.string :affects
      t.string :dmg_type
      t.integer :range
      t.string :icon

      t.timestamps
    end
  end
end
