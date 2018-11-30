class CreateAbilityEffects < ActiveRecord::Migration[5.2]
  def change
    create_table :ability_effects do |t|
      t.integer :ability_id
      t.integer :duration_1
      t.integer :duration_2
      t.integer :duration_3
      t.integer :duration_4
      t.integer :duration_5
      t.boolean :cc
      t.string :description
      t.float :dot_every
      t.integer :min_percentage
      t.integer :max_percentage
      t.integer :progression_1
      t.integer :progression_2
      t.integer :progression_3
      t.integer :progression_4
      t.integer :progression_5
      t.float :scaling

      t.timestamps
    end
  end
end
