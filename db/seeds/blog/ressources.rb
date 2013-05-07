#!/bin/env ruby
# encoding: utf-8

# Publics
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
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "TryRuby",
  :summary => "Testez Ruby sans l'installer ! Grâce à une 'console like' et une série de petits chalenges, découvrez les bases du langage.",
  :link => "http://tryruby.org/levels/1/challenges/0",
  :pool => :tutorial,
  :primal => true,
  :published => true  
# Publics End
  
# Article 'Sphère'
Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Hands On",
  :summary => "Site de démo des propriétés CSS3 les plus \"trendy\"",
  :link => "http://ie.microsoft.com/testdrive/graphics/hands-on-css3",
  :pool => :demo,
  :article => @sphere_article,
  :published => true
  
Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Coordonnées Sphériques",
  :summary => "C'est quoi les coordonnées sphériques ? Non mais dis donc ! Explique moi tout !",
  :link => "http://fr.wikipedia.org/wiki/Coordonn%C3%A9es_sph%C3%A9riques",
  :pool => :doc,
  :article => @sphere_article,
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Points on a sphére",
  :summary => "Répartir des points équitablement sur une sphére (en anglais)",
  :link => "http://www.xsi-blog.com/archives/115",
  :pool => :blog,
  :article => @sphere_article,
  :published => true
  
Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Three JS",
  :summary => "Librairie Javascript",
  :link => "http://mrdoob.github.com/three.js/",
  :pool => :technology_watch,
  :article => @sphere_article,
  :published => true
# Article Sphère End
