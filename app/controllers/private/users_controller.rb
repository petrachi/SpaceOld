class Private::UsersController < Private::ApplicationController
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
    MainUsersController.new.current(request).try(:private_user)    
  end
  
  def sign_out
    MainUsersController.new.sign_out @_request
    redirect_to root_url, :notice => "Logged out"
  end
end
