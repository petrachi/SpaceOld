class Private::ApplicationController < ApplicationController
  include Private; layout "private/application"
  
  include Private::ApplicationHelper
end
