class Cv::ApplicationController < ApplicationController
  include Cv; layout "cv/application"
  
  include Cv::ApplicationHelper
end
