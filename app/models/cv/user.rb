class Cv::User < ActiveRecord::Base
  include UserInherit
  
  attr_accessible :age, :headline, :main_user
end
