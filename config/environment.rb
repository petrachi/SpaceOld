# Load the rails application
require File.expand_path('../application', __FILE__)

# Load core extends
Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }

# Initialize the rails application
Space::Application.initialize! do |config|
  config.autoload_paths += %W(#{ Rails.root }/app/concerns) # Load concerns' modules
end

