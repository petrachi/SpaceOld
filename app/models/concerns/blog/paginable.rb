module Blog::Paginable
  extend ActiveSupport::Concern
  
  included do
    scope :paginate, ->(page, per){ limit("#{(page-1) * per}, #{per}") }
  end
end
