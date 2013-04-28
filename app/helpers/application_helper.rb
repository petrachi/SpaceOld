module ApplicationHelper
  include GridHelper
  include GridFormHelper
  include ErbHelper
  
  def authorized? application
    case application
    when :blog then true
    #when :game then Game::User.current
    #when :gems then true
    when :space then true
    when :super_user then SuperUser::User.current
    else false
    end
  end
  
  def install_authorized? application
    case application
    #when :blog then MainUser.current and Blog::User.current.blank?
    #when :game then MainUser.current and Game::User.current.blank?
    #when :gems then MainUser.current and Gems::User.current.blank?
    when :space then false
    when :super_user then false
    else false
    end
  end
  
  def application_is? application
    application == instance_variable_get(:@application)
  end
end
