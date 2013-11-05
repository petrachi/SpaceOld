#!/bin/env ruby
# encoding: utf-8


@octopus_experience = Blog::Experience.create :user => @primal_user.blog_user,
  :title => "Genetic Octopus",
  :summary => %q{
    Je dois avouer que si une fille pouvait ressembler à ça, je la demande en mariage instantanément.
  },
  :snippet => Blog::Snippet.create(:params => %q{
      @searched_image = ChunkyPNG::Image.from_file("app/assets/images/blog/experience/octopus.png")

      @generations = 1_500
      @mutation_rate = 1.0 / 1

      score_increment = 6.6

      color_start_hex = "#b62b2b"
      color_end_hex = "#b5702b"
    },
    :ruby => %q{
      # --- setup
    	@searched_genes = @searched_image.pixels
    	@availables_pixels = @searched_genes.uniq

    	@evolution_tree = []

    	# -- hill climbing
    	def create_gene
    		@availables_pixels.sample
    	end

    	def create_person genes = []
    		if genes.blank?
    			@searched_genes.size.times{ genes << create_gene }
    		end

    		{
    			:genes => genes.clone,
    			:muted => genes.clone,
    			:score => 0,
    			:fit => 0
    		}
    	end

    	def evaluate_person person
    		score = 0
    		person[:genes].zip(@searched_genes).each_with_index do |(gene, searched_gene), index|
    			if gene == searched_gene
    				score += 1
    			elsif rand < @mutation_rate					
    				person[:muted][index] = create_gene
    			end
    		end

    		person[:score] = score
    	end

    	def mutate person
    		create_person person[:muted]
    	end

    	GC.enable
    	first_timer = Time.now
    	timer = Time.now

    	p "Start Hill Climbing - #{ @generations } Generations - Complexity: #{ @searched_genes.size } genes + #{ @availables_pixels.size } colors"

    	score = 0

    	@population_of_one = create_person
    	@generations.times do |generation|
    		evaluate_person @population_of_one

    		mutation = mutate @population_of_one
    		evaluate_person mutation

    		if (@population_of_one[:score] * 100 / @searched_genes.size) >= score
    			score += score_increment

    			GC.start

    			puts "Generation #{ generation + 1 } - Score #{ @population_of_one[:score] } (#{ @population_of_one[:score] * 100 / @searched_genes.size }%) - time elapsed : #{ Time.now - timer } (this generation)"
    			timer = Time.now

    			@evolution_tree << [@population_of_one, generation]

    			break if score >= 100
    		end

    		if @population_of_one[:score] == @searched_genes.size
    			p "Perfect solution found - Exit at generation #{ generation }"
    			@evolution_tree << [@population_of_one, generation]
    			break 
    		end

    		if mutation[:score] > @population_of_one[:score]
    			@population_of_one = create_person mutation[:genes]
    		else
    			@population_of_one = create_person @population_of_one[:genes]
    		end
    	end

    	p "End Hill Climbing - Total time : #{ Time.now - first_timer }"
    	# --- hill climbing end


    	def asset_data_uri path
    	  env = Rails.application.assets.is_a?(Sprockets::Index) ? Rails.application.assets.instance_variable_get('@environment') : Rails.application.assets
        
    	  asset = env.find_asset path
        
        throw "Could not find asset '#{path}'" if asset.nil?
        
        base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
        "data:#{asset.content_type};base64,#{Rack::Utils.escape(base64)}"
    	end
      
    	def genes_to_uri genes
    		png = ChunkyPNG::Image.new(@searched_image.width, @searched_image.height, genes)
    		png.save("app/assets/images/blog/experience/genetic_best.png")
    		
    		uri = asset_data_uri("blog/experience/genetic_best.png")
    		File.delete("app/assets/images/blog/experience/genetic_best.png")
    		
    		uri
    	end
    },
    :scss => %q{
      .genetic-octopus{
    		margin: 1em 0 2em;

    		.hill-climbing{
    			padding-top: 1em;
    			text-align: center;

    			.icon-spinner{
    				font-size: 4em;
    				margin: .25em;
    			}
    		}
    	}
    },
    :erb => %q{
      <%= six_cols_container :collection => @evolution_tree, :class => :'genetic-octopus', :rows => {:nested => true}, :spans => {:class => :'hill-climbing display-none'} do |person, generation| %>

      	<% 
      		m = color_start_hex.match /#(..)(..)(..)/
      		color_start = {:r=>m[1].hex, :v=>m[2].hex, :b=>m[3].hex}

      		m = color_end_hex.match /#(..)(..)(..)/
      		color_end = {:r=>m[1].hex, :v=>m[2].hex, :b=>m[3].hex} 

      		percent = person[:score] * 100 / @searched_genes.size

      		r_diff = color_end[:r] - color_start[:r]
      		v_diff = color_end[:v] - color_start[:v]
      		b_diff = color_end[:b] - color_start[:b]

      		r = color_start[:r] + r_diff * percent/100.0
      		v = color_start[:v] + v_diff * percent/100.0
      		b = color_start[:b] + b_diff * percent/100.0
      	%>

      	<%= image_tag genes_to_uri(person[:genes]), :class => "display-none", :style=>"background-color: rgb(#{r.to_i}, #{v.to_i}, #{b.to_i});" %>
      	<i class="icon-spinner icon-spin"></i>

      <% end %>
    },
    :js => %q{
      var timers = [10, 138, 163, 146, 157, 152, 196, 195, 178, 215, 210, 279, 348, 362, 634, 1592];
    	var timer = 0;

     	var elems = document.getElementsByClassName("hill-climbing");
    	for(var timeIndex = 0; timeIndex < elems.length; ++timeIndex)
    	{
    		var img = elems[timeIndex].getElementsByTagName( "img" )[0];
    		var spinner = elems[timeIndex].getElementsByClassName( "icon-spinner" )[0];

    		setTimeout(r_kit.removeClass.bind(this, elems[timeIndex], "display-none"), timer);

    		timer = timer + timers[timeIndex]

    		setTimeout(r_kit.removeClass.bind(this, img, "display-none"), timer);
    		setTimeout(r_kit.addClass.bind(this, spinner, "display-none"), timer);
    	}
    },
    :published => true),
  :published => true,
  :tag => :genetic_octopus,
  :pool => :experience


