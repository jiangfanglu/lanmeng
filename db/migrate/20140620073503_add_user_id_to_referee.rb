class AddUserIdToReferee < ActiveRecord::Migration
  def change
    add_column :referees, :user_id, :integer
  end
end
