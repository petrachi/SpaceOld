#!/bin/env ruby
# encoding: utf-8

Blog::Version.create :experiment => @sphere_experiment,
  :title => "1.0",
  :code => %q{
    <%
	    n = 989
	    r = 232
	    h = 10
      
	    points = point_on_sphere(n)
	  %>
	  
	  <%= scss %Q{
	    .planet-container{
  			height: #{ r * 2 }px;
  			width: #{ r * 2 }px;
  			
  			.province{  
					height: #{ h }px; 
				  width: #{ h }px;

			    box-shadow: 0 0 0 #{ (h/2) - 1 }px rgba(0, 0, 0, .6) inset;
			    
			    left: #{ r - (h/2) }px;
			    top: #{ r - (h/2) }px;
				}
  		}
	  } %>
  },
  :published => true

Blog::Version.create :experiment => @sphere_experiment,
  :title => "1.1",
  :code => %q{
    <%
	    n = 589
	    r = 232
	    h = 10

	    points = point_on_sphere(n)
	  %>

	  <%= scss %Q{
	    .planet-container{
  			height: #{ r * 2 }px;
  			width: #{ r * 2 }px;

  			.province{  
					height: #{ h }px; 
				  width: #{ h }px;

			    box-shadow: 0 0 0 #{ (h/2) - 1 }px rgba(0, 0, 0, .6) inset;

			    left: #{ r - (h/2) }px;
			    top: #{ r - (h/2) }px;
				}
  		}
	  } %>
  },
  :published => true
