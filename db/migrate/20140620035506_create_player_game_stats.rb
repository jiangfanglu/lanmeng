class CreatePlayerGameStats < ActiveRecord::Migration
  def change
    create_table :player_game_stats do |t|
      t.integer :player_id
      t.integer :score
      t.integer :rebound
      t.integer :assist
      t.integer :block
      t.integer :dunk
      t.integer :steal

      t.timestamps
    end
  end
end
