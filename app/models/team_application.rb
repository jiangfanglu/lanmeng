class TeamApplication < ActiveRecord::Base
  attr_accessible :applicant_user_id, :applied_team_id, :status

  validates_uniqueness_of :applicant_user_id, :scope => [:applied_team_id]

  belongs_to :team
  belongs_to :user, foreign_key: :applicant_user_id
end
