module ErbHelper
  
  def remote_link_to *args
    link_to *args, :remote => true
  end

  def coderay options = {}, code = nil, &block
    if options.delete(:inline)
      CodeRay.scan(code, options.delete(:lang) || :ruby).span.html_safe
    else
      CodeRay.scan(code || capture(&block), options.delete(:lang) || :ruby).div(:css => :class, :tab_width => 2).html_safe
    end
  end
  
  def erb code
    render :inline => code
  end
  
  require 'sass'
  require 'sass/plugin'
  def scss code
    to_css = raw Sass::Engine.new(
      %Q{
        @import "variables";
        @import "#{ instance_variable_get(:@application) }/variables";
        @import "compass";
        @import "r_kit/mixins";
        @import "r_kit/animations";
      } + code, 
      :syntax => :scss,
      :load_paths => [
        File.join(Rails.root, "app/assets/stylesheets"),
        File.join(Rails.root, "lib/assets/stylesheets"),
        File.join(Gem.loaded_specs['compass'].full_gem_path, "frameworks/compass/stylesheets"),
        File.join(Gem.loaded_specs['compass'].full_gem_path, "frameworks/blueprint/stylesheets")
      ]
    ).render
    
    content_tag :style, to_css, :type => :'text/css'
  end
end
