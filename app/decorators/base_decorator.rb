module BaseDecorator
  def decorate(view_context)
    @view_context = view_context

    class << self 
      include DecoratorMethods
    end

    self
  end
  
end
