module Blog::ArticleDecorator
  
  
  include Blog::Decorable
  
  module DecoratorMethods
    def title
      "youpi #{id}"
    end
    
    def link
      h.link_to "youpi", "yop"
    end
    
    def label
      h.label_tag "ok"
    end
    
    def path
      h.blog_articles_url
    end
    
    def scss
      h.scss "html{color: #fff;}"
      
    end
  end
  
  
end