module Paginator
  ::ActionView::Base.send :include, Paginator::Helpers
  ::ActiveRecord::Base.extend Paginator::Models
end
