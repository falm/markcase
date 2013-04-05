class Bookmark < ActiveRecord::Base
  attr_accessible :category_id, :inbox, :link, :note, :star, :title, :user_id
  belongs_to :user

  scope :off_star, lambda { update_attributes(star: false)}
  scope :on_star, lambda { udpate_attributes(star: true)}
  scope :inbox, lambda { update_attributes(inbox: true)}
  scope :unbox, lambda { update_attributes(inbox: false)}
  
  scope :favorite, lambda { where(star: true)}
  scope :show_inbox, lambda { where(inbox: true)}
end
