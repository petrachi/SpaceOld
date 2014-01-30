class Decorator::Base < SimpleDelegator
  def initialize base, view_context
    super(base)
  
    @view_context = view_context
  end

  def h
    @view_context
  end
  
  def === object
    self == object || __getobj__ == object
  end
end
