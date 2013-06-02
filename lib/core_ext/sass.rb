p "in sass"
p self
p self.class
=begin
module Sass::Script::Functions
  def custom_percentage(value, total)
    value = value.to_i
    total = total.to_i

    percentage = value * 100.0 / total

    Sass::Script::String.new("#{ percentage }%")
  end
  declare :int, :args => [:string]
end
=end