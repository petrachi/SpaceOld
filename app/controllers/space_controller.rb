class SpaceController < ApplicationController  
  
  
  def index
    @applications = [:super_user, :game, :gems]
  end
  
  def super_user
  end
  
  def game
  end
  
  def gems
  end
  
  
  #demo
  def sprite_demo
    @applications = [:game, :cv]
  end
  
  #demo
  def css_grid 
    @collection = [Enumerable, Array, String].inject([]){ |arr, cur| arr << {:name=>cur.name, :methods=>"#{ cur.methods.count } methods"} }
    @large_collection = [Hash, Set, Fixnum, Float, NilClass, TrueClass].inject([]){ |arr, cur| arr << {:name=>cur.name, :methods=>"#{ cur.methods.count } methods"} }
  end
  
  #demo
  def game_layout_demo
    render :layout => false
  end
  
  #demo
  def general_demo
    render :layout => false    
  end
  
  # ??? trop générique ???
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
