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
      elsif @errors.present?
        render :text=>@errors.map{ |field, error| "#{ field } : #{ error }" }.join("<br/>")
      else
        render :text => "bug-merge"
      end
    elsif request.xhr?
      respond_to do |format|        
        format.js
      end
    end
  end
  
  def sign_up_errors params = params
    @user = MainUser.new params.select_from_collection([:first_name, :name, :email, :password, :password_confirmation])
    @user.valid?
    
    if params[:call] == "js"
        render :text=>@user.errors.map{ |field, error| "#{ field } : #{ error }" }.join("<br/>")
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
        render :text=>@errors.map{ |field, error| "#{ field } : #{ error }" }.join("<br/>")
      else
        render :text => "bug-merge"
      end
    elsif request.xhr?
      respond_to do |format|        
        format.js
      end
    end
  end
  
  def sign_in_errors params = params
    @user = MainUser.find_by_email params[:email]
    
    @errors = if @user.blank?
      {:user => "n'existe pas"} 
    elsif @user.authenticate(params[:password]).blank?
      {:user => "mdp non valide"}
    else 
      {}
    end
    
    if params[:call] == "js"
        render :text=>@errors.map{ |field, error| "#{ field } : #{ error }" }.join("<br/>")
    end
  end

  
  def current request
    @_request = request
    MainUser.find_by_id session[:user_id]
  end
  
  def sign_out
    session[:user_id], flash[:notice] = nil, "Logged out"
    
    if request.xhr?
      #flash[:notice] = "Logged out"
      # redirect_to root if page not authorized for unlogged user
      respond_to do |format|        
        format.js
      end
    else
      redirect_to root_url#, :notice => "Logged out"
    end
  end
end
