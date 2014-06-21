class Player < ActiveRecord::Base
  attr_accessible :alias, :number, :total_assist, :total_block, :total_dunk, :total_rebound, :total_score, :total_steal, :user_id

  validates_format_of :number, :with => /\d+/
  validates_presence_of :number
  validates_presence_of :alias

  has_many :player_teams, foreign_key: :player_id
  has_many :teams, through: :player_teams
  has_many :player_game_stats, foreign_key: :player_id
  belongs_to :user

  def owns_team?
  	Team.where("captain_player_id = ?", self.id).count > 0
  end
end
