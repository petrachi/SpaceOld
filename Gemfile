source 'https://rubygems.org'

gem 'rails', '3.2.14'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
	gem 'mysql2'
end

group :production do
	gem 'pg'
end

# Out of :assets because of the scss herper (use scss inline)
# this shoud be in assets and run a precompile on models at deploy

gem 'sass-rails',   '~> 3.2.3'
gem 'compass-rails'

group :assets do
	gem 'coffee-rails', '~> 3.2.1'

	# See https://github.com/sstephenson/execjs#readme for more supported runtimes
	# gem 'therubyracer', :platforms => :ruby

	gem 'uglifier', '>= 1.0.3'
  	
	gem 'font-awesome-rails'
end

gem 'jquery-rails'

gem 'turbolinks'

gem 'rails-i18n'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'newrelic_rpm'

gem 'hash_extend'
gem 'array_extend'

gem 'css_grid'

# For compass sprite
gem 'oily_png' 

# Code Highlight
gem 'coderay'

# this is my all in one gem
# gem 'r_kit'
gem 'r_kit', :path => "/Users/elPetrachi/Dev/r_kit"

# manipulation of png - needed for genetic octopus experience
gem "chunky_png", "~> 1.2.9"