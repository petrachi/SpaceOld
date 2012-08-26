module TableInherit
  
  module ClassMethods
    def inherit inherit_class
      self.class_eval "belongs_to :#{ inherit_association = inherit_class.name.demodulize.underscore }"
      inherit_class.class_eval "has_many :#{ self.name.demodulize.underscore.pluralize }"
      
      inherit_class.column_names.stealth_delete("id").each do |column|
        self.class_eval %{
          def #{ column }
            #{ inherit_association }.#{ column }
          end
          
          def #{ column }=(val)
            #{ inherit_association }.#{ column } = val
          end
        }
      end
      
      self.class_eval %{
        alias_method :default_#{ inherit_association }, :#{ inherit_association }
        
        def #{ inherit_association }
          default_#{ inherit_association } || (self.#{ inherit_association } = #{ inherit_class }.new)
        end
      }
      
      self.class_eval %{
        before_save :save_inherit
        
        def save_inherit
          #{ inherit_association }.save
          
          #{ inherit_association }.errors.each do |field, message|
            self.errors.add field, message
          end
        end
      }
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  
  
  
end