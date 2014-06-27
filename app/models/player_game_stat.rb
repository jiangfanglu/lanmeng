class PlayerGameStat < ActiveRecord::Base
  attr_accessible :assist, :block, :dunk, :player_id, :rebound, :score, :steal

  belongs_to :player, foreign_key: :player_id

  belongs_to :game, foreign_key: :game_id
end
