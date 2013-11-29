module Paginator::Helper
  def paginate collection, options = {}
    paginator = Paginator::Base.paginate(self, collection, options)
  end
end
