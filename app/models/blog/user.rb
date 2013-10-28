class Blog::User < ActiveRecord::Base
  belongs_to :user
  has_many :articles
  has_many :experiences
  has_many :ressources
  
  
  validates_presence_of :user
  
  
  delegate :to_s, to: :user
end
