class God < ApplicationRecord
  has_many :god_ranks
  has_many :builds
  has_many :abilities
  has_many :player_matches, primary_key: 'smite_id', foreign_key: 'god_id'

  def win_percent
    self.player_matches.where(win_status: "Winner").count.to_f/self.player_matches.count
  end

  def self.most_played(lvl_min = 0, lvl_max = 200)
    God.all.joins(:player_matches).group(:id).where("account_level >= ? AND account_level <= ?", lvl_min, lvl_max).order('COUNT(player_matches.god_name) DESC').pluck(:name, 'COUNT(player_matches.god_name)')
  end

  def self.most_played_roles(lvl_min = 0, lvl_max = 200)
    roles = {}
    God.all.joins(:player_matches).group(:id).where("account_level >= ? AND account_level <= ?", lvl_min, lvl_max).order('COUNT(player_matches.god_name) DESC').pluck(:roles, 'COUNT(player_matches.god_name)').each do |god|
      roles[god[0]] ? roles[god[0]] += god[1] : roles[god[0]] = god[1]
    end
    roles
  end

  def self.wins_by_god(lvl_min = 0, lvl_max = 200)
    wins = God.all.joins(:player_matches).group(:id).where("account_level >= ? AND account_level <= ?", lvl_min, lvl_max).where(player_matches: {win_status: 1}).order('COUNT(player_matches.god_name) DESC').pluck(:name, 'COUNT(player_matches.god_name)').to_h
    all = God.most_played(lvl_min, lvl_max).to_h
    wins.each {|k,v| wins[k] = (v.to_f/all[k]).round(8)}.sort_by {|k,v| v}.to_h
  end

  def self.wins_by_role(lvl_min = 0, lvl_max = 200)
    roles = {}
    God.all.joins(:player_matches).group(:id).where("account_level >= ? AND account_level <= ?", lvl_min, lvl_max).where(player_matches: {win_status: 1}).order('COUNT(player_matches.god_name) DESC').pluck(:roles, 'COUNT(player_matches.god_name)').each do |god|
      roles[god[0]] ? roles[god[0]] += god[1] : roles[god[0]] = god[1]
    end
    all = God.most_played_roles(lvl_min, lvl_max).to_h
    roles.each {|k,v| roles[k] = (v.to_f/all[k]).round(4)}.sort_by {|k,v| v}.to_h
  end

  def self.match_includes(god_name, percent = false, lvl_min = 0, lvl_max = 200)
    with_god = Match.joins(:player_matches).where("account_level >= ? AND account_level <= ? AND god_name = ?", lvl_min, lvl_max, god_name).uniq.count
    if percent
      return ((with_god / Match.joins(:player_matches).where("account_level >= ? AND account_level <= ?", lvl_min, lvl_max).uniq.count.to_f) * 100).round(2).to_s + "%"
    end
    with_god
  end

  def self.import_gods(api = nil)
    unless api
      api = Api.new()
    end
    gods = api.gods
    gods.each{|e| import_god(e)}
  end

  def self.import_god(god)
    God.create(god_card: god['godCard_URL'],
            god_icon: god["godIcon_URL"],
            smite_id: god["id"],
            attack_speed: god["AttackSpeed"],
            attack_speed_per_level: god["AttackSpeedPerLevel"],
            hp5_per_level: god["HP5PerLevel"],
            health: god["Health"],
            health_per_five: god["HealthPerFive"],
            health_per_level: god["HealthPerLevel"],
            mp5_per_level: god["MP5PerLevel"],
            magic_protection: god["MagicProtection"],
            magic_protection_per_level: god["MagicProtectionPerLevel"],
            magical_power: god["MagicalPower"],
            magical_power_per_level: god["MagicalPowerPerLevel"],
            mana: god["Mana"],
            mana_per_five: god["ManaPerFive"],
            mana_per_level: god["ManaPerLevel"],
            name: god["Name"],
            pantheon: god["Pantheon"],
            physical_power: god["PhysicalPower"],
            physical_power_per_level: god["PhysicalPowerPerLevel"],
            physical_protection: god["PhysicalProtection"],
            physical_protection_per_level: god["PhysicalProtectionPerLevel"],
            roles: god["Roles"],
            speed: god["Speed"],
            god_type: god["Type"],
          )
  end
end
