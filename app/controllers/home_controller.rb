class HomeController < ApplicationController  
  def index
  end
  
  def preview namespace
    render :template=>"home/preview", :locals=>{:namespace => namespace}
  end
  
  def action_missing method_name, *args, &block
    case method_name.to_s
    when /^(cv|game|private)$/
      self.preview($1, *args, &block)
    else super
    end
  end
end
