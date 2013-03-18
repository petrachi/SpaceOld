#!/bin/env ruby
# encoding: utf-8

Blog::Article.create :user => @user.blog_user,
  :title => "De l'histoire d'une boule",
  :summary => %q{
    De l'idée de représenter une planète, à la réalisation en CSS3 via la propriété 'transform', en passant par un algorithme de répartition des points sur une sphére. 
  },
  :content => %q{ 
    <%
      def point_on_sphere n
        n = n.to_f
        pts = []

        inc = Math::PI * (3 - Math::sqrt(5))
        off = 2 / n

        (0...n).each do |k|
          y = k * off - 1 + (off / 2)    
          r = Math::sqrt(1 - y**2)
          phi = k * inc

          x_phi = Math::PI/2 - Math::acos(y)

          pts << [1.0, phi, x_phi]
        end

        pts
      end

      n = 150
      r = 130

      points = point_on_sphere(n)
    %>
     
    <%= scss %Q{
    	.demo-transform{
    		.demo{
    			position: relative;

    			margin: auto;
    			height: 10em;
    			width: 10em;

    			div{
    				position: absolute;
    				top: 0;
    				left : 0;

    				height: 100%;
    				width : 100%;
    		    background-color: $primary-color;

    				@include box-shadow(0 0 0 1px rgba(0, 0, 0, .6) inset);
    				opacity: .25;
    				@include border-radius(1px);

    				color: $white;
    				font-weight: bold;
    				letter-spacing: 1px;

    				&.final{
    					opacity: 1;
    				}

    				p{	
    					margin: 0 .1em;
    				}
    			}

    			.rotation{
    				@include transform( perspective(800px) rotateY(1.05rad) );
    			}

    			.translation{
    				@include transform( perspective(800px) rotateY(1.05rad) translateZ(60px) );
    			}
    		}
    	}
    	
    	.demo-planet{
    	  .planet{
  		    height: 300px;
  		    width: 300px;
  				position: relative;
  		    margin: 1em auto;
  		    @include transform-style(preserve-3d);
          @include transform(perspective(800px) rotateY(15deg));
          background-color: rgba($black, .85);
          
  				.province{  
  			    height: 14px; 
  			    width: 14px;
  			    background-color: $primary-color;

  			    position: absolute;
  			    left: 50%;
  			    top: 50%;
  			    
  			    #{ 
              scss_points = Array.new
  			      points.each_with_index do |(p, ϕ, θ), i|
  			        scss_points << "&#province-#{ i }{
    	            @include transform(rotateY(#{ ϕ }rad) rotateX(#{ θ }rad) translateZ(#{ p * r }px));
    	          }"
  			      end
  			      scss_points.join("
  			      ")
  			    }
  			  }
  			}
    	}
    } %>

    <p>
    	Comment créer une sphère en utilisant seulement les technologies de l'internet, et pourquoi ?
    </p>

    <p>
      Le but de cette expérimentation est de représenter une planète, qui sera contruite à partir de multiple provinces. La planète sera utilisé dans un jeu où le joueur pourra conquérir chaque province, y contruire des bâtiments et recruter une armée.
    </p>

    <h3>
    	Transformations
    </h3>

    <p>
      Chaque province sera représentée par une 'div', ce qui permettra une interaction facile avec l'utilisateur.
    </p>
    
    <p>
      Afin de créer une planète, nous allons utiliser la propriété 'transform'. En fonction des coordonnées de chaque 'div', nous appliquerons d'abord une rotation, afin de positionner l'élément dans direction voulue, puis une translation, afin de projetter l'élément sur la surface de la planète.
    </p>
    
    <p>
    	Une petite démonstration s'impose, voilà ce que cela donne. (si la démo ne fonctionne pas, c'est parceque votre navigateur est trop vieux, pensez à le mettre à jour !)
    </p>

    <%= container :class => :'demo-transform' do %>
    	<%= row :nested => true do %>
    		<%= three_span :class => :base do %>
    			<h4 align="center">Pas de transformation</h4>

    			<div class="demo">
    				<div class="origin final">
    					<p>Final</p>
    				</div>
    			</div>
    		<% end %>

    		<%= three_span :class => :intermediate do %>
    			<h4 align="center">D'abord la rotation</h4>

    			<div class="demo">
    				<div class="origin">
    					<p>1</p>
    				</div>
    				<div class="rotation final">
    					<p>Final</p>
    				</div>
    			</div>
    		<% end %>

    		<%= three_span :class => :final do %>
    			<h4 align="center">Puis la translation</h4>

    			<div class="demo">
    				<div class="origin">
    					<p>1</p>
    				</div>
    				<div class="rotation">
    					<p>2</p>
    				</div>
    				<div class="translation final">
    					<p>Final</p>
    				</div>
    			</div>
    		<% end %>
    	<% end %>
    <% end %>

    <%= coderay :lang => :css do %>
.demo {
  transform: perspective(800px) rotateY(1.05rad) translateZ(60px); 
}
    <% end %>

    <p>
    	C'est tout de suite plus clair !<br/>
    	Allez donc faire un tour sur ce site de microsoft pour faire joujou avec 'transform' -  http://ie.microsoft.com/testdrive/graphics/hands-on-css3/hands-on_3d-transforms.htm
    </p>

    <h3>
    	Calcul des coordonnées
    </h3>

    <p>
      Maintenant qu'on sait utiliser les transforms, il ne nous reste plus qu'à apprendre comment calculer les valeurs de transform.
    </p>

    <p>
      Pour les coordonnées, j'ai choisi d'utiliser des coordonnées sphériques - http://fr.wikipedia.org/wiki/Coordonn%C3%A9es_sph%C3%A9riques. Ces ont celles qui correspondent le mieux aux valeurs qu'utilise 'transform'. Pour l'algo, j'ai choisi ... hem ... en fait, je n'ai pas choisi grand chose.
    </p>
    
    <h3>
      Maximiser la distance la plus courte entre deux points
    </h3>
    
    <p>
      La répartition des points sur une sphère, c'est un vrai problème de math, qui occupe les scientifiques et les les plus grands cerveaux de france depuis des siècles et des sciècles !
    </p>
    
    <p>
      La meilleure solution dont nous disposons aujourd'hui est de "maximiser la distance la plus courte entre deux points". C'est faire en sorte que la distance entre deux provinces soit toujours la plus grande distance possible. Le second rpoblème c'est que ... je n'ai pas bien compris toute les explications sur les fait d'associer des charges électriques sur les points, puis de calculer la valeur de répulsion...
    </p>
    
    <p>
    	L'algorithme que nous utiliserons ici se base sur le nombre d'or, afin de répartir les provinces tout autour de notre planète. Je l'ai traduit du python et adapté pour récupérer des données directement utilisables dans les transforms.
    </p>

    <%= container :class => :'demo-transform' do %>
    	<%= row :nested => true do %>
    		<%= four_span do %>
    			<h4>Le 'Golden Section Spiral' original</h4>

    			<%= coderay :lang => :python do %>
def pointsOnSphere(N):
  N = float(N) # in case we got an int which we surely got
  pts = []

  inc = math.pi * (3 - math.sqrt(5))
  off = 2 / N
  for k in range(0, N):
      y = k * off - 1 + (off / 2)
      r = math.sqrt(1 - y*y)
      phi = k * inc
      pts.append([math.cos(phi)*r, y, math.sin(phi)*r])

  return pts
      		<% end %>
      		
      		<p>
      		  Voir le code original dans son contexte - http://www.xsi-blog.com/archives/115
      		</p>
      	<% end %>

      	<%= five_span do %>
      		<h4>La traduction rubyiste</h4>

      		<%= coderay :lang => :python do %>
def points_on_sphere n
  n = n.to_f
  pts = []

  inc = Math::PI * (3 - Math::sqrt(5))
  off = 2 / n

  (0...n).each do |k|
  y = k * off - 1 + (off / 2)    
  r = Math::sqrt(1 - y**2)
  phi = k * inc

  x_phi = Math::PI/2 - Math::acos(y)

  pts << [1.0, phi, x_phi]
  end

  pts
end
    			<% end %>
    		<% end %>
    	<% end %>
    <% end %>

    <h3>
    	Le résultat planétaire !
    </h3>

    <p>
    	Une simple boucle suffit à produire notre HTML.
    </p>

    <%= container do %>
    	<%= row :nested => true do %>
    		<%= four_span do %>
    		  <%= coderay :lang => :erb do %>
<div class="planet-container">
	<div class="planet">
		<%% points.each do |(p, ϕ, θ)| %>
  			<div class="province"
    			style="transform: 
    			  rotateY(<%%= ϕ %>rad) 
    			  rotateX(<%%= θ %>rad) 
    			  translateZ(<%%= p * r %>px);" />
  			</div>
		<%% end %>
	</div>
</div>
    		  <% end %>
    		<% end %>

    		<%= five_span :class => 'demo-planet' do %>
  	      <div class="planet">
  	        <% points.each_with_index do |_, i| %>
  	          <div class="province" id="province-<%= i %>" />
      			</div>
    	      <% end %>
    	    </div>

    		<% end %>
    	<% end %>
    <% end %>
    
    <p>
    	Vous pouvez voir une démo encore plus impressionnante dans la section "Expérimentations" : <%= link_to t(:see), experiment_url(:action => :show, :id => 1), :class => :btn, :target => :_blank %>
    </p>

    <h3>
    	Conclusion
    </h3>

    <p>
      C'était vraiment très rigolo de faire cette planète avec vous les copains, mais faut quand même dire que c'était pas d'la tarte.
    </p>
    
    <p>
      La nouvelle propriété 'transition' que nous apporte CSS3 est très sympatique, mais je ne suis pas sûr qu'elle soit complètement adapté ici. Nous allons vouloir transformer, et même, animiner plusieurs centaines de provinces. Jettez un coup d'oeil sur votre processeur pendant que vous êtes sur la page de démo et vous comprendrez pourquoi je me fait du souci.
    </p>
    
    <p>
      Je jetterais sûrement un oeil sur des librairies 3D en javascript, comme "tree.js" - http://mrdoob.github.com/three.js/.<br/>
      D'ailleur, 'transform' n'est pas mon premier amour. J'avais déjà réalisé le même exercice en utilisant SVG, mais ça, c'est une autre histoire ... toire ... toire ...
    </p>
  },
  :published => true
