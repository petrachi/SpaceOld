#!/bin/env ruby
# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = MainUser.create :first_name => :thomas, 
  :name => :petrachi, 
  :email => :'admin@space-a.fr', 
  :password => :space,
  :password_confirmation => :space

Blog::User.create :main_user => user
Gems::User.create :main_user => user
Game::User.create :main_user => user
SuperUser::User.create :main_user => user

Blog::Experiment.create :user => user.blog_user,
  :title => "Planet",
  :summary => "Une planète, tout en algo et en CSS3",
  :block => %q{
    safe_buffer = content_tag :style, :type => "text/css" do
    	%q{
    		.planet-container{
    			height: 300px;
    			width: 300px;
    			margin: 1em;
    		}

    		@-webkit-keyframes tournez{
    			from{ -webkit-transform: perspective(800px) rotateX(-15deg) rotateY(0deg); }
    			to { -webkit-transform: perspective(800px) rotateX(-15deg) rotateY(360deg); }
    		}

    		.planet{ 
    			background-color: rgba(120, 255, 120, 0); 
    			height: 300px; 
    			width: 300px; 
    			position: relative;

    			-webkit-transform-style: preserve-3d;
    			-webkit-transform-origin: 50% 50%;
    			-webkit-transition: -webkit-transform 1s;
    			-webkit-animation: tournez 45s linear infinite;
    			-webkit-animation-fill-mode: both;	
    		}

    		.planet-container:hover .planet{
    			-webkit-animation-play-state: paused;
    		}

    		.province{ 
    			border: 1px solid blue; 
    			background: skyblue; 
    			border-radius: 0px; height: 10px; width: 10px;

    			-webkit-transform-origin: 50% 50%;
    			-webkit-backface-visibility: hidden;

    			position: absolute;
    			left: 150px;
    			top: 150px;
    		} 

    		.province:hover{
    			background:red;
    		}
    	}
    end


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

    n = 1000
    r = 130

    points = point_on_sphere_for_sphere(n)


    safe_buffer += content_tag :div, :class => :'planet-container' do
    	content_tag :div, :class => :planet do
    		points.map do |(p, ϕ, θ)|		
    			content_tag :div, nil,
    				:class => :province,
    				:style => %Q{
    					-webkit-transform: 
    						rotateY(#{ ϕ }rad) 
    						rotateX(#{ θ }rad) 
    						translateZ(#{ p * r }px) 
    						rotate(-30deg);
    				}
    		end.reduce(:safe_concat)
    	end
    end
  },
  :published => true
