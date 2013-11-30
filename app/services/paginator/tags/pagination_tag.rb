module Paginator::Tags::PaginationTag
  def pagination_tag
    p @current_page
    h.content_tag :nav, previous_tag + pages_tag + next_tag, class: :pagination
  end
end
