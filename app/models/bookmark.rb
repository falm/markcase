class Bookmark < ActiveRecord::Base
  attr_accessible :category_id, :inbox, :link, :note, :star, :title, :user_id
end
