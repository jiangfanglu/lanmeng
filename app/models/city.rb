class City < ActiveRecord::Base
  attr_accessible :name, :zone_id
  belongs_to :zone
  has_many :tournaments, foreign_key: :city_id
end
