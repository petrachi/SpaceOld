class Game::Province < ActiveRecord::Base
  include AssociateNamespace; accessors_for_namespace :game
  
  belongs_to :planet, :foreign_key => :game_planet_id
  belongs_to :ground
  belongs_to :user
  
  #attr_accessible :game_planet_id, :environment, :game_user_id
  attr_protected
  
  
  
  def to_3d x, y, canvas_width
    half_width = canvas_width / 2

    x -= half_width
    y = half_width - y

    distance = Math::sqrt( (x * x) + (y * y) )

    angle = (half_width - distance) * 180 / canvas_width
    rad_angle = angle * Math::PI / 180

    distance_3d = Math::cos( rad_angle ) * half_width
    transform_ratio = distance_3d / distance


    x *= transform_ratio
    y *= transform_ratio

    x += half_width
    y = half_width - y

    return x.to_i, y.to_i
  end
  
  def to_canvas_script max_x, max_y, canvas_width
 #   canvas_width = planet.size * 10
    
   # max_x, max_y = (provinces = planet.provinces).map(&:x).max, provinces.map(&:y).max
    
    hexa_height = canvas_width / (( 3 * (max_y + 1) ) + 1).to_f
    hexa_width = canvas_width / ( max_x + 1  + 1 ).to_f
    
    pt_ref = [x * hexa_width, y * 3 * hexa_height]
    
    top = [ pt_ref[0] + hexa_width, pt_ref[1] ]
    top_left = [ pt_ref[0], pt_ref[1] + hexa_height ]
    top_right = [ pt_ref[0] + ( 2 * hexa_width), pt_ref[1] + hexa_height ]
    bottom = [ pt_ref[0] + hexa_width, pt_ref[1] + ( 4 * hexa_height) ]
    bottom_left = [ pt_ref[0], pt_ref[1] + ( 3 * hexa_height) ]
    bottom_right = [ pt_ref[0] + ( 2 * hexa_width), pt_ref[1] + ( 3 * hexa_height) ]

    top = to_3d( top[0], top[1], canvas_width )
    top_left = to_3d( top_left[0], top_left[1], canvas_width )
    top_right = to_3d( top_right[0], top_right[1], canvas_width )
    bottom = to_3d( bottom[0], bottom[1], canvas_width )
    bottom_left = to_3d( bottom_left[0], bottom_left[1], canvas_width )
    bottom_right = to_3d( bottom_right[0], bottom_right[1], canvas_width )

  #  "ctx.beginPath();ctx.moveTo(#{ top[0] },#{ top[1] });ctx.lineTo(#{ top_right[0] },#{ top_right[1] });ctx.lineTo(#{ bottom_right[0] },#{ bottom_right[1] });ctx.lineTo(#{ bottom[0] },#{ bottom[1] });ctx.lineTo(#{ bottom_left[0] },#{ bottom_left[1] });ctx.lineTo(#{ top_left[0] },#{ top_left[1] });ctx.fill();       ctx.beginPath();ctx.moveTo(#{ top[0] },#{ top[1] });ctx.lineTo(#{ top_right[0] },#{ top_right[1] });ctx.lineTo(#{ bottom_right[0] },#{ bottom_right[1] });ctx.lineTo(#{ bottom[0] },#{ bottom[1] });ctx.lineTo(#{ bottom_left[0] },#{ bottom_left[1] });ctx.lineTo(#{ top_left[0] },#{ top_left[1] });         ctx.closePath();ctx.stroke();"
    
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
    #carre
  
  end
  
  def to_3d_tranform(max_x, max_y)
  #for provinces saved with x/y pos in integers
=begin
    max_y = planet.provinces.where(:x => x).map(&:y).max

    p "max y #{max_y}"

    y_deg = y * 180 / max_y rescue 0
    
    x_deg = Math::acos(x/max_x) * 90
    
    
    x_deg = 180 * Math::asin(x/max_x) / Math::PI
    
    "<div class='province' posx='#{x}' posy='#{y}' max='#{max_x}_#{max_y}' style='-webkit-transform: perspective(0px) rotateY(#{y_deg}deg) rotateX(#{x_deg}deg) translateZ(125px);'></div>"
=end


  "<div class='province' posx='#{x}' posy='#{y}' max='#{max_x}_#{max_y}' style='-webkit-transform: perspective(0px) rotateY(#{y}rad) rotateX(#{x}rad) translateZ(125px);'></div>"
  end
  
end
