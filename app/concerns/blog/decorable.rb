module Blog::Decorable
  extend ActiveSupport::Concern
  
 # include AbstractController::Rendering
  #include AbstractController::Layouts
  #include AbstractController::Helpers
  #include AbstractController::Translation
  #include AbstractController::AssetPaths
  #include Rails.application.routes.url_helpers
  
 # include ActionView::Helpers
  
#  include ApplicationHelper
  
  #include ErbHelper
  
 # include Blog::ApplicationHelper
  
  
  def decorate(view_context)
    @view_context = view_context
    
    class << self 
      include DecoratorMethods
    end
    
    self
  end
  
    
  
  def h
    @view_context
  end
  
  #module ClassMethods
  #  def decorate method, *args, &block
   #   p self
    #  self.define_method("beautiful_#{ method }", &block)
      
      # alias method
      # define method with args & block
      
      # false good idea, because orig method will be ne more available naturally
#    end
  #end
end


=begin
#one possibility of what i want

@art = Blog::Article

@art.title => title
@art.decorate_title => decorated title
=end



=begin

include AbstractController::Rendering
 include AbstractController::Layouts
 include AbstractController::Helpers
 include AbstractController::Translation
 include AbstractController::AssetPaths
 #include ActionController::UrlWriter
 include Rails.application.routes.url_helpers
 
 # Uncomment if you want to use helpers 
 # defined in ApplicationHelper in your views
 helper ApplicationHelper
 helper Blog::ApplicationHelper
 
=end
