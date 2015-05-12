#encoding: utf-8
class ChangeTypeOfShortDescOfMoviesFromStringToText < ActiveRecord::Migration

  def change

    change_column :movies, :short_desc, :text, comment: '电影剧情简介'

  end

end
