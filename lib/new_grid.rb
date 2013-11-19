module NewGrid
  
  # i'm not happy with that method
  # this is doing too mush for very rare use
  # -> maybe, allow proc only for spans, and maybe put it in a "proc options" key
  def proc_options instance, options = {}
    (options[:proc_options] || []).each do |key, proc|
      options[key] = proc.call(instance)
    end
  end
  
  def html_options options = {}, defaults = {}
    id = options[:id]
    classes = "#{ defaults[:class] } #{ options[:class] }"
    classes += " off-#{ options[:offset] }" if options[:offset]
    
    {
      :id => id,
      :class => classes
    }
  end
  
  
  # miss-list 
  # -> proc html_options (class / id)
  # -> row-option & col-options in row_*_tag
  # -> container-row-col-ptions in container_*_tag
  
  def container_tag options = {}, &block
    html_options = html_options(options, {class: :container})
    content_tag options[:tag] || :div, html_options, &block
  end
  
  def row_tag options = {}, &block
    html_options = html_options(options, {class: :row})
    content_tag options[:tag] || :div, html_options, &block
  end
  
  def col_tag instance = nil, options = {}, &block
    proc_options instance, options
    html_options = html_options(options, {class: "col-#{ options[:col_size] }"})
    
    content_tag(options[:tag] || :div, html_options){ block.call(instance) }
  end
  
  1.upto 12 do |col_size|
    define_method "col_#{ col_size }_tag" do |instance = nil, options = {}, &block|
      col_tag instance, options.merge(col_size: col_size), &block
    end
  
    define_method "row_#{ col_size }_tag" do |collection, options = {}, &block|
      col_options = options.delete(:spans) || {}
      
      cols_buffer = collection.inject ActiveSupport::SafeBuffer.new do |safe_buffer, instance|
        safe_buffer.safe_concat send("col_#{ col_size }_tag", instance, col_options, &block)
      end
      
      row_tag(options){ cols_buffer }
    end
    
    define_method "container_#{ col_size }_tag" do |collection, options = {}, &block|
      row_options = options.delete(:rows) || {}
      
      rows_buffer = collection
        .in_groups_of(12 / 1, false)
        .inject ActiveSupport::SafeBuffer.new do |safe_buffer, collection|
          safe_buffer.safe_concat send("row_#{ col_size }_tag", collection, row_options, &block)
      end
      
      container_tag(options){ rows_buffer }
    end
  end
end