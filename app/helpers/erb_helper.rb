module ErbHelper
  
  def remote_link_to *args
    link_to *args, :remote => true
  end

  def coderay options = {}, &block
    CodeRay.scan(options.delete(:str) || capture(&block), options.delete(:lang) || :ruby).div(:css => :class, :tab_width => 2).html_safe
  end
  
  def erb code
    action_view = ActionView::Base.new
    action_view.class_eval "include ApplicationHelper"
    action_view.render(:inline => code.gsub(/<--%|%-->/, '<--%' => '<%', '%-->' => '%>')
  end
  
  require 'sass'
  require 'sass/plugin'
  def scss code
    content_tag :style, Sass::Engine.new(
      %Q{
        @import "variables";
        @import "variables/#{ instance_variable_get(:@application) }";
        @import "compass";
        @import "r_kit";
        @import "mixins";
        @import "animations";
      } + code, 
      :syntax => :scss,
      :load_paths => [
        File.join(Rails.root, "lib/assets/stylesheets"),
        File.join(Gem.loaded_specs['compass'].full_gem_path, "frameworks/compass/stylesheets"),
        File.join(Gem.loaded_specs['compass'].full_gem_path, "frameworks/blueprint/stylesheets")
      ]
    ).render, :type => :'text/css'
  end
end
