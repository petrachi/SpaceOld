# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = MainUser.create :first_name => :thomas, 
  :name => :petrachi, 
  :email => :'thomas.petrachi@space.com', 
  :password => :space,
  :password_confirmation => :space
  
Game::User.create :main_user => user
SuperUser::User.create :main_user => user