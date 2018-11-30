class ChangeMatchPlayerMatch < ActiveRecord::Migration[5.2]
  def change
    remove_column :player_matches, :match, :integer
    add_column :player_matches, :smite_match_id, :integer
  end
end
