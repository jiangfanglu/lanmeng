class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :telephone
      t.string :username
      t.string :name
      t.string :password
      t.string :salt
      t.text :cart
      t.text :wishlist
      t.integer :newsletter
      t.integer :user_group_id,:default=>1
      t.string :ip
      t.integer :status,:default=>1
      t.string :token
      t.integer :thumbnail, :default=>0
      t.text :params
      t.integer :block,:default=>0

      t.timestamps
    end
  end
end
