class Hash
  def select_from_collection collection
    self.dup.keep_if{ |field, value| collection.include? field.to_sym }
  end
end