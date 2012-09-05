class Cv::Experimentation < ActiveRecord::Base
  belongs_to :user
  attr_accessible :brief, :controller, :description, :name, :view, :user
end
