class HomeController < ApplicationController  
  def index
  end
  
  def css_grid 
    @collection = [Enumerable, Array, String].inject([]){ |arr, cur| arr << {:name=>cur.name, :methods=>"#{ cur.methods.count } methods"} }
    @large_collection = [Hash, Set, Fixnum, Float, NilClass, TrueClass].inject([]){ |arr, cur| arr << {:name=>cur.name, :methods=>"#{ cur.methods.count } methods"} }
  end
  
  def game_layout_demo
    @sections = Array.new(4,0)
    render :layout => false
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
