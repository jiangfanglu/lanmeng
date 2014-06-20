class Tournament < ActiveRecord::Base
  attr_accessible :name, :status, :team_count
end
