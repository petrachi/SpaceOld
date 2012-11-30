module ActionForm
  module ClassMethods
    
    def action_form action_name, options = {}
      object_name = "@#{ options[:model].name.demodulize.underscore }" if options[:model]
      
      define_method action_name, ->(params = params) do
        case params.delete(:wish).try :to_sym
        when :errors
          
          if options[:model]
            @object = options[:model].new
            
            #p "before check errors"
            #p params
            #p params.map{ |attr_name| @object.respond_to? :"#{ attr_name }="  }
            #p params.keep_if{ |attr_name| @object.respond_to? :"#{ attr_name }="  }
            
            
            @object = options[:model].new 
            @object.attributes = params.dup.keep_if{ |attr_name| @object.respond_to? :"#{ attr_name }=" }
            @object.valid?
            
            #p "errors"
            #p @object
            #p params
            #p params.map{ |attr_name| @object.respond_to? :"#{ attr_name }="  }
            #p params.keep_if{ |attr_name| @object.respond_to? :"#{ attr_name }="  }
            
            p "return error"
            p @object.errors
            p @object.errors.keys
            
            
            
            
            @errors = @object.errors.keys
            
            eval "#{ object_name } = @object"
          end
          
          instance_exec(params, &options[:errors]) if options[:errors].present?

          if params.delete(:call) == :ruby
            p "ruby return in errors"
            
            return @errors
          else
            p "json return"
            
            render :json => @errors
          end

        when :validate
          
          p "res error"
          p eval("#{ action_name }(params.merge :call=>:ruby, :wish=>:errors)")
          p eval("#{ action_name }(params.merge :call=>:ruby, :wish=>:errors)").blank?
          
          if eval("#{ action_name }(params.merge :call=>:ruby, :wish=>:errors)").blank?
            p "is blank, will valid"
            
            if options[:model]
              p "save"
              r = @object.save 
              p r
              #eval "#{ object_name } = @object"
            end
            
            instance_exec(&options[:validation]) if options[:validation]
            
            
            
            safe_validation = true          
            if options[:model]
              p "safe valid"
              p @object
              p @object.errors.full_messages

              safe_validation &&= @object.id.present?
            end

            if options[:safe_validation]
              safe_validation &&= instance_exec(&options[:safe_validation])
            end

            if safe_validation
              flash[:notice] = "youpiyop"
              render :js => "window.location = #{ root_path.to_json }"
            else
              raise
            end
          else
            raise
          end
          
          
        end
      end
    end
  end

  def self.included base
    base.extend ClassMethods
  end
  
  
  def check_errors_for attr, no_blank = false, &block
    raise ArgumentError, "errors must be an Array" if @errors.class != Array

    case attr
    when String, Symbol
      unless @errors.include? attr
        @errors << attr if case block.arity
        when 0 then yield
        when 1 then yield(attr)
        else raise NotImplementedError, "block arity can be nil or 1"
        end
      end

    when Array
      attr.each do |single_attr|
        check_errors_for single_attr, &block
      end

    else
      raise ArgumentError, "attr must be a String, a Symbol or an Array"
    end
  end
  
end