class Blog::RessourceDecorator < RKit::Decorator::Base
  def link_to
    _h.link_to _h.t(:link), link, target: :_blank, class: :btn
  end
  
  def preview
    _h.content_tag :iframe, nil, 
    width: 840,
    height: 500,
    src: link
  end
end
