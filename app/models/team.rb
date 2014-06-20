class Team < ActiveRecord::Base
  attr_accessible :captain_player_id, :description, :logo, :member_count, :name

  has_many :team_tournaments, foreign_key: :team_id
  has_many :tournaments, through: :court_tournaments

  has_one :team_stat, foreign_key: :team_id

  has_many :player_teams, foreign_key: :team_id
  has_many :players, through: :player_teams
end
