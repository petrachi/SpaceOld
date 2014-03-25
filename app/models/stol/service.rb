class Stol::Service < ActiveRecord::Base
  belongs_to :user
  belongs_to :version

  include Runnable
end
