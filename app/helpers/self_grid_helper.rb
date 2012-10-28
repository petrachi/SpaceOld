module SelfGridHelper
  
  
  TWELVE_STRING_INTS = {:one => 1, :two => 2, :three => 3, :four => 4, :five => 5, :six => 6, :seven => 7, :eight => 8, :nine => 9, :ten => 10, :evelen => 11, :twelve => 12}

  def grid element_class, options = Hash.new, &block
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
  
  # make an "option special" who is an an array (or single symbol), an wich contains ":nested", ":no_auto_spans", etc...
  # make an option "spans" which contains options for spans (like :class, :append, etc..)
  def rows col_number, options = Hash.new, &block
#    prepend, append = options.delete_many :prepend, :append
    
    nested, kontainer, spans = options.delete_many :nested, :container, :spans
    nested, kontainer, spans = (options.delete(:running) || Hash.new).delete_many :nested, :container, :spans
    # nested et no spans ne peut pas aller ensemble je crois. en désactiver un si les deux sont true
    
    #réorganiser options en : :rows=>{:id, :class}, :spans=>{:nested, :disable, :id, :class, :prepend, :append}, :container=>{:disable, :id, :class}
    
    collection_length = TWELVE_STRING_INTS[col_number.to_sym]
    span_width = TWELVE_STRING_INTS.invert[ 12 / collection_length ]
    
    
    
    rows = recollect(collection_length, options.delete(:collection) || [1]).map do |collection_mini|
      #col col_number, {:collection => collection_mini, :nested => nested}, &block
      

      cols = collection_mini.map do |elt|
        
        if nested.present?
          
          # instead of using (:nested=>true, :id=>html_id, :class=>html_class), use (:class=>"#{ html_class } nested")
          # this is for optimisation, test the code to be sure string interpolation is faster than passing by args
          grid("row", :nested => true){ 
            grid("#{ span_width }_span"){ capture(elt, &block) }
          }
          
        else
          grid("#{ span_width }_span"){ capture(elt, &block) }
        end
=begin        
        eval %{
          #{ span_width }_span do
            #{ "row :nested=>true do" if nested }
              capture(elt, &block)
            #{ "end" if nested }
          end 
        }
=end
      end

      # utiliser "grid(...)" pour alléger le code et optimiser la rapiditée 
      row :id => options.delete(:id_i), :class => options.delete(:class_i) do
        cols.inject(ActiveSupport::SafeBuffer.new){ |buffer, col| buffer.safe_concat(col) }
      end
      
    end
    
    container :id => options.delete(:id), :class => options.delete(:class) do
      rows.inject(ActiveSupport::SafeBuffer.new){ |buffer, col| buffer.safe_concat(col) }
    end
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