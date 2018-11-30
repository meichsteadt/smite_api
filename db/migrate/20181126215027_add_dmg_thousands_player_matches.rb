class AddDmgThousandsPlayerMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :player_matches, :damage_player_thousands, :float
    add_column :player_matches, :damage_mitigated_thousands, :float
    add_column :player_matches, :damage_taken_thousands, :float
    add_column :player_matches, :structure_damage_thousands, :float
    add_column :player_matches, :kd, :float
    add_column :player_matches, :kda, :float
    add_column :player_matches, :kill_participation, :float
  end
end
