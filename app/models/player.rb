class Player < ApplicationRecord
  has_many :player_matches
  has_many :matches, through: :player_matches
  has_many :god_ranks
  has_many :gods, through: :god_ranks

  def self.import_player(player_name, api = nil)
    unless api
      api = Api.new()
    end
    player_info = api.get_player(player_name).first
    date = parse_date(player_info["Created_Datetime"])
    if player_name
      Player.create(
        avatar: player_info["Avatar_URL"],
        created_datetime: date,
        smite_id: player_info["Id"],
        last_login_datetime: player_info["Last_Login_Datetime"],
        leaves: player_info["Leaves"],
        level: player_info["Level"],
        losses: player_info["Losses"] ,
        mastery_level: player_info["MasteryLevel"],
        name: player_info["Name"].split("]")[-1],
        rank_stat_duel: player_info["Rank_Stat_Duel"],
        rank_stat_conquest: player_info["Rank_Stat_Conquest"],
        rank_stat_joust: player_info["Rank_Stat_Joust"],
        region: player_info["Region"],
        team_id: player_info["TeamId"],
        team_name: player_info["Team_Name"],
        tier_conquest: player_info["Tier_Conquest"],
        tier_duel: player_info["Tier_Duel"],
        tier_joust: player_info["Tier_Joust"],
        total_achievements: player_info["Total_Achievements"],
        total_worshippers: player_info["Total_Worshippers"],
        wins: player_info["Wins"]
      )
    end
  end

  def self.parse_date(date)
    return Date.strptime(date, "%m/%d/%Y")
  end
end
