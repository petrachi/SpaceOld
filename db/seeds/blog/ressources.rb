#!/bin/env ruby
# encoding: utf-8

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "HCN",
  :summary => "HCN (Human Coders News) est un des incontournables sites de veille info en français.",
  :link => "http://news.humancoders.com/",
  :pool => :technology_watch,
  :primal => true,
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Railscasts",
  :summary => "Des Screencasts qui parlent de rails ... d'où le nom ... c'est une contraction ... astucieux vous trouvez pas ?",
  :link => "http://railscasts.com/",
  :pool => :technology_watch,
  :primal => true,
  :published => false

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "TryRuby",
  :summary => "Testez Ruby sans l'installer ! Grâce à une 'console like' et une série de petits chalenges, découvrez les bases du langage.",
  :link => "http://tryruby.org/levels/1/challenges/0",
  :pool => :tutorial,
  :primal => true,
  :published => false  
