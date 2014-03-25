class User < ActiveRecord::Base
  include ThreadedLibrary; thread_local_accessor :current

  has_one :blog_user, :class_name => 'Blog::User'
  has_one :stol_user, :class_name => 'Stol::User'

  has_secure_password

  validates_presence_of :password, :on => :create
  validates_presence_of :email, :first_name, :name
  validates_uniqueness_of :email

  def to_s
    "#{ first_name } #{ name }"
  end
end
