class CreatePlayerMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :player_matches do |t|
      t.integer :match_id
      t.integer :player_id
      t.integer :account_level
      t.integer :active_id_1
      t.integer :active_id_2
      t.integer :active_id_3
      t.integer :active_id_4
      t.integer :assists
      t.string :ban_1
      t.string :ban_10
      t.integer :ban_10_id
      t.integer :ban_1_id
      t.string :ban_2
      t.integer :ban_2_id
      t.string :ban_3
      t.integer :ban_3_id
      t.string :ban_4
      t.integer :ban_4_id
      t.string :ban_5
      t.integer :ban_5_id
      t.string :ban_6
      t.integer :ban_6_id
      t.string :ban_7
      t.integer :ban_7_id
      t.string :ban_8
      t.integer :ban_8_id
      t.string :ban_9
      t.integer :ban9_id
      t.integer :camps_cleared
      t.integer :conquest_losses
      t.integer :conquest_points
      t.integer :conquest_tier
      t.integer :conquest_wins
      t.integer :damage_bot
      t.integer :damage_done_in_hand
      t.integer :damage_done_magical
      t.integer :damage_done_physical
      t.integer :damage_mitigated
      t.integer :damage_player
      t.integer :damage_taken
      t.integer :damage_taken_magical
      t.integer :damage_taken_physical
      t.integer :deaths
      t.integer :distance_traveled
      t.integer :duel_losses
      t.integer :duel_points
      t.integer :duel_tier
      t.integer :duel_wins
      t.datetime :entry_datetime
      t.integer :final_match_level
      t.string :first_ban_side
      t.integer :god_id
      t.integer :gold_earned
      t.integer :gold_per_minute
      t.integer :healing
      t.integer :healing_bot
      t.integer :healing_player_self
      t.integer :item_id_1
      t.integer :item_id_2
      t.integer :item_id_3
      t.integer :item_id_4
      t.integer :item_id_5
      t.integer :item_id_6
      t.string :item_active_1
      t.string :item_active_2
      t.string :item_active_3
      t.string :item_active_4
      t.string :item_purch_1
      t.string :item_purch_2
      t.string :item_purch_3
      t.string :item_purch_4
      t.string :item_purch_5
      t.string :item_purch_6
      t.integer :joust_losses
      t.integer :joust_points
      t.integer :joust_tier
      t.integer :joust_wins
      t.integer :killing_spree
      t.integer :kills_bot
      t.integer :kills_double
      t.integer :kills_fire_giant
      t.integer :kills_first_blood
      t.integer :kills_gold_fury
      t.integer :kills_penta
      t.integer :kills_phoenix
      t.integer :kills_player
      t.integer :kills_quadra
      t.integer :kills_siege_juggernaut
      t.integer :kills_single
      t.integer :kills_triple
      t.integer :kills_wild_juggernaut
      t.string :map_game
      t.integer :mastery_level
      t.integer :match
      t.integer :minutes
      t.integer :multi_kill_max
      t.integer :objective_assists
      t.integer :party_id
      t.integer :rank_stat_conquest
      t.integer :rank_stat_duel
      t.integer :rank_stat_joust
      t.string :reference_name
      t.string :region
      t.string :skin
      t.integer :skin_id
      t.integer :structure_damage
      t.integer :surrendered
      t.integer :task_force
      t.integer :team_1_score
      t.integer :team_2_score
      t.integer :team_id
      t.string :team_name
      t.integer :time_in_match_seconds
      t.integer :towers_destroyed
      t.integer :wards_placed
      t.string :win_status
      t.integer :winning_task_force
      t.string :has_replay
      t.integer :match_queue__id
      t.string :name
      t.integer :player_id
      t.string :player_name
      t.string :god_name

      t.timestamps
    end
  end
end