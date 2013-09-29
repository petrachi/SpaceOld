#!/bin/env ruby
# encoding: utf-8

@gaulois_1_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Gaulois cherche Gauloise (1)",
  :summary => %q{
    Chez les gaulois, l'amour triomphe toujours ! Comment ça se passe en ruby ? C'est justement le sujet de cet article.
  },
  :code => %q{
		<p>
			Salut les p'tit amis.<br/>
			Aujourd'hui, un programme simple avec un gaulois, qui tentera de rejoindre sa gauloise. On va d'abord créer une carte, y placer nos deux personnages, et faire bouger notre gaulois jusqu'à ce qu'il rejoigne sa chérie. Tout ça grâce à la puissance et à la beauté de ruby !
		</p>

		<h3>'M' pour afficher la carte</h3>

		<p>
			Pour représenter la carte du monde, on va d'abord créer une classe <%= coderay({:inline => true}, "Province") %>, qui représentera une position sur la carte. Puis une classe <%= coderay({:inline => true}, "World") %>, qui regroupera toutes les provinces.
		</p>

		<p>
			On veut créer une carte où les positions sont des hexagones. Pourquoi des hexagones et pas des carrés ? Simplement parce qu'ils représentent mieux la réalité. Lorsqu'on choisis de représenter une carte à partir d'une série de position, comme ici, il est important d'anticiper la notion de distance entre deux positions.<br/>
			On aurait plus naturellement choisi des positions carrés, pour représenter la carte comme un grand tableau. Le problème qui se pose, si on définit une distance de 1 pour deux provinces côtes à côtes, est de calculer la distance d'une position en diagonale. Une distance qui ne soit pas un entier va nous poser problème ensuite. Ce problème ne se posera pas avec des positions hexagonales.
		</p>

		<p>
			Les positions seront définies par trois coordonnées. Encore une fois, il semble plus naturel de n'utiliser que deux coordonnées pour représenter une carte en 2D, mais ajouter une troisième coordonnées permettra de faciliter largement le calcul des distances entre deux positions. Ces trois coordonnées seront notés <%= coderay({:inline => true}, ":x, :y, :z") %>, et devront respecter la condition <%= coderay({:inline => true}, "-x + y + z == 0") %>.
		</p>

		<p>
			Sans plus attendre, je vous donne le code de nos deux premières classes.
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
			Rapidement, on va afficher un exemple de la liste des positions générées.
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
			Pour représente nos deux gaulois, rien de plus simple, on va créer une classe <%= coderay({:inline => true}, "Gaulois") %>, et lui donner un attribut <%= coderay({:inline => true}, ":province") %>. On va en profiter pour créer et placer les deux personnages dans la méthode <%= coderay({:inline => true}, "World#initialize") %>.
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

		<p>
			Rapide digression, j'ai crée deux méthodes : <%= coderay({:inline => true}, "Array#except") %> et <%= coderay({:inline => true}, "Array#sample") %>. La première exclu une, ou plusieurs, valeurs dans un tableau. La seconde sélectionne une valeur aléatoirement.<br/>
			Ces deux extends ne sontpas obligatoires, vous trouverez <%= coderay({:inline => true}, "Array#reject") %> e ruby, qui fait presque la même chose que mon <%= coderay({:inline => true}, "Array#except") %>. Et <%= coderay({:inline => true}, "Array#sample") %> est déjà inclus dans rails, puisque la méthode est définie dans <%= coderay({:inline => true}, "??? active support") %>.
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
			Allez, on a fait un monde et deux gaulois, je pense qu'il est temps de se reposer. C'est déjà beaucoup. Un prochain article va suivre où on commencera à faire bouger notre gaulois.
		</p>
  },
  :pool => :ruby,
  :published => true
  
  
@gaulois_2_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Gaulois cherche Gauloise (2)",
  :summary => %q{
    On va se bouger aujourd'hui ! Et les gaulois aussi, ça suffit !
  },
  :code => %q{
		<p>
			Coucou les copains, comment ça va aujourd'hui ?<br/>
			Allez directement, on a fait un monde, des provinces, des gaulois, maintenant il faut les faire se déplacer. Sauf la gauloise, elle, elle bouge pas.
		</p>

		<h3>Du mouvement vint la vie</h3>

		<p>
			Pour faire déplacer Gérôme le gaulois, il suffit de modifier la valeur de l'attribut <%= coderay({:inline => true}, ":province") %>. La difficulté sera de sélectionner une valeur cohérente. Pour cela, nous allons créer une méthode <%= coderay({:inline => true}, "Province#vision(distance)") %>, qui nous renverra la liste de toutes les provinces visibles à une certaine distance. Et une méthode <%= coderay({:inline => true}, "Province#distance(province)") %>, qui va calculer la distance jusqu'à la province passé en paramètre.
		</p>

		<p>
			Afin d'avoir accès aux provinces qui existent dans le monde, nous allons devoir modifer la méthode <%= coderay({:inline => true}, "Province#initialize") %>, pour passer l'instance de la classe <%= coderay({:inline => true}, "World") %> dans laquelle elle est incluse.
		</p>

		<%= coderay do %>
class Province
  attr_accessor :x, :y, :z

  def initialize x, y, z, world
  	@x, @y, @z, @world = x, y, z, world
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

		<h3>Gaulois#move</h3>

		<p>
			Enfin, on va pouvoir faire se déplacer notre Gérôme le gaulois. À chaque "tour" (<%= coderay({:inline => true}, "World#play_turn") %>), il va regarder toutes les provinces autour de lui, à une distance de 1, et se déplacer sur l'une d'entre-elles aléatoirement (<%= coderay({:inline => true}, "Gaulois#move") %>). On répétera l'opération jusqu'a ce que les deux personnages soit réunis.
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
			Volontairement, je vais choisir un monde assez petit. Ainsi codé, Gérôme le gaulois peut lobotomiser assez longtemps avant de retrouver sa gauloise.
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
			Et voilà ! L'amour à triomphé ! C'est très bien. Dans le prochain et dernier article, on va améliorer la méthode <%= coderay({:inline => true}, "Gaulois#move") %>, pour que les déplacements soit un peu moins aléatoires.
		</p>

		<p>
			Allez, c'est tout pour aujourd'hui. Vous pouvez partir. Il faut me débarrasser le plancher !
		</p>
  },
  :pool => :ruby,
  :published => true
  

@gaulois_3_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Gaulois cherche Gauloise (3)",
  :summary => %q{
    Épisode final où l'amour triomphe pour Gérôme le gaulois et sa copine. Aujourd'hui, on fait de l'intelligence artificielle ! (Enfin, pas vraiment mais on va dire que oui).
  },
  :code => %q{
		<p>
			En forme aujourd'hui ?<br/>
			Très bien. Retour sur nos deux gaulois. Dans cet épisode final, on va upgrade la méthode <%= coderay({:inline => true}, "Gaulois#move") %> de deux façons, vous allez voir, vous allez comprendre.
		</p>

		<h3>Vision de jeu</h3>

		<p>
			On va ajouter un attribut <%= coderay({:inline => true}, ":vision") %> à la classe <%= coderay({:inline => true}, "Gaulois") %>. Ce nouvel attribut nous permettra d'inspecter les alentours avant de se déplacer.
		</p>

		<p>
			Rappelez vous, dans la méthode <%= coderay({:inline => true}, "Gaulois#move") %>, on sélectionne une province sur laquelle se déplacer. Pour l'instant, le choix de la province reléve du pur hasard. On va modifier la méthode afin de regarder d'abord si la gauloise que nous cherchons à atteindre est en vue. Si oui, nous sélectionnerons une province qui nous rapproche d'elle le plus possible. Sinon, on retourne sur le hasard.
		</p>

		<%= coderay do %>
class Gaulois
  attr_accessor :world, :province

  def initialize world, province
  	@world, @province = world, province
  	@vision = 4
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
			Pour finir, nous allons mémoriser toutes les provinces déjà visitées, et éviter d'y retourner. Pour faire ça, on va stocker toutes les provinces vues dans un tableau, et modifier la partie "sélection aléatoire" de la méthode <%= coderay({:inline => true}, "Gaulois#move") %>, afin d'exclure les provinces déjà visitées de la liste des déplacements disponibles. Il faudra également prévoir le cas où toutes les déplacements disponibles ont déjà été vus, pour éviter de se retrouver coincé dans un cul de sac.
		</p>

		<%= coderay do %>
class Gaulois
  def initialize world, province
  	@world, @province = world, province
  	@vision = 4

  	@seen = Array.new
  end

  def move
    @province = find_a_way
    @seen << @province
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
end
		<% end %>

		<p>
			Avec ça, Gérôme le gaulois devrait retouver sa belle plus rapidement. Allez, je lance le script, et je vous rajoute des <%= coderay({:inline => true}, "puts") %> pour bien comprendre tout ce qui se passe.
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
			Youpi, l'amour triomphe encore chez les gaulois ! C'était le dernier article de la série, même si on pourrait encore travailler à davantage d'améliorations. Si vous voulez vous amuser, je vous conseillerais d'ajouter des obstacles sur la route, par exemple.
		</p>

		<h3>Conclusion</h3>

		<p>
			J'ai surtout l'habitude de rails, et j'ai dû travailler sur la notion de "visibilité" des objets. Par exemple pour les provinces, j'aurais eu le réflexe de faire quelque chose comme <%= coderay({:inline => true}, "province.world.provinces") %>. Le système d'associations d'<%= coderay({:inline => true}, "ActiveRecord") %>, et le fait d'avoir une base de donnée, rends presque invisible les mécaniques qui vont lier deux objets entre eux. Comment faire alors pour qu'une instance de <%= coderay({:inline => true}, "Province") %> ait accès au reste de ses homologues ?
		</p>

		<p>
			Peut-être que cette première expérience en "plain ruby" m'amènera à me pencher d'avantage sur les mécaniques d'<%= coderay({:inline => true}, "ActiveRecord") %>, et de ruby sans rails.
		</p>

		<p>
			Allez, je vous laisse les copains. C'est fini pour aujourd'hui. Non mais allez-vous en, ça commence à devenir gênant.
		</p>
  },
  :pool => :ruby,
  :published => true
