class Cv::User < ActiveRecord::Base
  include UserInherit
  
  has_many :achievements
  has_many :experiments
  
  attr_accessible :age, :headline, :main_user
  
  
end
