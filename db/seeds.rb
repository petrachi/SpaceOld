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
load File.join(File.dirname(__FILE__), 'seeds', 'blog', 'articles.rb')






Blog::Experiment.create :user => @user.blog_user,
  :title => "Sphère",
  :summary => %q{
    Comment créer et utiliser un globe planétaire dans l'internet ? Voici une réponse, en utilisant les transformations 3d de la nouvelle norme -CSS3-, et un algorithme basé sur le nombre d'or pour calculer la répartition des éléments et les valeurs des transformations à appliquer.<br/>
    Attention, -webkit- only !
  },
  :block => %q{
    <style type="text/css">
      .planet-container{
        height: 450px;
        width: 450px;
        margin: 1em auto;
      }

      @-webkit-keyframes tournez{
        from{ -webkit-transform: perspective(1800px) rotateX(0deg) rotateY(0deg); }
        to { -webkit-transform: perspective(1800px) rotateX(0deg) rotateY(360deg); }
      }

      .planet{ 
        height: 100%;
        width: 100%;
        position: relative;

        -webkit-transform-style: preserve-3d;
        -webkit-transition: -webkit-transform 1s;
        -webkit-animation: tournez 45s linear infinite;
        -webkit-animation-fill-mode: both;	
      }

      .planet-container:hover .planet{
        -webkit-animation-play-state: paused;
      }

      .province{  
        height: 10px; 
        width: 10px;
        
        box-shadow: 0 0 0 4px rgba(0, 0, 0, .6) inset;
        background-color: #b62b2b;
        
        -webkit-backface-visibility: hidden;
        -webkit-transition: box-shadow .6s ease;
        
        position: absolute;
        left: 50%;
        top: 50%;
      } 

      .planet-container:hover .province{
        box-shadow: 0 0 0 1px rgba(0, 0, 0, .6) inset;
      }
    </style>

    <%
      def point_on_sphere n
        n = n.to_f
        pts = []

        inc = Math::PI * (3 - Math::sqrt(5))
        off = 2 / n

        (0...n).each do |k|
          y = k * off - 1 + (off / 2)    
          r = Math::sqrt(1 - y**2)
          phi = k * inc

          x_phi = Math::PI/2 - Math::acos(y)

          pts << [1.0, phi, x_phi]
        end

        pts
      end

      n = 600
      r = 225

      points = point_on_sphere(n)
    %>
    
    <div class="planet-container">
      <div class="planet">
        <% points.each do |(p, ϕ, θ)| %>
          <div class="province"
            style="-webkit-transform: rotateY(<%= ϕ %>rad) rotateX(<%= θ %>rad) translateZ(<%= p * r %>px) rotate(-30deg);" />
          </div>
        <% end %>
      </div>
    </div>
  },
  :published => true
