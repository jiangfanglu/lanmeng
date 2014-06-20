class UserGroup < ActiveRecord::Base
  attr_accessible :name

  has_many :users, foreign_key: :user_group_id
end
