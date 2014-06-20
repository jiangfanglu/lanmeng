class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :number
      t.string :alias
      t.integer :user_id
      t.integer :total_score
      t.integer :total_rebound
      t.integer :total_assist
      t.integer :total_block
      t.integer :total_dunk
      t.integer :total_steal

      t.timestamps
    end
  end
end
