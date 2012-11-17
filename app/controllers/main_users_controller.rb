class MainUsersController < ApplicationController 
  def sign_up
    sign_up_errors params.merge(:call=>"ruby")
    
    if @user.errors.blank?
      @user.save
    end
    
    if params[:call] == "js"
      if @user.id.present?
        @valid, flash[:notice] = true, "Signed in"
        respond_to do |format|        
          format.js
        end
      elsif @user.errors.present?
        render :json => @user.errors.keys
      else
        render :text => "bug-merge"
      end
    else
      respond_to do |format|        
        format.js
      end
    end
  end
  
  def sign_up_errors params = params
    @user = MainUser.new params.extract [:first_name, :name, :email, :password, :password_confirmation]
    @user.valid?
    
    if params[:call] == "js"
        render :json => @user.errors.keys
    end
  end
  

  def sign_in
    sign_in_errors params.merge(:call=>"ruby")
    
    if @errors.blank?
      session[:user_id] = @user.id
    end
    
    if params[:call] == "js"
      if session[:user_id].present?
        @valid, flash[:notice] = true, "Signed in"
        respond_to do |format|        
          format.js
        end
      elsif @errors.present?
        render :json => @errors
      else
        render :text => "bug-merge"
      end
    end
  end
  
  def sign_in_errors params = params
    @errors = Array.new
    @user = MainUser.find_by_email params[:email]
    
    check_errors_for [:email, :password] do |attr|
      params[attr].blank?
    end
    
    check_errors_for :email do
      @user.blank?
    end
    
    check_errors_for :password do
      @user.authenticate(params[:password]).blank?
    end
    
    if params[:call] == "js"
      render :json => @errors
    end
  end

  
  def sign_out
    session[:user_id], flash[:notice] = nil, "Logged out"
    
    if request.xhr?
      respond_to do |format|        
        format.js
      end
    else
      redirect_to root_url
    end
  end
end
