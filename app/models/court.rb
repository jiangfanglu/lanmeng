class Court < ActiveRecord::Base
  attr_accessible :latitude, :location, :longitude, :name

  has_many :court_tournaments, foreign_key: :court_id
  has_many :tournaments, through: :court_tournaments

  has_many :games, foreign_key: :court_id
end
