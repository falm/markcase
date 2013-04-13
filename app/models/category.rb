class Category < ActiveRecord::Base
  attr_accessible :title, :user_id

  belongs_to :user
  has_many :bookmarks
  self.per_page = ENV['PER_PAGE'] 
end
