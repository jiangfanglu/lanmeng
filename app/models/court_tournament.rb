class CourtTournament < ActiveRecord::Base
  attr_accessible :court_id, :tournament_id

  belongs_to :tournament
  belongs_to :court
end
