#!/bin/env ruby
# encoding: utf-8

@sphere_experiment = Blog::Experiment.create :user => @primal_user.blog_user,
  :title => "Sphère",
  :summary => %q{
    Une sphère tout en web :). Pas de flash, pas de librairies javascript, juste des <i>div</i> et des <i>transforms</i>. 
  },
  :block => %q{
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

  	  n = 589
  	  r = 232
  	  h = 8

  	  points = point_on_sphere(n)
  	%>

  	<%= scss %Q{
  		@include keyframes(planet-rotation){
  			from{
  				@include transform(rotateZ(23deg) rotateY(360deg)); 
  			}
  		    to {
  				-webkit-transform: rotateZ(23deg) rotateY(0deg); 
  			}
  		}

  		.planet-container{
  			height: #{ r * 2 }px;
  			width: #{ r * 2 }px;
  		    margin: 1em auto;

  			.planet{ 
  		    	height: 100%;
  			    width: 100%;
  			    position: relative;

  			    @include transform-style(preserve-3d);
  			    @include animation(planet-rotation 270s linear infinite);

  				.province{  
  					height: #{ h }px; 
  				    width: #{ h }px;

  				    box-shadow: 0 0 0 #{ (h/2) - 1 }px rgba(0, 0, 0, .6) inset;
  				    background-color: $primary-color;

  				    @include backface-visibility(hidden);
  				    @include transition(all .15s ease);

  				    position: absolute;
  				    left: #{ r - (h/2) }px;
  				    top: #{ r - (h/2) }px;
  				}
  			}

  			&:hover{
  				.planet{
  					.province{
  						left: #{ r - (h * 2) }px;
  						top: #{ r - (h * 2) }px;

  						height: #{ h * 4 }px;
  						width: #{ h * 4 }px;
  						box-shadow: 0 0 0 1px rgba(0, 0, 0, .6) inset;
  					}
  				}
  			}
  		}
  	} %>
    
    <div class="planet-container">
      <div class="planet">
        <% points.each do |(p, ϕ, θ)| %>
          <div class="province"
            style="-webkit-transform: rotateY(<%= ϕ %>rad) rotateX(<%= θ %>rad) translateZ(<%= p * r %>px);" />
          </div>
        <% end %>
      </div>
    </div>
  },
  :article => @sphere_article,
  :published => true


@sphere_svg_experiment = Blog::Experiment.create :user => @primal_user.blog_user,
  :title => "Sphère SVG",
  :summary => %q{
    Préparez-vous à être éblouis par cette sphère 2d !
  },
  :block => %q{
    <%	
    	def point_on_sphere n
    		points = Array.new
    		point = Struct.new(:x, :y)

    		height = n
    		width = n / 2

    		large_perimeter = Math::PI * 2 * width

    		height.times do |y|
    			current_height = (y - width).abs
    			radius = Math::sqrt( (width * width) - (current_height * current_height) )

    			small_perimeter = Math::PI * 2 * radius

    			nb_perimeter_points = ( small_perimeter / large_perimeter ) * height

    			min_x = (height - nb_perimeter_points) / 2
    			max_x = height - min_x

    			(min_x.to_i..max_x.to_i).each do |x|
    				if x % 2 == y % 2
                    	points << point.new(x, y)
    				end
              	end
    		end

    		points
    	end

    	def point_to_3d x, y, width
    	    half_width = width / 2

    	    x -= half_width
    	    y = half_width - y

    	    distance = Math::sqrt( (x * x) + (y * y) )

    	    angle = (half_width - distance) * 180 / width
    	    rad_angle = angle * Math::PI / 180

    	    distance_3d = Math::cos( rad_angle ) * half_width
    	    transform_ratio = distance_3d / distance

    	    x *= transform_ratio
    	    y *= transform_ratio

    	    x += half_width
    	    y = half_width - y

    	    return x.to_i, y.to_i
    	end

    	def to_canvas_script point, max_x, max_y, width
    	    hexa_height = width / (( 3 * (max_y + 1) ) + 1).to_f
    	    hexa_width = width / ( max_x + 1  + 1 ).to_f

    	    pt_ref = [point.x * hexa_width, point.y * 3 * hexa_height]

    	    top = [ pt_ref[0] + hexa_width, pt_ref[1] ]
    	    top_left = [ pt_ref[0], pt_ref[1] + hexa_height ]
    	    top_right = [ pt_ref[0] + ( 2 * hexa_width), pt_ref[1] + hexa_height ]
    	    bottom = [ pt_ref[0] + hexa_width, pt_ref[1] + ( 4 * hexa_height) ]
    	    bottom_left = [ pt_ref[0], pt_ref[1] + ( 3 * hexa_height) ]
    	    bottom_right = [ pt_ref[0] + ( 2 * hexa_width), pt_ref[1] + ( 3 * hexa_height) ]

    	    top = point_to_3d( top[0], top[1], width )
    	    top_left = point_to_3d( top_left[0], top_left[1], width )
    	    top_right = point_to_3d( top_right[0], top_right[1], width )
    	    bottom = point_to_3d( bottom[0], bottom[1], width )
    	    bottom_left = point_to_3d( bottom_left[0], bottom_left[1], width )
    	    bottom_right = point_to_3d( bottom_right[0], bottom_right[1], width )

    		"ctx.beginPath();
    	    ctx.moveTo(#{ top[0] },#{ top[1] });
    	    ctx.lineTo(#{ top_right[0] },#{ top_right[1] });
    	    ctx.lineTo(#{ bottom_right[0] },#{ bottom_right[1] });
    	    ctx.lineTo(#{ bottom[0] },#{ bottom[1] });
    	    ctx.lineTo(#{ bottom_left[0] },#{ bottom_left[1] });
    	    ctx.lineTo(#{ top_left[0] },#{ top_left[1] });
    	    ctx.fill();     
    	    ctx.closePath();
    	    ctx.stroke();"
    	end
    %>
    
    <%	n = 58
    	width = 8
    	points = point_on_sphere n
    	max_x, max_y = points.map(&:x).max, points.map(&:y).max

    	p points.size
    %>

    <%= scss %Q{
    	div#sphere_svg{
    		margin: 1em auto;
    		width: #{ n * width }px;
    	}
    } %>
    
    <div id="sphere_svg">
    	<canvas id="sphere_svg_demo" width="<%= n * width %>" height="<%= n * width %>">
    	</canvas>
    </div>

    <script type='text/javascript'>
    	var canvas = document.getElementById('sphere_svg_demo');
    	var ctx = canvas.getContext('2d');

    	if (canvas.getContext){
    	ctx.strokeStyle = '#b62b2b';

          // ctx.fillStyle = 'rgba(225,165,0, .1)';
           ctx.lineJoin = 'round';
           ctx.lineWidth =1;

    	<%= points.map{	|point| to_canvas_script(point, max_x, max_y, n * width) }.join " " %>
    };
    </script>
  },
  :published => true