#!/bin/env ruby
# encoding: utf-8

@sphere_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Blocks",
  :summary => %q{
    En ruby, les blocks permettent de définir un bout de code sans contexte, une fonction anonyme. Le dévellopeur rails en utilise fréquement dans des fonctions comme le 'each'. Nous allons voir comment les utiliser en paramètres de nos propres fonctions.
  },
  :code => %q{ 
		<p>
			Un block (ou proc, ou lambda) c'est un bout de code, une fonction sans définition. Ils peuvent être utilisés pour passer du code en argument d'une fonction, et nous allons découvrir comment.
		</p>
		
		<h3>
			Les blocks comme on les connait
		</h3>
		
		<p>
			Seul un NulDeveloppeur en ruby/rails ne connaitrait pas les blocks, beaucoup de fonctions utilisent des blocks, <i>Array#each</i> pour n'en citer qu'une. Les blocks, c'est ce bout de code définit entre deux accolade à l'appel d'une fonction (note : les accolades peuvent aussi être troqués contre un do..end).
		</p>
	
		<h3>
			Écrire une fonction avec un block
		</h3>
	
		<p>
			Voici un exemple d'une fonction simple, qui utilise un block
		</p>
	
		<%= coderay :lang => :ruby do %>
def simple
	p "Start of my very simple function"
	yield
	p "End of my very simple function"
end

?> simple{ p "I'm alive !" }
=> "Start of my very simple function"
"I'm alive !"
"End of my very simple function"
		<% end %>
	
		<p>
			L'instruction <code>yield</code> <%= CodeRay.scan("yield", :ruby).span.html_safe %> indique à la fonction d'exécuter le code passé en paramètre, lors de l'appel.
		</p>
		
		<p>
			Notez que la syntaxe peut être plus explicite.
		</p>
		
		<%= coderay :lang => :ruby do %>
def simple &block
	p "Start of my very simple function"
	block.call
	p "End of my very simple function"
end

?> simple{ p "I'm alive !" }
=> "Start of my very simple function"
"I'm alive !"
"End of my very simple function"
		<% end %>
		
		<h3>
			Suite ... Développement de niveau 1
		</h3>
	
		<%= container do %>
    		<%= row :nested => true do %>
	    		<%= four_span :append => 1 do %>
	    			<h4>Block optionnel - Tu fais quelque chose ou c'est moi !</h4>
					
	    			<%= coderay :lang => :ruby do %>
def optional
	p "In my optionnal block function"
	if block_given?
		yield
	else
		p "No block given, so sad :("
	end
end

?> optional{ p "I'm alive" }
=> "In my optionnal block function"
"I'm alive"

?> optional
=> "In my optionnal block function"
"No block given, so sad :("
					<% end %>
					
					<p>
						L'appel à <code>block_given?</code> permet de savoir si un block à été passé en paramètre à l'appel de la fonction.
					</p>
	      		<% end %>

		      	<%= four_span do %>
		      		<h4>Des paramètres au block</h4>

		      		<%= coderay :lang => :ruby do %>
def parameters
	p "Here, have two random numbers."
	yield rand(10), rand(50)
	p "Now say thank you!"
end

?> parameters { |x, y| p "#{ x }, #{ y }" }
=> "Here, have two random numbers."
"8, 21"
"Now say thank you!"
		   			<% end %>
					
					<p>
						Je donne à l'appel de la fonction des valeurs qui seront traitées dans le block, sans savoir ce que le développeur décidera d'en faire. C'est ici que ce joue la magie d'un <code>Array#each</code> par exemple.
					</p>
		   		<% end %>
		   	<% end %>
	  	<% end %>
	
		<h3>
			Boss de fin
		</h3>

		<%= coderay :lang => :ruby do %>
def arity &block
	p "Arity function has begun"
	case block.arity
	when 1 then yield "one"
	when 2 then yield "one", "two"
	when 3 then yield "one", "two", "three"
	end
	p "Arity has ended"
end

?> arity{}
=> "Arity function has begun"
"Arity has ended"

?> arity{ |x| p x }
=> "Arity function has begun"
"one"
"Arity has ended"

?> arity{ |x, y| p x, y }
=> "Arity function has begun"
"one"
"two"
"Arity has ended"

?> arity{ |x, y, z| p x, y, z }
=> "Arity function has begun"
"one"
"two"
"three"
"Arity has ended"
		<% end %>

		<p>
			La méthode <code>Proc#arity</code> permet de connaitre le nombre d'argument demandé lors de l'appel. Vous pourrez adapter le code de votre fonction afin de permettre différentes utilisations (utiliser un <code>Array</code> ou un <code>Hash</code> par exemple)
		</p>
	
		<h3>
			IRL
		</h3>
	
		<p>
			Et dans la vraie vie ? On utilise les blocks souvent lorsqu'il s'agit de fonction d'itération (Array#each) ou de templating (link_to, content_tag)
		</p>
		
		<%= container do %>
    		<%= row :nested => true do %>
	    		<%= four_span :append => 1 do %>
					<h3>
						Un itérateur inutile
					</h3>
					
					<%= coderay :lang => :ruby do %>
class Array
	def each_but_not_all range
		range.each do |i|
			yield self[i]
		end
	end
end

?> array = [1, 2, 3, 4, 5]
=> [1, 2, 3, 4, 5]

?> array.each_but_not_all (1..3) { |x| p x }
=> 2
3
4
					<% end %>
				<% end %>
				
				<%= four_span do %>
					<h3>
						Une template inutile
					</h3>
					
					<p>
						<%= coderay :lang => :ruby do %>
def my_box_tag &block
	"<div>" << yield << "</div>"
end
						<% end %>
					</p>
				<% end %>
			<% end %>
		<% end %>
		
	
		<h3>
			Conclusion
		</h3>
	
		<p>
			Les blocks peuvent être très utile lorsque vous cherchez à rendre votre code plus modulable, à condition de penser à les utiliser ;)
		</p>
		
		<p>
			Bisous les copains !
		</p>
  },
  :pool => :ruby,
  :published => true
