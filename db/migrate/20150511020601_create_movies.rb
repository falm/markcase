#encoding: utf-8
class CreateMovies < ActiveRecord::Migration

  def change

    create_table :movies, comment: '电影' do |t|

      t.references :user, comment: '推荐人'
      t.string :title, comment: '电影名'
      t.string :score, comment: '电影得分'
      t.string :short_desc, comment: '电影剧情简介'
      t.string :recommend_words, comment: '推荐感言'
      t.string :cover_url, comment: '封面图片URL'
      t.timestamps

    end
  end

end
