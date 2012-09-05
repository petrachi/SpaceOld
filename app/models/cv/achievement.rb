class Cv::Achievement < ActiveRecord::Base
  belongs_to :user
  attr_protected
 # attr_accessible :activity, :brief, :country, :description, :location, :organisation, :type, :year, :user
end
