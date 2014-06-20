class Game < ActiveRecord::Base
  attr_accessible :court_id, :referal_id, :team_a_id, :team_b_id, :time
end
