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

  def game_stats
    @tournament = Tournament.find params[:id]

    @games = Game.includes(:team_a).includes(:team_b).joins(:game_tournaments).where("game_tournaments.tournament_id = ? and time >= ?", params[:id], Time.now).order("games.created_at desc")
    @games = @games.select{|game| game.stat_enterred? }
    @game = params[:gid] ? Game.find(params[:gid]) : @games.first

    @team_a_player_ids = @game.team_a.players.collect{|p|p.id}
    @team_b_player_ids = @game.team_b.players.collect{|p|p.id}

    @player_game_stats_team_a = PlayerGameStat.includes(:player).where("game_id = ? and player_id in (?)", @game.id, @team_a_player_ids)
    @player_game_stats_team_b = PlayerGameStat.includes(:player).where("game_id = ? and player_id in (?)", @game.id, @team_b_player_ids)
  end
end
