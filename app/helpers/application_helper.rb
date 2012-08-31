module ApplicationHelper
  include DynamicMethod
  
  include HomeHelper
  include MainUsersHelper
  
  
  def grid element_class, html_class = nil, &block
    content_tag(:div, :class => "#{ element_class } #{ html_class }", &block)
  end
  
  def col col_number, collection, html_class = nil, &block
    span_width, collection_length = case col_number
    when "two" then [:six, 2]
    when "three" then [:four, 3]
    when "four" then [:three, 4]
    when "six" then [:two, 6]
    when "twelve" then [:one, 12]
    end
    
    raise ArgumentError, "collection.size must be <= #{ collection_length }" if collection.size > collection_length
    
    cols = collection.map do |elt|
      eval %{
        #{ span_width }_span do
          capture(elt, &block)
        end }
    end
        
    row html_class do
      cols.inject(ActiveSupport::SafeBuffer.new){ |buffer, col| buffer.safe_concat(col) }
    end
  end
  
  def recollect size, collection
    recollected = Array.new
    0.step(collection.size - 1, size) do |i|
      recollected << collection[i..i + size - 1]
    end
    recollected
  end
  
  def rows col_number, collection, html_class = nil, &block
    recollection_size = {"two" => 2, "three" => 3, "four" => 4, "six" => 6, "twelve" => 12}[col_number]
    
    rows = recollect(recollection_size, collection).map do |collection_mini|
      p collection_mini
      
      col col_number, collection_mini, &block
    end
    
    container html_class do
      rows.inject(ActiveSupport::SafeBuffer.new){ |buffer, col| buffer.safe_concat(col) }
    end
  end
  
  def dynamic_method method_name, *args, &block
    case method_name.to_s
    when /^(container|row|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span)$/
      lambda{ self.grid($1, *args, &block) }
    when /^(two|three|four|six|twelve)_col_row$/
      lambda{ self.col($1, *args, &block) }
    when /^(two|three|four|six|twelve)_col_container$/
      lambda{ self.rows($1, *args, &block) }
    else super
    end
  end
  
end
