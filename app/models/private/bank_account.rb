class Private::BankAccount < ActiveRecord::Base
  include AssociateNamespace; accessors_for_namespace :private
  
  belongs_to :user
  attr_accessible :balance
end
