class User < ActiveRecord::Base
  attr_accessible :block, :cart, :email, :ip, :name, :newsletter, :params, :password, :salt, :status, :telephone, :thumbnail, :token, :user_group_id, :username, :wishlist
end
