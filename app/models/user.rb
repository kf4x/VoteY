class User < ActiveRecord::Base

  acts_as_voter

  has_many :posts
  attr_accessor :password
  attr_accessible :username, 
                  :email,
                  :password,  
                  :password_confirmation
                  
  before_save :encrypt_password
  
  validates_uniqueness_of :email, 
                          :username, :on => :create, :message => "must be unique"
  
  validates_confirmation_of :password
  
  validates_presence_of :username,
                        :email,
                        :password, :on => :create
  
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  validates_length_of :password, :within => 6..20, :on => :create
  
  before_create { generate_token(:auth_token) }
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.encrypted_password == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end
end