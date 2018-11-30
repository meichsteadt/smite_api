require 'uri'
class PlayerMatch < ApplicationRecord
  belongs_to :player
  belongs_to :match
  belongs_to :god, foreign_key: 'god_id', primary_key: 'smite_id'

  def self.lvl_breakdown(by = 10)
    lvls = {}
    PlayerMatch.pluck(:account_level).sort.each do |lvl|
      tens = lvl / by * by
      lvls[tens] ? lvls[tens] += 1 : lvls[tens] = 1
    end
    lvls
  end

  def self.import_player_matches(api = nil, every = 10)
    unless api
      api = Api.new()
    end
    matches = (Match.all - Match.joins(:player_matches)).pluck(:match_id)
    (matches.length.to_f/every).ceil.times do |t|
      break if api.count >= 14999
      max = [matches.length-1, (t+1)*every-1].min
      import_player_match(matches[t*every..max], api)
    end
  end

  def self.import_player_match(match_ids, api = nil)
    api.nil? ? api = Api.new() : false
    match_details = api.get_match_details_batch(match_ids)
    match_details.each do |pm|
      break if api.count >= 14999
      break unless pm["ret_msg"].nil?
      match = Match.find_by(match_id: pm["Match"])
      player_name =  pm["playerName"]
      if player_name === ""
        player = Player.find_by(name: "hidden player")
      else
        player = Player.find_by(name: player_name.split("]")[-1])
      end
      unless player
        begin
          name = URI::encode(player_name.split("]")[-1])
          player = Player.import_player(name, api)
        rescue
          player = Player.find_by(name: "hidden player")
        end
      end
      unless pm_exists?(pm, match)
        god = God.find_by(smite_id: pm["GodId"])
        player_match = create_player_match(pm, match, player, god)
      end
    end
    PlayerMatch.all.each {|e| e.update(
      kd: e.get_kd,
      kda: e.get_kda,
      kill_participation: e.get_kill_participation
    )}
  end

  def self.pm_exists?(pm, match)
    PlayerMatch.find_by(god_id: pm["GodId"], win_status: pm["Win_Status"], match_id: match.id)
  end

  def self.create_player_match(pm, match, player, god)
    match.player_matches.create(
      match_id: match.id,
      player_id: player.id,
      account_level: pm["Account_Level"],
      assists: pm["Assists"],
      damage_mitigated: pm["Damage_Mitigated"],
      damage_player: pm["Damage_Player"],
      damage_taken: pm["Damage_Taken"],
      deaths: pm["Deaths"],
      entry_datetime: pm["Entry_Datetime"],
      final_match_level: pm["Final_Match_Level"],
      god_id: pm["GodId"],
      gold_earned: pm["Gold_Earned"],
      gold_per_minute: pm["Gold_Per_Minute"],
      healing: pm["Healing"],
      kills_fire_giant: pm["Kills_Fire_Giant"],
      kills_first_blood: pm["Kills_First_Blood"],
      kills_gold_fury: pm["Kills_Gold_Fury"],
      kills_phoenix: pm["Kills_Phoenix"],
      kills_player: pm["Kills_Player"],
      mastery_level: pm["Mastery_Level"],
      smite_match_id: pm["Match"],
      minutes: pm["Minutes"],
      objective_assists: pm["Objective_Assists"],
      structure_damage: pm["Structure_Damage"],
      surrendered: pm["Surrendered"],
      time_in_match_seconds: pm["Time_In_Match_Seconds"],
      towers_destroyed: pm["Towers_Destroyed"],
      wards_placed: pm["Wards_Placed"],
      win_status: won?(pm["Win_Status"]),
      god_name: god.name,
      damage_player_thousands: pm["Damage_Player"].to_f/1000,
      damage_mitigated_thousands: pm["Damage_Mitigated"].to_f/1000,
      damage_taken_thousands: pm["Damage_Taken"].to_f/1000,
      structure_damage_thousands: pm["Structure_Damage"].to_f/1000
    )
  end

  def get_kd
    self.kills_player/[self.deaths.to_f, 1.0].max
  end

  def get_kda
    (self.kills_player + self.assists/2)/[self.deaths.to_f, 1.0].max
  end

  def get_kill_participation
    (self.kills_player + self.assists) / [PlayerMatch.where(match_id: self.match_id, win_status: self.win_status).sum(:kills_player).to_f, 1.0].max
  end

  def get_adj_gold_per_minute
    @gold_earned = self.gold_earned
    @minutes = self.minutes
    @towers_destroyed = self.match.player_matches.where(win_status: self.win_status).sum(:towers_destroyed)
    @gold_furys = self.match.player_matches.where(win_status: self.win_status).sum(:kills_gold_fury)
    @fire_giants = self.match.player_matches.where(win_status: self.win_status).sum(:kills_fire_giant)
    @phoenixes = self.match.player_matches.where(win_status: self.win_status).sum(:kills_phoenix)
    adj_gold_per_minute = (@gold_earned - 1500 - (3*self.time_in_match_seconds) - (350*@fire_giants) - (250 * @gold_furys) - (150 * @phoenixes))/@minutes.to_f
    self.update(adj_gold_per_minute: adj_gold_per_minute)
  end

  def self.won?(status)
    return status === "Winner" ? 1 : 0
  end

  def self.output_csv
    require 'csv'
    CSV.open("#{self.to_s.underscore}_output.csv", "w") do |row|
      keys = self.attribute_names
      keys.push("test", "roles")
      row << keys
      keys = keys.map {|m| if m === "test" || m === "roles"; m; else "player_matches." + m; end}
      self.includes(:match, :god).pluck(keys).each {|e| row << e}
    end
  end

  def self.output_god_roles_csv
    require 'csv'
    CSV.open("god_roles_output.csv", "w") do |row|
      keys = ["match_id", "guardians", "warriors", "mages", "hunters", "assassins", "win_status"]
      hash = {}
      PlayerMatch.includes(:god).pluck(:match_id, :win_status, :roles).each do |pm|
        hash[pm[0]] = {} unless hash[pm[0]]
        hash[pm[0]][pm[1]] = [] unless hash[pm[0]][pm[1]]
        hash[pm[0]][pm[1]] << pm[2]
      end
      row << keys
      hash.each do |k, v|
        @match_id = k
        v.each do |pmk, pmv|
          @win_status = pmk
          @guardians = pmv.count(" Guardian")
          @mages = pmv.count(" Mage")
          @hunters = pmv.count(" Hunter")
          @assassins = pmv.count(" Assassin")
          @warriors = pmv.count(" Warrior")
          row << [@match_id, @guardians, @warriors, @mages, @hunters, @assassins, @win_status]
        end
      end
    end
  end
end
