module Blog::ArticleDecorator
  include RKit::Decorable
  
  module DecoratorMethods
    include Blog::Seriable::Decorator
    
    def title
      if serie
        "#{ super } <small><i>(vol #{ serial_number })</i></small>".html_safe
      else
        super
      end
    end
  end
end
