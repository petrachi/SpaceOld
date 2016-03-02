class Blog::ExperiencesController < Blog::ApplicationController
  def get_location
    @section = :experiences
    super
  end

  def index
    @experiences = Blog::Experience.published.order("id desc")
    @experiences = @experiences.pool params[:pool] if params[:pool]

    @experiences = @experiences.paginate params[:page].to_i, 16 if params[:page] || (params[:page] = 1)
  end

  def show
    @experience = Blog::Experience.published
      .tagged(params[:tag])
  end





  # helper NewGrid

  #### Dev zone
  #if Rails.env == "development"

    def tmp
      params[:page] ||= "1"
      render :template => "blog/experiences/tmp_#{ params[:page] }"

=begin
      if params[:page] == "2"
        render :template => "blog/experience/tmp_2"
      end

      if params[:page] == "3"
        render :template => "blog/experience/tmp_3"
      end

       if params[:page] == "4"
          render :template => "blog/experience/tmp_4", layout: false
        end

        if params[:page] == "5"
           render :template => "blog/experience/tmp_5"
         end
=end
=begin
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
=end
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

	  def try_hard
	   render layout: false
	  end

  #end
  ####
end
