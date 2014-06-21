class TeamApplication < ActiveRecord::Base
  attr_accessible :applicant_user_id, :applied_team_id, :status

  belongs_to :team
  belongs_to :user
end
