class Paginator::Collection < SimpleDelegator
  def initialize base
    super(base)
    @paginables = base.dup
  end
  
  def paginables
    @paginables
  end
  
  def limit str
    __setobj__ __getobj__.limit(str)
    self
  end
end