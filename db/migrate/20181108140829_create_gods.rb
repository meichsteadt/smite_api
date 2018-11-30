class CreateGods < ActiveRecord::Migration[5.2]
  def change
    create_table :gods do |t|
      t.string :god_card
      t.string :god_icon
      t.integer :smite_id
      t.float :attack_speed
      t.float :attack_speed_per_level
      t.float :hp5_per_level
      t.integer :health
      t.integer :health_per_five
      t.integer :health_per_level
      t.float :mp5_per_level
      t.integer :magic_protection
      t.float :magic_protection_per_level
      t.integer :magical_power
      t.float :magical_power_per_level
      t.integer :mana
      t.float :mana_per_five
      t.integer :mana_per_level
      t.string :name
      t.string :pantheon
      t.integer :physical_power
      t.float :physical_power_per_level
      t.integer :physical_protection
      t.float :physical_protection_per_level
      t.string :roles
      t.integer :speed
      t.string :god_type
      t.integer :basic_attack_dmg
      t.float :basic_attack_dmg_per_level
      t.float :basic_attack_progression, array: true, :default => [] 

      t.timestamps
    end
  end
end
