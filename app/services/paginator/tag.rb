class Paginator::Tag
  def self.paginate_tag *args
    new(*args).paginate_tag
  end
  
  
  def initialize view_context, pages_count, options = {}
    @view_context = view_context
    
    @pages_count = pages_count
    @current_page = options[:current_page]
  end
  
  def h
    @view_context
  end
  
  
  def paginate_tag
    previous_tag + pages_tag + next_tag
  end
  
  
  def pages_tag
    1.upto(@pages_count).inject(ActiveSupport::SafeBuffer.new) do |safe_buffer, page|
      safe_buffer.safe_concat (if page == @current_page
        disabled_page_tag page
      else
        page_tag page
      end)
    end
  end
  
  def previous_tag
    options = {content: h.t(:icon_previous)}
    
    if @current_page <= 1
      disabled_page_tag @current_page, options
    else
      page_tag @current_page - 1, options
    end
  end
  
  def next_tag
    options = {content: h.t(:'icon_previous')}
    
    if @current_page >= @pages_count
      disabled_page_tag @current_page, options
    else
      page_tag @current_page + 1, options
    end
  end
  
  
  def disabled_page_tag page, options = {}
    h.content_tag :span, (options[:content] || page), class: :'btn-disabled'
  end
  
  def page_tag page, options = {}
    h.link_to (options[:content] || page), h.url_for(page: page), class: :'btn'
  end
end