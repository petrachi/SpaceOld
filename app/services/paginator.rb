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