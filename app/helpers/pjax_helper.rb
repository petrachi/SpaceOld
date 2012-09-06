module PjaxHelper
  def pjax_flashs
    javascript_tag do
      "$(document).ready(function(){ #{ reload_flashs } });".html_safe
    end if pjax_request?
  end
  
  def pjax_redirect url
    "$.pjax({url: #{ url }, container: '[data-pjax-container]'});".html_safe
  end
end