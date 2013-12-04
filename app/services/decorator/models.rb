module Paginator::Models
  def acts_as_decorables &block
    Object.const_set "#{ name }Decorator", Class.new(&block)
    
    extend ClassMethods
    include InstanceMethods
  end
  
  module ClassMethods
    def decorator_class
      "#{ name }Decorator".constantize
    end
  end
  
  module InstanceMethods
    def decorate
      self.class.decorator_class.new self
    end
  end
end
