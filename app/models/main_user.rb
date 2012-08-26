class MainUser < ActiveRecord::Base
  attr_accessible :email, :first_name, :name, :password_hash, :password_salt
  
  validates_presence_of :email, :first_name, :name, :password_hash, :password_salt
end
