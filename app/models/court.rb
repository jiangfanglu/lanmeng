class Court < ActiveRecord::Base
  attr_accessible :latitude, :location, :longitude, :name
end
