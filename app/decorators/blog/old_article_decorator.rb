module Blog::OldArticleDecorator
  include RKit::Decorable
  
  module DecoratorMethods
    include Blog::SeriableDecorator
    
    def title
      if serie
        "#{ super } <small><i>(vol #{ serial_number })</i></small>".html_safe
      else
        super
      end
    end
  end
end
