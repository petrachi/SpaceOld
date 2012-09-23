class OneReadOnly
  def initialize val
    @val = val
  end
  
  def read
    val = @val
    @val = nil
    val
  end
end