class CreateTeamApplications < ActiveRecord::Migration
  def change
    create_table :team_applications do |t|
      t.integer :applicant_user_id
      t.integer :applied_team_id
      t.integer :status

      t.timestamps
    end
  end
end
