class Paginator
  def initialize view_context, options = {}
    @view_context = view_context
    @page, @per = options.values_at :page, :per
  end
  
  def paginate collection
    nb_pages = collection.count / @per
    
    
    nb_pages += 1

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
  end
end

class Paginator
  # = Helpers
  module ActionViewExtension
    # A helper that renders the pagination links.
    #
    #   <%= paginate @articles %>
    #
    # ==== Options
    # * <tt>:window</tt> - The "inner window" size (4 by default).
    # * <tt>:outer_window</tt> - The "outer window" size (0 by default).
    # * <tt>:left</tt> - The "left outer window" size (0 by default).
    # * <tt>:right</tt> - The "right outer window" size (0 by default).
    # * <tt>:params</tt> - url_for parameters for the links (:controller, :action, etc.)
    # * <tt>:param_name</tt> - parameter name for page number in the links (:page by default)
    # * <tt>:remote</tt> - Ajax? (false by default)
    # * <tt>:ANY_OTHER_VALUES</tt> - Any other hash key & values would be directly passed into each tag as :locals value.
    def paginate(collection, options = {})
      paginator = Paginator.new(self, options).paginate(collection)
    end
  end
end

::ActionView::Base.send :include, Paginator::ActionViewExtension