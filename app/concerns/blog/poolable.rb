class Blog::Poolable < Module
  
  def initialize inclusion_of
    @inclusion_of = inclusion_of
  end
  
  def included(model)
    super
    
    included_do @inclusion_of
    instance_methods
  end
  
  def included_do inclusion_of
    class_eval do
      scope :pool, -> pool { where(:pool => pool) }
      
      validates_presence_of :pool
      validates_inclusion_of :pool, :in => inclusion_of
      
    end
  end
  
  def pool_url
    URL.blog_articles_path :pool => pool
  end
  
  def instance_methods
    define_method("pool_url") do
      URL.blog_articles_path :pool => pool
    end
  end
end