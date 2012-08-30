class Private::UsersController < Private::ApplicationController
  def globalize
    User.create :main_user => MainUsersController.new.current(@_request)
    redirect_to root_url, :notice => "Globalized"
  end
  
  def current request = @_request
    MainUsersController.new.current(request).try(:private_user)    
  end
end
