class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :avatar
      t.datetime :created_datetime
      t.integer :smite_id, default: 0
      t.datetime :last_login_datetime
      t.integer :leaves, default: 0
      t.integer :level, default: 0
      t.integer :losses, default: 0
      t.integer :mastery_level, default: 0
      t.string :name
      t.integer :rank_stat_duel, default: 0
      t.integer :rank_stat_conquest, default: 0
      t.integer :rank_stat_joust, default: 0
      t.string :region
      t.integer :team_id, default: 0
      t.string :team_name
      t.integer :tier_conquest, default: 0
      t.integer :tier_duel, default: 0
      t.integer :tier_joust, default: 0
      t.integer :total_achievements, default: 0
      t.integer :total_worshippers, default: 0
      t.integer :wins, default: 0

      t.timestamps
    end
  end
end
