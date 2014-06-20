class TeamTournament < ActiveRecord::Base
  attr_accessible :team_id, :tournament_id

  belongs_to :tournament
  belongs_to :team
end
