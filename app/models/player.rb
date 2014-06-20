class Player < ActiveRecord::Base
  attr_accessible :alias, :number, :total_assist, :total_block, :total_dunk, :total_rebound, :total_score, :total_steal, :user_id
end
