module NewGrid
  
  def container_tag options = {}, &block
    content_tag :div, class: :container, &block
  end
  
  def row_tag options = {}, &block
    content_tag :div, class: :row, &block
  end
  
  def col_tag options = {}, &block
    content_tag :div, class: "col-#{ options[:col_size] }", &block
  end
  
  1.upto 12 do |col_size|
    define_method "col_#{ col_size }_tag" do |&block|
      col_tag col_size: col_size, &block
    end
  end
  
  1.upto 6 do |col_size|
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