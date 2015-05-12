class AddUrlToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :url, :string, comment: '电影网址'
  end
end
