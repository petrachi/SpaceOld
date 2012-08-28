class Hash
  def select_from_collection! collection
    self.keep_if{ |field, value| collection.include? field.to_sym }
  end
  
  ["select_from_collection"].each do |method_name|
    define_method method_name do |*args|
      hash = self.dup
      eval "hash.#{ method_name }! *args"
      return hash
    end
  end
end