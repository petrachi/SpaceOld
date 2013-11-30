module Paginator::Helpers::PaginationTag
  def pagination_tag collection, options = {}
    content_tag :nav, class: :pagination do
      pages_tag Paginator::Base.new(self).paginate(collection, options)
    end
  end
end
