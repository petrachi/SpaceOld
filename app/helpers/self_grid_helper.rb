module SelfGridHelper
  
  
  TWELVE_STRING_INTS = {:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9, :ten => 10, :evelen => 11, :twelve => 12}
  
  TWELVE_STRING_INTS_INVERT = TWELVE_STRING_INTS.invert
  
  
  
=begin  
  GRID_CONFIG = { :classes => { :container => :container,
                                :row => :row, :nested => :nested,                                                                                                  
                                :prepend => :prepend, :append => :append,                                                                                              
                                :one_span => :one_span, :two_span => :two_span, :three_span => :three_span, :four_span => :four_span,                                  
                                :five_span => :five_span, :six_span => :six_span, :seven_span => :seven_span, :eight_span => :eight_span,                              
                                :nine_span => :nine_span, :ten_span => :ten_span, :eleven_span => :eleven_span, :twelve_span => :twelve_span },
                  :elements => {:container => :section,
                                :row => :div,                                                                                              
                                :one_span => :div, :two_span => :div, :three_span => :div, :four_span => :div,                                  
                                :five_span => :div, :six_span => :div, :seven_span => :div, :eight_span => :div,                              
                                :nine_span => :div, :ten_span => :div, :eleven_span => :div, :twelve_span => :div}
                }                        
=end  
  
  GRID_CONFIG = { :classes => Hash.new{ |hash, key| hash[key] = key }, 
                  :elements => Hash.new(:div).merge(:container => :section) }
  
  # tester grid config avec twitter bootstrap & autre => à mettre dans le readme
  
  
  # opti : 0.024 / 0.028 / 0.031 / 0.042 / 0.017 / 0.011 - manque optimisation + personnalisation
  
  
  def initialize *args
    @nested_stack = []
    super
  end
  
  def grid tag, options = {}, &block
    #note - append/prepend do not support '=> :one', only '=> 1'
    prepend = TWELVE_STRING_INTS_INVERT[options.delete :prepend]
    append = TWELVE_STRING_INTS_INVERT[options.delete :append]
    
    warn "WARNING : argument ':nested' is not supported for '#{ tag }'" if options[:nested].present? and tag != :row
    
    if tag =~ /(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span$/
        @nested_stack << $1
        
        unstack = true
    else
      warn "WARNING : argument ':prepend' is not supported for '#{ tag }'" if prepend.present?
      warn "WARNING : argument ':append' is not supported for '#{ tag }'" if append.present?
            
      unstack = false
    end
    
    content_class = [GRID_CONFIG[:classes][tag], options.delete(:class)]
    content_class << "#{ GRID_CONFIG[:classes][:prepend] }_#{ prepend }" if prepend
    content_class << "#{ GRID_CONFIG[:classes][:append] }_#{ append }" if append
    content_class << GRID_CONFIG[:classes][:nested] if options.delete(:nested)
    
    # instead of using div, think if you can use html5 elements ("section" for container maybye)
    safe_buffer = content_tag(GRID_CONFIG[:elements][tag], nil, :id => options.delete(:id), :class => content_class.join(" ") , &block)
    
    @nested_stack.pop if unstack
    
    safe_buffer
  end

  def recollect size, collection
    recollected = []
    0.step(collection.size - 1, size) do |i|
      recollected << collection[i..i + size - 1]
    end
    recollected
  end
  
  
  
  #faire une var de config générale qui donne les noms des container, rows, spans, offsets etc, les éléments html à créer, etc...
  
  # note - nested :spans == va contenir des spans à l'intérieur des spans auto générées' / nested :container == est exécuté à l'intérieur d'une span
  # note - nested-container est automatique et ne devrait plus être appelé manuellement 
  def cols_container col_number, options = {}, &block
    
    options[:rows] ||= {}
    options[:spans] ||= {}
    
    if @nested_stack.present?
      options[:rows].merge!({:nested => true})
      options[:nested_width] ||= TWELVE_STRING_INTS[@nested_stack.last.to_sym]
    end
    
    #note - disable span ignore option nested
    
    disable = [*options.delete(:disable)]
    nested = [*options.delete(:nested)]
    
    
    #nested container => tjr utilisé si automatique dans les spans ???
    # delete this line ?
    options[:rows].merge!({:nested => true}) if nested.delete :container    
    
    collection_length = TWELVE_STRING_INTS[col_number]
    span_width = @span_width || TWELVE_STRING_INTS_INVERT[(options.delete(:nested_width) || 12) / (collection_length + (options[:spans][:prepend] || 0) + (options[:spans][:append] || 0))]
    
    rows = recollect(collection_length, options.delete(:collection) || [1]).map do |collection_mini|
      
      cols = collection_mini.map do |elt|

        if disable.include? :spans
          capture(elt, &block)
          
        else
          grid("#{ span_width }_span".to_sym, options[:spans].clone) do
            safe_buffer = capture(elt, &block)
            safe_buffer = grid(:row, :nested=>true){ safe_buffer } if nested.include? :spans
            
            safe_buffer
          end
        end
      end
      
      grid(:row, options[:rows].clone){ cols.reduce(:safe_concat) }
    end
    
    safe_buffer = rows.reduce(:safe_concat)
    safe_buffer = grid(:container, :id=>options.delete(:id), :class=>options.delete(:class)){ safe_buffer } unless disable.delete :container
    safe_buffer
  end
  
  def spans_container span_width, options = {}, &block
    
    
    if @nested_stack.present?
      options[:nested_width] ||= TWELVE_STRING_INTS[@nested_stack.last.to_sym]
    end
    
    @span_width = span_width
    col_number = TWELVE_STRING_INTS_INVERT[(options.delete(:nested_width) || 12) / TWELVE_STRING_INTS[span_width]]
    
    
    p @span_width, col_number, "-"
    
    safe_buffer = cols_container col_number, options, &block
    @span_width = nil
    
    safe_buffer
  end
  
  
  def one_col_row options = {}, &block
     #note - options :disable, :rows are ignore, and options :id/:class affect the row 
    
    cols_container :one, options.merge(:disable=>:container, :rows=>{:id=>options.delete(:id), :class=>options.delete(:class)}), &block
  end
  
  def method_missing method_name, *args, &block
    case method_name.to_sym
    when /^(container|row|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span)$/
      self.grid($1.to_sym, *args, &block)
   # when /^(one|two|three|four|six|twelve)_col_row$/
  #    self.col($1, *args, &block)
    
    # todo - delete start
    #in wainting
    
  #  when /^(one|two|three|four|six|twelve)_col_row$/
  #      self.cols_container($1.to_sym, *args, &block)
    
    #todo delete - end
    
    when /^(one|two|three|four|six|twelve)_cols?_container$/
      self.cols_container($1.to_sym, *args, &block)
    when /^(one|two|three|four|six|twelve)_spans?_container$/
      self.spans_container($1.to_sym, *args, &block)
    else super
    end
  end
  
  
  # compléter le respond to
  def respond_to? method_name, include_private = false
    case method_name.to_s
    when  /^(container|row|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span)$/, 
   #       /^(one|two|three|four|six|twelve)_col_row$/,
          /^(one|two|three|four|six|twelve)_cols?_container$/,
          /^(one|two|three|four|six|twelve)_spans?_container$/
      true
    else super
    end
  end
  
end