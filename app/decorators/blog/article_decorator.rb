class Blog::ArticleDecorator < Decorator::Base
=begin
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
=end
  
  
 # acts_as_decorables do
     #how to delegate
    
     include Blog::SeriableDecorator
    
     def title
       if serie
         "#{ super } <small><i>(vol #{ serial_number })</i></small>".html_safe
       else
         super
       end
     end
  # end
end
