#!/bin/env ruby
# encoding: utf-8

@color_clock_experiment = Blog::Experience.create :user => @primal_user.blog_user,
  :title => "Color Clock",
  :summary => %q{
    Il est vert, la couleur de la pause ! La color clock, intégrée dans la montre intelligente Space.
  },
  :snippet => Blog::Snippet.create(:params => %q{
      color_stops = ["#000000", "#ff00ff", "#0000ff", "#00ffff", "#ffffff", "#00ff00", "#ffff00", "#ff0000", "#000000"]
      steps = 180
    },
    :ruby => %q{
  		def hex_to_rgb hex
  			hex =~ /#(..)(..)(..)/
  			{r: $1.hex, v: $2.hex, b: $3.hex}
  		end

  		def rgb_to_hex rgb
  			"##{"%02x" % rgb[:r]}#{"%02x" % rgb[:v]}#{"%02x" % rgb[:b]}"
  		end

  		def percent value, total
  			value.to_f / total
  		end

  		def diff_color from, to
  			{
  				r: to[:r] - from[:r],
  				v: to[:v] - from[:v],
  				b: to[:b] - from[:b]
  			}
  		end

  		def blend_color from, diff, progress
  			{
  				r: from[:r] + diff[:r] * progress,
  				v: from[:v] + diff[:v] * progress,
  				b: from[:b] + diff[:b] * progress
  			}
  		end

  		def blender color_stops, steps
  			blender = Array.new

  			begin
  				from = hex_to_rgb color_stops.shift
  				to = hex_to_rgb color_stops.first

  				diff = diff_color from, to

  				steps.times do |i|
  					progress = percent i, steps

  					blended = blend_color from, diff, progress
  					blender << rgb_to_hex(blended)
  				end
  			end while color_stops.size > 1

  			blender
  		end
  		
    	blended = blender(color_stops, steps)
    },
    :scss => %q{
      #clock{
  			color: $black;

  			p{
  				text-align: center;
  				font-size: 3em;
  				margin: 1em 0;
  			}
  		}

  		#colors{
  			.color-sample{
  				height: 1.5em;
  				width: 1.5em;

  				font-size: 2em;
  				font-weight: 100;

  				text-align: center;

  				padding: .75em;
  				margin: 2px auto;
  				border: 1px solid $text-color;
  			}
  		}
    },
    :erb => %q{
      <div id="clock">
    		<p>
    			<span id="regular-display"></span><br/>
    			<span id="color-display"></span>
    		</p>

    		<p id="next-display"></p>
    	</div>

    	<div id="colors">
    		<% 24.times do |hour| %>
    			<div class="color-sample" style="background-color: <%= blended[hour * 60] %>">
    				<%= hour %>h
    			</div>
    		<% end %>
    	</div>
    },
    :js => %q{
      var colors = <%= blended.to_json.html_safe %>;

  		function displayTime(date, color){
  			var hours = date.getHours();
  			var minutes = date.getMinutes();
  			var seconds_remaining = 60 - date.getSeconds();

  			document.getElementById("regular-display").innerHTML = "Time is : " + hours + "hrs " + minutes;
  			document.getElementById("color-display").innerHTML = "Color is : " + color;

  			if(seconds_remaining == 60){
  				document.getElementById("next-display").innerHTML = "Next color in : " + color;
  			}else{
  				document.getElementById("next-display").innerHTML = "Next color in : " + seconds_remaining;
  			}
  		}

  		function colorTime(color){
  			document.getElementsByTagName("body")[0].style.background = color;
  			document.getElementsByTagName("html")[0].style.background = color;
  		}

  		function set_color_clock(){
  			var date = new Date();
  			var total_minutes = date.getMinutes() + (60 * date.getHours());
  			var color = colors[total_minutes];

  			displayTime(date, color);
  			colorTime(color);

  			setTimeout(set_color_clock, 1000);
  		};

  		set_color_clock();
    },
    :published => true),
  :published => true,
  :tag => :color_clock,
  :pool => :experience
  

Blog::Snippet.create :primal => @color_clock_experiment.snippet,
  :params => %q{
    color_stops = ["#b62b2b", "#2b2bb6"]
    steps = 186
  },
  :scss => %q{
		#colors{
			.color-sample{
				height: 6em;
				width: .25em;

				//border: 1px solid black;
				border: none;
				
				vertical-align: top;
				
				font-size: 1em;
				font-weight: 100;
				color: $black;
				
				display: inline-block;
				
				transition: width ease 1s;
				
				.color-value{
				  visibility: hidden;
				}
				
				&:hover{
				  width: 6em;
				  border: 1px solid black;
				  border-top: none;
				  border-bottom: none;
				  
				  .color-value{
				    visibility: visible;
				    padding: .25em;
				  }
				}
			}
		}
  },
  :erb => %q{
    <div id="colors" %>
      <% blended.each do |color| %><!--
        --><div class="color-sample" style="background-color: <%= color %>">
          <span class="color-value"><%= color %></span>
			  </div><!--
			--><% end %>
    </div>
  },
  :js => %q{
    // No JS
  },
  :mutation => :only_blender,
  :published => true
