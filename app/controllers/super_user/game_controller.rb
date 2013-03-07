class SuperUser::GameController < SuperUser::ApplicationController
  
  def index
    @action_links = [:create_planet]
  end
  
  # Action Links - Start
  action_form :create_planet, :model => Game::Planet#,
     #         :validation => -> do
                
=begin
                n = n.to_f
                  pts = []

                  inc = Math::PI * (3 - Math::sqrt(5))
                  off = 2 / n

                  (0...n).each do |k|


                    y = k * off - 1 + (off / 2)    
                    r = Math::sqrt(1 - y**2)
                    phi = k * inc


                	p "intersting values : phi #{phi} / r #{r}, y #{y}"

                	p "cartesian in generation"
                	p [Math::cos(phi)*r, y, Math::sin(phi)*r]

                	p "-------------"

                   # pts << [Math::cos(phi)*r, y, Math::sin(phi)*r]

                	x_phi = Math::PI/2 - Math::acos(y)

                	pts << [1.0, phi, x_phi]

                  end

                  pts













                nb = @planet.size
                
                
                
                half = nb / 2
                
                xstart = 0 - half
                xend = nb + xstart
                
                
                
                x_rad_scale = Math::PI / nb.to_f
                
                p "<"*15
                
                (xstart..xend).each{ |x|  
                  
                  
                  height = x / xend.to_f
                  percent = Math::acos(height.abs) / (Math::PI / 2)
                  nb_prov = nb * percent
                  
                  y_rad_scale = Math::PI * 2 / nb_prov.to_i.to_f
                  
                  p "calc values for x = #{x} => height was #{height} / percent was #{percent} / nb prov result is #{nb_prov} / y rad sclae is #{y_rad_scale}"
                  
                  (1..nb_prov).each{ |y|
                    
                    #saving pos in rads, should keep x,y for vision, and use proper convention naming
=end                    
=begin                    
                    rayon-colatitude-longitude
                    Étant donné un repère cartésien (O, x, y, z), les coordonnées sphériques (ρ, ϕ, θ) d'un point P sont définies par :
                    ρ est la distance du point P au centre O et donc ρ > 0;
                    ϕ est l'angle non orienté formé par les vecteurs z et OP, appelé angle zénithal ou colatitude ;
                    θ est l'angle orienté formé par les demi-plans ayant pour frontière l'axe vertical et contenant respectivement la demi-droite [O, x) et le point P. Si H est le projeté orthogonal de P dans le plan horizontal (O, x, y), alors θ peut être défini comme l'angle formé par les vecteurs x et OH.
                    Par convention, et pour assurer l'unicité de ρ, l'angle ϕ est compris entre 0 et π radians (0 et 180°) et θ entre 0 et 2π radians (0 et 360°)1 (pour le repérage, mais θ et ϕ peuvent parcourir un intervalle plus important pour une courbe paramétrée ρ(θ, ϕ) ). En conséquence la relation de passage aux coordonnées cartésiennes s'écrit :

                    x = p cosθ sinϕ
                    y = p sinθ sinϕ
                    z = p cosϕ
=end
=begin  
  
    p "creating prov for x #{ x  } - y #{y} / will be rad x #{x*x_rad_scale} - y #{y*y_rad_scale}"

                    Game::Province.create(:x=>x*x_rad_scale, :y=>y*y_rad_scale, :planet=>@planet )
                    
                  }
                  
                }



=end

#for 3d with integer positions
=begin                
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
=end


    
# for canvas
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
           #   end#,
          #    :safe_validation => -> do
          #      @planet.provinces.size == @planet.size
          #    end
  # Actions Links - Stop
end

