class Blog::ArticleController < Blog::ApplicationController
  def get_location
    @section = :article
    super
  end
  
  def index
    if params[:pool]
      @articles = Blog::Article.pool params[:pool]
    else
      @articles = Blog::Article.all
    end
  end
  
  def show
    @article = Blog::Article.where(:id => params[:id])
      .includes(:experiment)
      .includes(:ressources)
      .first
  end
  
  def pool
    @articles = Blog::Article.pool params[:pool]
  end
  
  
  #### Dev zone
  #if Rails.env == "development"
  
    def tmp
      experiment = Blog::Experiment.where(:id => 4)
	      		.with_version(5)
	      		.first
	    
	    scss = %q{
	      @import "compass/utilities/sprites/base";
	      
		$sc-icon-sprites: sprite-map("blog/experiment/sc-icon/*.png");

		.sc-icon-sprite{
		    background-image: inline-sprite($sc-icon-sprites);
		}

		@include sprites($sc-icon-sprites, protoss terran zerg);

		@each $sprite in sprite_names($sc-icon-sprites) {
			.sc-icon-\#{$sprite}{
				@extend .sc-icon-sprite;

				display: inline-block;
				width: image-width(sprite_file($sc-icon-sprites, $sprite));
				height: image-height(sprite_file($sc-icon-sprites, $sprite));
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

		@include sprite-reposition-percent($sc-icon-sprites, 264px);

    @mixin resize-sprite($width) {
		  width: $width;
			height: $width;

			box-shadow: inset 0 0 $width/2 black;
		}

		@each $sprite in sprite_names($sc-icon-sprites) {
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
