module ApplicationHelper
  include GridHelper
  include GridFormHelper
  
  # ajax link
  def remote_link_to *args
    link_to *args, :remote=>true
  end
end
