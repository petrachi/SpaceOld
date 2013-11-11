#!/bin/env ruby
# encoding: utf-8

@method_location_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Method location",
  :summary => %q{
    Mince, j'ai pas un IDE chouettos qui peut m'envoyer directement à la définition d'une méthode. Si seulement le space blog avait la solution !
  },
  :snippet => Blog::Snippet.create(erb: %q{
		<p>
			Salut tout le monde ! Vous êtes en forme aujourd'hui ?<br/>
			C'est important de poser la question, parce qu'on va envoyer la sauce pas plus tard que maintenant. Trouver facilement le fichier et la ligne où est définie une méthode, c'est possible ! Et c'est parfois utile, aussi.
		</p>
		
		<h3>Ruby 1.9+</h3>
		
		<p>
			On peut directement utiliser la méthode <%= coderay({:inline => true}, "Method#source_location") %>, qui renverra le fichier où est défini votre méthode, et la ligne. Mais on doit d'abord récupérer une instance de <%= coderay({:inline => true}, "Method") %>. Pour ça, c'est la méthode <%= coderay({:inline => true}, "Object#method") %> qui va nous servir.<br/>
			Il faudra faire attention à une chose, la méthode <%= coderay({:inline => true}, "Method#source_location") %> renverra <%= coderay({:inline => true}, "nil") %> si la méthode cherchée n'est pas écrire en ruby.
		</p>
		
		<%= coderay do %>
class User
def name
	"thomas"
end
end

?> user = User.new

?> method = user.method(:name)
=> #<Method: User#name>

?> method.source_location
=> ["(irb)", 17]


# ---
?> "bonjour".method(:constantize).source_location
=> ["/opt/boxen/(...)/active_support/core_ext/string/inflections.rb", 53]


# --- Méthode native
?> "bonjour".method(:upcase).source_location
=> nil
		<% end %>
		
		<h3>Ruby 1.8 REE</h3>
		
		<p>
			Sur ruby 1.8, la méthode <%= coderay({:inline => true}, "Method#source_location") %> n'existe pas. Cependant, la version enterprise (ree) nous fournit deux méthodes, <%= coderay({:inline => true}, "__file__") %> et <%= coderay({:inline => true}, "__line__") %>, qui vont nous permettre de facilement reproduire le comportement de <%= coderay({:inline => true}, "Method#source_location") %>.
		</p>
		
		<%= coderay do %>
class Method
def source_location
	[
		__file__,
		__line__
	]
end
end

?> "bonjour".method(:constantize).source_location
=> ["/usr/local/rvm/(...)/active_support/core_ext/string/inflections.rb", 53]


# --- Méthode native
?> "bonjour".method(:upcase).source_location
=> ArgumentError: native Method
from (irb):36:in `__file__'
from (irb):36:in `source_location'
from (irb):42
		<% end %>
		
		<h3>Conclusion</h3>
		
		<p>
			Voilà une méthode utile, pour du débug ou par curiosité, mais que je ne conseille de ne pas utiliser ailleurs que dans son irb ou sa console.
		</p>
		
		<p>
			Hop, c'est fini.
		</p>
  }),
  :pool => :quicktip,
  :published => true,
  :published_at => "11-11-2013".to_datetime,
  :tag => :method_location
