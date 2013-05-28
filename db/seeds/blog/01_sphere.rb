#!/bin/env ruby
# encoding: utf-8

@sphere_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "C'est l'histoire d'une boule",
  :summary => %q{
    De l'idée de représenter une planète, à la réalisation en CSS3 via la propriété 'transform', en passant par un algorithme de répartition des points sur une sphére. 
  },
  :code => %q{ 
    <%= scss %Q{
      @include keyframes(rotation){
    		from{ 
    			@include transform( perspective(600px) rotateY(0rad) ); 
    		}
    		45%{ 
    			@include transform( perspective(600px) rotateY(.85rad) ); 
    		}
    	}

    	@include keyframes(translation){
    		from { 
    			@include transform( perspective(600px) rotateY(.85rad) ); 
    		}
    		45%{ 
    			@include transform( perspective(600px) rotateY(.85rad) ); 
    		}
    		90%{ 
    			@include transform( perspective(600px) rotateY(.85rad) translateZ(80px) ); 
    		}
    	}

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

    				@include box-shadow(0 0 0 1px $black-shadow inset);
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
    				@include transform( perspective(600px) rotateY(.85rad) );
    			}

    			.translation{
    				@include transform( perspective(600px) rotateY(.85rad) translateZ(80px) );
    			}
    			
    			.final{
        		&.rotation{
      				@include animation(rotation 4s ease-out infinite);
      			}

      			&.translation{
      				@include animation(translation 4s ease-out infinite);
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
  transform: perspective(600px) rotateY(.85rad) translateZ(80px); 
}
    <% end %>

    <p>
    	C'est tout de suite plus clair !<br/>
    	Allez donc faire un tour sur ce site de microsoft pour faire joujou avec 'transform' - <%= link_to t(:link), "http://ie.microsoft.com/testdrive/graphics/hands-on-css3/hands-on_3d-transforms.htm", :target => :_blank %> 
    </p>

    <h3>
    	Calcul des coordonnées
    </h3>

    <p>
      Maintenant qu'on sait utiliser les transforms, il ne nous reste plus qu'à apprendre comment calculer les valeurs de transform.
    </p>

    <p>
      Pour les coordonnées, j'ai choisi d'utiliser des coordonnées sphériques - <%= link_to t(:wikilink), "http://fr.wikipedia.org/wiki/Coordonn%C3%A9es_sph%C3%A9riques", :target => :_blank %>. Ces ont celles qui correspondent le mieux aux valeurs qu'utilise 'transform'. Pour l'algo, j'ai choisi ... hem ... en fait, je n'ai pas choisi grand chose.
    </p>
    
    <h3>
      Maximiser la distance la plus courte entre deux points
    </h3>
    
    <p>
      La répartition des points sur une sphère, c'est un vrai problème de maths, qui occupe les scientifiques et les les plus grands cerveaux de france depuis des siècles et des sciècles !
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
      		  Voir le code original dans son contexte - <%= link_to t(:link), "http://www.xsi-blog.com/archives/115", :target => :_blank %>
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

    <%= coderay :lang => :erb do %>
<div class="planet-container">
	<div class="planet">
		<%% points.each do |(p, ϕ, θ)| %>
  			<div class="province"
    			style="transform: rotateY(<%%= ϕ %>rad) rotateX(<%%= θ %>rad) translateZ(<%%= p * r %>px);" />
  			</div>
		<%% end %>
	</div>
</div>
    <% end %>
    
    <%= erb @article.experiment.with_mutant_version(:article).code %>

    <p>
    	Vous pouvez voir une démo encore plus impressionnante dans la section "Expérimentations"
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
      Je jetterais sûrement un oeil sur des librairies 3D en javascript, comme "tree.js" - <%= link_to t(:link), "http://mrdoob.github.com/three.js/", :target => :_blank %><br/>
      D'ailleur, 'transform' n'est pas mon premier amour. J'avais déjà réalisé le même exercice en utilisant SVG, mais ça, c'est une autre histoire ... toire ... toire ...
    </p>
  },
  :pool => :experiment,
  :published => true


@sphere_experiment = Blog::Experiment.create :user => @primal_user.blog_user,
  :title => "Sphère",
  :summary => %q{
    Une sphère tout en web :). Pas de flash, pas de librairies javascript, juste des <i>div</i> et des <i>transforms</i>. 
  },
  :article => @sphere_article,
  :published => true


@sphere_version = Blog::Version.create :user => @primal_user.blog_user,
  :experiment => @sphere_experiment,
  :params => %q{
    n = 789
    r = 230
    h = 8
  },
  :ruby => %q{
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
	  
	  points = point_on_sphere(n)
  },
  :scss => %q{
    @include keyframes(planet-rotation){
			from{
				@include transform(rotateZ(23deg) rotateY(360deg)); 
			}
		  to {
				@include transform(rotateZ(23deg) rotateY(0deg));
			}
		}

		.planet-container{
		  margin: 1em auto;

      height: #{ r * 2 }px;
			width: #{ r * 2 }px;

			.planet{ 
		  	height: 100%;
		    width: 100%;
		    position: relative;

		    @include transform-style(preserve-3d);
		    @include animation(planet-rotation 270s linear infinite);

				.province{  
			    @include backface-visibility(hidden);

			    position: absolute;
			    left: #{ r - (h/2) }px;
			    top: #{ r - (h/2) }px;

			    height: #{ h }px; 
				  width: #{ h }px;

          background-color: $primary-color;
			    @include border-radius(50%);
			    
			    #{
			      points.each_with_index.map do |(p, ϕ, θ), i|
			        %Q{
			          &#province-#{ i }{
                  @include transform(rotateY(#{ ϕ }rad) rotateX(#{ θ }rad) translateZ(#{ p * r }px));
    	          }
			        } 
			      end.join "
			      "
			    }
			  }
			}
		}
  },
  :erb => %q{
    <div class="planet-container">
      <div class="planet">
        <% points.each_index do |i| %>
          <div class="province" id="province-<%= i %>">
          </div>
        <% end %>
      </div>
    </div>
  },
  :js => "// No JS",
  :published => true

Blog::Version.create :user => @primal_user.blog_user,
  :experiment => @sphere_experiment,
  :primal => @sphere_version,
  :params => %q{
    n = 389
    r = 132
    h = 4
  },
  :scss => %q{
		.planet-container{
		  margin: 1em auto;

      height: #{ r * 2 }px;
			width: #{ r * 2 }px;

			.planet{ 
		  	height: 100%;
		    width: 100%;
		    position: relative;

		    @include transform-style(preserve-3d);

				.province{  
			    @include backface-visibility(hidden);

			    position: absolute;
			    left: #{ r - (h/2) }px;
			    top: #{ r - (h/2) }px;

			    height: #{ h }px; 
				  width: #{ h }px;

          background-color: $primary-color;
          
          #{
			      points.each_with_index.map do |(p, ϕ, θ), i|
			        %Q{
			          &#province-#{ i }{
                  @include transform(rotateY(#{ ϕ }rad) rotateX(#{ θ }rad) translateZ(#{ p * r }px));
    	          }
			        } 
			      end.join "
			      "
			    }
			  }
			}
		}
  },
  :mutation => :article,
  :published => true


Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Hands On",
  :summary => "Site de démo des propriétés CSS3 les plus \"trendy\"",
  :link => "http://ie.microsoft.com/testdrive/graphics/hands-on-css3",
  :pool => :demo,
  :article => @sphere_article,
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Coordonnées Sphériques",
  :summary => "C'est quoi les coordonnées sphériques ? Non mais dis donc ! Explique moi tout !",
  :link => "http://fr.wikipedia.org/wiki/Coordonn%C3%A9es_sph%C3%A9riques",
  :pool => :doc,
  :article => @sphere_article,
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Points on a sphére",
  :summary => "Répartir des points équitablement sur une sphére (en anglais)",
  :link => "http://www.xsi-blog.com/archives/115",
  :pool => :blog,
  :article => @sphere_article,
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Three JS",
  :summary => "Librairie Javascript",
  :link => "http://mrdoob.github.com/three.js/",
  :pool => :technology_watch,
  :article => @sphere_article,
  :published => true