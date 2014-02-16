module Blog::SeriableDecorator
  attr_reader :showcase
  
  def serie_title
    "#{ __getobj__.title } <small><i class='no-warp'>(vol #{ serial_number })</i></small>".html_safe
  end
  
  def showcase_title
    "#{ __getobj__.title } <small><i class='no-warp'>(#{ serie_size } vols)</i></small>".html_safe
  end
  
  def title options = {}
    if serie and showcase
      showcase_title
    elsif serie
      serie_title
    else
      super()
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
        _h.btn_to "vol #{ instance.serial_number }", instance
      end
    end.reduce(:safe_concat)
  end
  
  def navigate
		_h.content_tag :p do
      safe_buffer = ActiveSupport::SafeBuffer.new
      safe_buffer += _h.btn_to _h.t(:previous), following if following
      safe_buffer += " "
      safe_buffer += _h.btn_to _h.t(:next), followed if followed
      safe_buffer
      
    end
  end
end