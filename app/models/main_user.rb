class MainUser < ActiveRecord::Base
  attr_accessible :email, :first_name, :name, :password, :password_confirmation
  
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  
  def to_s
    email
  end
end
