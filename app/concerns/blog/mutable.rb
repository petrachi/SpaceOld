class Blog::Mutable < Module
  
  def initialize options = {}
    options.each do |key, value|
      instance_variable_set "@#{ key }", value
    end
  end
  
  def included(base)
    super
    
    base.extend(ClassMethods)
    base.included_do
    
    instance_methods_do
  end
  
  module ClassMethods
    def included_do
      belongs_to :primal, class_name: name, foreign_key: "primal_id"
      has_many :mutations, class_name: name, foreign_key: "primal_id", conditions: "published = true"
      
      validates_presence_of :primal_id, :mutation, unless: :primal?
      validates_uniqueness_of :mutation, scope: :primal_id, unless: :primal?
    end
  end
  
  def instance_methods_do
    @mutables.each do |mutable|
      define_method mutable do
        super() || primal.try(mutable)
      end
    end
  
    define_method :primal? do
      primal.blank?
    end
  end
end
