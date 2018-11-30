class AddTestBooleanMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :test, :boolean, default: false
  end
end
