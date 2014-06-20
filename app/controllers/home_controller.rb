class HomeController < ApplicationController
  include ApplicationHelper
  def index
  	redirect_to :controller=>"weblogs" if !current_city.blank? && params[:c].blank?
  	@zones = Zone.includes(:cities).all
  end

  def city
  	set_user_city params[:id]
  	redirect_to controller: :tournament
  end

  def tournament
  	set_user_tournament params[:id]
  	redirect_to controller: :teams
  end
end
