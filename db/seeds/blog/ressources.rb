#!/bin/env ruby
# encoding: utf-8

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Human Coder News",
  :summary => "Site français de veille techno.",
  :link => "http://news.humancoders.com/",
  :pool => :misc,
  :published => true,
  :published_at => "05-05-2013".to_datetime,
  :tag => :hcn

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Railscasts",
  :summary => "Tutos vidéos sur rails et son écosystème.",
  :link => "http://railscasts.com/",
  :pool => :video,
  :published => true,
  :published_at => "16-02-2014".to_datetime,
  :tag => :railscasts

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "TryRuby",
  :summary => "Testez Ruby sans l'installer ! Grâce à une 'console like' et une série de petits chalenges, découvrez les bases du langage.",
  :link => "http://tryruby.org/levels/1/challenges/0",
  :pool => :tutorial,
  :published => false  
