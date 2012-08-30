class Private::User < ActiveRecord::Base
  include UserInherit
  
  has_many :bank_accounts
  
  attr_accessible :access_authorized
end
