class CreateGameStats < ActiveRecord::Migration
  def change
    create_table :game_stats do |t|
      t.integer :game_id
      t.integer :team_id
      t.integer :score

      t.timestamps
    end
  end
end
