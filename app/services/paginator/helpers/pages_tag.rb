module Paginator::Helpers::PagesTag
  
  private
  def pages_tag pages
    pages.map do |page|
      page_tag page
    end.reduce(:safe_concat)
  end
  
  def page_tag page
    content = case page[:content]
    when :previous
      t :icon_previous
    when :next
      t :icon_next
    else
      page[:content]
    end
    
    if page[:disabled]
      content_tag :span, content, class: :'btn-disabled'
    else
      link_to content, url_for(page: page[:page]), class: :btn
    end
  end
end
