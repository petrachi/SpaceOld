module AssociateNamespace
  
  module ClassMethods
    def find_foreign_keys namespace
      self.column_names.map do |column_name|
        $1 if column_name =~ /^#{ namespace }_(.*_id)$/
      end.compact
    end
    
    def attr_accessor_demodulize namespace, column
      self.class_eval %{
        attr_accessible :#{ column }
        
        def #{ column }
          #{ namespace }_#{ column }
        end
        
        def #{ column }= val
          self.#{ namespace }_#{ column } = val
        end
      }
    end
    
    def accessors_for_namespace namespace
      find_foreign_keys(namespace).map{ |column| attr_accessor_demodulize namespace, column }
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
end

