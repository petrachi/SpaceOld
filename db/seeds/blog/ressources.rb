#!/bin/env ruby
# encoding: utf-8

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "HCN",
  :summary => "HCN (Human Coders News) est un des incontournables sites de veille info en français.",
  :link => "http://news.humancoders.com/",
  :pool => :technology_watch,
  :public => true,
  :published => true
  
Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Hands On",
  :summary => "Site de démo des propriétés CSS3 les plus \"trendy\"",
  :link => "http://ie.microsoft.com/testdrive/graphics/hands-on-css3",
  :pool => :demo,
  :source => @sphere_article,
  :published => true
