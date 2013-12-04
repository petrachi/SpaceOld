class Blog::Article < ActiveRecord::Base
  belongs_to :user
  
  #include Blog::ArticleDecorator
  acts_as_decorables # Blog::SuperArticleDecorator
  
=begin
  acts_as_decorables do
    #how to delegate
    
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
  
  
  include Blog::Poolable.new inclusion_in: [:experience, :ruby, :css, :quicktip]
  include Blog::Publishable
  include Blog::Runnable
  include Blog::Seriable
  include Blog::Taggable
  
  validates_presence_of :user, :title, :summary
end
