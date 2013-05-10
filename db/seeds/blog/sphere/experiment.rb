#!/bin/env ruby
# encoding: utf-8

@sphere_experiment = Blog::Experiment.create :user => @primal_user.blog_user,
  :title => "Sphère",
  :summary => %q{
    Une sphère tout en web :). Pas de flash, pas de librairies javascript, juste des <i>div</i> et des <i>transforms</i>. 
  },
  :article => @sphere_article,
  :published => true


@sphere_version = Blog::Version.create :user => @primal_user.blog_user,
  :experiment => @sphere_experiment,
  :params => %q{
    n = 989
    r = 232
    h = 10
  },
  :ruby => %q{
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
  },
  :scss => %q{
    @include keyframes(planet-rotation){
			from{
				@include transform(rotateZ(23deg) rotateY(360deg)); 
			}
		  to {
				@include transform(rotateZ(23deg) rotateY(0deg));
			}
		}

		.planet-container{
		  margin: 1em auto;

      height: #{ r * 2 }px;
			width: #{ r * 2 }px;

			.planet{ 
		  	height: 100%;
		    width: 100%;
		    position: relative;

		    @include transform-style(preserve-3d);
		    @include animation(planet-rotation 270s linear infinite);

				.province{  
			    @include backface-visibility(hidden);
			    @include transition(all .15s ease);

			    position: absolute;
			    left: #{ r - (h/2) }px;
			    top: #{ r - (h/2) }px;

			    height: #{ h }px; 
				  width: #{ h }px;

          background-color: $primary-color;
			    box-shadow: 0 0 0 #{ (h/2) - 1 }px rgba(0, 0, 0, .6) inset;
			    @include border-radius(50%);
			  }
			}
		}
  },
  :erb => %q{
    <div class="planet-container">
      <div class="planet">
        <% point_on_sphere(n).each do |(p, ϕ, θ)| %>
          <div class="province"
            style="-webkit-transform: rotateY(<%= ϕ %>rad) rotateX(<%= θ %>rad) translateZ(<%= p * r %>px);" />
          </div>
        <% end %>
      </div>
    </div>
  },
  :published => true




  Blog::Version.create :user => @primal_user.blog_user,
    :experiment => @sphere_experiment,
    :params => %q{
      n = 389
      r = 132
      h = 6
    },
    :rank => 2,
    :primal => @sphere_version,
    :published => true