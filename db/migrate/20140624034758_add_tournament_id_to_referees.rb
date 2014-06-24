class AddTournamentIdToReferees < ActiveRecord::Migration
  def change
    add_column :referees, :tournament_id, :integer
  end
end
