class Array
  def stealth_delete *args
    delete *args
    return self
  end
  
  def stealth_delete_from_collection collection
    collection.each do |val|
      delete val
    end
    return self
  end
end