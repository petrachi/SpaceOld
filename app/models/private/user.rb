class Private::User < ActiveRecord::Base
  include UserInherit
  
  has_many :bank_accounts
  
  attr_accessible :access_authorized
  
  def to_s
    email
  end
end
