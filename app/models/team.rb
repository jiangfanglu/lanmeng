class Team < ActiveRecord::Base
  attr_accessible :captain_player_id, :description, :logo, :member_count, :name
end
