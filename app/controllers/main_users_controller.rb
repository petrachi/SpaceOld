class MainUsersController < ApplicationController 
  


  action_form :sign_up, :model => MainUser


  def sign_in params = params
    
    options = {
      :errors => ->(params) do
        p "here"
        p params
        
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
      end,
      
      :validation => -> do
        
        p "valid"
        p @user
        
        
        session[:user_id] = @user.id
      end
    }
    
    
    p "first"
    p params
    
    case params.delete(:wish).try :to_sym
    when :errors
      
      p "in error"
      
      options[:errors].call params if options[:errors].present?
      
      
      
      if params.delete(:call) == :ruby
        return @errors
      else
        render :json => @errors
      end
      
      
      
    when :validate     
      
      p "in valid in method"
      
      
      
      
      
      options[:validation].call if sign_in(params.merge :call=>:ruby, :wish=>:errors).blank?
      
      
      if session[:user_id].present?
      
        flash[:notice] = "youpiyop"
        render :js => "window.location = #{ root_path.to_json }"
      else
        raise
      end
    end
    
    
    
    
  end
  

  def old_sign_in
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
  
  def old_sign_in_errors params = params
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
