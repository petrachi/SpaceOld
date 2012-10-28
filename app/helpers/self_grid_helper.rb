module SelfGridHelper
  
  
  TWELVE_STRING_INTS = {:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9, :ten => 10, :evelen => 11, :twelve => 12}

  def grid element_class, options = Hash.new, &block
    options = Hash.new if options.nil?
    
    prepend, append = options.delete_many :prepend, :append
    prepend = TWELVE_STRING_INTS.invert[prepend] if prepend.class == Fixnum
    append = TWELVE_STRING_INTS.invert[append] if append.class == Fixnum
    
   # raise ArgumentError, "" => offset only for span, nested only for rows
    
    #TypeError: wrong argument type Array (expected Regexp)
    # raise a warning instead
    
    
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
  
  
  
  #faire une var de config générale qui donne les noms des container, rows, spans, offsets etc, les éléments html à créer, la largeur de la grid
  
  
  
  # option "continer width" qui permet de gérer si j'appelle la fonction dans un 9_span par ex => doit mettre les rows large en nested + prendre en compte pour le calcul du span width
  def rows col_number, options = Hash.new, &block
    
    # attention au prepend / append à prendre en compte dans le calcul du span_width    
    
    #:disable=>[:container, :spans]
    #:nested
    #:container_width
    
    #refaire nested avec nested=>[::spans, :container=>width] ?
    
    
    
    #note - disable span ignore option nested
    
    disable = [*options.delete(:disable)]
    nested = options.delete :nested
    
    
    
    collection_length = TWELVE_STRING_INTS[col_number.to_sym]
    span_width = TWELVE_STRING_INTS.invert[ 12 / collection_length ]
    
    
    
    rows = recollect(collection_length, options.delete(:collection) || [1]).map do |collection_mini|
      
      
      cols = collection_mini.map do |elt|
        
        
        
        safe_buffer = capture(elt, &block)
        
        unless disable.include? :spans
          
          
          
          if nested
            safe_buffer = grid(:row, :nested=>true){ safe_buffer }
            
          end
          
          safe_buffer = grid("#{ span_width }_span", options[:spans]){ safe_buffer }
        
          
        
        end
        
        
        
        safe_buffer
      end

      
      grid(:row, options[:rows]){ cols.reduce(:safe_concat) }
      
    end
    
    
    
    
    
    safe_buffer = rows.reduce(:safe_concat)
    
    unless disable.include? :container
      safe_buffer = grid(:container, options.delete(:container)){ safe_buffer }
    
      
    
    end
    
    safe_buffer
  end
  
  
  def method_missing method_name, *args, &block
    case method_name.to_s
    when /^(container|row|(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)_span)$/
      self.grid($1, *args, &block)
   # when /^(one|two|three|four|six|twelve)_col_row$/
  #    self.col($1, *args, &block)
    
    
    #in wainting
    
    when /^(one|two|three|four|six|twelve)_col_row$/
        self.rows($1, *args, &block)
    
    #todo deletr
    
    when /^(one|two|three|four|six|twelve)_col_container$/
      self.rows($1, *args, &block)
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