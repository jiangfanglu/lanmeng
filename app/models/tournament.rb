class Tournament < ActiveRecord::Base
  attr_accessible :name, :status, :team_count, :city_id

  belongs_to :city, foreign_key: :city_id

  has_many :court_tournaments, foreign_key: :tournament_id
  has_many :courts, through: :court_tournaments

  has_many :team_tournaments, foreign_key: :tournament_id
  has_many :teams, through: :team_tournaments

  has_many :game_tournaments, foreign_key: :tournament_id
  has_many :games, through: :game_tournaments

  has_many :referees, foreign_key: :tournament_id
end
