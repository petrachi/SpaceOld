module Blog::ScreencastDecorator
  include RKit::Decorable
  
  module DecoratorMethods
    include Blog::SeriableDecorator
    
    def title
      if serie
        "#{ super } <small><i class='no-warp'>(vol #{ serial_number })</i></small>".html_safe
      else
        super
      end
      
    end
  end
end
