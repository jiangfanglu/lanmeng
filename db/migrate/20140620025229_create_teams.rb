class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :logo
      t.text :description
      t.integer :member_count
      t.integer :captain_player_id

      t.timestamps
    end
  end
end
