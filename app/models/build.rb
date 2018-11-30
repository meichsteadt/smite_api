class Build < ApplicationRecord
  belongs_to :player
  belongs_to :god
  has_many :items
end
