class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.string :name
      t.string :location
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
