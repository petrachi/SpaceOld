class Blog::Poolable < Module
  
  def initialize options = {}
    options.each do |key, value|
      instance_variable_set "@#{ key }", value
    end  
  end
  
  def included(base)
    super
    
    base.extend(ClassMethods)
    base.included_do @inclusion_in
    
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    def included_do inclusion_in
      scope :pool, -> pool { where(pool: pool) }
      
      validates_presence_of :pool
      validates_inclusion_of :pool, in: inclusion_in
    end
    
    def pools options = {}
      except = Array.wrap(options[:except])
        .map(&:to_s)
      
      group(:pool).pluck(:pool) - except
    end
    
    def pool_url pool
      URL.send "#{ ActiveModel::Naming.route_key self }_path", pool: pool
    end
  end
  
  module InstanceMethods
    def pool_url
      URL.send "#{ ActiveModel::Naming.route_key self.class }_path", pool: pool
    end
  end
end