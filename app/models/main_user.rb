class MainUser < ActiveRecord::Base
  attr_accessible :email, :first_name, :name, :password, :password_confirmation
  
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :first_name, :name
  validates_uniqueness_of :email
  
  def to_s
    "#{ first_name } #{ name }"
  end
end