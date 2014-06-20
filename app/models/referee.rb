class Referee < ActiveRecord::Base
  attr_accessible :game_count, :name, :rating, :rating_count, :status
  has_many :games, foreign_key: :referee_id

  belongs_to :user
end
