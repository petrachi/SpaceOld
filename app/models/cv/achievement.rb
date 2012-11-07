class Cv::Achievement < ActiveRecord::Base
  belongs_to :user
  attr_protected
  
  validates_presence_of :year, :activity, :brief
 # attr_accessible :activity, :brief, :country, :description, :location, :organisation, :type, :year, :user
end
