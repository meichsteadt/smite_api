class AbilityEffect < ApplicationRecord
  belongs_to :ability

  def self.import_ability_effects
    api = Api.new()
    api.create_session
    gods = api.gods
    gods.each do |g|
      @god = God.find_by(name: g["Name"])
      puts @god.name
      4.times do |t|
        rankitems = g["Ability_#{t + 1}"]["Description"]["itemDescription"]["rankitems"]
        rankitems.each do |item|
          progression = item[0]["value"].split(" ")[0]
          scaling = item[0]["value"].split(" (")[1].split("%")[0].to_f/100
        end
      end
    end
  end
end
