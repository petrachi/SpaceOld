module DynamicMethod
  
  def method_missing method_name, *args, &block
    dynamic_proc = dynamic_method method_name, *args, &block
    return dynamic_proc.call if dynamic_proc
    
    super
  end
  
  def respond_to? method_name, include_private = false
    super || !!dynamic_method(method_name.to_sym)
  end

  def method method_name
    super
  rescue NameError
    dynamic_proc = dynamic_method method_name
    (class<<self;self;end).class_eval { define_method method_name, &dynamic_proc }
    retry
  end

  def dynamic_method *args; nil; end
end

