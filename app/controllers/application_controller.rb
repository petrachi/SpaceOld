class ApplicationController < ActionController::Base
  layout "main"
  protect_from_forgery
  
  clear_helpers
  include ApplicationHelper
  
  include ActionForm
  
  before_filter :get_current_user
  def get_current_user
    MainUser.current = MainUser.find_by_id session[:user_id]
  end
  
  before_filter :get_location
  def get_location
    @application = :space
  end


  around_filter :disable_gc
  private
  def disable_gc
    GC.disable
    begin
      yield
    ensure
      GC.enable
      GC.start
    end
  end
end
