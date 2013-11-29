Dir[File.join(Rails.root, "app", "extends", "**", "*.rb")].each{ |path| require path }
Dir[File.join(Rails.root, "app", "services", "*.rb")].each{ |path| require path }
