#!/bin/env ruby
# encoding: utf-8

@pad_article = Blog::Article.create :user => @primal_user.blog_user,
  :title => "Pad with zeros",
  :summary => %q{
    Pourquoi mon ordinateur ne comprends pas qu'il faut afficher "07" et pas juste "7". Rhaaa, ce truc me rend fou !
  },
  :snippet => Blog::Snippet.create(erb: %q{
		<p>
			Allez, pas de mensonges, on a tous eu besoin d'ajouter des zéros au début d'un nombre afin de respecter un certain format. Aujourd'hui, je vous donne la solution dans deux languages. Enjoy ;)
		</p>
		
		<h3>En Javascript</h3>
		
		<p>
			On va prendre une chaine de caractère composée uniquement de zéros, ajouter à la suite notre nombre, et enfin, on va sélectionner dans cette nouvelle chaine le nombre correcte de caractères.<br/>
			Si cette fonction renvoie le plus souvent un résultat correct, elle n'est pas fiable à 100%.Si je veux injecter trop de zéros, ou si le nombre passé en paramètre est trop grand, la fonction va renvoyer une mauvaise valeur.
		</p>
		
		<%= coderay :lang => :javascript do %>
function pad(value, size) {
var padded = "0000000000" + value;
return padded.substr(padded.length - size);
}
		<% end %>
		
		<%= coderay :lang => :javascript do %>
> pad(15, 3);
"015"

> pad(155, 3);
"155"

> pad(1554, 3);
"554" // ! bug

> pad(1554, 15);
"4" // ! bug

> pad("2bff", 6); // hexa
"002bff"
		<% end %>
		
		<h3>En Ruby</h3>
		
		<p>
			J'utilise la méthode <%= coderay({:inline => true}, 'Kernel#sprintf') %>, mais il existe peut-être de meilleures solutions que je en connais pas encore. Si la syntaxe de est au moins aussi sale que celle des <%= coderay({:inline => true}, 'Regexp') %>, cette méthode est vraiment puissante et permet de formatter une string facilement.
		</p>
		
		<p>
			On crée d'abord une <%= coderay({:inline => true}, 'String') %> qui correspond au format voulu. On utilise ensuite l'opérateur <%= coderay({:inline => true}, '%') %> qui peut prendre plusieurs types d'objets en paramètre (notamment un <%= coderay({:inline => true}, 'Array') %> ou un <%= coderay({:inline => true}, 'Hash') %>).<br/>
			La <%= coderay({:inline => true}, 'String') %> de format va utiliser certains caractères spéciaux afin d'insérer les paramètres. Ici on va utiliser quelquechose comme <%= coderay({:inline => true}, '"%02d"') %>, qui va dire au système : insère le premier paramètre , dont le type doit pouvoir être évalué via <%= coderay({:inline => true}, 'Integer()') %>, et ajoute des zéros au besoin, pour atteindre une longueur minimale de 2 caractères.
		</p>
		
		<%= coderay do %>
def pad value, size
"%0#{ size }d" % value
end

?> pad 15, 3
=> "015"

?> pad 155, 3
=> "155"

?> pad 1554, 3
=> "1554"

?> pad 1554, 15
=> "000000000001554"

> pad("2bff", 6); # hexa
ArgumentError: invalid value for Integer(): "f" # ! bug
		<% end %>
		
		<p>
			Cette méthode fonctionne mieux que celle en javascript, mais elle est beaucoup plus sensible aux type d'objet des paramètres. Pour utiliser des valeurs hexadécimales, voir binaires, il faudra procéder différemment. En utilisant une <%= coderay({:inline => true}, 'String') %> de format différente, on pourra à la fois convertir et formatter des valeurs décimales.
		</p>
		
		<%= coderay do %>
?> "%06x" % 15 # hexa
=> "00000f"

?> "%08b" % 15 # binaire
=> "00001111"
		<% end %>
		
		<h3>Conclusion</h3>
		
		<p>
			<%= coderay({:inline => true, :lang => :html}, %Q{<troll> ruby > javascript </troll>}) %>
		</p>
		
		<p>
			Plus sérieusement, la méthode <%= coderay({:inline => true}, 'Kernel#sprintf') %> est assez repoussante la première fois, mais elle se révèle suffisamment puissante pour l'utiliser malgré tout. Ça me fait penser au <%= coderay({:inline => true}, 'Regexp') %> dans l'idée : je l'aime et la déteste à la fois.
		</p>
		
		<p>
			C'est fini pour aujourd'hui. Allez, tu vas pas rester toute la journée devant ton écran alors qu'il fait beau ?
		</p>
  }),
  :pool => :quicktip,
  :published => true,
  :published_at => "08-11-2013".to_datetime,
  :tag => :pad_with_zeros
