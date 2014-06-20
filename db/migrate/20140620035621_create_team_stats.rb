class CreateTeamStats < ActiveRecord::Migration
  def change
    create_table :team_stats do |t|
      t.integer :win
      t.integer :lose
      t.integer :team_id

      t.timestamps
    end
  end
end
