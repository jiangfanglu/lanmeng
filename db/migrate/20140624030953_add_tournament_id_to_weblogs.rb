class AddTournamentIdToWeblogs < ActiveRecord::Migration
  def change
    add_column :weblogs, :tournament_id, :integer
  end
end
