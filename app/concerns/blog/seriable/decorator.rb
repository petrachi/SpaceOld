module Blog::Seriable::Decorator
  def serie_link_to
    h.link_to serie, serie_url, class: :btn
  end
  
  def paginate
    serie_collection.map do |instance|
      if instance.eql? self
        h.content_tag :span, "vol #{ instance.serial_number }", class: :'btn-disabled'
      else
        h.link_to "vol #{ instance.serial_number }", instance, class: :btn
      end
    end.reduce(:safe_concat)
  end
end