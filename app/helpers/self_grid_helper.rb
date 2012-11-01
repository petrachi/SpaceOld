module SelfGridHelper
  
  
  TWELVE_STRING_INTS = {:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9, :ten => 10, :evelen => 11, :twelve => 12}
  
  TWELVE_STRING_INTS_INVERT = TWELVE_STRING_INTS.invert
  #faire le invert dans une classe afin de pouvoir le précalculer
  
  # optimisation : parcourir les calculs "cachables", pour les mettre dans une var de classe
  # ex : @content_class[options] ||= calc_content_class[options]; content_class = @content_class[options]
  # ça sera sauvegardé jusqu'au prochain redémarrage, faire gaffe au "memory leak", mais dans l'appel du *_cols_container, si il y a des options "rows" ou "spans", ce sera probablement utile
  
  #peut etre en faire une option activable, if @use_cache; @content_class[] ||= calc; else; content_class = calc; end
  #et on pourrait l'utiliser dans le col_container automatiquement
  #et en option des "grid" : ex, je l'active dansun container, tout est géré avec le cache (l'exécution du &block), à la fin, la variable se désactive
  #si je fais ça, faire gaffe au multi exécutions
  
  
  #faire des options "persistantes", par ex le nested_width, qui probablement sera utilisé tout au long de la page.
  # je pourrais faire une var @persistant qui prendra une certaine config, et à chaque appel je ferais options = @persistant.merge!(options)
  # utilise pour col_container & span_container
  
  
  # renommer col_container en col ? :four_cols_container(...){...} => :four_cols(...){...}
  # peut être pas, le container est plus explicite
  
  def grid element_class, options = Hash.new, &block
    #note - append/prepend do not support '=> :one', only '=> 1'
    prepend = TWELVE_STRING_INTS_INVERT[options.delete :prepend]
    append = TWELVE_STRING_INTS_INVERT[options.delete :append]
    
    warn "WARNING : argument ':nested' is not supported for '#{ element_class }'" if options[:nested].present? and element_class != :row
    
    
    if element_class =~ /(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span$/
      if options[:anticipate_nested]
        
        # do support if possible
        raise ArgumentError, "argument ':anticipate' do not supported to be nested" if @options.present?
        
        
        @options = {:nested => :container, :nested_width => TWELVE_STRING_INTS[$1.to_sym]}
        
      end
    else
      warn "WARNING : argument ':prepend' is not supported for '#{ element_class }'" if prepend.present?
      warn "WARNING : argument ':append' is not supported for '#{ element_class }'" if append.present?
      
      raise ArgumentError, "argument ':anticipate' is not supported for '#{ element_class }' - use it on *_span" if options.delete :anticipate
    end
    
    content_class = [element_class, options.delete(:class)]
    content_class << "prepend_#{ prepend }" if prepend
    content_class << "append_#{ append }" if append
    content_class << "nested" if options.delete(:nested)
    
    # instead of using div, think if you can use html5 elements ("section" for container maybye)
    safe_buffer = content_tag(:div, nil, :id => options.delete(:id), :class => content_class.join(" ") , &block)
    
    
    @options = nil if options.delete :anticipate_nested
    safe_buffer
  end

  def recollect size, collection
    recollected = Array.new
    0.step(collection.size - 1, size) do |i|
      recollected << collection[i..i + size - 1]
    end
    recollected
  end
  
  
  
  #faire une var de config générale qui donne les noms des container, rows, spans, offsets etc, les éléments html à créer, etc...
  
  # attention au options mergables (genre :disable, :rows, :spans, :nested, ...)
  # voir même, les class doivent se 'persistant + current' (persistant :ok, options :youpi => doit être "ok youpi")
  
  # rename persistant oprions
  
  # add option :persistant => {...} dans cols_container qui permet de set ces options là en persistant
  # persistant should not be used out of block (in this example, the persistant applies ont the layout elements)
  # grooso modo : nine_span :anticipate=>:nested_container do; ...(*_col_container inside); end
  
  # faire un "auto persistant" qui va set le :nested_width / :nested=>:container automatiquement dans un *_span
=begin
  def persistant_options options
    p "-"*20 + "is set #{options.inspect}"
    
    @options = Hash.new
    
    @options[:rows] ||= Hash.new
    @options[:spans] ||= Hash.new
    
    @options = options
  end
=end  
  def merge_persistant_options options
    
    p options
    p @options
    
    if @options.present?
      
      p "*"*14 + "opt #{options.inspect}"
      p "&"*14 + "@opt #{@options.inspect}"
      
      
      p [*options[:nested]], [*@options[:nested]], [*options[:nested]] + [*@options[:nested]]
      
      options[:nested] = [*options.delete(:nested)] + [*@options[:nested]]
      
      
      p "*"*14 + "opt #{options.inspect}"
      
      options[:nested_width] ||= @options[:nested_width]
      
    #  options.merge!({:nested_width => @options[:nested_width]})
      
      p "*"*14 + "opt #{options.inspect}"
    end
    
    #options.merge!(@options) if @options.present?
    
    p options
    
    #options
  end
  
=begin  
  def clear_persistant_options
    
    p "-"*20 + "is clear"
    
    @options = nil
    
  end
=end  
  
  #mettre un .floor pour le calcul de la span_width & collection_width
  
  
  # note - nested :spans == va contenir des spans à l'intérieur des spans auto générées' / nested :container == est exécuté à l'intérieur d'une span
  def cols_container col_number, options = Hash.new, &block
    
    p options
    p @options
    
    
    
    merge_persistant_options options
    
    p options
    
    
    
    p "col #{options.inspect}"
    
    options[:rows] ||= Hash.new
    options[:spans] ||= Hash.new
    
    
    
    #note - disable span ignore option nested
    
    disable = [*options.delete(:disable)]
    nested = [*options.delete(:nested)]
    
    
    
    options[:rows].merge!({:nested => true}) if nested.delete :container
    #end
    
    
    collection_length = TWELVE_STRING_INTS[col_number]
    span_width = @span_width || TWELVE_STRING_INTS_INVERT[(options.delete(:nested_width) || 12) / (collection_length + (options[:spans][:prepend] || 0) + (options[:spans][:append] || 0))]
    
    
    
    p "span_width #{span_width}"
    p *["-"*75]*3
    rows = recollect(collection_length, options.delete(:collection) || [1]).map do |collection_mini|
      
      
      cols = collection_mini.map do |elt|
        
        
        
        safe_buffer = capture(elt, &block)
        
        unless disable.include? :spans
          
          
          
          
          safe_buffer = grid(:row, :nested=>true){ safe_buffer } if nested.include? :spans
            
        #  end
          
          safe_buffer = grid("#{ span_width }_span".to_sym, options[:spans].clone){ safe_buffer }
          
          
          
        end
        
        
        
        safe_buffer
      end
      
      
      grid(:row, options[:rows].clone){ cols.reduce(:safe_concat) }
      
    end
    
    
    
    
    
    safe_buffer = rows.reduce(:safe_concat)
    
    safe_buffer = grid(:container, :id=>options.delete(:id), :class=>options.delete(:class)){ safe_buffer } unless disable.delete :container
    
    
      
    
    #end
    
    safe_buffer
  end
  
  
  
  def spans_container span_width, options = Hash.new, &block
    
    @span_width = span_width
    col_number = TWELVE_STRING_INTS_INVERT[(options.delete(:nested_width) || 12) / TWELVE_STRING_INTS[span_width]]
    
    
    safe_buffer = cols_container col_number, options, &block
    @span_width = nil
    
    
    
    safe_buffer
    
    
  end
  
  
  def one_col_row options = Hash.new, &block
    p "one col #{options.inspect}"
    
    cols_container :one, options.merge(:disable=>:container, :rows=>{:id=>options.delete(:id), :class=>options.delete(:class)}), &block
  end
  
=begin
  #not sure if i must do this one
  def one_col_row options = Hash.new, &block
    
    options[:disable] = [*options.delete(:disable)] << :container
    cols_container one, options, &block
  end
=end
  
  def method_missing method_name, *args, &block
    case method_name.to_sym
    when /^(container|row|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span)$/
      self.grid($1.to_sym, *args, &block)
   # when /^(one|two|three|four|six|twelve)_col_row$/
  #    self.col($1, *args, &block)
    
    # todo - delete start
    #in wainting
    
    when /^(one|two|three|four|six|twelve)_col_row$/
        self.cols_container($1.to_sym, *args, &block)
    
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
          /^(one|two|three|four|six|twelve)_cols_container$/
      true
    else super
    end
  end
  
end