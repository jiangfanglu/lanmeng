class GameStat < ActiveRecord::Base
  attr_accessible :game_id, :score, :team_id
end
