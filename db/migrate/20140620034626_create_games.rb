class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :team_a_id
      t.integer :team_b_id
      t.integer :referal_id
      t.datetime :time
      t.integer :court_id

      t.timestamps
    end
  end
end
