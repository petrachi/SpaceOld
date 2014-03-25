#!/bin/env ruby
# encoding: utf-8

@primal_user = User.create :first_name => :thomas,
  :name => :petrachi,
  :email => :'admin@space-a.fr',
  :password => :space,
  :password_confirmation => :space

Blog::User.create :user => @primal_user
Stol::User.create :user => @primal_user
