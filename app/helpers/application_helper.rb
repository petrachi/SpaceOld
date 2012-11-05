module ApplicationHelper
  include DynamicMethod
  
  include GridHelper
  include GridFormHelper
  
  include PjaxHelper
  
  include HomeHelper
  include MainUsersHelper
  
  
  def reload_flashs
    "$(\"#flashs\").replaceWith(\"#{ escape_javascript(render(:partial => "layouts/flashs")) }\");".html_safe
  end
  
  def reload_user_info
    "$(\"#user_info\").replaceWith(\"#{ escape_javascript(render(:partial => "layouts/user_info")) }\");".html_safe
  end
  
  def resize_push
    "$(\"body\").css(\"margin-top\", $(\"#header\").height() + 30 );".html_safe
  end
  
  
  def remote_link_to *args
    link_to *args, :remote=>true
  end
  
  def pjax_skip_link_to *args
    link_to *args, "data-skip-pjax"=>true
  end
  
end
