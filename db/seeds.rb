#!/bin/env ruby
# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

load File.join(File.dirname(__FILE__), 'seeds', 'users.rb')
Dir[File.join(File.dirname(__FILE__), "seeds", "*", "**", "*.rb")].sort.each do |l|
  load l
end
