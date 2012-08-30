class MainUsersController < ApplicationController
  def sign_up
    sign_up_errors params.merge(:call=>"ruby")
    
    if @user.errors.blank?
      @user.save
    end

    if params[:call] == "js"
      render :text => if @user.id.present?
        "valid-merge"
      else
        "bug-merge"
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
      
      #redirect_to root_url, :notice => "Logged out"
      #notice=Flash%20message
      #render :update do |page|
      #        page.redirect_to show_product_path(:id=>@entities[0].id)
      #end
      
      render :text => if @user.id.present?
        "valid-merge"        
      else
        "bug-merge"
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
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end
end
