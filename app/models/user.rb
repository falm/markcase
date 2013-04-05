class User < ActiveRecord::Base
  attr_accessible :description, :email, :password, :username, :password_confirmation
  validates_presence_of :username, :email 
  validates_confirmation_of :password, message: "towice password not equal"
   
    
    
  def password
    @password
  end
  def password=(password)
    return unless password
    @password = password
    generate_password(password)
  end
  
  def reset_password(args)
    
    if  Digest::SHA256.hexdigest(self.salt + self.pwd)==
        args[:user][:password]
      password = args[:user][:new_password]
      return save
    end
  end

  def self.authenticate(user,pwd)
    user = User.find_by_username(user)
    if user && Digest::SHA256.hexdigest(user.salt + pwd)==
        user.hashed_password
      return user
    end
    false
  end
  
  def self.register(args)
    return if User.find_by_username(args[:username]) 
    user = User.create(User.analysis(args))
    user.save!
    user
  end
    
  private
  def generate_password(pass)
    salt = Array.new(10) { rand(512).to_s(36) }.join
    self.salt, self.hashed_password =
      salt, Digest::SHA256.hexdigest(salt+pass)
  end
  
  def self.analysis(args)
    {username: args[:username], password: args[:password], password_confirmation: args[:password_confirmation],
    email: args[:email]}
  end
end
