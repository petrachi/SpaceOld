#!/bin/env ruby
# encoding: utf-8

@sphere_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Blocks, Procs, Lambdas",
  :summary => %q{
    Rapide 'walkthrough' de l'utilisation des blocks dans l'implémentation de fonctions en ruby.
  },
  :snippet => Blog::Snippet.create(erb: %q{ 
		<p>
		  Les blocks, procs ou lambda, c'est tout la même chose : une instance de la classe <%= coderay({:inline => true}, :Proc) %> qui sert à stocker du code. Ils sont utilisés fréquement en ruby, dans la méthode <%= coderay({:inline => true}, "Enumerable#each") %> par exemple (le block c'est ce code entré entre les accolades - ou le do..end).<br/>
		</p>
		
		<p>
		  Je vais tenter d'expliquer ici comment implémenter des méthodes qui prennet un block en paramètre.
		</p>
		
		<h3>
			Avant de savoir comment, dis moi pourquoi ?
		</h3>
		
		<p>
		  Les blocks sont utiles pour injecter du code au coeur d'une méthode. La méthode <%= coderay({:inline => true}, "Enumerable#each") %> est un exemple d'itérateur parfait, elle va parcourir tous les éléments de votre collection et vous laisse la liberté d'en faire ce que vous voulez via le block.<br/>
		  On se sert aussi des blocks lorsqu'on veut réaliser une méthode de 'template'. Dans rails par exemple, la méthode <%= coderay({:inline => true}, "ActionView::Helpers::UrlHelper#link_to") %> accepte un block, la méthode va 'entourer' le résultat de l'exécution du block dans une balise <%= coderay({:inline => true, :lang => :html}, "<a>") %>.
		</p>
		
		<h3>
			Ma première méthode
		</h3>
	
		<p>
		  Juste pour apprécier la syntaxe, voici la méthode la plus basique qu'on puisse imaginer utilisant un block (c'est simple, la méthode ne fait rien sauf exécuter le block). Deux approches, utiliser l'instruction <%= coderay({:inline => true}, :yield) %> qui va excuter le block directement, ou expliciter la présence du block en utilisant une '&' devant le nom du paramètre, puis en utilisant la méthode <%= coderay({:inline => true}, "Proc#call") %> pour lancer l'exécution du block.
		</p>
	
		<%= coderay do %>
def easy
	yield
end

#or
def easy &block
  block.call
end

?> easy{ "I'm in a block !" }
=> "I'm in a block !"

#or
?> easy do
  "I'm in a block !"
end
=> "I'm in a block !"
		<% end %>
		
		<h3>
			Block optionnel
		</h3>
	  
	  <p>
	    Comme les arguments, les blocks peuvent être optionnels. En rails, la méthode <%= coderay({:inline => true}, "ActionView::Helpers::UrlHelper#link_to") %> fonctionne très bien si l'on ne passe aucun block en argument, ce comportement est rendu possible grâce à la méthode <%= coderay({:inline => true}, "Kernel#block_given?") %> qui va nous indiquer si oui ou non, un block à été passé en argument. Exemple : 
	  </p>
	  
	  <%= coderay do %>
def optional
	if block_given?
		yield
	else
		"No block here :("
	end
end

?> optional{ "I'm in a block again ! :)" }
=> "I'm in a block again ! :)"

?> optional
=> "No block here :("
		<% end %>
		
		<h3>
		  Passages de paramètres au block
		</h3>
    
    <p>
      Exécuter un block dans une méthode, c'est bien, mais ça pourrait être interressant de faire passer des valeurs dans notre block. Le <%= coderay({:inline => true}, "Enumerable#each") %> serait bien inutile sy on n'avait pas accés aux valeurs à l'intérieur de notre block.<br/>
      Allez c'est tellement simple que la démo suffit pour comprendre que le block peut être appelé avec des arguments, comme n'importe quelle autre méthode : 
    </p>
		
		<%= coderay do %>
def with_params
	yield 18
end

?> with_params{ |i| "I'm over #{ i }" }
=> "I'm over 18"
    <% end %>
		
		<p>
		  On peut également jouer sur le nombre de paramètres attendu par le block. La méthode <%= coderay({:inline => true}, "Proc#arity") %> nous renvoie justement cette information. À noter que cette méthode renverra un résultat négatif si le block déclare un argument optionnel, dans ce cas le résulata sera -[nombre de paramètres oblogatoires]-1.
		</p>
		
		<%= coderay do %>
def arity &block
  block.arity
end

?> arity{}
=> 0

?> arity{ |a| }
=> 1

?> arity{ |a, b| }
=> 2

?> arity{ |*a| }
=> -1

?> arity{ |a, b, *c| }
=> -3
    <% end %>
	
		<h3>
			Final
		</h3>
	
		<p>
		  Exceptionnellement, je vais vous donner une méthode <%= coderay({:inline => true}, "Hash#compact") %>, c'est cadeau, c'est gratuit, c'est de l'amour :
		</p>
		
		<%= coderay do %>
class Hash
	def compact &block
	  block ||= Proc.new{ |_, value| value.nil? }
	  
		each do |key, value|
      delete key if block.call key, value
    end
	end
end

?> {:a => 100, :b => 200, :c => nil}.compact
=> {:a=>100, :b=>200}

?> {:a => 100, :b => 200, :c => nil}.compact{ |_, value| value.to_i > 150 }
=> {:a=>100, :c=>nil}

?> {:a => 100, :b => 200, "c" => nil}.compact{ |key, _| key.is_a? String }
=> {:a=>100, :b=>200}
		<% end %>
	
		<h3>
			Conclusion
		</h3>
	
		<p>
			J'aime beaucoup cette feature de ruby. J'aime utiliser les blocks pour rendre une méthode plus flexible, ou pour définir un comportement spécifique dans un appel particulier.<br/>
			Le seul reproche que je porrais faire, c'est qu'on ne peut passer qu'un seul block 'proprement' à une méthode. Je dis 'proprement' car on peut envoyer des instances de <%= coderay({:inline => true}, :Proc) %> dans les paramètres classiques, mais c'est moins joli.
		</p>
		
		<p>
			Allez, bisous les copains ! Faut partir maintenant, y'a plus l'temps !
		</p>
  }),
  :pool => :ruby,
  :published => true,
  :tag => :block
