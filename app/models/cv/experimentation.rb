class Cv::Experimentation < ActiveRecord::Base
  belongs_to :cv_user
  attr_accessible :brief, :controller, :description, :name, :view
end
