class Administrator < ActiveRecord::Base
  attr_accessible :email, :username, :password

  validates_presence_of :email, :username, :password

  def password
    @password
  end

  def password=(password)
    return unless password
    @password = password
    generate_password(password)    
  end

  def self.authenticate(username,pwd)
    admin = Administrator.find_by_username(username)    
    if admin && Digest::SHA256.hexdigest(pwd+admin.salt) == admin.hashed_password
      return admin
    end
    false
  end

private
  def generate_password(password)
    salt = Array.new(10){ rand(512).to_s(36)}.join
    self.salt, self.hashed_password = salt, Digest::SHA256.hexdigest(password+salt)
  end

end
