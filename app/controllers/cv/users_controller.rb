class Cv::UsersController < Cv::ApplicationController
  before_filter :install_authorize, :only => :install
  def install_authorize
    if MainUsersController.new.current(@_request).present? and current.blank?
    else
      #}, {:notice => "no access"}
      
      redirect_to :subdomain=>false, :controller=>:home, :action=>:cv
    end
  end
  
  def install
    User.create :main_user => MainUsersController.new.current(@_request)
    
    #flash[:notice] = "Globalized"
    #respond_to do |format|        
    #  format.js
    #end
    
    
    #}, {:notice => "Globalized"}
    redirect_to :subdomain=>false, :controller=>:home, :action=>:cv
  end
  
  def installed? request = @_request
    current(request).present?
  end
  
  def current request = @_request
    MainUsersController.new.current(request).try(:cv_user)    
  end
end
