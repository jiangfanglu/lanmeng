class Player < ActiveRecord::Base
  attr_accessible :alias, :number, :total_assist, :total_block, :total_dunk, :total_rebound, :total_score, :total_steal, :user_id

  has_many :player_teams, foreign_key: :player_id
  has_many :teams, through: :player_teams
  has_many :player_game_stats, foreign_key: :player_id
  belongs_to :user

end
