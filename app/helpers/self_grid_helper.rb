module SelfGridHelper
  
  
  TWELVE_STRING_INTS = {:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9, :ten => 10, :evelen => 11, :twelve => 12}

  def grid element_class, options = Hash.new, &block
    html_id, html_class, offset, nested = options.delete_many :id, :class, :offset, :nested
    offset = TWELVE_STRING_INTS.invert[offset] if offset.class == Fixnum
    
   # raise ArgumentError, "" => offset only for span, nested only for rows
    
    content_class = [element_class, html_class]
    content_class << "offset_#{ offset }" if offset #change in append / prepend
    content_class << "nested" if nested
    
    content_tag(:div, nil, :id => html_id, :class => content_class.compact.join(" ") , &block)
  end

  #is this function realy necessary ? move it in "rows"
  # btw, rename "rows" in something
  # end create a "four_spans_rows", wich will do the same, but not auto calculate span width (?), and not in container. (for use in nested_row for example)
  def col col_number, options = Hash.new, &block
    collection = options.delete(:collection) || [1]
    nested = options.delete :nested

    collection_length = TWELVE_STRING_INTS[col_number.to_sym]
    span_width = TWELVE_STRING_INTS.invert[ 12 / collection_length ]

    raise ArgumentError, "collection.size must be <= #{ collection_length }" if collection.size > collection_length
    
    cols = collection.map do |elt|
      eval %{
        #{ span_width }_span do
          #{ "row :nested=>true do" if nested }
            capture(elt, &block)
          #{ "end" if nested }
        end 
      }
    end

    row :id => options.delete(:id), :class => options.delete(:class) do
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

  def rows col_number, options = Hash.new, &block
    nested = options.delete :nested
    rows = recollect(TWELVE_STRING_INTS[col_number.to_sym], options.delete(:collection) || [1]).map do |collection_mini|
      col col_number, {:collection => collection_mini, :nested => nested}, &block
    end

    container :id => options.delete(:id), :class => options.delete(:class) do
      rows.inject(ActiveSupport::SafeBuffer.new){ |buffer, col| buffer.safe_concat(col) }
    end
  end
  
  
  def method_missing method_name, *args, &block
    case method_name.to_s
    when /^(container|row|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span)$/
      self.grid($1, *args, &block)
    when /^(one|two|three|four|six|twelve)_col_row$/
      self.col($1, *args, &block)
    when /^(one|two|three|four|six|twelve)_col_container$/
      self.rows($1, *args, &block)
    else super
    end
  end
  
  def respond_to? method_name, include_private = false
    case method_name.to_s
    when  /^(container|row|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span)$/, 
          /^(one|two|three|four|six|twelve)_col_row$/,
          /^(one|two|three|four|six|twelve)_col_container$/
      true
    else super
    end
  end
  
end