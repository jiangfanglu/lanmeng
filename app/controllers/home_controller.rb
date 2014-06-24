class HomeController < ApplicationController
  include ApplicationHelper
  def index
  	#redirect_to :controller=>"weblogs" if !current_city.blank? && params[:c].blank?
  	   @zones = Zone.includes(:cities).all

    @weblogs = Weblog.where("blog_type = 'G'").order("created_at desc")
  end

  def city
  	set_user_city params[:id]
  	redirect_to controller: :tournament
  end

  def tournament
     @tournamet = Tournament.find params[:id]
  	   @teams = Team.joins(:tournaments).where("tournaments.id = ?", params[:id])

     @team_ids = @teams.collect{|t| t.id }
     @team_ladder = Team.includes(:team_stat).where("teams.id in (?)", @team_ids).order("(team_stats.win/(team_stats.win+team_stats.lose)) desc")

     @weblogs = Weblog.where("blog_type = 'Z' and tournament_id = ? ", @tournamet.id).order("created_at desc")

     @games = Game.includes(:court).includes(:team_a).includes(:team_b).includes(:referee).joins(:game_tournaments).where("game_tournaments.tournament_id = ? and time >= ?", params[:id], Time.now).order("games.created_at desc")
      #set_user_tournament params[:id]
  	  #redirect_to controller: :teams
  end
end
