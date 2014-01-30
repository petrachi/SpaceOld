#!/bin/env ruby
# encoding: utf-8


@spriting_experience = Blog::Experience.create :user => @primal_user.blog_user,
  :title => "Spriting SC2",
  :summary => %q{
    Un sprite pour toutes les tailles.
  },
  :published => false,
  :tag => :sprite,
  :pool => :experience

@spriting_version = Blog::Snippet.create :runnable => @spriting_experience,
  :params => %q{
    # No Params
  },
  :ruby => %q{
    Object.class_eval %q{
			module Sass::Script::Functions
			  remove_method :custom_percentage if defined? custom_percentage
        
			  def custom_percentage(value, total)
			    value = value.to_i
			    total = total.to_i
          
			    percentage = value * 100.0 / total
          
			    Sass::Script::String.new("#{ percentage }%")
			  end
			  declare :int, :args => [:string]
			end
		}
  },
  :scss => %q{
		$sc-icon-sprites: sprite-map("blog/experience/sc-icon/*.png");
		
		.sc-icon-sprite{
		    background-image: inline-sprite($sc-icon-sprites);
		}
		
		@include sprites($sc-icon-sprites, protoss terran zerg);
		
		@each $sprite in sprite_names($sc-icon-sprites) {
			.sc-icon-\#{$sprite}{
				@extend .sc-icon-sprite;
				
				display: inline-block;
				width: image-width(sprite_file($sc-icon-sprites, $sprite));
				height: image-height(sprite_file($sc-icon-sprites, $sprite));
			}
		}
		
		@mixin sprite-reposition-percent($map, $space-between){
			$mapHeight: image-height(sprite-path($map)) - $space-between;
      
			@each $sprite in sprite_names($map) {
				$spriteHeight: nth(sprite-position($map, $sprite), 2);
				$spriteHeight: -$spriteHeight;
        
				.\#{sprite_map_name($map)}-\#{$sprite}{
					background-size: 100%;
					background-position: 50% custom_percentage($spriteHeight, $mapHeight);
          
					display: inline-block;
				}
			}
		}
    
		@include sprite-reposition-percent($sc-icon-sprites, 264px);
		
    @mixin resize-sprite($width) {
		  width: $width;
			height: $width;
				
			box-shadow: inset 0 0 $width/2 black;
		}
			
		@each $sprite in sprite_names($sc-icon-sprites) {
		  .sc-icon-\#{$sprite}{
				@include resize-sprite(66px);
			}
      
			.sc-icon-\#{$sprite}.icon-x2{
				@include resize-sprite(132px);
			}
      
    	.sc-icon-\#{$sprite}.icon-x3{
				@include resize-sprite(198px);
			}
      
			.sc-icon-\#{$sprite}.icon-x4{
				@include resize-sprite(264px);
			}
		}
		
		
		#sc-demo{
			line-height: 0;
		  margin: 1em 0;
		  
			.row{
				width: 864px;
			}
		}
		
		#fit-article{
		  margin: 1em 5em;
		}
  },
  :erb => %q{
    <%= container :id => :'sc-demo' do %>
    	<%= row do %>

    		<%= three_span do %>
    			<%= raw '<i class="sc-icon-zerg"></i>' * 16 %>
    		<% end %>

    		<%= three_span do %>
    			<i class="sc-icon-protoss icon-x4"></i>
    		<% end %>

    		<%= three_span do %>
    			<%= raw '<i class="sc-icon-terran icon-x2"></i>' * 4 %>
    		<% end %>

    	<% end %>
    <% end %>
  },
  :js => "// No JS"

Blog::Snippet.create :primal => @spriting_version,
  :erb => %q{
	  <i class="sc-icon-protoss icon-x4"></i>
  },
  :mutation => :protoss_big

Blog::Snippet.create :primal => @spriting_version,
  :scss => %q{
		$px-icon-sprites: sprite-map("blog/experience/sc-icon/*.png");
		
		.px-icon-sprite{
		    background-image: inline-sprite($px-icon-sprites);
		}
		
		@include sprites($px-icon-sprites, protoss terran zerg);
		
		@each $sprite in sprite_names($px-icon-sprites) {
			.px-icon-\#{$sprite}{
				@extend .px-icon-sprite;
				
				display: inline-block;
				width: image-width(sprite_file($px-icon-sprites, $sprite));
				height: image-height(sprite_file($px-icon-sprites, $sprite));
			}
		}
		
    @mixin resize-sprite($width) {
		  width: $width;
			height: $width;
				
			box-shadow: inset 0 0 $width/2 black;
		}
			
		@each $sprite in sprite_names($px-icon-sprites) {
		  .px-icon-\#{$sprite}{
				@include resize-sprite(66px);
			}
      
			.px-icon-\#{$sprite}.icon-x2{
				@include resize-sprite(132px);
			}
      
    	.px-icon-\#{$sprite}.icon-x3{
				@include resize-sprite(198px);
			}
      
			.px-icon-\#{$sprite}.icon-x4{
				@include resize-sprite(264px);
			}
		}
  },
  :erb => %q{
    <div id="fit-article">
      <i class="px-icon-zerg"></i>
      <i class="px-icon-zerg icon-x2"></i>
      <i class="px-icon-zerg icon-x3"></i>
  	  <i class="px-icon-zerg icon-x4"></i>
	  </div>
  },
  :mutation => :pixels

Blog::Snippet.create :primal => @spriting_version,
  :erb => %q{
    <div id="fit-article">
      <i class="sc-icon-terran"></i>
      <i class="sc-icon-terran icon-x2"></i>
      <i class="sc-icon-terran icon-x3"></i>
  	  <i class="sc-icon-terran icon-x4"></i>
	  </div>
  },
  :mutation => :percent


@spriting_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Positionnement relatif d'un sprite",
  :summary => %q{
    Comment hacker la rigidité du spriting CSS ? En utilisant un positionnement exprimé en '%', le même sprite peut facilement être utilisé dans toutes les tailles du monde !
  },
  :snippet => Blog::Snippet.create(erb: %q{ 
		<p>
			Cet article aborde des notions avancées de CSS, utilise Sass, Compass, et parle de Ruby. Si UNE SEULE de ces technologie vous sont inconnues, RTFMN !
		</p>
				
		<p>
			Les sprites, c'est super facile. Enfin, c'est surtout facile depuis que Sass & Compass se sont ramené avec leur 'magic'. Mais j'ai toujours eu l'impression que cette technique manquait de flexibilité. J'veux dire, regardez les icon-font, du genre de font-awesome. Alors je me suis creusé la tête un maximax et je suis revenu avec une solution, simple, qui permet d'afficher ses sprites dans n'importe quelle taille ! Whaow !
		</p>
		    		
		<h3>
			Création d'un sprite
		</h3>
		
		<p>
			Pour commencer, on va créer un sprite avec les icônes des trois races de starcraft, parceque j'aime bien starcraft. Pour cette partie, je vous laisse lire la doc de Compass.
		</p>
		
		<%= container do %>
			<%= row :nested => true do %>
				<%= six_span do %>
					<%= coderay :lang => :css do %>
@import "sc-icon/*.png";
@include all-sc-icon-sprites;
					<% end %>
					
					<p>
						Pour ceux que la 'magie' interresse, je vous invite à lancer la commande manuelle d'import sprite dans votre console
					</p>
					
					<%= coderay :lang => :shell do %>
compass sprite "app/assets/images/sc-icon/*.png"
					<% end %>
				<% end %>
				
				<%= three_span do %>				  
				  <%= erb @article.experience.with_mutant_version(:protoss_big).code %>
				<% end %>
			<% end %>
		<% end %>
		
		<p>
			Compass va positionner les backgrounds des sprites en 'px', c'est ça qui pose problème si on veut afficher le sprite dans une autre dimension que la dimension native de l'image. 
		</p>
		
		<p>
			Si je voulais faire un peu le fou-fou et que j'utilisait le code situé juste en dessous afin de redimensionner mes sprites, la déception devant le résultat serait à la hauteur de mes espérances. Nul.
		</p>
		
		<%= coderay :lang => :css do %>
@mixin resize-sprite($width) {
  width: $width;
  height: $width;
}

@each $sprite in sprite_names($sc-icon-sprites) {
  .sc-icon-#{$sprite}{
  	@include resize-sprite(66px);
  }

  .sc-icon-#{$sprite}.icon-x2{
  	@include resize-sprite(132px);
  }

  .sc-icon-#{$sprite}.icon-x3{
  	@include resize-sprite(198px);
  }

  .sc-icon-#{$sprite}.icon-x4{
  	@include resize-sprite(264px);
  }
}
		<% end %>
		
		<%= erb @article.experience.with_mutant_version(:pixels).code %>
	  		
		<h3>
			Re-positionnement relatif
		</h3>
		
		<p>
			Maintenant, on va faire travailler votre imagination. Imaginez que le positionnement des sprites soit exprimé en '%', la taille de l'élément conteneur n'aurait plus vraiment d'importance. Vous y êtes ? Votre esprit s'émerveille-t-il devant les trésors révélés dans ce monde fantastique de votre imagination ? Let's get real !
		</p>
		
		<%= coderay :lang => :css do %>	
@mixin sprite-reposition-percent($map, $last-img-height){
  $mapHeight: image-height(sprite-path($map)) - $last-img-height;

  @each $sprite in sprite_names($map) {
  	$spriteHeight: nth(sprite-position($map, $sprite), 2);
  	$spriteHeight: -$spriteHeight;

  	.#{sprite_map_name($map)}-#{$sprite}{
  		background-size: 100%;
  		background-position: 50% custom_percentage($spriteHeight, $mapHeight);

  		display: inline-block;
  	}
  }
}

@include sprite-reposition-percent($sc-icon-sprites, 264px);
		<% end %>
		
		<p>
			On prends chaque image, et on recalcule la position pour l'exprimer en '%'. Vous remarquez, parceque vous êtes malin, que j'ai utilisé une fonction 'custom_percentage', et je crois qu'il est temps d'ouvrir un aparté pour expliquer ça.
		</p>
		
		<h3>
			Du Ruby dans Sass
		</h3>
		
		<p>
			Je n'utilise pas la fonction 'native' Sass 'percentage', car la valeur dans la variable $spriteHeight est inexploitable et renvoie une erreur. Me demandez pas pourquoi j'ai pas compris. J'ai préféré directement étendre Sass, vu que c'est assez facile une fois qu'on a trouvé un exemple sur l'internet.
		</p>
		
		<%= coderay :lang => :ruby do %>
module Sass::Script::Functions
  def custom_percentage(value, total)
    value = value.to_i
    total = total.to_i

    percentage = value * 100.0 / total

    Sass::Script::String.new("#{ percentage }%")
  end
  declare :int, :args => [:string]
end
		<% end %>
		
		<p>
			Pas compliqué, le code est extrait d'un fichier 'sass.rb' dans mon dossier '/lib'. À noter que Sass n'accepte que des strings comme valeur de retour.
		</p>
		
		<h3>
			Du nain au géant, mon srite est infini !
		</h3>
		
		<p>
			Tout est prêt pour la démo finale. Je croise les doigts pour que tout fonctionne comme prévu .... Le temps que le moteur chauffe .... j'appuie sur le bouton ! Go !
		</p>
		
		<%= erb @article.experience.with_mutant_version(:percent).code %>
				
		<h3>
			Conclusion
		</h3>
		
		<p>
			Ouf ! Si vous êtes là c'est que tout à bien marché, et qu'en plus vous avez tout compris. C'est génial. Vous attendez quoi maintenant ? Une conclusion ? Ha ?
		<p>
		
		<p>	
			Personnellement, j'utiliserais toujours ce mixin si je dois afficher des icones en plusieurs tailles et que je veux optimiser en utilisant les sprites. Bien sûr, la contrepartie c'est que l'utilisateur doit toujours télécharger l'image en plus grande résolution, mais de toute façon il l'aurait téléchargé un jour et elle sera cachée par le navigateur alors ça passe.
		</p>
		
		<p>
			J'espère que vous vous êtes bien amusé, que vous allez , et je vous fais des bisous !
		</p>
  }),
  :pool => :css,
  :published => false,
  :tag => :sprite



Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Sass",
  :summary => "Précompileur CSS écrit en ruby. Incontournable pour tout projet rails.",
  :link => "http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html",
  :pool => :doc,
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Compass",
  :summary => "Librairie de mixins pour Sass, quasi indispensable.",
  :link => "http://compass-style.org/",
  :pool => :doc,
  :published => true

Blog::Ressource.create :user => @primal_user.blog_user,
  :title => "Font Awesome",
  :summary => "La meilleure font-icon que je connaisse.",
  :link => "http://fortawesome.github.io/Font-Awesome/",
  :pool => :doc,
  :published => true
