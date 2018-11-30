class EditWinStatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :player_matches, :win_status, :string
    add_column :player_matches, :win_status, :integer
  end
end
