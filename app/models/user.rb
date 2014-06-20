class User < ActiveRecord::Base
  attr_accessible :block, :cart, :email, :ip, :name, :newsletter, :params, :password, :salt, :status, :telephone, :thumbnail, :token, :user_group_id, :username, :wishlist

  has_one :player, foreign_key: :user_id
  has_one :referee, foreign_key: :user_id
  belongs_to :user_group
  has_many :weblogs, foreign_key: :user_id

  # has_many :follows, foreign_key: :followed_id
  # has_many :fans, through: :follows

  # has_many :follows, foreign_key: :follower_id
  # has_many :idols, through: :follows

  def set_token
    self.token = Digest::SHA2.hexdigest "#{username}-#{lastvisitDate.to_i}" if self.token.blank?
  end

  def user_type
    self.user_group.name
  end

  def followed? followed_id
    Follow.where("followed_id = ? and follower_id = ?",followed_id, self.id ).exists?
  end

  def create_token
    self.token = gen_encrypt self.salt
  end
end
