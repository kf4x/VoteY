class Post < ActiveRecord::Base
  
  acts_as_voteable
  
  mount_uploader :image, ImageUploader
  
  belongs_to :user, :foreign_key => "user_id"
  
  attr_accessible :title, :content, :image, :remote_image_url
  
  validates_presence_of :title, :content, :on => :create
  
  validates_length_of :content, :within => 0..140, :on => :create
  
  validates_length_of :title, :within => 3..100, :on => :create
  
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  

    
end
