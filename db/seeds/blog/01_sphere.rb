#!/bin/env ruby
# encoding: utf-8

@sphere_experience = Blog::Experience.create :user => @primal_user.blog_user,
  :title => "Sphère",
  :summary => %q{
    Une sphère tout en web :). Pas de flash, pas de librairies javascript, juste des <i>div</i> et des <i>transforms</i>. 
  },
  :snippet => Blog::Snippet.create(:params => %q{
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
  				@include transform(rotateZ(23deg) rotateY(-180deg)); 
  			}
  		  to {
  				@include transform(rotateZ(23deg) rotateY(180deg));
  			}
  		}

  		.planet-container{
  		  margin: 2em auto;

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
    :js => "// No JS"),
  :published => true,
  :published_at => "05-05-2013".to_datetime,
  :tag => :sphere,
  :pool => :experience




Blog::Snippet.create :primal => @sphere_experience.snippet,
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
  :mutation => :mini


@sphere_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Construction d'une sphère",
  :summary => %q{
    Répartition équitable de <i>n</i> points sur une sphére et rendu graphique avec les technologies web natives.
  },
  :snippet => Blog::Snippet.create(erb: %q{ 
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

    				@include box-shadow(0 0 0 1px $shadow inset);
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
    	Allez, salut les p'tit amis !<br/>
    	Aujourd'hui, on va tenter de faire une sphére tout en html. Pour ce faire, nous allons 'répartir' équitablement un nombre <i>n</i> de points à la surface de la sphère, puis créer une <%= coderay({:inline => true, :lang => :html}, "<div>") %> pour chaque point que nous allons positionner grâce aux nouvelles propriétés 3D de CSS3.
    </p>
    
    <h3>
    	Répartition de <i>n</i> points à la surface d'une sphère
    </h3>

    <p>
      Il y a plusieurs définitions possibles lorsqu'on parle de répartir équitablement <i>n</i> points à la surface d'une sphère. On peut choisir de positionner les points de telle façon que le polyèdre formé par ceux-ci soit un polyèdre régulier. Malheureusement, on ne connait aujourd'hui qu'un nombre très limité de polyèdre réguliers.<br/>
      Nous allons choisir une autre définition qui consite à tenter de maximiser la distance la plus courte entre deux points. Plusieurs méthodes sont disponibles pour arriver à ce résultat. On peut par exemple positionner les points d'abord aléatoirement, puis les repositionner par itération en faisant s'appliquer une force de répulsion entre les points.
    </p>
    
    <p>
      En cherchant bien sur l'internet, j'ai trouvé un algorithme fiable et rapide basé sur le nombre d'or. Rapidement traduit en ruby, cet algorithme renvoie un tableau de points, représentés par leurs coordonnées sphériques ([distance, angle horizontal, angle vertical] - noté [p, ϕ, θ] - les angles sont exprimés en radians). Voilà ce que ça donne : 
    </p>
    
    
  	<%= row_tag do %>
  		<%= col_5_tag do %>
    		<%= coderay do %>
def points_on_sphere n
n = n.to_f
pts = Array.new

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

    	<%= col_4_tag do %>
    	  <%= coderay do %>
>> points_on_sphere 6
=>[
[1.0, 0.0, -1.1596584], 
[1.0, 2.3999632, -0.848062], 
[1.0, 4.7999264, -0.6228265], 
[1.0, 7.1998896, -0.4297754], 
[1.0, 9.5998529, -0.2526802], 
[1.0, 11.9998161, -0.08343], 
[1.0, 14.3997793, 0.08343], 
[1.0, 16.7997426, 0.2526802], 
[1.0, 19.1997058, 0.4297754], 
[1.0, 21.599669, 0.6228265], 
[1.0, 23.9996322, 0.848062], 
[1.0, 26.3995955, 1.1596584]
]
        <% end %>
  		<% end %>
  	<% end %>
    
    <h3>
    	Représentation graphique
    </h3>
    
    <p>
      Chaque point sera représenté par une <%= coderay({:inline => true, :lang => :html}, "<div>") %>, qui sera ensuite positionnée via les propriètés <%= coderay({:inline => true, :lang => :css}, :transform) %> de la norme CSS3. Une rapide démonstration de l'utilisation des <%= coderay({:inline => true, :lang => :css}, :transform) %> montre bien la facilité avec laquelle nous pouvons réaliser un rendu graphique 3D en web aujourd'hui, merci les nouvelles technologies !
    </p>
  
  	<%= row_tag :class => :'demo-transform' do %>
  		<%= col_3_tag :class => :base do %>
  			<h4 class="text-center">Aucune transformation</h4>

  			<div class="demo">
  				<div class="origin final">
  					<p>Final</p>
  				</div>
  			</div>
  		<% end %>

  		<%= col_3_tag :class => :intermediate do %>
  			<h4 class="text-center">Une rotation</h4>

  			<div class="demo">
  				<div class="origin">
  					<p>1</p>
  				</div>
  				<div class="rotation final">
  					<p>Final</p>
  				</div>
  			</div>
  		<% end %>

  		<%= col_3_tag :class => :final do %>
  			<h4 class="text-center">Suivie d'une translation</h4>

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
    
    <%= coderay :lang => :css do %>
.demo {
  transform: perspective(600px) rotateY(.85rad) translateZ(80px); 
}
    <% end %>

    <h3>
    	Application aux coordonnées sphériques
    </h3>

    <p>
    	En appliquant ces propriétés de <%= coderay({:inline => true, :lang => :css}, :transform) %> aux valeurs des coordonnées sphériques calculées précédement, nous pouvons afficher notre sphère très simplement.
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
    
    <%= erb Blog::Experience.where(tag: :sphere).first.run(:mini) %>

    <h3>
    	Conclusion
    </h3>

    <p>
      J'ai eu beaucoup de difficultés à faire l'algorithme de répartition de points sur une sphére, à tel point que j'ai fini par un récupérer un sur l'internet (dont le fonctionnement me reste un peu obscur). L'utilisation des propriètés CSS liés à la 3D à par contre été plutôt simple, même si elles ont l'air assez consomatrices en ressources et en temps de rendu DOM.
    </p>
    
    <p>
      Je pense me replonger un jour dans la réalisation d'une sphère en 3D, via SVG, WebGL ou des librairies javascript.
    </p>
    
    <p>
      Allez, bisous les copains ! Ouste !
    </p>
  }),
  :pool => :experience,
  :tag => :sphere,
  :published => true,
  :published_at => "05-05-2013".to_datetime


Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Hands On",
  :summary => "Site de démo des propriétés CSS3 les plus \"trendy\"",
  :link => "http://ie.microsoft.com/testdrive/graphics/hands-on-css3",
  :pool => :demo,
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Coordonnées Sphériques",
  :summary => "C'est quoi les coordonnées sphériques ? Non mais dis donc ! Explique moi tout !",
  :link => "http://fr.wikipedia.org/wiki/Coordonn%C3%A9es_sph%C3%A9riques",
  :pool => :doc,
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Points on a sphére",
  :summary => "Répartir des points équitablement sur une sphére (en anglais)",
  :link => "http://www.xsi-blog.com/archives/115",
  :pool => :blog,
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Three JS",
  :summary => "Librairie Javascript",
  :link => "http://mrdoob.github.com/three.js/",
  :pool => :technology_watch,
  :published => true
