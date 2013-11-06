#!/bin/env ruby
# encoding: utf-8

@gaulois_1_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Gaulois cherche Gauloise",
  :summary => %q{
    Chez les gaulois, l'amour triomphe toujours ! Comment ça se passe en ruby ? C'est justement le sujet de cet article.
  },
  :snippet => Blog::Snippet.create(erb: %q{
		<p>
			Salut les p'tit amis !<br/>
			Aujourd'hui, un programme simple avec un gaulois, qui tentera de rejoindre une gauloise.<br/>
			On va d'abord créer une carte, y placer nos deux personnages, puis faire bouger notre gaulois jusqu'à ce qu'il rejoigne sa chére et tendre. Tout ça grâce à la beauté et puissance de ruby !
		</p>

		<h3>'M' pour afficher la carte</h3>

		<p>
			Pour représenter la carte du monde, on va d'abord créer une classe <%= coderay({:inline => true}, "Province") %>, qui représentera une position sur la carte. Puis une classe <%= coderay({:inline => true}, "World") %>, qui regroupera toutes les provinces.
		</p>

		<p>
			On veut créer une carte où les provinces sont représentées par des hexagones. Pourquoi uitliser des hexagones plutôt qu'un bête tableau ? Lorsqu'on choisis de représenter une carte à partir d'une série de position, il est important d'anticiper la notion de distance.<br/>
			La construction d'une carte en forme de tableau est plus intuitive, mais va nous poser problème lorsqu'on arrivera à définir la notion de distance. Si on définit la distance entre deux positions mitoyennes à 1, la distance qui sépare une position donnée d'une position situé en diagonale sera un nombre non entier.<br/>
			Si notre personnage peut se déplacer de 1 par tour, combien de tour doit il compter pour se déplacer sur une position située à 1,414 de distance ?<br/>
			Utiliser des positions "hexagonales" évite de poser ce genre de problèmes, car toutes les distances calculées seront des nombres entiers.
		</p>

		<p>
			Les positions seront définies par trois coordonnées <%= coderay({:inline => true}, ":x, :y, :z") %>. Encore une fois, il semble plus naturel de n'utiliser que deux coordonnées pour représenter une carte à deux dimensions, mais ajouter cette troisième coordonnée permettra de faciliter le calcul des distances. La valeur de la troisième coordonnée sera donnée par la formule <%= coderay({:inline => true}, "z = x - y") %>.
		</p>

		<p>
			Sans transitions, voici le code de nos deux premières classes :
		</p>

		<%= coderay do %>
class World
  attr_accessor :provinces

  def initialize size
  	@provinces = Array.new

  	(-size..size).each do |x|
  		(-size..size).each do |y|
  			@provinces << Province.new(x, y, (x - y))
  		end
  	end
  end
end

class Province
  attr_accessor :x, :y, :z

  def initialize x, y, z
  	@x, @y, @z = x, y, z
  end
end
		<% end %>

		<p>
			On peut donner un exemple des positions générées :
		</p>

		<%= coderay do %>
class World
  def show
  	@provinces.map do |province|
  		province.show
  	end
  end
end

class Province
  def show
  	[@x, @y, @z]
  end
end


?> world = World.new 2
?> world.show
=> [
  [-1, -1, 0], 
  [-1, 0, -1], 
  [-1, 1, -2], 
  [0, -1, 1], 
  [0, 0, 0], 
  [0, 1, -1], 
  [1, -1, 2], 
  [1, 0, 1], 
  [1, 1, 0]
]
		<% end %>

		<h3>Les Gaulois</h3>

		<p>
			Pour représente nos deux personnages, on va créer une classe <%= coderay({:inline => true}, "Gaulois") %>, et lui donner un attribut <%= coderay({:inline => true}, ":province") %> (il permettra de définir la position d'un gaulois). On va en profiter pour modifier la méthode <%= coderay({:inline => true}, "World#initialize") %>, afin de créer et de placer sur la carte nos deux amoureux.
		</p>

		<%= coderay do %>
class Gaulois
  attr_accessor :province

  def initialize province
  	@province = province
  end

  def show
  	@province.show
  end
end


class World
  attr_accessor :provinces, :gaulois, :gauloise

  def initialize size
  	@provinces = Array.new

  	(-size..size).each do |x|
  		(-size..size).each do |y|
  			@provinces << Province.new(x, y, (x - y))
  		end
  	end

  	@gaulois = Gaulois.new(self, @provinces.sample)
    @gauloise = Gaulois.new(self, (@provinces.except(@gaulois.province)).sample)
  end
end

		<% end %>

    <h3>Array Extend</h3>

		<p>
			Courte digression : j'ai crée les deux méthodes <%= coderay({:inline => true}, "Array#except") %> et <%= coderay({:inline => true}, "Array#sample") %>. La première exclu une, ou plusieurs, valeurs dans un tableau. La seconde sélectionne une valeur aléatoirement. Ces deux méthodes n'étaient pas nécéssaires, puisque vous trouverez <%= coderay({:inline => true}, "Array#reject") %> en ruby, qui fait presque la même chose que mon <%= coderay({:inline => true}, "Array#except") %>. Et la méthode <%= coderay({:inline => true}, "Array#sample") %> est déjà incluse dans rails, via <%= coderay({:inline => true}, "ActiveSupport") %>.
		</p>

		<%= coderay do %>
class Array
  def except *value
  	self - [*value]
  end

  def sample
  	shuffle.first
  end
end
		<% end %>

		<h3>Conclusion</h3>

		<p>
			Allez, on a fait un monde et deux gaulois, je crois qu'on a le droit à un moment de repos. Demain, on verra comment faire avancer notre gaulois.
		</p>
		
		<p>
		  C'est tout pour cette fois. Vraiment, c'est pas la peine de rester y'en aura pas plus.
		</p>
  }),
  :pool => :ruby,
  :published => true,
  :published_at => "03-10-2013".to_datetime,
  :serie => :gaulois
  
  
@gaulois_2_article = Blog::Article.create :user => @primal_user.blog_user,
  :summary => %q{
    On va se bouger aujourd'hui ! Et les gaulois aussi, ça suffit ! Allez allez c'est parti.
  },
  :snippet => Blog::Snippet.create(erb: %q{
		<p>
			Coucou les copains, comment ça va aujourd'hui ?<br/>
			Allez directement, on a fait un monde, des provinces, des gaulois, maintenant on va mettre tout ça en action.
		</p>

		<h3>Du mouvement</h3>

		<p>
			Pour faire se déplacer notre gaulois, il suffit de modifier la valeur son attribut <%= coderay({:inline => true}, ":province") %>. Reste à choisir une valeur cohérente.<br/>
			Pour `nous aider, nous allons créer deux méthode : Et <%= coderay({:inline => true}, "Province#distance(province)") %>, qui va calculer la distance jusqu'à la province passé en paramètre. Et <%= coderay({:inline => true}, "Province#vision(distance)") %>, qui nous renverra la liste de toutes les provinces "visibles" à une certaine distance.
		</p>

		<p>
			Afin d'avoir accès à la liste provinces qui peuplent notre carte, nous allons modifer la méthode <%= coderay({:inline => true}, "Province#initialize") %>, afin d'inclure l'instance de <%= coderay({:inline => true}, "World") %> qui englobe notre province.
		</p>

		<%= coderay do %>
class Province
  attr_accessor :x, :y, :z

  def initialize x, y, z, world
  	@x, @y, @z, @world = x, y, z, world
  end
  
  def distance province
    [
      (@x - province.x).abs,
      (@y - province.y).abs,
      (@z - province.z).abs,
    ].max
  end
  
  def vision distance
  	@world.provinces.select do |province|
  		(@x - distance..@x + distance) === province.x and
  		(@y - distance..@y + distance) === province.y and
  		(@z - distance..@z + distance) === province.z
  	end
  end
end


class World
  attr_accessor :provinces, :gaulois, :gauloise

  def initialize size
  	@provinces = Array.new

  	(-size..size).each do |x|
  		(-size..size).each do |y|
  			@provinces << Province.new(x, y, (x - y), self)
  		end
  	end

  	@gaulois = Gaulois.new(self, @provinces.sample)
  	@gauloise = Gaulois.new(self, (@provinces.except(@gaulois.province)).sample)
  end
end
		<% end %>
    
    <p>
      C'est ici que le choix des trois coordonnées paye. La méthode de distance cherche juste la valeur maximale de la différence de chaque coordonnée. Et la méthode de vision sélectionne une plage trés simple de valeurs pour chaque coordonnées.<br/>
      Essayez donc chez vous de reproduire ces deux fonctions avec seulement deux coordonnées, toujours pour une carte "hexagonale", et venez me dire aprés que c'était plus facile.
    </p>
    
		<h3>Gaulois#move</h3>

		<p>
			Pour sélectionner une province sur laquelle notre personnage va se déplacer, nous allons d'abord récupérer la liste des provinces visibles, à partir de sa position actuelle, à une disance de 1. Puis sélectionner aléatoirement une de ces provinces.<br/>
			Cette mécanique sera décrite dans la fonction <%= coderay({:inline => true}, "World#play_turn") %>, tandis que la fonction <%= coderay({:inline => true}, "World#play_turn") %>) nous permettra de faire passer un tour de jeu dans notre monde.
		</p>

		<%= coderay do %>
class Gaulois
  def move
  	province = @province.vision(1).except(@province)
  	@province = province
  end
end


class World
  def play_turn
  	@gaulois.move
  end
end
		<% end %>

		<p>
		  On peut voir le résultat directement. J'ai volontairement choisi un monde assez petit pour cette fois, car avec cette méthode de déplacement aléatoire, il peut se passer de nombreux tours de jeu avant que nos deux personnages soient réunis.
		</p>

		<%= coderay do %>		
?> world = World.new 2
puts "Gauloise stands on #{ world.gauloise.province.show.inspect }"

begin
  puts "Gaulois stands on #{ world.gaulois.province.show.inspect }"
  world.play_turn
end until world.gaulois.province == world.gauloise.province

puts "L'amour triomphe toujours chez les gaulois ! Gaulois has reach #{ world.gaulois.province.show.inspect }"


=> "Gauloise stands on [2, -1, 3]"
"Gaulois stands on [0, 1, -1]"
"Gaulois stands on [-1, 0, -1]"
"Gaulois stands on [-2, -1, -1]"
"Gaulois stands on [-1, 0, -1]"
"Gaulois stands on [0, 0, 0]"
"Gaulois stands on [1, 0, 1]"
"Gaulois stands on [1, -1, 2]"
"Gaulois stands on [0, -1, 1]"
"Gaulois stands on [1, 0, 1]"
"Gaulois stands on [2, 0, 2]"
"L'amour triomphe toujours chez les gaulois ! Gaulois has reach [2, -1, 3]"
		<% end %>

		<h3>Conclusion</h3>

		<p>
			Et voilà ! L'amour à triomphé chez les gaulois ! C'est très bien. Mais on ne va pas s'arreter là, dans le prochain article, on va améliorer la méthode <%= coderay({:inline => true}, "Gaulois#move") %>, et rendre les déplacements de notre gaulois moins aléatoires.
		</p>

		<p>
			Allez, c'est fini pour aujourd'hui. Vous devez partir. Il faut me débarrasser le plancher !
		</p>
  }),
  :pool => :ruby,
  :published => true,
  :published_at => "03-10-2013".to_datetime,
  :following => @gaulois_1_article  

@gaulois_3_article = Blog::Article.create :user => @primal_user.blog_user,
  :summary => %q{
    Épisode final pour notre ami gaulois et sa tendre amie. Aujourd'hui, on fait de l'intelligence artificielle ! (Enfin, pas vraiment mais on va dire que oui).
  },
  :snippet => Blog::Snippet.create(erb: %q{
		<p>
			Patate aujourd'hui ?<br/>
			Très bien. Retour sur nos deux gaulois. Dans cet article, on va améliorer la méthode <%= coderay({:inline => true}, "Gaulois#move") %> afin de rendre les déplacements moins aléatoires.
		</p>

		<h3>Vision de jeu</h3>

		<p>
			On va commencer par ajouter un attribut <%= coderay({:inline => true}, ":vision") %> aux gaulois. il va nous permettre d'inspecter les alentours avant de se déplacer.
		</p>

		<p>
		  On va modifier la méthode <%= coderay({:inline => true}, "Gaulois#move") %> pour y faire bon usage de ce nouvel attribut. Avant de choisir une province sur laquelle se déplacer, nous allons regarder les provinces autour de nous, aussi loin que nous le permet notre vision, à la recherche de la gauloise.<br/>
		  Si la gauloise est en vue, nous allons sélectionner une province qui nous raproche d'elle. Sinon, on reprendra notre comportement aléatoire habituel.
		</p>

		<%= coderay do %>
class Gaulois
  attr_accessor :world, :province

  def initialize world, province
  	@world, @province = world, province
  	@vision = 4
  end

  def look &block
    @province.vision(@vision).detect &block
  end
  
  def find_a_way
  	province_gauloise = look{ |province| province == @world.gauloise.province }

  	if province_gauloise
  		if province_gauloise.distance(@province) == 1
  			province_gauloise
  		else
  			closest_distance = province_gauloise.distance(@province)
  			closest_province = nil

  			@province.vision(1).each do |province|
  				if province_gauloise.distance(province) < closest_distance
  					closest_province = province
  					closest_distance = province_gauloise.distance(province)
  				end
  			end

  			closest_province
  		end
  	else
  		@province.vision(1).except(@province)
  	end
  end
  
  def move
    @province = find_a_way
  end
end
		<% end %>

		<h3>Mémoire - Du poisson rouge à l'éléphant</h3>

		<p>
			La seconde amélioration sera de mémoriser toutes les provinces déjà visitées, et éviter d'y retourner.
		</p>
		
		<p>
		  Pour ajouter ce nouveau comportement, on va créer un attribut <%= coderay({:inline => true}, ":seen") %>, dans lequel nous allons enregistrer toutes les positions déjà vue.<br/>
		  On va aussi modifier la méthode <%= coderay({:inline => true}, "Gaulois#move") %>, afin d'exclure, si possible, les provinces visitées de la sélection des provinces sur lequelles se déplacer. Je dis "si possible", car on ne peut pas exclure de se retrouver coincé dans un cul de sac. À ce moment, il faudra retourner sur ses pas.
		</p>

		<%= coderay do %>
class Gaulois
  def initialize world, province
  	@world, @province = world, province
  	@vision = 4

  	@seen = Array.new
  end

  def find_a_way
  	province_gauloise = look{ |province| province == @world.gauloise.province }

  	if province_gauloise
  		if province_gauloise.distance(@province) == 1
  			province_gauloise
  		else
  			closest_distance = province_gauloise.distance(@province)
  			closest_province = nil

  			@province.vision(1).each do |province|
  				if province_gauloise.distance(province) < closest_distance
  					closest_province = province
  					closest_distance = province_gauloise.distance(province)
  				end
  			end

  			closest_province
  		end
  	else

  		possible_provinces = @province.vision(1).except(@province).except(@seen)
  		possible_provinces = @province.vision(1).except(@province) if possible_provinces.empty?
  		possible_provinces.sample
  	end
  end
  
  def move
    @province = find_a_way
    @seen << @province
  end
end
		<% end %>

		<p>
			Avec ça, notre gaulois devrait pouvoir retouver sa gauloise un peu plus rapidement. Allez, je lance le script sur un monde plus grand que la dernière fois, et je rajoute des <%= coderay({:inline => true}, "puts") %> pour plus de clarté.
		</p>

		<%= coderay do %>		
?> world = World.new 7
puts "Gauloise stands on #{ world.gauloise.province.show.inspect }"

begin
  world.play_turn
end until world.gaulois.province == world.gauloise.province

puts "L'amour triomphe toujours chez les gaulois ! Gaulois has reach #{ world.gaulois.province.show.inspect }"


=> "Gauloise stands on [5, -4, 9]"
"Exploring new path -> Gaulois stands on [6, 3, 3]"
"Exploring new path -> Gaulois stands on [6, 2, 4]"
"Gauloise is unreachable (distance : 5) -> Gaulois stands on [5, 1, 4]"
"Gauloise is unreachable (distance : 4) -> Gaulois stands on [5, 0, 5]"
"Gauloise is unreachable (distance : 3) -> Gaulois stands on [5, -1, 6]"
"Gauloise is unreachable (distance : 2) -> Gaulois stands on [5, -2, 7]"
"Gauloise is close -> Gaulois stands on [5, -3, 8]"
"L'amour triomphe toujours chez les gaulois ! Gaulois has reach [5, -4, 9]"
		<% end %>

		<p>
			C'est assez dingue mais, l'amour triomphe encore cette fois chez les gaulois ! C'était le dernier article de la série, et je sais qu'on pourrait encore améliorer les déplacements du gaulois, ou faire d'autres trucs plus fun. Essayez donc chez vous d'ajouter des obstacles sur la route.
		</p>

		<h3>Conclusion</h3>

		<p>
			J'ai surtout l'habitude d'utiliser ruby via rails. Le fait de ne pas avoir de système de données persistant  m'a fait retravailler le concept de visibilité des objets. Une instance de <%= coderay({:inline => true}, "Province") %> n'a pas accés "naturellement" aux autres instances de <%= coderay({:inline => true}, "Province") %>.
		</p>
		
		<p>
			Cette expérience en "plain ruby" m'a beaucoup plu, et je vais essayer de coder plus souvent en dehors de rails. J'essaierait peut être bientôt de reproduire certains comportements d'<%= coderay({:inline => true}, "ActiveRecord") %>, afin de mieux saisir cette mécanique de visibilité des objets.
		</p>
    
		<p>
			Allez, je vous laisse les copains. C'est fini, vous pouvez partir ... Non mais rentrez chez vous maintenant, ça commence à devenir gênant.
		</p>
  }),
  :pool => :ruby,
  :published => true,
  :published_at => "03-10-2013".to_datetime,
  :following => @gaulois_2_article
