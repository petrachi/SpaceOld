module TagHelper
  def btn_to text, link, options = {}
    options[:class] = "btn #{ options[:class] }"
    
    link_to text, link, options
  end
end