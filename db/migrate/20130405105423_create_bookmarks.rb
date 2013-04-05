class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :title
      t.string :link
      t.integer :category_id
      t.integer :user_id
      t.boolean :star, default: false
      t.boolean :inbox, default: false
      t.text :note

      t.timestamps
    end
  end
end
