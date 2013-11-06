module Blog::Decorable
  def decorate(view_context)
    @view_context = view_context
    
    class << self 
      include DecoratorMethods
    end
    
    self
  end
  
  def h
    @view_context
  end
end
