module Paginator::Helper
  def paginate collection, options = {}
    paginator = Paginator.paginate(self, collection, options)
  end
end
