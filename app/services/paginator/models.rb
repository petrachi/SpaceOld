module Paginator::Models
  def act_as_paginable
    extend ClassMethods
  end
  
  module ClassMethods
    def paginate page, per
      Paginator::Collection.new(scoped).limit("#{(page-1) * per}, #{per}")
    end
  end
end
