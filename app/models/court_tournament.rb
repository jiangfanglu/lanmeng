class CourtTournament < ActiveRecord::Base
  attr_accessible :court_id, :tournament_id

  validates_uniqueness_of :court_id, :scope => [:tournament_id]

  belongs_to :tournament
  belongs_to :court
end
