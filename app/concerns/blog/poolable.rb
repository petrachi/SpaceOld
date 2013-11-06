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
    
    class << base
      include InstanceMethods
    end
  end
  
  module ClassMethods
    def included_do inclusion_in
      scope :pool, -> pool { where(pool: pool) }
      
      validates_presence_of :pool
      validates_inclusion_of :pool, in: inclusion_in
    end
  end
  
  module InstanceMethods
    def pool_url
      URL.send "#{ ActiveModel::Naming.route_key self.class }_path", pool: pool
    end
  end
end