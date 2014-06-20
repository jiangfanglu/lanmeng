class Referee < ActiveRecord::Base
  attr_accessible :game_count, :name, :rating, :rating_count, :status
end
