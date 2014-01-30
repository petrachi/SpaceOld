class Blog::ScreencastDecorator < RKit::Decorator::Base
  include Blog::SeriableDecorator
  
  def embed
    _h.content_tag :iframe, nil, 
    :width => 840,
    :height => 500,
    :src => "//www.youtube.com/embed/#{ super }?rel=0",
    :frameborder => "0",
    :allowfullscreen => ""
  end
end
