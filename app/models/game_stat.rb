class GameStat < ActiveRecord::Base
  attr_accessible :game_id, :score, :team_id
  validates_uniqueness_of :game_id, :scope => [:team_id]
  belongs_to :game
end
