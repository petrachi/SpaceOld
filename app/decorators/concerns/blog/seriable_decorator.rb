module Blog::SeriableDecorator
  def title
    if serie
      "#{ super } <small><i class='no-warp'>(vol #{ serial_number })</i></small>".html_safe
    else
      super
    end
  end
  
  def serie_link_to
    _h.link_to serie, serie_url, class: :btn
  end
  
  def paginate
    serie_collection.map do |instance|
      if self === instance
        _h.content_tag :span, "vol #{ instance.serial_number }", class: :'btn-disabled'
      else
        _h.link_to "vol #{ instance.serial_number }", instance, class: :btn
      end
    end.reduce(:safe_concat)
  end
  
  def navigate
		_h.content_tag :p do
      safe_buffer = ActiveSupport::SafeBuffer.new
      safe_buffer += _h.link_to _h.t(:previous), following, class: :btn if following
      safe_buffer += " "
      safe_buffer += _h.link_to _h.t(:next), followed, class: :btn if followed
      safe_buffer
      
    end
  end
end