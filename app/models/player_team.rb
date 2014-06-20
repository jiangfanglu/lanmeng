class PlayerTeam < ActiveRecord::Base
  attr_accessible :player_id, :team_id

  belongs_to :team
  belongs_to :player
end
