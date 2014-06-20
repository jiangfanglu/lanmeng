class PlayerGameStat < ActiveRecord::Base
  attr_accessible :assist, :block, :dunk, :player_id, :rebound, :score, :steal

  belongs_to :player
end
