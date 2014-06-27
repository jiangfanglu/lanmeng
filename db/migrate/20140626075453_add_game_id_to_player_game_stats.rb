class AddGameIdToPlayerGameStats < ActiveRecord::Migration
  def change
    add_column :player_game_stats, :game_id, :integer
  end
end
