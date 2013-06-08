class Blog::ExperimentController < Blog::ApplicationController
  def get_location
    @section = :experiment
    super
  end
  
  def index
    @experiments = Blog::Experiment.with_primal_version
  end
  
  def show
    @experiment = Blog::Experiment.where(:id => params[:id])
      .with_version(params[:version_id])
      .first
  end
  
  
  
  
  
  
  
  #### Dev zone
  #if Rails.env == "development"
  
    def tmp
      experiment = Blog::Experiment.where(:id => 4)
	      		.with_version(5)
	      		.first
	    
	    scss = %q{
	      
	      

		.sc-icon-sprite{
		    background-image: inline-sprite($youpi-sprites);
		}

		@include sprites($youpi-sprites, protoss terran zerg);

		@each $sprite in sprite_names($youpi-sprites) {
			.sc-icon-\#{$sprite}{
				@extend .sc-icon-sprite;

				display: inline-block;
				width: image-width(sprite_file($youpi-sprites, $sprite));
				height: image-height(sprite_file($youpi-sprites, $sprite));
			}
		}

		@mixin sprite-reposition-percent($map, $space-between){
			$mapHeight: image-height(sprite-path($map)) - $space-between;

			@each $sprite in sprite_names($map) {
				$spriteHeight: nth(sprite-position($map, $sprite), 2);
				$spriteHeight: -$spriteHeight;

				.\#{sprite_map_name($map)}-\#{$sprite}{
					background-size: 100%;
					background-position: 50% custom_percentage($spriteHeight, $mapHeight);

					display: inline-block;
				}
			}
		}

		@include sprite-reposition-percent($youpi-sprites, 264px);

    @mixin resize-sprite($width) {
		  width: $width;
			height: $width;

			box-shadow: inset 0 0 $width/2 black;
		}

		@each $sprite in sprite_names($youpi-sprites) {
		  .sc-icon-\#{$sprite}{
				@include resize-sprite(66px);
			}

			.sc-icon-\#{$sprite}.icon-x2{
				@include resize-sprite(132px);
			}

    	.sc-icon-\#{$sprite}.icon-x3{
				@include resize-sprite(198px);
			}

			.sc-icon-\#{$sprite}.icon-x4{
				@include resize-sprite(264px);
			}
		}


		#sc-demo{
			line-height: 0;
		  margin: 1em 0;

			.row{
				width: 864px;
			}
		}

		#fit-article{
		  margin: 1em 5em;
		}
  }
	    
	    @code = %Q{
	      <%= scss %Q{#{ scss }} %>
	    }
=begin	    
	    @code = %Q{
	      <%
          #{ experiment.version.params }
          #{ experiment.version.ruby }
        %>

        <%= scss %Q{#{ experiment.version.scss }} %>

        #{ experiment.version.erb }

        <script type='text/javascript'>
          #{ experiment.version.js }
        </script>
	    }
=end	    
	  end
  #end
  ####
end
