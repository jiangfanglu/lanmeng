class Team < ActiveRecord::Base
  attr_accessible :captain_player_id, :description, :logo, :member_count, :name

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :logo

  has_many :team_tournaments, foreign_key: :team_id
  has_many :tournaments, through: :team_tournaments

  has_one :team_stat, foreign_key: :team_id

  has_many :player_teams, foreign_key: :team_id
  has_many :players, through: :player_teams

  has_many :team_applications, foreign_key: :applied_team_id

  def applied? user_id
    TeamApplication.where("applicant_user_id =? and applied_team_id = ?",user_id, self.id ).count > 0
  end

  def joined? player_id
    PlayerTeam.where("player_id =? and team_id = ?",player_id, self.id ).count > 0
  end

  def joined_tournament?
    TeamTournament.where("team_id = ?", self.id).count > 0
  end
end
