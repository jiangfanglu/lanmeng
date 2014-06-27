class Game < ActiveRecord::Base
  attr_accessible :court_id, :referal_id, :team_a_id, :team_b_id, :time

  has_many :game_tournaments, foreign_key: :game_id
  has_many :tournaments, through: :game_tournaments

  belongs_to :team_a, foreign_key: :team_a_id, :class_name=>"Team"
  belongs_to :team_b, foreign_key: :team_b_id, :class_name=>"Team"

  has_many :player_game_stats, foreign_key: :game_id
  has_many :game_stats, foreign_key: :game_id
  belongs_to :referee, foreign_key: :referal_id
  
  has_many :court_tournaments, foreign_key: :court_id
  has_many :tournaments, through: :court_tournaments

  belongs_to :court, foreign_key: :court_id

  def stat_enterred?
    self.game_stats.size > 0
  end
end
