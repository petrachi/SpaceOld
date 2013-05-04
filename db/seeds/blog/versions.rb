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
	    n = 389
	    r = 232
	    h = 40
	    w = 60

	    points = point_on_sphere(n)
	  %>

	  <%= scss %Q{
	    @include keyframes(planet-rotation){
  			from{
  				@include transform(rotateZ(90deg) rotateY(0deg)); 
  			}
  		  to {
  			  @include transform(rotateZ(90deg) rotateY(360deg)); 
  			}
  		}
	    
	    .planet-container{
  			height: #{ r * 2 }px;
  			width: #{ r * 2 }px;
        
        .planet{
          @include animation(planet-rotation 90s linear infinite);
        }
        
  			.province{  
					height: #{ h }px; 
				  width: #{ w }px;

			    box-shadow: 0 0 0 1px rgba(0, 0, 0, .6) inset;

			    left: #{ r - (h/2) }px;
			    top: #{ r - (w/2) }px;
				}
  		}
	  } %>
  },
  :published => true

Blog::Version.create :experiment => @sphere_experiment,
  :title => "1.2",
  :code => %q{
    <%
	    n = 4589
	    r = 232
	    h = 2

	    points = point_on_sphere(n)
	  %>

	  <%= scss %Q{
	    .planet-container{
  			height: #{ r * 2 }px;
  			width: #{ r * 2 }px;
        
        .planet{
          @include animation(none);
        }
        
  			.province{  
					height: #{ h }px; 
				  width: #{ h }px;

			    box-shadow: 0 0 0;

			    left: #{ r - (h/2) }px;
			    top: #{ r - (h/2) }px;
				}
  		}
	  } %>
  },
  :published => true
