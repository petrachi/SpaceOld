module ApplicationHelper
  include DynamicMethod
  
  include GridHelper
  include GridFormHelper
    
    
  def remote_link_to *args
    link_to *args, :remote=>true
  end
  
  
  
  
  # à garder ?
  def no_turbolink_to *args
    link_to *args, 'data-no-turbolink'=>true
  end
  
=begin  
  def pjax_skip_link_to *args
    link_to *args, "data-skip-pjax"=>true
  end
=end

end
