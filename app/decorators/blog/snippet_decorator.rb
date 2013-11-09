module Blog::SnippetDecorator
  include RKit::Decorable
  
  module DecoratorMethods
    [:params, :ruby, :scss, :erb, :js].each do |column|
      define_method column do
        super().html_safe
      end
    end
    
    def coderay
      
      # each coderays should be in single methods (one for ruby, one from scss ...)
      # code clumn (ruby, sccs, js) should be override to add html_safe
      
      h.capture do
        x = h.coderay do
          params + ruby
        end
        
        x += h.coderay :lang => :css do
              scss
        end.html_safe
        
        x += h.coderay :lang => :javascript do
              js
        end.html_safe
        
        
      end.html_safe
    end
  end
end
