class Weblog < ActiveRecord::Base
  attr_accessible :blog_type, :content, :title, :user_id, :tournament_id

  belongs_to :user
end
