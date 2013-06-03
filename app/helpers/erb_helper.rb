module ErbHelper
  
  def remote_link_to *args
    link_to *args, :remote => true
  end

  def coderay options = {}, &block
    CodeRay.scan(options.delete(:str) || capture(&block), options.delete(:lang) || :ruby).div(:css => :class, :tab_width => 2).html_safe
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
        @import "variables/#{ instance_variable_get(:@application) }";
        @import "compass";
        @import "r_kit/mixins";
        @import "mixins";
      } + code, 
      :syntax => :scss,
      :load_paths => [
        File.join(Rails.root, "lib/assets/stylesheets"),
        File.join(Gem.loaded_specs['compass'].full_gem_path, "frameworks/compass/stylesheets"),
        File.join(Gem.loaded_specs['compass'].full_gem_path, "frameworks/blueprint/stylesheets")
      ]
    ).render
    
    content_tag :style, to_css, :type => :'text/css'
  end
end
