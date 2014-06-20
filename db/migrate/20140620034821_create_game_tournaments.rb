class CreateGameTournaments < ActiveRecord::Migration
  def change
    create_table :game_tournaments do |t|
      t.integer :game_id
      t.integer :tournament_id

      t.timestamps
    end
  end
end
