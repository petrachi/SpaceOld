module UserInherit
  
  module ClassMethods
    def user_inherit
      self.class_eval "include TableInherit; inherit MainUser"
      [:password, :password_confirmation].each do |column|
        self.class_eval %{
          attr_accessible :#{ column }
          
          def #{ column }
            main_user.#{ column }
          end
          
          def #{ column }=(val)
            main_user.#{ column } = val
          end
        }
      end
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
    base.user_inherit
  end
  
end