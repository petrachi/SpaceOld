module ApplicationHelper
  include GridHelper
  include GridFormHelper
  
  include RKit::DecorableHelper
  include ErbHelper
  include GoogleAnalyticsHelper
  
  def authorized? application
    case application
    when :blog then true
    #when :game then Game::User.current
    #when :gems then true
    when :space then true
    #when :super_user then SuperUser::User.current
    else false
    end
  end
  
  def install_authorized? application
    case application
    #when :blog then User.current and Blog::User.current.blank?
    #when :game then User.current and Game::User.current.blank?
    #when :gems then User.current and Gems::User.current.blank?
    when :space then false
    #when :super_user then false
    else false
    end
  end
  
  def application_is? application
    application == @application
  end
end
