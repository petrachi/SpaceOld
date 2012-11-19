module ActionForm
  module ClassMethods
    
    def action_form action_name, options = {}
      #object_name = "@#{ object_class.name.demodulize.underscore }"
      
      define_method action_name, ->(params = params) do
        case params.delete(:wish).try :to_sym
        when :errors
          
          if options[:model]
            @object = options[:model].new(params.extract! *options[:model].column_names + [:password, :password_confirmation])
            @object.valid?
          
            @errors = @object.errors.keys
          
            #eval "#{ object_name } = @object"
          end
          
          instance_exec(params, &options[:errors]) if options[:errors].present?

          if params.delete(:call) == :ruby
            return @errors
          else
            render :json => @errors
          end

        when :validate
          if eval("#{ action_name }(params.merge :call=>:ruby, :wish=>:errors)").blank?

            if options[:model]
              @object.save 

              #eval "#{ object_name } = @object"
            end
            
            instance_exec(&options[:validation]) if options[:validation]
          end

          safe_validation = true          
          if options[:model]
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