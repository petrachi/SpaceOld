class MainUsersController < ApplicationController 
  before_filter :request_xhr?, :only=>[:sign_up, :sign_in]
  def request_xhr?
    redirect_to root_url, :alert => "acces non authorise" unless request.xhr?
  end
  
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
    @user = MainUser.new params.select_from_collection([:first_name, :name, :email, :password, :password_confirmation])
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
    else
      respond_to do |format|        
        format.js
      end
    end
  end
  
  def sign_in_errors params = params
    @user = MainUser.find_by_email params[:email]
    
    @errors = if @user.blank?
      [:user]
    elsif @user.authenticate(params[:password]).blank?
      [:password]
    else 
      []
    end
    
    if params[:call] == "js"
        render :json => @errors
    end
  end

  
  def current request
    @_request = request
    MainUser.find_by_id session[:user_id]
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
