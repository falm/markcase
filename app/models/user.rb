class User < ActiveRecord::Base
  attr_accessible :description, :email, :password, :username, :password_confirmation
  validates_presence_of :username, :email ,:password, :on => :create
  validates_confirmation_of :password, message: '两次密码不相同'

  has_many :bookmarks  
  has_many :categories
  acts_as_tagger

  self.per_page = ENV['PER_PAGE']
    
    
  def password
    @password
  end

  def password=(password)
    return unless password
    @password = password
    generate_password(password)
  end
  
  def reset_password(args)
    
    if Digest::SHA256.hexdigest(self.salt + args[:password])==
        self.hashed_password
      self.password = args[:new_password]
      return save
    end
  end

  def self.authenticate(email,pwd)
    user = User.find_by_email(email)
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
    
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_send_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
 
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
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
