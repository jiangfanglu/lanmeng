class GameTournament < ActiveRecord::Base
  attr_accessible :game_id, :tournament_id

  belongs_to :tournament
  belongs_to :game
end
