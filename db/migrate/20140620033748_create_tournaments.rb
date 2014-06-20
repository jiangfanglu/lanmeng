class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :status
      t.integer :team_count

      t.timestamps
    end
  end
end
