module DecoratorHelper
  def decorate obj, &block
    capture do
      block.call obj.decorate(self)
    end
  end
end
