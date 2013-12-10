module Paginator::Models
  def act_as_paginable
    extend ClassMethods
  end
  
  module ClassMethods
    def paginate page, per
      Paginator::Collection.new(scoped).limit(per).offset((page-1) * per)
    end
  end
end
