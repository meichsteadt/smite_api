class Match < ApplicationRecord
  has_many :player_matches
  has_many :players, through: :player_matches
  validates :match_id, uniqueness: true

  scope :without_children, -> {left_outer_joins(:player_matches).where(player_matches: { id: nil })}

  def self.import_matches(hour = nil, api = nil, date = nil, test = false, queue_id = 426)
    unless api
      api = Api.new()
    end
    matches = api.get_match_ids_by_queue(queue_id, hour = hour, date = date)
    matches.each do |match|
      Match.create(match_id: match, test: test)
    end
  end

  def get_match_details(api)
    api.get_match_details(self.match_id)
  end

  def delete_children
    self.player_matches.destroy_all
  end

  def self.incomplete
    Match.group(:id).joins(:player_matches).having("count(player_matches.id) < 10").count
  end
end
