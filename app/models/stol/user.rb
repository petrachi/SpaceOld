class Stol::User < ActiveRecord::Base
  belongs_to :user
  has_many :services
  has_many :versions

  validates_presence_of :user

  delegate :to_s, to: :user
end
