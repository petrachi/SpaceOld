module TableInherit
  
  module ClassMethods
    def inherit inherit_class
      self.class_eval "belongs_to :#{ inherit_association = inherit_class.name.demodulize.underscore }"
      inherit_class.class_eval "has_one :#{ self.name.underscore.gsub("/", "_") }, :class_name => \"#{ self.name }\""
      
      
      p "wat"
      p inherit_class.column_names
      p inherit_class.column_names.stealth_delete(["id", "created_at", "updated_at"])
      
      
      inherit_class.column_names.stealth_delete("id", "created_at", "updated_at").each do |column|
        p "inherit table #{column}"
        
        self.class_eval %{
          attr_accessible :#{ column }
          
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
        before_validation :save_inherit
        validate :inherit_saved
        
        def save_inherit
          #{ inherit_association }.save
          
          #{ inherit_association }.errors.each do |field, message|
            self.errors.add field, message
          end
        end
        
        def inherit_saved
          #{ inherit_association }.valid?
        end
      }
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end