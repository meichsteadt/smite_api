class Ability < ApplicationRecord
  belongs_to :god
  has_many :ability_effects

  def self.import_abilities
    api = Api.new()
    gods = api.gods
    gods.each do |g|
      @god = God.find_by(name: g["Name"])
      puts @god.name
      5.times do |t|
        abil = g["Ability_#{t + 1}"]
        name = abil["Summary"]
        icon = abil["URL"]
        cooldowns = abil["Description"]["itemDescription"]["cooldown"].remove("s").split("/")
        costs = abil["Description"]["itemDescription"]["cost"].split("/")
        ability_type = abil["Description"]["itemDescription"]["menuitems"][0]["value"]
        affects = abil["Description"]["itemDescription"]["menuitems"][1]["value"] if abil["Description"]["itemDescription"]["menuitems"].length > 2
        dmg_type = abil["Description"]["itemDescription"]["menuitems"][2]["value"] if abil["Description"]["itemDescription"]["menuitems"].length > 2
        range = abil["Description"]["itemDescription"]["menuitems"][3]["value"] if abil["Description"]["itemDescription"]["menuitems"].length > 3
        if cooldowns.length < 5
          4.times do
            cooldowns << cooldowns[0]
          end
        end
        if costs.length < 5
          4.times do
            costs << costs[0]
          end
        end
        Ability.create(
          god_id: @god.id,
          name: name,
          icon: icon,
          cooldown_rank_1: cooldowns[0],
          cooldown_rank_2: cooldowns[1],
          cooldown_rank_3: cooldowns[2],
          cooldown_rank_4: cooldowns[3],
          cooldown_rank_5: cooldowns[4],
          cost_rank_1: costs[0],
          cost_rank_2: costs[1],
          cost_rank_3: costs[2],
          cost_rank_4: costs[3],
          cost_rank_5: costs[4],
          ability_type: ability_type,
          affects: affects,
          range: range.to_i,
          dmg_type: dmg_type
        )
      end
    end
  end
end
