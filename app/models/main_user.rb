class MainUser < ActiveRecord::Base
  include ThreadedLibrary; thread_local_accessor :current
  
  attr_protected
  
  has_secure_password
  
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :first_name, :name
  
  validates_uniqueness_of :email
  
  def to_s
    "#{ first_name } #{ name }"
  end
  
  
  
  def created_at
    p "youpi"
    self[:created_at]
  end
end
