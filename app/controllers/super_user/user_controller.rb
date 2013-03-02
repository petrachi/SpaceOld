class SuperUser::UserController < SuperUser::ApplicationController
  skip_before_filter :authorized?, :only => :install
  before_filter :install_authorized?, :only => :install
  
  def install_authorized?
    redirect_to space_super_user_url(:subdomain => false), :alert => t(:restricted) unless super @application
  end
  
  def install
    SuperUser::User.create :main_user => MainUser.current
    redirect_to space_super_user_url(:subdomain => false), :notice=>t(:installed)
  end
end