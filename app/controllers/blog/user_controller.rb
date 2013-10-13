class Blog::UserController < Blog::ApplicationController
  skip_before_filter :authorized?, :only => :install
  before_filter :install_authorized?, :only => :install
  
  def install_authorized?
    redirect_to space_blog_url(:subdomain => false), :alert => t(:restricted) unless super @application
  end
  
  def install
    Blog::User.create :user => User.current
    redirect_to space_blog_url(:subdomain => false), :notice=>t(:installed)
  end
end
