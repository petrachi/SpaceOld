class ApplicationController < ActionController::Base
  layout "main"
  protect_from_forgery
  
  clear_helpers
  include ApplicationHelper
  
  include ActionForm
  
  
  around_filter :disable_gc
  def disable_gc
    GC.disable
    begin
      yield
    ensure
      GC.enable
      GC.start
    end
  end
  
  
  before_filter :get_current_user
  def get_current_user
    User.current = User.where(:id => session[:user_id]).first
  end
  
  before_filter :get_location
  def get_location
    @application = :space
  end
  
  before_filter :authorized?
  def authorized?
    redirect_to root_url(:subdomain => false), :alert => t(:restricted) unless super @application
  end
end
