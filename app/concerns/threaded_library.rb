module ThreadedLibrary
  
  module ClassMethods
    def thread_local_accessor name, options = {}
      class_eval do
        class_variable_set :"@@#{name}", Hash.new{ |hash, key| hash[key] = options[:default] }
      end
      
      class_eval %{
        FINALIZER = lambda{ |id| @@#{ name }.delete id }

        def self.#{ name }
          @@#{ name }[Thread.current.object_id]
        end
        
        def self.#{ name }= val
          ObjectSpace.define_finalizer Thread.current, FINALIZER unless @@#{ name }.has_key? Thread.current.object_id
          @@#{ name }[Thread.current.object_id] = val
        end
      }
    end
  end
  
  def self.included base
    base.extend ClassMethods
  end
end

# http://coderrr.wordpress.com/2008/04/10/lets-stop-polluting-the-threadcurrent-hash/