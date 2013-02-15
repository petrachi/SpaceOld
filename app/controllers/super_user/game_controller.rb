class SuperUser::GameController < SuperUser::ApplicationController
  
  def index
    @actions = [:create_planet]
  end
  
  # Action Links - Start
  
  # action form is actually realy specific to MainUser => finish it before use it !
  action_form :create_planet, :model => Game::Planet,
              :validation => -> do
                
                
                # must be impair
                nb = @planet.size * 2 - 1
                half = nb / 2
                
                start_pos, end_pos = 0 - half, nb - half
                
                
                
                rayon = nb / (Math::PI * 2)
                
                
                
                p "-"*45
                p "nb #{nb} / rayon #{rayon}"
                
                
                
                0.upto(rayon.to_i){ |x|
                  
                  
                  
                  
                 p "x"*15
                 p "   for x #{x}"
                 
                  p "section Math::sqrt( #{rayon**2} - #{x**2} )"
                  p Math::sqrt( rayon**2 - x**2 )
                  
                  
                  
                  section_rayon = Math::sqrt( rayon**2 - x**2 )
                
                  
                  
                  section_perimetre = section_rayon * Math::PI * 2
                  
                  p "sec permi #{section_perimetre}"
                  
                  s_nb = section_perimetre.to_i / 2 * 2 + 1
                  
                  half = s_nb / 2
                  
                  start_pos, end_pos = 0 - half, s_nb - half
                  
                
                p "start #{start_pos} .. end #{end_pos}"
                
                  (start_pos..end_pos).each{ |y|
                  
                  
                    Game::Province.create(:x=>x, :y=>y, :planet=>@planet )
                    
                    Game::Province.create(:x=>-x, :y=>y, :planet=>@planet ) if x != 0
                    
                    
                  
                  }
                }
                
                
=begin                
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
=end                                
              end#,
          #    :safe_validation => -> do
          #      @planet.provinces.size == @planet.size
          #    end
  # Actions Links - Stop
end
