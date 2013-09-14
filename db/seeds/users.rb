#!/bin/env ruby
# encoding: utf-8

@primal_user = MainUser.create :first_name => :thomas, 
  :name => :petrachi, 
  :email => :'admin@space-a.fr', 
  :password => :space,
  :password_confirmation => :space

Blog::User.create :main_user => @primal_user
