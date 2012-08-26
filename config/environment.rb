# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Space::Application.initialize! do |config|
  config.autoload_paths += %W(#{ Rails.root }/app/concerns)
end

Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }
