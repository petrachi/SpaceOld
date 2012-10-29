module SelfGridHelper
  
  
  TWELVE_STRING_INTS = {:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9, :ten => 10, :evelen => 11, :twelve => 12}
  
  TWELVE_STRING_INTS_INVERT = TWELVE_STRING_INTS.invert
  #faire le invert dans une classe afin de pouvoir le précalculer
  
  # optimisation : parcourir les calculs "cachables", pour les mettre dans une var de classe
  # ex : @content_class[options] ||= calc_content_class[options]; content_class = @content_class[options]
  # ça sera sauvegardé jusqu'au prochain redémarrage, faire gaffe au "memory leak", mais dans l'appel du *_col_container, si il y a des options "rows" ou "spans", ce sera probablement utile
  
  #peut etre en faire une option activable, if @use_cache; @content_class[] ||= calc; else; content_class = calc; end
  #et on pourrait l'utiliser dans le col_container automatiquement
  #et en option des "grid" : ex, je l'active dansun container, tout est géré avec le cache (l'exécution du &block), à la fin, la variable se désactive
  #si je fais ça, faire gaffe au multi exécutions
  
  def grid element_class, options = Hash.new, &block
    
    prepend = TWELVE_STRING_INTS_INVERT[options.delete :prepend]
    append = TWELVE_STRING_INTS_INVERT[options.delete :append]
    
   # raise ArgumentError, "" => offset only for span, nested only for rows
    
    warn "WARNING : argument ':nested' is not supported for #{ element_class }" if options[:nested].present? and element_class != :row
    
    content_class = [element_class, options.delete(:class)]
    content_class << "prepend_#{ prepend }" if prepend
    content_class << "append_#{ append }" if append
    content_class << "nested" if options.delete(:nested)
    
    # instead of using div, think if you can use html5 elements ("section" for container maybye)
    content_tag(:div, nil, :id => options.delete(:id), :class => content_class.join(" ") , &block)
  end





  #is this function realy necessary ? move it in "rows"
  # btw, rename "rows" in something
  # end create a "four_spans_rows", wich will do the same, but not auto calculate span width (?), and not in container. (for use in nested_row for example)
  
  #def col col_number, options = Hash.new, &block
   # collection = options.delete(:collection) || [1]
  #  nested = options.delete :nested
    
  #end

  def recollect size, collection
    recollected = Array.new
    0.step(collection.size - 1, size) do |i|
      recollected << collection[i..i + size - 1]
    end
    recollected
  end
  
  
  #faire des fonctions "raccourics", par exemple, l'ancien 'one_col_row' pourra être réactivé en appelant one_col_container(:disable=>:container)
  # gaffe en faisant ça pour gérer les options, par exemple si j'appelle one_col_row(:disable=>:spans)
  
  
  
  #faire une var de config générale qui donne les noms des container, rows, spans, offsets etc, les éléments html à créer, etc...
  
  
  
  # option "continer width" qui permet de gérer si j'appelle la fonction dans un 9_span par ex => doit mettre les rows large en nested + prendre en compte pour le calcul du span width
  def rows col_number, options = Hash.new, &block
    options[:rows] ||= Hash.new
    options[:spans] ||= Hash.new
    # attention au prepend / append => gérer le :offset=>1 comme le offset=>:one (, ou pas, mais changer dans 'grid' aussi alors)
    
    
    
    #note - disable span ignore option nested
    
    disable = [*options.delete(:disable)]
    nested = [*options.delete(:nested)]
    
    
    
    options[:rows].merge!({:nested => true}) if nested.delete :container
    #end
    
    
    collection_length = TWELVE_STRING_INTS[col_number]
    span_width = TWELVE_STRING_INTS_INVERT[(options.delete(:nested_width) || 12) / (collection_length + (options[:spans][:prepend] || 0) + (options[:spans][:append] || 0))]
    
    
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
  
  
  def method_missing method_name, *args, &block
    case method_name.to_s
    when /^(container|row|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span)$/
      self.grid($1.to_sym, *args, &block)
   # when /^(one|two|three|four|six|twelve)_col_row$/
  #    self.col($1, *args, &block)
    
    # todo - delete start
    #in wainting
    
    when /^(one|two|three|four|six|twelve)_col_row$/
        self.rows($1.to_sym, *args, &block)
    
    #todo delete - end
    
    when /^(one|two|three|four|six|twelve)_col_container$/
      self.rows($1.to_sym, *args, &block)
    else super
    end
  end
  
  def respond_to? method_name, include_private = false
    case method_name.to_s
    when  /^(container|row|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span)$/, 
   #       /^(one|two|three|four|six|twelve)_col_row$/,
          /^(one|two|three|four|six|twelve)_col_container$/
      true
    else super
    end
  end
  
end