class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.string :username
      t.string :email
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
  end
end
