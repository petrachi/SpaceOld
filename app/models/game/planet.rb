class Game::Planet < ActiveRecord::Base
  include AssociateNamespace; accessors_for_namespace :game
  
  #has_many :provinces
  
  has_many :provinces, :foreign_key => :game_planet_id #, :class_name => Game::Province.name
  
  attr_protected
  
  def to_canvas
    t = Time.now
    canvas_width = 288  #size * 10
    
      p "map"
      #str = "<MAP name='map' id='map'>"
      str = "<canvas id='tutoriel' width='#{canvas_width}' height='#{canvas_width}'>"
      str2 = ""
      i = 0
      j = provinces.size
      
      
      max_x, max_y = provinces.map(&:x).max, provinces.map(&:y).max
      
      
      

      #str += "</MAP>"
      str += "</canvas>"
      str +="<script type='text/javascript'>
        var canvas = document.getElementById('tutoriel');
         if (canvas.getContext){
           var ctx = canvas.getContext('2d');

           ctx.strokeStyle = '#FFA500';
           ctx.fillStyle = 'rgba(225,165,0,0)';
           ctx.lineJoin = 'round';
           ctx.lineWidth =1;

           "
           
           provinces.each{ |province| 
             
             str += province.to_canvas_script(max_x, max_y, canvas_width); 
             
             p "#{ i * 100 / j }% (#{ i }/#{ j })" if ((i += 1) % (j / 10)).zero?
           
           }

           

           str += "


           requestAnimFrame(function() {
                     animate();
                   });

         }


      </script> #{ Time.now - t }"

    
  end
  
  def to_3d_transform
    max_x = (size * 2 - 1) / (Math::PI * 2)
     
    
    max_y = provinces.map(&:y).max
    
    
    "<div id=planet>#{ provinces.map{|x| x.to_3d_tranform(max_x, max_y) }.join }</div>"
  end
end
