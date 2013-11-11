module Blog::SnippetDecorator
  include RKit::Decorable
  
  module DecoratorMethods
    [:params, :ruby, :scss, :erb, :js].each do |column|
      define_method column do
        super().html_safe
      end
    end
    
    def coderay column
      h.coderay lang: column do
        self.send column
      end
    end
    
    def code
      h.div_for self, class: "display-none" do
        safe_buffer = h.content_tag :h3, h.t("blog.snippet.ruby")
        safe_buffer += coderay :ruby
        
        safe_buffer += h.content_tag :h3, h.t("blog.snippet.scss")
        safe_buffer += coderay :scss
        
        safe_buffer += h.content_tag :h3, h.t("blog.snippet.erb")
        safe_buffer += coderay :erb
        
        safe_buffer += h.content_tag :h3, h.t("blog.snippet.js")
        safe_buffer += coderay :js
      end
    end
    
    def reveal
      h.content_tag :span, h.t("blog.snippet.reveal"), onclick: "r_kit.removeClass(document.getElementById('#{ h.dom_id(self) }'), 'display-none');"
    end
  end
end
