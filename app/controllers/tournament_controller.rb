class TournamentController < ApplicationController
	include ApplicationHelper
  def index
  	redirect_to controller: :home if current_city.blank?
  	@city = City.find current_city
  	@tounaments = Tournament.where("city_id = ?", current_city)
  end

  def select
  	redirect_to controller: :home if current_city.blank?
  	@city = City.find current_city
  	@tounaments = Tournament.where("city_id = ?", current_city)
  end

  def selected
  	@team = Team.find_by_captain_player_id current_user.player.id
  	@team_tournament = TeamTournament.new(
  			team_id: @team.id,
  			tournament_id: params[:id].to_i
  		)
  	redirect_to :controller=>"teams", :action=>"captain_teams",:id=>0 if @team_tournament.save
  end
end
