class TournamentController < ApplicationController
	include ApplicationHelper
  def index
  	redirect_to controller: :home if current_city.blank?
  	@city = City.find current_city
  	@tounaments = Tournament.where("city_id = ?", current_city)
  end
end
