class MainUsersController < ApplicationController
  def sign_in params, request
    @_request = request
    sign_in_errors params.merge(:call=>"ruby")
    
    if @errors.blank?
      session[:user_id] = @user.id
    end
  end
  
  def sign_in_errors params, request
    @_request = request
    @user = MainUser.find_by_email params[:email]
    
    @errors = if @user.blank?
      {:user => "n'existe pas"} 
    elsif @user.authenticate(params[:password]).blank?
      {:user => "mdp non valide"}
    else 
      {}
    end
    
    return @errors.map{ |field, error| "#{ field } : #{ error }" }.join("<br/>")
  end
  
  def current request
    @_request = request
    MainUser.find_by_id session[:user_id]
  end
  
  def sign_out request
    @_request = request
    session[:user_id] = nil
  end
end
