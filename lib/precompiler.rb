class Precompiler < AbstractController::Base
  include AbstractController::Rendering
  include AbstractController::Layouts
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths
  include Rails.application.routes.url_helpers
  
  
  def initialize snippet, application, helpers
    @snippet = snippet
    @application = application
    
    include_helpers helpers
  end
  
  def include_helpers helpers
    class_eval do
      helpers.each do |elper|
        helper elper.constantize
      end
    end
  end
  
  delegate :raw, to: :@snippet
  
  def precompile
    render inline: raw, locals: {:@application => @application}
  end
end
