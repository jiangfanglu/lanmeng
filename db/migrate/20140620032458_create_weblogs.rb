class CreateWeblogs < ActiveRecord::Migration
  def change
    create_table :weblogs do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.string :blog_type

      t.timestamps
    end
  end
end
