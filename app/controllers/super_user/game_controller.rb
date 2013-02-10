class SuperUser::GameController < SuperUser::ApplicationController
  
  def index
    @actions = [:create_planet]
  end
  
  # Action Links - Start
  
  # action form is actually realy specific to MainUser => finish it before use it !
  action_form :create_planet, :model => Game::Planet,
              :validation => -> do
                
                planet_height = @planet.size
                planet_width = planet_height / 2
                
                planet_height.times{ |y|
                  curr_height = (y - planet_width).abs
                  radius = Math::sqrt( (planet_width * planet_width) - (curr_height * curr_height) )
                  
                  large_perimeter = Math::PI * 2 * planet_width
                  small_perimeter = Math::PI * 2 * radius

                  how_many_provinces = ( small_perimeter / large_perimeter ) * planet_height

                  min_x = (planet_height - how_many_provinces) / 2
                  max_x = planet_height - min_x

                  (min_x.to_i..max_x.to_i).each do |x| 
                    if x % 2 == y % 2
                      Game::Province.create(:x=>x, :y=>y, :planet=>@planet )
                    end
                  end
                }                
              end#,
          #    :safe_validation => -> do
          #      @planet.provinces.size == @planet.size
          #    end
  # Actions Links - Stop
end
