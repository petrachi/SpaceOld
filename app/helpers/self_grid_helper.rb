module SelfGridHelper
  
  
  TWELVE_STRING_INTS = {:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9, :ten => 10, :evelen => 11, :twelve => 12}
  
  TWELVE_STRING_INTS_INVERT = TWELVE_STRING_INTS.invert
  
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
  
  
  #optimisation : [] 2* + rapide que Array.new (2s vs 1s sur 5,000,000), {} 6* + rapide que Hash.new (6s vs 1s sur 5.000.000)
  
  
  # opti : 0.024 / 0.028 / 0.031 / 0.042 / 0.017 / 0.011 - manque optimisation + personnalisation
  
  
  # renommer col_container en col ? :four_cols_container(...){...} => :four_cols(...){...}
  # peut être pas, le container est plus explicite
  def initialize *args
    @nested_stack = []
    super
  end
  
  def grid element_class, options = {}, &block
    #note - append/prepend do not support '=> :one', only '=> 1'
    prepend = TWELVE_STRING_INTS_INVERT[options.delete :prepend]
    append = TWELVE_STRING_INTS_INVERT[options.delete :append]
    
    warn "WARNING : argument ':nested' is not supported for '#{ element_class }'" if options[:nested].present? and element_class != :row
    
    if element_class =~ /(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span$/
        @nested_stack << $1
        
        unstack = true
    else
      warn "WARNING : argument ':prepend' is not supported for '#{ element_class }'" if prepend.present?
      warn "WARNING : argument ':append' is not supported for '#{ element_class }'" if append.present?
      
      raise ArgumentError, "argument ':anticipate' is not supported for '#{ element_class }' - use it on *_span" if options.delete :anticipate
      
      unstack = false
    end
    
    content_class = [element_class, options.delete(:class)]
    content_class << "prepend_#{ prepend }" if prepend
    content_class << "append_#{ append }" if append
    content_class << "nested" if options.delete(:nested)
    
    # instead of using div, think if you can use html5 elements ("section" for container maybye)
    safe_buffer = content_tag(:div, nil, :id => options.delete(:id), :class => content_class.join(" ") , &block)
    
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
  
  # persistant option
  # attention au options mergables (genre :disable, :rows, :spans, :nested, ...)
  # voir même, les class doivent se 'persistant + current' (persistant :ok, options :youpi => doit être "ok youpi")
  
  # rename persistant oprions
  
  # add option :persistant => {...} dans cols_container qui permet de set ces options là en persistant
  # persistant should not be used out of block (in this example, the persistant applies ont the layout elements)
  # grooso modo : nine_span :anticipate=>:nested_container do; ...(*_col_container inside); end  
  
  # note - nested :spans == va contenir des spans à l'intérieur des spans auto générées' / nested :container == est exécuté à l'intérieur d'une span
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