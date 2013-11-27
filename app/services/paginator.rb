class Paginator
  def self.paginate view_context, *args
    new(view_context).paginate(*args)
  end
  
  
  def initialize view_context, options = {}
    @view_context = view_context
  end
  
  def paginate collection, options = {}
    pages_count = (collection.size.to_f / options[:per]).ceil
    
    safe_buffer = ActiveSupport::SafeBuffer.new
    safe_buffer += Paginator::Tag.previous_tag(@view_context, pages_count, current_page: options[:page])
    safe_buffer += Paginator::Tag.pages_tag(@view_context, pages_count, current_page: options[:page])
    safe_buffer += Paginator::Tag.next_tag(@view_context, pages_count, current_page: options[:page])
    safe_buffer
=begin    
    buf = ""
    nb_pages.times do |i|

      if i+1 == @page
        buf += "<span>#{i+1}</span>"
      else
        buf += @view_context.link_to "#{i+1}", @view_context.url_for(:page => i+1)
        #buf += "<a href='/screencasts/page-#{i+1}'>#{i+1}</a>"
      end
    end

    buf.html_safe
=end
  end
  
  ::ActionView::Base.send :include, Paginator::Helper
end