module Paginator::Models
  def act_as_paginable
    scope :paginate, ->(page, per){ limit("#{(page-1) * per}, #{per}") }
  end
end
