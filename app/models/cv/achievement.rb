class Cv::Achievement < ActiveRecord::Base
  belongs_to :cv_user
  attr_accessible :activity, :brief, :country, :description, :location, :organisation, :type, :year
end
