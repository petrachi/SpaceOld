module NewGrid
  
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
  
  def col_tag options = {}, &block
    html_options = html_options(options, {class: "col-#{ options[:col_size] }"})
    content_tag options[:tag] || :div, html_options, &block
  end
  
  1.upto 12 do |col_size|
    define_method "col_#{ col_size }_tag" do |options = {}, &block|
      col_tag options.merge(col_size: col_size), &block
    end
  
    define_method "row_#{ col_size }_tag" do |collection, &block|
      cols_buffer = collection.inject ActiveSupport::SafeBuffer.new do |safe_buffer, instance|
        safe_buffer.safe_concat send("col_#{ col_size }_tag"){ block.call(instance) }
      end
      
      row_tag{ cols_buffer }
    end
    
    define_method "container_#{ col_size }_tag" do |collection, &block|
      rows_buffer = collection
        .in_groups_of(12 / 1, false)
        .inject ActiveSupport::SafeBuffer.new do |safe_buffer, collection|
          safe_buffer.safe_concat send("row_#{ col_size }_tag", collection, &block)
      end
      
      container_tag{ rows_buffer }
    end
  end
end