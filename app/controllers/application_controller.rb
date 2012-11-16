class ApplicationController < ActionController::Base
  layout "home"
  
  
  protect_from_forgery
  
  clear_helpers
  include ApplicationHelper
  
  #after_filter :discard_flash_if_xhr
  #def discard_flash_if_xhr
  #  flash.discard if request.xhr?
  #end
end
