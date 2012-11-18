class MainUsersController < ApplicationController 
  
#  merge_form :sign_up, MainUser


#  action_form :sign_up, :model => MainUser

  def sign_up params = params

    options = {:model => MainUser}
    
  
  
    case params.delete(:wish).try :to_sym
    when :errors
    
    
      p "error check => render list errors"
      p "-" * 20
      
      p "columns check"
      p options[:model].column_names
      
      p "params"
      p params
      
      p "params will be select"
      p params.dup.extract! *options[:model].column_names
      
      p MainUser.new :name=>"thomas"
      
      
      
      
      @object = options[:model].new(params.extract! *options[:model].column_names + [:password, :password_confirmation])
      @object.valid?
    
      
      p @object
      p @object.errors.full_messages
      
      
      if params.delete(:call) == :ruby
        
        return @object.errors.keys
        
      else
        render :json => @object.errors.keys
      end
      
      
      
    when :validate
      p "validate form, redirect or raise"
      
      
      err = sign_up params.dup.merge :call=>:ruby, :wish=>:errors
      
      
      p err
      
      @object.save if err.blank?
      
      
      
      
      if @object.id.present?
       
        flash[:notice] = "youpiyop"
        render :js => "window.location = #{root_path.to_json}"
        
      #  redirect_to root_path, :notice => "youpiyop"
        
      else
        raise
        
      end
      
      
=begin      
      if @object.id.present?
        
        
        render :text => "valid-merge"
        
        
      else
        
        render :text => "bug-merge"
        
        
      end
=end      
      
    end
  
end

=begin

  def sign_up
  end
  
  def sign_up_errors
  end
  
  def sign_up_validations
  end


  
  def sign_up
    
    
    
    
    sign_up_errors params.merge(:call=>"ruby")
    
    if @user.errors.blank?
      @user.save
    end
    
    if params[:call] == "js"
      if @user.id.present?
        flash[:notice] = "Signed in"
        render :text => "valid-merge"
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
    @user = MainUser.new params.select_by [:first_name, :name, :email, :password, :password_confirmation]
    @user.valid?
    
    if params[:call] == "js"
        render :json => @user.errors.keys
    end
  end
=end  

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
