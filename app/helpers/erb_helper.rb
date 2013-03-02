module ErbHelper
  
  def remote_link_to *args
    link_to *args, :remote=>true
  end

  def coderay options = {}, &block
    CodeRay.scan(options.delete(:str) || capture(&block), options.delete(:lang) || :ruby).div(:css => :class, :tab_width => 2).html_safe
  end
end
