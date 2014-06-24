class TeamStat < ActiveRecord::Base
  attr_accessible :lose, :team_id, :win

  belongs_to :team, foreign_key: "team_id"
end
