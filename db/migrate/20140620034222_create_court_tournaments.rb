class CreateCourtTournaments < ActiveRecord::Migration
  def change
    create_table :court_tournaments do |t|
      t.integer :court_id
      t.integer :tournament_id

      t.timestamps
    end
  end
end
