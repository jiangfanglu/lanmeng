class Zone < ActiveRecord::Base
  attr_accessible :name
  has_many :cities, foreign_key: :zone_id
end
