# Load the rails application
require File.expand_path('../application', __FILE__)

# Load .rb files in lib directory
Dir[File.join(Rails.root, "lib", "**", "*.rb")].each {|l| require l }

# Initialize the rails application
Space::Application.initialize! do |config|
  config.autoload_paths += %W(#{ Rails.root }/app/modules)
  config.autoload_paths += %W(#{ Rails.root }/app/super_user)
end

