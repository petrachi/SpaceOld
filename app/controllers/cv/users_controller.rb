class Cv::UsersController < Cv::ApplicationController
  before_filter :install_authorize, :only => :install
  def install_authorize
    p "autho"
    p current    
    p MainUsersController.new.current(@_request)
    
    if MainUsersController.new.current(@_request).present? and current.blank?
    else
      @_request.env['HTTP_REFERER'] ||= root_url(:subdomain=>false)
      redirect_to :back, :notice => "no access"
    end
  end
  
  def install
    User.create :main_user => MainUsersController.new.current(@_request)
    redirect_to root_url, :notice => "Globalized"
  end
  
  
  def current request = @_request
    p MainUsersController.new.current(request)
    p MainUsersController.new.current(request).try(:cv_user)    
    
    MainUsersController.new.current(request).try(:cv_user)    
  end
end
