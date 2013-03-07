class SerializableProc
   def initialize block
     @block = block
     to_proc
   end

   def to_proc
     eval "Proc.new{ #{@block} }"
   end

   def method_missing *args
     to_proc.send *args
   end
end
