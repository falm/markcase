class Administrator < ActiveRecord::Base
  attr_accessible :email, :hashed_password, :salt, :username
end
