class Game < ActiveRecord::Base
  attr_accessible :court_id, :referal_id, :team_a_id, :team_b_id, :time

  has_many :game_tournaments, foreign_key: :game_id
  has_many :tournaments, through: :game_tournaments

  has_many :game_stats, foreign_key: :game_id
  belongs_to :referee
  belongs_to :count 
end
