class CreateReferees < ActiveRecord::Migration
  def change
    create_table :referees do |t|
      t.string :name
      t.integer :game_count
      t.integer :rating
      t.integer :rating_count
      t.integer :status

      t.timestamps
    end
  end
end
