class TeamTournament < ActiveRecord::Base
  attr_accessible :team_id, :tournament_id

  validates_uniqueness_of :team_id, :scope => [:tournament_id]

  belongs_to :tournament
  belongs_to :team
end
