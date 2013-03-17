#!/bin/env ruby
# encoding: utf-8

@user = MainUser.create :first_name => :thomas, 
  :name => :petrachi, 
  :email => :'admin@space-a.fr', 
  :password => :space,
  :password_confirmation => :space

Blog::User.create :main_user => @user
Gems::User.create :main_user => @user
Game::User.create :main_user => @user
SuperUser::User.create :main_user => @user
