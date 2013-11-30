class Paginator::Base
  def initialize view_context, options = {}
    @view_context = view_context
  end
  
  def paginate collection, options = {}
    collection = collection.paginables if collection.is_a? Paginator::Collection
    
    pagination = 
      [previous_page(options[:page])] + 
      pages(options[:page], collection, options[:per]) + 
      [next_page(options[:page], pages_count(collection, options[:per]))]
  end
  
  
  def pages current_page, collection, per
    1.upto(pages_count collection, per).inject(Array.new) do |pages, i|
      pages << page(current_page, i)
      pages
    end
  end
  
  def page current_page, i
    {
      content: i,
      page: i,
      disabled: i == current_page
    }
  end
  
  
  def previous_page current_page
    {
      content: :previous,
      page: current_page - 1,
      disabled: current_page <= 1
    }
  end
  
  def next_page current_page, pages_count
    {
      content: :next,
      page: current_page + 1,
      disabled: current_page >= pages_count
    }
  end
  
  
  private
  def pages_count collection, per
    (collection.count.to_f / per).ceil
  end
  
end
