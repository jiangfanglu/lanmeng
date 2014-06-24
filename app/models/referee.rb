class Referee < ActiveRecord::Base
  attr_accessible :game_count, :name, :rating, :rating_count, :status,:user_id, :tournament_id
  has_many :games, foreign_key: :referee_id

  belongs_to :user
  belongs_to :tournament
end
