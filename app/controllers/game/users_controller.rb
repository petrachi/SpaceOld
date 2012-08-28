class Game::UsersController < Game::ApplicationController
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
    @user = Game::User.new params.select_from_collection([:first_name, :name, :email, :password, :password_confirmation])
    @user.valid?
    
    if params[:call] == "js"
        render :text=>@user.errors.map{ |field, error| "#{ field } : #{ error }" }.join("<br/>")
    end
  end

  

  def sign_in
    MainUsersController.new.sign_in params, @_request
    
    if params[:call] == "js"
      render :text => if session[:user_id].present?
        "valid-merge"
      else
        "bug-merge"
      end
    end
  end
  
  def sign_in_errors
    render_text = MainUsersController.new.sign_in_errors params
    
    if params[:call] == "js"
        render :text=>render_text
    end
  end
  
  def current request = @_request
    p MainUsersController.new.current(request)
    MainUsersController.new.current(request).try(:game_user)
    
  end
  
  def sign_out
    MainUsersController.new.sign_out @_request
    redirect_to root_url, :notice => "Logged out"
  end
end