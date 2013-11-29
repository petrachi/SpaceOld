class Paginator::Base
  def self.paginate view_context, *args
    new(view_context).paginate(*args)
  end
  
  
  def initialize view_context, options = {}
    @view_context = view_context
  end
  
  def paginate collection, options = {}
    pages_count = (collection.size.to_f / options[:per]).ceil
    
    Paginator::Tag.paginate_tag(@view_context, pages_count, current_page: options[:page])
  end
end
