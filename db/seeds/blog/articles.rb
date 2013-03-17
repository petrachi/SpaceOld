#!/bin/env ruby
# encoding: utf-8

Blog::Article.create :user => @user.blog_user,
  :title => "De l'histoire d'une boule",
  :summary => %q{
    De l'idée de représenter une planète, à la réalisation en CSS3 via la propriété 'transform', en passant par un algorithme de répartition des points sur une sphére. 
  },
  :content => %q{  
    <%= scss %q{
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
    } %>

    <p>
    	Créer une sphére n'est pas une tâche facile, et le faire en utilisant uniquement des éléments html et les nouvelles propriétés CSS 'transform' ne facilite pas la tâche. Mais pour commencer, pourquoi faire une sphére.
    </p>

    <p>
    	Imaginons que l'auteur de cet article veuille créer un jeu, sur l'internet. Ce jeu se déroulerait dans l'espace, et la mécanique principale serait de conquérir des planètes, provinces par provinces.<br/>
    	L'auteur de cette article devrait pouvoir représenter une planète, et être capable d'interagir avec. L'idée est de positionner chaque province afin de donner une forme sphérique à l'ensemble, qui créera l'illusion de former un tout.
    </p>

    <h3>
    	Provinces et coordonées sphériques
    </h3>

    <p>
    	Pour représenter les provinces, j'utilise des 'div'. Simples, élégantes, elles ont l'avantage d'être hyper interactives. On peut y mettre des liens, des effets ':hover', etc.<br/>
    	Là où cela se complique, c'est de les positionner, en 3d, sur une sphère. La nouvelle norme CSS3 nous aide beaucoup ici car elle implémente des transformations 3d.
    </p>

    <p>
    	Les transformations, ce sont les fonctions de géométrie qu'on apprends au collège. Rotations, translations, etc.<br/>
    	Pour la sphére, je commence d'abord par effectuer une rotation, afin d'aligner la div dans la bonne direction, puis j'effectue une translation. Hum... Je pense qu'une démo (-webkit- only) sera plus explicite.
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
    			<h4 align="center">J'ajoute la rotation</h4>

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
.demo{
  -webkit-transform: perspective(800px) rotateY(1.1rad) translateZ(60px);
}
    <% end %>

    <p>
    	Mieux non ? Jettez donc un oeil au site de microsoft qui permet de bien s'amuser avec les transform - http://ie.microsoft.com/testdrive/graphics/hands-on-css3/hands-on_3d-transforms.htm
    </p>

    <h3>
    	Répartition des points sur une sphére
    </h3>

    <p>
    	Maintenant qu'on sait comment positionner nos provinces, il va falloir calculer les positions pour chaqu'une, en faisant en sorte que la distance entre chaque province soit égale.
    </p>

    <p>
    	C'est un vrai problème de math, qui reste encore irrésolu pour un nombre de points variable (il existe des solutions pour 3, 4, 6 et 12 points). Il existe, en cherchant bien, des modéles mathématiques très compliqué basé sur la répulsion afin de << maximiser la distance la plus courte entre deux points >>.<br/>
    	Ce genre d'algorithme est assez compliqué, le principe et de positionner les points, puis de re-calculer récursivement les positions en fonction d'une valeur de répulsion.<br/>
    	J'ai opté pour un algo plus simple qui se base sur le nombre d'or. 
    </p>

    <%= container :class => :'demo-transform' do %>
    	<%= row :nested => true do %>
    		<%= four_span do %>
    			<h4>Code original -en python-</h4>

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
  	<% end %>

  	<%= four_span :prepend => 1 do %>
  		<h4>Code traduit en ruby</h4>

  		<%= coderay :lang => :python do %>
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
    			<% end %>
    		<% end %>
    	<% end %>
    <% end %>

    <p>
    	Ne me demandez pas de vous expliquer les détails. je l'ai traduit de python pour ruby. J'ai aussi adapté les valeurs de retour car le code python retourne des coordonnées cartésiennes, et je veux utiliser des coordonnées sphériques (http://fr.wikipedia.org/wiki/Coordonn%C3%A9es_sph%C3%A9riques).
    </p>

    <h3>
    	Tout ça mis ensemble, ça donne quoi ?
    </h3>

    <p>
    	Une simple boucle suffit à produire le HTML.
    </p>

    <%= coderay :lang => :erb do %>
<div class="planet-container">
	<div class="planet">
		<%% points.each do |(p, ϕ, θ)| %>
  			<div class="province"
    			style="-webkit-transform: rotateY(<%%= ϕ %>rad) rotateX(<%%= θ %>rad) translateZ(<%%= p * r %>px) rotate(-30deg);" />
  			</div>
		<%% end %>
	</div>
</div>
    <% end %>
    <p>
    	Vous pouvez retrouver la démo live dans la section expériment : <%= link_to t(:see), experiment_url(:action => :show, :id => 1), :class => :btn, :target => :_blank %>

    </p>

    <h3>
    	Alors, prêt à faire des transition tout le temps ?
    </h3>

    <p>
    	Faire une sphére, c'est compliqué si on n'utilise que HTML/CSS. Ça a néanmoins le mérite d'exister, et d'être accessible sans plugins, flash ou autre -à condition d'avoir un navigateur moderne-.<br/>
    	Côté optimisation, le processeur monte vite en charge. Les transforms ne semblent pas utiliser les ressources GPU mais CPU. Vous avez vous-même pu voir votre process prendre un coup sur la page de démo. Notez tout de même qu'on anime 600 provinces dans la démo.<br/>
    	Je me pencherais peut-être sur des librairies 3D javascript, comme trre.js -http://mrdoob.github.com/three.js/-, qui semblent plus performantes pour l'instant. (D'ailleurs, voici une démo dont je pourrais m'inspirer http://mrdoob.github.com/three.js/examples/css3d_periodictable.html (cliquez sur "sphére" en bas))
    </p>

    <p>
    	Voilà, je me suis beaucoup amusé au cours de cette expérience. Je vous parlerais prochainement d'une autre solution que j'avais élaboré pour représenté une sphére, basé sur SVG.
    </p>

    <p>
    	À la prochaine les loulous !
    </p>
  },
  :published => true