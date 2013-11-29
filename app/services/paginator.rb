module Paginator
  ::ActionView::Base.send :include, Paginator::Helper
end
