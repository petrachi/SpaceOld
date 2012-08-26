class Array
  def stealth_delete *args
    delete *args
    return self
  end
end