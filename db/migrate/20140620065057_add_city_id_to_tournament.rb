class AddCityIdToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :city_id, :integer
  end
end
